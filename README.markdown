# Overview

"TaxWorks" is a simple Ruby application and library that accepts a list of
products, then shows a receipt for those products, along with any taxes you've
paid as a result.

Written by [John Feminella](http://linkedin.com/in/johnxf).

# Packaging

There are no dependencies other than a recent version of Ruby to run
`tax_works`. Use Ruby 1.9.3-p0 for best results.

The test dependencies can be installed with Bundler:

    gem install bundler
    bundle install

# Usage

Provide a file (either on standard input or as an argument) to the `tax_works`
executable. `tax_works` expects your input to be well-formed, and expects your
file to follow the format of the examples.

    $ bin/tax_works < input.txt
    $ bin/tax_works input.txt

You can also run TaxWorks directly with your local Ruby, if you're in an
environment that can't look up your local `ruby` from the shell.

    $ ruby bin/tax_works < input.txt
    $ ruby bin/tax_works input.txt

Alternatively, from IRB:

    $ irb -Ilib                   # Ensure lib is on your path.
    >> require 'tax_works'
    # => true

    >> TaxWorks.load_from File.open "input.txt"
    # => ...

# Running the examples

The examples given with the original problem are in the examples directory as
input[1-3].txt, so you can run those with:

    $ ruby bin/tax_works < examples/input1.txt

# Specifying additional exemptions

TaxWorks conveniently computes sales tax on items for you, subject to exemptions
based on your local laws. It ships with some exemptions initially.  Exemptions
are in the form of YAML strings.

Because laws may differ from country to country (or even within a particular
country) about which items are and are not exempt from sales tax, TaxWorks
allows you to provide your own list of exemptions.

This file is expected to have certain properties:

  * It must be named "exemptions.yml".

  * It must contain only a YAML array of strings to match.

If a product you supply matches an exemption, it will be excluded from sales tax
computations.

Hopefully, you will upgrade your receipt-printing software soon to something
more robust than TaxWorks, as anyone who uses regular expressions to make
inferences about object state (especially where financial reasons are concerned)
is living in a state of sin.

# Running tests

You can run the tests by running 'rake'.

# Finally

Thanks for using TaxWorks!
