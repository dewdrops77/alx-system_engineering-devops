# Installing a package with a particular version
package { 'flask':
  ensure   => '2.1.0',
  provider => pip3;
  }
