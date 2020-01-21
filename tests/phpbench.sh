mkdir -p /root/.phoronix-test-suite/
cp -rf /tests/user-config.xml /root/.phoronix-test-suite/
cp -rf /tests/user-config.xml /etc/phoronix-test-suite.xml
phoronix-test-suite batch-benchmark pts/phpbench
