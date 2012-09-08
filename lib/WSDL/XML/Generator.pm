package WSDL::XML::Generator;

use 5.006;
use strict;
use warnings;

=head1 NAME

WSDL::XML::Generator - The great new WSDL::XML::Generator!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Just find out Type in WSDL file, write test xml sample.

    use WSDL::XML::Generator qw( write );
    write('t/test.wsdl'); 

=head1 EXPORT

    write

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

use Carp;
use Exporter;
use File::Slurp qw(read_file write_file);
our @ISA    = qw( Exporter );
our @EXPORT = qw( write );

sub write {
    my $wsdl_file = shift;
    my $element_name;
    open( my $src, $wsdl_file ) or die $!;
    my ($file_name_prex) = $wsdl_file =~ /(\w+)\.wsdl/;
    my @lines = read_file($wsdl_file);
    foreach (@lines) {
        if ( /<types>/ .. /<\/types>/ ) {
            if ( /<xsd:element name="(\w+)">/ .. /<\/xsd:element>/ ) {
                $element_name =
                  /<xsd:element name="(\w+)">/ ? $1 : $element_name;
                my $output_xml = $file_name_prex . '_' . $element_name . '.xml';
                if ( /<xsd:sequence>/ .. /<\/xsd:sequence>/ ) {
                    if (/<xsd:element name="(\w+)" type="(.*)" \/>/) {
                        my $name = $1;
                        write_file( $output_xml, { append => 1 },
                            "<$name>$name<\/$name>" );
                    }
                }
            }
        }
    }
    return 1;
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Linus, C<< <yuan_shijiang at 163.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-wsdl-xml-generator at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WSDL-XML-Generator>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WSDL::XML::Generator


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WSDL-XML-Generator>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WSDL-XML-Generator>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WSDL-XML-Generator>

=item * Search CPAN

L<http://search.cpan.org/dist/WSDL-XML-Generator/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Linus.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1;    # End of WSDL::XML::Generator
