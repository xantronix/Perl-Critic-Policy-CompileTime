PPIx::PerlCompiler and Perl::Critic::Policy::CompileTime
========================================================

A dynamic duo for finding abberant code with bad compile-time side effects!
---------------------------------------------------------------------------

PPIx::PerlCompiler is a suite of extensions to PPI which allow one to quickly
find code in a large codebase or installation which may not run the way one
expects when compiled by the Perl compiler, B::C.  It does so by performing
some rudimentary pattern matching against statements and subexpressions in
specific instances.

Current features
----------------

PPIx::PerlCompiler provides the ability to check compile time code blocks,
BEGIN, UNITCHECK, and CHECK, for code that may likely have system-wide side
effects, or may perform I/O that may invalidate dependent state of compiled
binaries when they run.

PPIx::PerlCompiler also provides Perl::Critic::Policy::CompileTime, which issues
severity level 40 advisories regarding the aforementioned features in Perl code.
To use Perl::Critic::Policy::CompileTime, simply add something like the
following to your .perlcriticrc file:

    include = CompileTime
