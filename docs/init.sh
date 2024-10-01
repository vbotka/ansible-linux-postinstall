#!/bin/sh

SOURCE=${HOME}/.ansible/roles/ansible-ansible/contrib/docs

USAGE="
$(basename "$0") role_path [force] [GITHUB_USER] [GITHUB_PROJECT] [GALAXY_PROJECT]

Copy docs framework from ${SOURCE} to role_path/docs. Optionally, override (force) existing \
files and replace default globals.

Example:
shell>  ./init.sh /home/admin/.ansible/roles/ansible-ansible force vbotka ansible none
Force the framework to this docs and replace all globals except the Galaxy project."

EXPECTED_ARGS=1
if [ $# -lt $EXPECTED_ARGS ]; then
    echo "$USAGE"
    exit
fi

DEST="${1}"
FORCE="${2:-noforce}"
GITHUB_USER="${3:-none}"
GITHUB_PROJECT="${4:-none}"
GALAXY_PROJECT="${5:-none}"

DOC_DIRS="docs \
docs/annotation \
docs/annotation/vars"

DOC_FILES="batch1.sh \
init.sh \
playbook.yml"

DOC_ANNOTATION_FILES="README \
annotation-handlers.rst.j2 \
annotation-handlers.yml.j2 \
annotation-tasks.rst.j2 \
annotation-tasks.yml.j2 \
annotation-templates.rst.j2 \
annotation-templates.yml.j2 \
pb-annotations.yml"

DOC_ANNOTATION_TEMPLATES="annotation-handlers.rst.j2 \
annotation-handlers.yml.j2 \
annotation-tasks.rst.j2 \
annotation-tasks.yml.j2 \
annotation-templates.rst.j2 \
annotation-templates.yml.j2"

create_dir () {
    if [ ! -e "$1" ]; then
	if (mkdir "$1"); then
	    printf "[OK]  dir %s created\n" "$1"
	else
	    printf "[ERR] can not create dir %s\n" "$1"
	fi
    else
	printf "[OK]  dir %s exists\n" "$1"
    fi
}

copy_file () {
    if [ ! -e "$2" ]; then
	if (cp "$1" "$2"); then
	    printf "[OK]  file %s created\n" "$2"
	else
	    printf "[ERR] can not create %s\n" "$2"
	fi
    else
	printf "[OK]  file %s exists\n" "$2"
    fi
}

force_file () {
    if (cp "$1" "$2"); then
	printf "[OK]  file %s forced\n" "$2"
    else
	printf "[ERR] can not force %s\n" "$2"
    fi
}

# Create dirs - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for d in $DOC_DIRS; do
    create_dir "$DEST"/"$d"
done

# Copy docs files
for f in $DOC_FILES; do
    if [ "$FORCE" = "force" ]; then
	force_file "$SOURCE"/"$f" "$DEST"/docs/"$f"
    else
	copy_file "$SOURCE"/"$f" "$DEST"/docs/"$f"
    fi
done

# Copy annotation files - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for f in $DOC_ANNOTATION_FILES; do
    if [ "$FORCE" = "force" ]; then
	force_file "$SOURCE"/annotation/"$f" "$DEST"/docs/annotation/"$f"
    else
        copy_file "$SOURCE"/annotation/"$f" "$DEST"/docs/annotation/"$f"
    fi
done

# Replace globals - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ "$GITHUB_USERNAME" != "none" ]; then
    for f in $DOC_ANNOTATION_TEMPLATES; do
	sed -i "s/__GITHUB_USERNAME__/${GITHUB_USER}/g" "$DEST"/docs/annotation/"$f"
    done
fi
if [ "$PROJECT" != "none" ]; then
    for f in $DOC_ANNOTATION_TEMPLATES; do
	sed -i "s/__PROJECT__/${GITHUB_PROJECT}/g" "$DEST"/docs/annotation/"$f"
    done
fi
if [ "$GALAXY_PROJECT" != "none" ]; then
    for f in $DOC_ANNOTATION_TEMPLATES; do
	sed -i "s/__GALAXY_PROJECT__/${GALAXY_PROJECT}/g" "$DEST"/docs/annotation/"$f"
    done
fi

# EOF
