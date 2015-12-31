module Settings.Packages.IntegerGmp (integerGmpPackageArgs) where

import Base
import Expression
import GHC (integerGmp)
import Predicates (builder, package)

-- TODO: Is this needed?
-- ifeq "$(GMP_PREFER_FRAMEWORK)" "YES"
-- libraries/integer-gmp_CONFIGURE_OPTS += --with-gmp-framework-preferred
-- endif
integerGmpPackageArgs :: Args
integerGmpPackageArgs = package integerGmp ?
    builder GhcCabal ? mconcat
        [ arg "--configure-option=--with-intree-gmp"
        , appendSub "--configure-option=CFLAGS" includeGmp
        , appendSub "--gcc-options"             includeGmp ]
  where
    includeGmp = ["-I" ++ pkgPath integerGmp -/- "gmp"]
