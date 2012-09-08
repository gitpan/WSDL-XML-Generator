use inc::Module::Install;

name     'WSDL-XML-Generator';
all_from 'lib/WSDL/XML/Generator.pm';
author   q{Linus <yuan_shijiang@163.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

