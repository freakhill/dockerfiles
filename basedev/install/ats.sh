#!/usr/bin/env sh

cd /install

# Variation of Hibou57/PostiATS-Utilities/blob/master/install-ats2-on-debian-ubuntu.sh
# Variation of githwxi/C9-ATS2-install.sh at https://gist.github.com/githwxi/7e31f4fd4df92125b73c

# Installation directory: edit to set it to your own.
INST_DIR="$HOME/.local/ats"
# For when compiling with Z3 support: edit to set it to your own.
export C_INCLUDE_PATH="/usr/include"
export LIBRARY_PATH="/usr/lib/x86_64-linux-gnu"
# Values: 1 means Yes, 0 means No.
WITH_PATSOLVE_Z3=1
WITH_PATSOLVE_SMT2=1

exit_if_failed() {
   if [ "$?" -ne 0 ]; then
      echo "Exit on failure."
      exit 1
   fi
}

get_or_update_git_clone() {
   # Caller defines DIR and URL.
   if [ \! -d "$DIR/.git" ]; then
      if [ -d "$DIR" ]; then
         # Directory exists, but is not a valid git clone: reset.
         echo "Please, delete the $DIR directory, it is not a Git clone."
         exit 1;
      fi
      git clone -b master --single-branch --depth 1 $URL $DIR
      exit_if_failed
   else
      (cd $DIR && git fetch --depth 1 && git reset --hard origin/master)
      exit_if_failed
   fi;
}

DIR=ATS2
URL=git://git.code.sf.net/p/ats2-lang/code
get_or_update_git_clone

DIR=ATS2-contrib
URL=https://github.com/githwxi/ATS-Postiats-contrib.git
get_or_update_git_clone

DIR=PostiATS-Utilities
URL=https://github.com/Hibou57/PostiATS-Utilities.git
get_or_update_git_clone

######
# Building patsopt + patscc
(cd ATS2 && ./configure --prefix="$INST_DIR"); exit_if_failed
(cd ATS2 && make all && make clean); exit_if_failed
#
######
# Installing patscc and patsopt
(cd ATS2 && make install); exit_if_failed

export PATSHOME=$(find "$INST_DIR/lib" -mindepth 1 -maxdepth 1 -type d -name "ats2-postiats-*")
if [ \! $(echo $PATSHOME | wc -w) -eq 1 ]; then
   echo "Error: there should be exactly one ATS2 version in $INST_DIR/lib"
   exit
fi;
export PATSCONTRIB="$PWD/ATS2"  # The build-time one, not the final one.
export PATH="$INST_DIR/bin:$PATH"
PATSHOME_NAME=$(basename $PATSHOME)

ln -fs lib/$PATSHOME_NAME/share $INST_DIR/share
(cd ATS2-contrib && cp -r contrib "$INST_DIR/")
(cd ATS2-contrib && cp -r document "$INST_DIR/doc")
(cd ATS2 && cp -r doc "$INST_DIR/")

######
# For parsing constraints
(cd ATS2/contrib/ATS-extsolve && make DATS_C); exit_if_failed
# For building patsolve_z3
(cd ATS2/contrib/ATS-extsolve-z3 && make all && make clean); exit_if_failed
(cd ATS2/contrib/ATS-extsolve-z3/bin && mv -f patsolve_z3 $PATSHOME/bin); exit_if_failed
# For building patsolve_smt2
(cd ATS2/contrib/ATS-extsolve-smt2 && make all && make clean); exit_if_failed
(cd ATS2/contrib/ATS-extsolve-smt2/bin && mv -f patsolve_smt2 $PATSHOME/bin); exit_if_failed

######
# For parsing C code
# generated from ATS source
#
(cd ATS2/contrib/CATS-parsemit && make all); exit_if_failed
#
# For installing PostiATS-Utilities
cp -ar "PostiATS-Utilities/doc" "$INST_DIR/doc/Hibou57"
cp "PostiATS-Utilities/README.md" "$INST_DIR/doc/Hibou57/"
cp -ar "PostiATS-Utilities/postiats" "$INST_DIR/bin/"
if [ ! -d "$INST_DIR/bin/postiats" ]; then
   mkdir -p "$INST_DIR/bin/postiats"
fi
for f in "PostiATS-Utilities/pats-"*; do
   cp -a $f "$INST_DIR/bin/"
done
#
# Safely strip executables and libraries
#
EXECUTABLES=$(find "$INST_DIR" -type f -perm -u=x -exec file -i {} \; | grep "charset=binary" | sed -n "s/^\(.*\):.*$/\1/p")
for FILE in $EXECUTABLES; do
   COMMAND="strip --strip-unneeded \"$FILE\""
   echo $COMMAND
   eval $COMMAND
done
#
# Reminder
#
echo "========================="
echo "Please, ensure your environement (ex. from \`.profile\`) has these:"
echo "export PATSHOME=$PATSHOME"
stow -d $HOME/.local/ats -t $HOME/.local --override=".*" bin contrib doc lib share
