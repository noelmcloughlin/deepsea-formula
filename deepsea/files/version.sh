set -xv
( git describe 2>/dev/null || echo '0.0.0') | sed -e 's/^v//' -e 's/-/+/' -e 's/-/./'
