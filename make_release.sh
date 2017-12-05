VERSION="$1"

if [ -z "$1"  ];
then
  echo "No version provided"  
  VERSION="noname"
fi

rm -R optiminer-equihash/bin optiminer-equihash/logs
mkdir -p optiminer-equihash/bin
cp -r ~/programme/optiminer-zcash/bin/Equihash*.bin optiminer-equihash/bin/

for V in 191205 200406 203603 207903 223600
do
  mkdir -p "optiminer-equihash/bin-$V"
  cp -r ~/programme/optiminer-zcash/bin-$V/Equihash*.bin "optiminer-equihash/bin-$V/"
done

cp ~/programme/optiminer-zcash/build/optiminer-equihash optiminer-equihash/
cp ~/programme/optiminer-zcash/LICENSE optiminer-equihash/
cp ~/programme/optiminer-zcash/*-license.txt optiminer-equihash/
cp ~/programme/optiminer-zcash/mine*.sh optiminer-equihash/
cp ~/programme/optiminer-zcash/watchdog-cmd.sh optiminer-equihash/
cp README.md optiminer-equihash/
rm bin/x*.bin
strip optiminer-equihash/optiminer-equihash
tar -h -czvf optiminer-equihash-${VERSION}.tar.gz optiminer-equihash/*

