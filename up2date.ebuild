# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Easily keep your Gentoo system updated"
HOMEPAGE="https://sourceforge.net/projects/gentoo-up2date/"
SRC_URI="mirror://sourceforge/gentoo-up2date/${P}.tar.bz2"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="anacron"

DEPEND="virtual/cron"
RDEPEND="${DEPEND}"

src_compile() {
	# Nothing to compile, remember, we are just a shell script...
	einfo "Nothing to compile"
}

src_install() {
	dodoc README CHANGELOG DESCRIPTION
	exeinto /usr/bin
	if use anacron; then
		doexe up2date.daily
		doexe up2date.weekly
		elog "To actually run the tool, add the following lines to /etc/crontab:"
		elog ""
		elog "    1       30      dailyu2d        /usr/bin/up2date.daily"
		elog "    7       50      weeklyu2d       /usr/bin/up2date.weekly"
	else
		doexe up2date
		elog "To actually run the tool, add the following line to /etc/crontab:"
		elog ""
		elog "    55 1 * * *      root    /usr/bin/up2date"
	fi
}

