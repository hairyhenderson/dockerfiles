zeek-grep() {
    grep -E "(^#)|$1" $2;
}
alias zeek-column="sed \"s/fields.//;s/types.//\" | column -s $'\t' -t"
