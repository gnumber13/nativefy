#!/bin/sh

. ./nativefy.conf

to_lower_and_snake_case()
## convert webapp_name to lower case and replace spaces with underscore ##
{
echo $(echo $1 | tr ' ' '_' | tr '[:upper:]' '[:lower:]')
}

# needs test
make_dirs() 
{
    echo "creating dir $webapps_folder"
    mkdir -p $webapps_folder
    echo "creating dir $user_path_directory"
    mkdir -p $user_path_directory
    echo "creating dir $user_appliations_directory"
    mkdir -p $user_appliations_directory
}

get_build_electron_version()
## determine electron version to build with ##
{
    # get npm and system electron versions
    system_el_version=$(electron -v | cut -c2-)
    npm_el_version=$(npm list electron | grep electron | cut -d'@' -f2 | cut -d' ' -f1)

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

write_to_template() {
    app_root=$(pwd)
    cd $webapps_folder/$1-linux-*

    desktop_file="$1.desktop"
    echo "Name=$2" >> $desktop_file
    echo "Exec=$3" >> $desktop_file
    echo "Icon=$4" >> $desktop_file
    echo "StartupWMClass=$5" >> $desktop_file

    cd $app_root
}

get_wm_class(){
    echo "$(cat $1 | jq .name | cut -d"\"" -f2)"
}

create_desktop_file(){
    ## creates desktop file for newly created webapp, takes webapp display name (capitalized with spaces if you like) ##    
    webapp_display_name=$1 
    webapp_name=$2
    nativefy_root=$(pwd)

    echo "$(pwd) <----"
    echo "webapps/"$webapp_name"-linux*"
    cd $webapps_folder/"$webapp_name"-linux* || echo "duplicates detectet"
    echo "$(pwd) <---"
    cat $nativefy_root/template.desktop > "$webapp_name".desktop

    # set variables for the .desktop file
    startup_wm_class=$(get_wm_class resources/app/package.json)
    exec_path="$(pwd)/$webapp_name"
    icon_path="$(pwd)/resources/app/icon.png"

    #write_to_template $1 $exec_path $webapp_display_name $icon_path $startup_wm_class
    write_to_template $webapp_name "$webapp_display_name" $exec_path $icon_path $startup_wm_class
}

copy_desktop_file_to_directory(){
    cp $1 $2
}
create_symlink_to_user_path(){
    ln -s $1 $2
}
