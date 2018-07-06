using BinaryBuilder, Compat

# Collection of sources required to build ZMQ
sources = [
    "https://github.com/stevengj/cubature.git" =>
    "a61dd32094bcf925fbc4a93d02e0f0f147f8b734", # v1.0.3
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/cubature
${CC} ${LDFLAGS} -shared -fPIC -O3 hcubature.c pcubature.c -o ${libdir}/libcubature.${dlext}
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms() # build on all supported platforms

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libcubature", :libcubature),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "Cubature", sources, script, platforms, products, dependencies)
