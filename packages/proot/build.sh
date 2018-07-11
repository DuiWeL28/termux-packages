TERMUX_PKG_HOMEPAGE=https://proot-me.github.io/
TERMUX_PKG_DESCRIPTION="Emulate chroot, bind mount and binfmt_misc for non-root users"
# Just bump commit and version when needed:
_COMMIT=46c3ed54c824765cb90c5de3c158f1adeb3203c7
TERMUX_PKG_VERSION=5.1.107
TERMUX_PKG_REVISION=12
TERMUX_PKG_SRCURL=https://github.com/CypherpunkArmory/proot/archive/${_COMMIT}.zip
TERMUX_PKG_SHA256=9aa207bf1e956f25d826fa4fa3653c033fbec6c5ebd24d78e80aa5c8ac26b3c9
TERMUX_PKG_DEPENDS="libtalloc"

termux_step_pre_configure() {
	export LD=$CC
	CPPFLAGS+=" -DARG_MAX=131072"
}

termux_step_make_install () {
	export CROSS_COMPILE=${TERMUX_HOST_PLATFORM}-

	cd $TERMUX_PKG_SRCDIR/src
	make V=1
	make install

	mkdir -p $TERMUX_PREFIX/share/man/man1
	cp $TERMUX_PKG_SRCDIR/doc/proot/man.1 $TERMUX_PREFIX/share/man/man1/proot.1

	cp $TERMUX_PKG_BUILDER_DIR/termux-chroot $TERMUX_PREFIX/bin/
}
