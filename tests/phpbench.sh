mkdir -p /root/.phoronix-test-suite/
cp -rf /tests/user-config.xml /root/.phoronix-test-suite/
phoronix-test-suite batch-benchmark pts/phpbench
