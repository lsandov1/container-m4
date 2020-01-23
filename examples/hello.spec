Summary: hello greets the world
Name: hello
Version: 1.0
Release: 1
License: GPL
Group: Applications/Tutorials
Source: hello.tar.gz

%description
hello greets the world

%prep
%setup

%build
make

%install
#make install prefix=\$RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/bin
install -m755 hello $RPM_BUILD_ROOT/usr/bin/

%files
%defattr(-, root, root)
/usr/bin/hello
