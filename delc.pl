#!/usr/bin/perl -w

if (@ARGV){ 
    @file_list = @ARGV;
}else{ 
    print "ERROR: no args\n";
    exit 1;
}

my $arg_in_single_string = "";
foreach $file (@file_list){
    $arg_in_single_string = $arg_in_single_string . " " . $file;
}

my @all_files = glob($arg_in_single_string);

my @file_delete_array;
foreach $file (@all_files){
    $type = "file";
    if(-d $file){
        $type = "directory"
    }

    print "delete? [y,q] $type: $file ";
    $input1 = <STDIN>;

    if(lc($input1) eq "y\n"){
        push @file_delete_array, $file;
    }elsif(lc($input1) eq "q\n"){
        last;
    }
}

if(scalar(@file_delete_array) > 0){
    print "complete all deletions? [y]: ";
    $input2 = <STDIN>;
    
    if($input2 eq "Y\n"){
        foreach $file (@file_delete_array){
            system("rm -rf $file");
        }
    }else{
        print "Nothing has been deleted.\n";
    }
}else{
    print "No files to Delete.\n";
}

exit 0;