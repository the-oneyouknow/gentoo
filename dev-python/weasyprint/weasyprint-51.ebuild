# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Visual rendering engine for HTML and CSS that can export to PDF"
MY_PN="WeasyPrint"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"
HOMEPAGE="https://weasyprint.org https://github.com/Kozea/WeasyPrint"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jpeg test tiff"
RESTRICT="!test? ( test )"

# Note: specific subslot of pango since it inlines some of pango headers.
#	>=dev-python/lxml-3.0[${PYTHON_USEDEP}]
RDEPEND="
	>=dev-python/cairocffi-0.9[${PYTHON_USEDEP}]
	>=dev-python/cffi-0.6:=[${PYTHON_USEDEP}]
	>=dev-python/cssselect2-0.1[${PYTHON_USEDEP}]
	>=dev-python/html5lib-0.999999999[${PYTHON_USEDEP}]
	>=dev-python/pyphen-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/tinycss2-1.0.0[${PYTHON_USEDEP}]
	>=media-gfx/cairosvg-2.4.0[${PYTHON_USEDEP}]
	>=x11-libs/cairo-1.15.4
	x11-libs/gdk-pixbuf[jpeg?,tiff?]
	x11-libs/pango:0/0
"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}]
		media-fonts/ahem
	)
"

PATCHES=( "${FILESDIR}/${PN}-51-skip-useless-deps.patch" )
# 	"${FILESDIR}/${PN}-43-skip-failing-test.patch"

S="${WORKDIR}/${MY_P}"

python_test() {
	pytest -vv || die "testsuite failed under ${EPYTHON}"
}
