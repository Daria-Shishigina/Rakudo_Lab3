use v6;
my $res = {};
my $pathToFileOne = "file1.txt"; # path to file 1
my $pathToFileTwo = "file2.txt"; # path to file 2
my $pathToFileResult = "result.txt"; # path to file result


if (my $fh = open $pathToFileOne, :r) {
    for $fh.lines -> $line {
		my $regRes = ($line ~~ /(\S+)\s(\d+)/);
		if !$regRes[0] or !$regRes[1] {next;}
		$res{$regRes[0]}{'age'} = $regRes[1];
	}
 }


if (my $ft = open $pathToFileTwo, :r) {
    for $ft.lines -> $line {
		my $regRes = ($line ~~ /(\S+)\s(\d+\-\d+\-\d+)/);
		if !$regRes[0] or !$regRes[1] {next;};
		$res{$regRes[0]}{'phone'} = $regRes[1];
	}
}

if keys($res).elems != 0 {
	my $newFileRow = ("Name			Age		Phone\n");
	for $res.keys.sort -> $key {
		my $age = (!$res{$key}{'age'}) ?? '-' !! $res{$key}{'age'};
		my $phone = (!$res{$key}{'phone'}) ?? '-' !! $res{$key}{'phone'};
		$newFileRow ~= ("$key 			$age 		$phone\n");
	}
    if (my $fr = open $pathToFileResult, :w) {
	print("$newFileRow\nData was saved into $pathToFileResult");
        $fr.say($newFileRow);
    } else {
	die "Can`n save file";
	}
} else {
	die "No one line was found";
}