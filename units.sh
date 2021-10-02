#!/bin/sh

to_lower_and_snake_case()
## convert webapp_name to lower case and replace spaces with underscore ##
{
echo $(echo $1 | tr ' ' '_' | tr '[:upper:]' '[:lower:]')
}

get_build_electron_version()
## determine electron version to build with ##
{
    # get npm and system electron versions
    system_el_version=$(electron -v | cut -c2-)
    npm_el_version=$(npm list electron | grep electron | cut -d'@' -f2)

    case $1 in
        default)
            [ $system_el_version == '' ] && build_el_version=$npm_el_version \
                || build_el_version=$system_el_version
            ;;
        system)
            build_el_version=$system_el_version
            ;;
        npm)
            build_el_version=$npm_el_version
            ;;
        *)
            echo "custom electron versions are unsupported right now"
            exit
            ;;
    esac

    echo $build_el_version
}

is_webpage_up() {
    ping -c1 -q $1 > /dev/null && echo true || echo false
}


