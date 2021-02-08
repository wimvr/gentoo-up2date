# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Easily keep your Gentoo system updated"
HOMEPAGE="https://github.com/wimvr/nagios-check_ext"
SRC_URI="https://github.com/wimvr/gentoo-up2date/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="anacron"

DEPEND="virtual/cron"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/gentoo-${PF}/ ${WORKDIR}/${PF}/
}

src_install() {
	dodoc README CHANGELOG DESCRIPTION
	exeinto /usr/bin
	if use anacron; then
		doexe up2date.daily
		doexe up2date.weekly
	else
		doexe up2date
	fi
}

pkg_postinst() {
	if use anacron; then
		elog "To actually run the tool, add the following lines to /etc/crontab:"
		elog ""
		elog "    1       30      dailyu2d        /usr/bin/up2date.daily"
		elog "    7       50      weeklyu2d       /usr/bin/up2date.weekly"
	else
		elog "To actually run the tool, add the following line to /etc/crontab:"
		elog ""
		elog "    55 1 * * *      root    /usr/bin/up2date"
	fi
}

