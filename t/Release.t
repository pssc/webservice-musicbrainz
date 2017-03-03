use strict;
use Test::More;

use WebService::MusicBrainz;
use Data::Dumper;

my $ws = WebService::MusicBrainz->new();
ok($ws);

my $s1_res = $ws->search(release => { mbid => '2139a963-42d2-4f3d-be3f-8e0177640c75' });
ok($s1_res->{title} eq 'Love Is Hell');
ok($s1_res->{quality} eq 'normal');
ok($s1_res->{date} eq '2004-05-03');
ok($s1_res->{country} eq 'US');

my $s2_res = $ws->search(release => { mbid => '2139a963-42d2-4f3d-be3f-8e0177640c75', inc => 'artists' });
ok(defined($s2_res->{'artist-credit'}));
ok(defined($s2_res->{'artist-credit'}->[0]->{artist}));
ok($s2_res->{'artist-credit'}->[0]->{artist}->{'sort-name'} eq 'Adams, Ryan');

my $s3_res = $ws->search(release => { mbid => '2139a963-42d2-4f3d-be3f-8e0177640c75', inc => 'url-rels' });
ok(defined($s3_res->{relations}));
ok($s3_res->{relations}->[0]->{type} eq 'amazon asin');
ok($s3_res->{relations}->[0]->{direction} eq 'forward');

done_testing();
