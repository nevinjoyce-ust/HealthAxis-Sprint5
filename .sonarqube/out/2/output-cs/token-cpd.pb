Ά
RC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IPatientService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
;! "
public 
	interface 
IPatientService  
{ 
Task 
< 	

PatientDto	 
> 
GetPatientByIdAsync (
(( )
int) ,
id- /
)/ 0
;0 1
Task		 
<		 	

PatientDto			 
>		 #
GetPatientByUserIdAsync		 ,
(		, -
string		- 3
userId		4 :
)		: ;
;		; <
Task 
< 	

PatientDto	 
> 
UpdatePatientAsync '
(' (
int( +
id, .
,. /
UpdatePatientDto0 @
dtoA D
)D E
;E F
} •G
VC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\PatientService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
.! "
Impl" &
;& '
public

 
class

 
PatientService

 
(

 
IPatientRepository 
patientRepository (
,( )
UserManager 
< 
IdentityUser 
> 
userManager )
,) *
IMapper 
mapper 
) 
: 
IPatientService %
{ 
public 

async 
Task 
< 

PatientDto  
>  !
GetPatientByIdAsync" 5
(5 6
int6 9
id: <
)< =
{ 
var 
patient 
= 
await 
patientRepository -
.- .'
GetPatientByIdWithUserAsync. I
(I J
idJ L
)L M
;M N
if 

( 
patient 
== 
null 
) 
{ 	
throw 
new 
NotFoundException '
(' (
ErrorMessages( 5
.5 6
PatientNotFound6 E
)E F
;F G
} 	
return 
mapper 
. 
Map 
< 

PatientDto $
>$ %
(% &
patient& -
)- .
;. /
} 
public 

async 
Task 
< 

PatientDto  
>  !#
GetPatientByUserIdAsync" 9
(9 :
string: @
userIdA G
)G H
{ 
var 
patient 
= 
await 
patientRepository -
.- .#
GetPatientByUserIdAsync. E
(E F
userIdF L
)L M
;M N
if 

( 
patient 
== 
null 
) 
{   	
throw!! 
new!! 
NotFoundException!! '
(!!' (
ErrorMessages!!( 5
.!!5 6
PatientNotFound!!6 E
)!!E F
;!!F G
}"" 	
var$$ 
patientWithUser$$ 
=$$ 
await$$ #
patientRepository$$$ 5
.$$5 6'
GetPatientByIdWithUserAsync$$6 Q
($$Q R
patient$$R Y
.$$Y Z
Id$$Z \
)$$\ ]
;$$] ^
if&& 

(&& 
patientWithUser&& 
==&& 
null&& #
)&&# $
{'' 	
throw(( 
new(( 
NotFoundException(( '
(((' (
ErrorMessages((( 5
.((5 6
PatientNotFound((6 E
)((E F
;((F G
})) 	
return++ 
mapper++ 
.++ 
Map++ 
<++ 

PatientDto++ $
>++$ %
(++% &
patientWithUser++& 5
)++5 6
;++6 7
},, 
public.. 

async.. 
Task.. 
<.. 

PatientDto..  
>..  !
UpdatePatientAsync.." 4
(..4 5
int..5 8
id..9 ;
,..; <
UpdatePatientDto..= M
dto..N Q
)..Q R
{// 
var00 
patient00 
=00 
await00 
patientRepository00 -
.00- .'
GetPatientByIdWithUserAsync00. I
(00I J
id00J L
)00L M
;00M N
if22 

(22 
patient22 
==22 
null22 
)22 
{33 	
throw44 
new44 
NotFoundException44 '
(44' (
ErrorMessages44( 5
.445 6
PatientNotFound446 E
)44E F
;44F G
}55 	
if77 

(77 
patient77 
.77 
User77 
==77 
null77  
)77  !
{88 	
throw99 
new99 
NotFoundException99 '
(99' (
ErrorMessages99( 5
.995 6"
PatientAccountNotFound996 L
)99L M
;99M N
}:: 	
var;; 
email;; 
=;; 
dto;; 
.;; 
Email;; 
.;; 
Trim;; "
(;;" #
);;# $
;;;$ %
await== .
"EnsureEmailIsAvailableForUserAsync== 0
(==0 1
email==1 6
,==6 7
patient==8 ?
.==? @
UserId==@ F
)==F G
;==G H
patient?? 
.?? 
FullName?? 
=?? 
dto?? 
.?? 
FullName?? '
.??' (
Trim??( ,
(??, -
)??- .
;??. /
patient@@ 
.@@ 
DateOfBirth@@ 
=@@ 
dto@@ !
.@@! "
DateOfBirth@@" -
;@@- .
patientAA 
.AA 
GenderAA 
=AA 
dtoAA 
.AA 
GenderAA #
.AA# $
TrimAA$ (
(AA( )
)AA) *
;AA* +
patientBB 
.BB 
AddressBB 
=BB 
dtoBB 
.BB 
AddressBB %
.BB% &
TrimBB& *
(BB* +
)BB+ ,
;BB, -
patientDD 
.DD 
UserDD 
.DD 
EmailDD 
=DD 
emailDD "
;DD" #
patientEE 
.EE 
UserEE 
.EE 
UserNameEE 
=EE 
emailEE  %
;EE% &
patientFF 
.FF 
UserFF 
.FF 
PhoneNumberFF  
=FF! "
dtoFF# &
.FF& '
PhoneNumberFF' 2
.FF2 3
TrimFF3 7
(FF7 8
)FF8 9
;FF9 :
patientGG 
.GG 
UserGG 
.GG 
EmailConfirmedGG #
=GG$ %
trueGG& *
;GG* +
varII 
updateUserResultII 
=II 
awaitII $
userManagerII% 0
.II0 1
UpdateAsyncII1 <
(II< =
patientII= D
.IID E
UserIIE I
)III J
;IIJ K
ifKK 

(KK 
!KK 
updateUserResultKK 
.KK 
	SucceededKK '
)KK' (
{LL 	
varMM 
errorsMM 
=MM 
stringMM 
.MM  
JoinMM  $
(MM$ %
$strMM% (
,MM( )
updateUserResultMM* :
.MM: ;
ErrorsMM; A
.MMA B
SelectMMB H
(MMH I
errorMMI N
=>MMO Q
errorMMR W
.MMW X
DescriptionMMX c
)MMc d
)MMd e
;MMe f
throwNN 
newNN 
BadRequestExceptionNN )
(NN) *
errorsNN* 0
)NN0 1
;NN1 2
}OO 	
awaitQQ 
patientRepositoryQQ 
.QQ  
UpdateAsyncQQ  +
(QQ+ ,
patientQQ, 3
)QQ3 4
;QQ4 5
varSS 
updatedPatientSS 
=SS 
awaitSS "
patientRepositorySS# 4
.SS4 5'
GetPatientByIdWithUserAsyncSS5 P
(SSP Q
idSSQ S
)SSS T
;SST U
ifUU 

(UU 
updatedPatientUU 
==UU 
nullUU "
)UU" #
{VV 	
throwWW 
newWW 
NotFoundExceptionWW '
(WW' (
ErrorMessagesWW( 5
.WW5 6
PatientNotFoundWW6 E
)WWE F
;WWF G
}XX 	
returnZZ 
mapperZZ 
.ZZ 
MapZZ 
<ZZ 

PatientDtoZZ $
>ZZ$ %
(ZZ% &
updatedPatientZZ& 4
)ZZ4 5
;ZZ5 6
}[[ 
private]] 
async]] 
Task]] .
"EnsureEmailIsAvailableForUserAsync]] 9
(]]9 :
string]]: @
email]]A F
,]]F G
string]]H N
currentUserId]]O \
)]]\ ]
{^^ 
var__ 
normalizedEmail__ 
=__ 
email__ #
.__# $
Trim__$ (
(__( )
)__) *
;__* +
var`` 
existingUser`` 
=`` 
await``  
userManager``! ,
.``, -
FindByEmailAsync``- =
(``= >
normalizedEmail``> M
)``M N
;``N O
ifbb 

(bb 
existingUserbb 
!=bb 
nullbb  
&&bb! #
existingUserbb$ 0
.bb0 1
Idbb1 3
!=bb4 6
currentUserIdbb7 D
)bbD E
{cc 	
throwdd 
newdd 
ConflictExceptiondd '
(dd' (
ErrorMessagesdd( 5
.dd5 6
EmailAlreadyExistsdd6 H
)ddH I
;ddI J
}ee 	
}ff 
}gg ›x
[C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\HealthRecordService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
.! "
Impl" &
;& '
public 
class 
HealthRecordService  
(  !
HealthAxisDbContext 
context 
,  #
IHealthRecordRepository "
healthRecordRepository 2
,2 3"
IAppointmentRepository !
appointmentRepository 0
,0 1
IMapper 
mapper 
) 
:  
IHealthRecordService *
{ 
public 

async 
Task 
< 
PagedResultDto $
<$ %
HealthRecordDto% 4
>4 5
>5 6,
 GetHealthRecordsByPatientIdAsync7 W
(W X
int 
	patientId 
, 
PaginationQueryDto 

pagination %
)% &
{ 
var 
records 
= 
await "
healthRecordRepository 2
.2 3,
 GetHealthRecordsByPatientIdAsync3 S
(S T
	patientId 
, 

pagination 
. 

PageNumber !
,! "

pagination 
. 
PageSize 
)  
;  !
return 
MapPagedResult 
< 
HealthRecord *
,* +
HealthRecordDto, ;
>; <
(< =
records= D
)D E
;E F
} 
public 

async 
Task 
< 
PagedResultDto $
<$ %
HealthRecordDto% 4
>4 5
>5 65
)GetHealthRecordsForDoctorPatientViewAsync7 `
(` a
int   
	patientId   
,   
int!! 
doctorId!! 
,!! 
PaginationQueryDto"" 

pagination"" %
)""% &
{## 
var$$ #
hasConfirmedAppointment$$ #
=$$$ %
await$$& +!
appointmentRepository$$, A
.%% 9
-DoctorHasConfirmedAppointmentWithPatientAsync%% :
(%%: ;
doctorId%%; C
,%%C D
	patientId%%E N
)%%N O
;%%O P
if'' 

('' #
hasConfirmedAppointment'' #
)''# $
{(( 	
return)) 
await)) ,
 GetHealthRecordsByPatientIdAsync)) 9
())9 :
	patientId)): C
,))C D

pagination))E O
)))O P
;))P Q
}** 	
return,, 
await,, 7
+GetHealthRecordsByPatientIdAndDoctorIdAsync,, @
(,,@ A
	patientId,,A J
,,,J K
doctorId,,L T
,,,T U

pagination,,V `
),,` a
;,,a b
}-- 
public// 

async// 
Task// 
<// 
PagedResultDto// $
<//$ %
HealthRecordDto//% 4
>//4 5
>//5 67
+GetHealthRecordsByPatientIdAndDoctorIdAsync//7 b
(//b c
int00 
	patientId00 
,00 
int11 
doctorId11 
,11 
PaginationQueryDto22 

pagination22 %
)22% &
{33 
var44 
records44 
=44 
await44 "
healthRecordRepository44 2
.442 37
+GetHealthRecordsByPatientIdAndDoctorIdAsync443 ^
(44^ _
	patientId55 
,55 
doctorId66 
,66 

pagination77 
.77 

PageNumber77 !
,77! "

pagination88 
.88 
PageSize88 
)88  
;88  !
return:: 
MapPagedResult:: 
<:: 
HealthRecord:: *
,::* +
HealthRecordDto::, ;
>::; <
(::< =
records::= D
)::D E
;::E F
};; 
public== 

async== 
Task== 
<== 
HealthRecordDto== %
>==% &$
GetHealthRecordByIdAsync==' ?
(==? @
int==@ C
id==D F
)==F G
{>> 
var?? 
record?? 
=?? 
await?? "
healthRecordRepository?? 1
.??1 2/
#GetHealthRecordByIdWithDetailsAsync??2 U
(??U V
id??V X
)??X Y
;??Y Z
ifAA 

(AA 
recordAA 
==AA 
nullAA 
)AA 
{BB 	
throwCC 
newCC 
NotFoundExceptionCC '
(CC' (
ErrorMessagesCC( 5
.CC5 6 
HealthRecordNotFoundCC6 J
)CCJ K
;CCK L
}DD 	
returnFF 
mapperFF 
.FF 
MapFF 
<FF 
HealthRecordDtoFF )
>FF) *
(FF* +
recordFF+ 1
)FF1 2
;FF2 3
}GG 
publicII 

asyncII 
TaskII 
<II 
HealthRecordDtoII %
>II% &#
CreateHealthRecordAsyncII' >
(II> ?!
CreateHealthRecordDtoII? T
dtoIIU X
,IIX Y
intIIZ ]
doctorIdII^ f
)IIf g
{JJ 
varKK 
appointmentKK 
=KK 
awaitKK !
appointmentRepositoryKK  5
.KK5 6.
"GetAppointmentByIdWithDetailsAsyncKK6 X
(KKX Y
dtoKKY \
.KK\ ]
AppointmentIdKK] j
)KKj k
;KKk l
ifMM 

(MM 
appointmentMM 
==MM 
nullMM 
)MM  
{NN 	
throwOO 
newOO 
NotFoundExceptionOO '
(OO' (
ErrorMessagesOO( 5
.OO5 6
AppointmentNotFoundOO6 I
)OOI J
;OOJ K
}PP 	
ifRR 

(RR 
appointmentRR 
.RR 
PatientRR 
==RR  "
nullRR# '
)RR' (
{SS 	
throwTT 
newTT 
NotFoundExceptionTT '
(TT' (
ErrorMessagesTT( 5
.TT5 6
PatientNotFoundTT6 E
)TTE F
;TTF G
}UU 	
ifWW 

(WW 
appointmentWW 
.WW 
DoctorIdWW  
!=WW! #
doctorIdWW$ ,
)WW, -
{XX 	
throwYY 
newYY 
ForbiddenExceptionYY (
(YY( )
ErrorMessagesYY) 6
.YY6 7<
0DoctorCanCreateHealthRecordOnlyForOwnAppointmentYY7 g
)YYg h
;YYh i
}ZZ 	
if\\ 

(\\ 
appointment\\ 
.\\ 
Status\\ 
!=\\ !
AppointmentStatus\\" 3
.\\3 4
	Confirmed\\4 =
)\\= >
{]] 	
throw^^ 
new^^ !
BusinessRuleException^^ +
(^^+ ,
ErrorMessages^^, 9
.^^9 :3
'OnlyConfirmedAppointmentsCanBeCompleted^^: a
)^^a b
;^^b c
}__ 	
varaa 
todayaa 
=aa 
DateOnlyaa 
.aa 
FromDateTimeaa )
(aa) *
DateTimeaa* 2
.aa2 3
Todayaa3 8
)aa8 9
;aa9 :
ifcc 

(cc 
appointmentcc 
.cc 
AppointmentDatecc '
!=cc( *
todaycc+ 0
)cc0 1
{dd 	
throwee 
newee !
BusinessRuleExceptionee +
(ee+ ,
ErrorMessagesee, 9
.ee9 :9
-HealthRecordCanBeCreatedOnlyOnAppointmentDateee: g
)eeg h
;eeh i
}ff 	
ifhh 

(hh 
dtohh 
.hh 
	VisitDatehh 
!=hh 
appointmenthh (
.hh( )
AppointmentDatehh) 8
)hh8 9
{ii 	
throwjj 
newjj !
BusinessRuleExceptionjj +
(jj+ ,
ErrorMessagesjj, 9
.jj9 :-
!VisitDateMustMatchAppointmentDatejj: [
)jj[ \
;jj\ ]
}kk 	
varmm 
existingRecordmm 
=mm 
awaitmm ""
healthRecordRepositorymm# 9
.mm9 :/
#GetHealthRecordByAppointmentIdAsyncmm: ]
(mm] ^
dtomm^ a
.mma b
AppointmentIdmmb o
)mmo p
;mmp q
ifoo 

(oo 
existingRecordoo 
!=oo 
nulloo "
)oo" #
{pp 	
throwqq 
newqq 
ConflictExceptionqq '
(qq' (
ErrorMessagesqq( 5
.qq5 63
'HealthRecordAlreadyExistsForAppointmentqq6 ]
)qq] ^
;qq^ _
}rr 	
awaittt 
usingtt 
vartt 
transactiontt #
=tt$ %
awaittt& +
contexttt, 3
.tt3 4
Databasett4 <
.tt< =!
BeginTransactionAsynctt= R
(ttR S
)ttS T
;ttT U
tryvv 
{ww 	
varxx 
healthRecordxx 
=xx 
newxx "
HealthRecordxx# /
{yy 
AppointmentIdzz 
=zz 
dtozz  #
.zz# $
AppointmentIdzz$ 1
,zz1 2

PatientAge{{ 
={{ 
CalculateAge{{ )
({{) *
appointment{{* 5
.{{5 6
Patient{{6 =
.{{= >
DateOfBirth{{> I
,{{I J
appointment{{K V
.{{V W
AppointmentDate{{W f
){{f g
,{{g h
	VisitDate|| 
=|| 
dto|| 
.||  
	VisitDate||  )
,||) *
	Diagnosis}} 
=}} 
dto}} 
.}}  
	Diagnosis}}  )
,}}) *
Prescription~~ 
=~~ 
dto~~ "
.~~" #
Prescription~~# /
,~~/ 0
Notes 
= 
dto 
. 
Notes !
}
€€ 
;
€€ 
var
‚‚ 
createdRecord
‚‚ 
=
‚‚ 
await
‚‚  %$
healthRecordRepository
‚‚& <
.
‚‚< =
AddAsync
‚‚= E
(
‚‚E F
healthRecord
‚‚F R
)
‚‚R S
;
‚‚S T
appointment
„„ 
.
„„ 
Status
„„ 
=
„„  
AppointmentStatus
„„! 2
.
„„2 3
	Completed
„„3 <
;
„„< =
await
…… #
appointmentRepository
…… '
.
……' (
UpdateAsync
……( 3
(
……3 4
appointment
……4 ?
)
……? @
;
……@ A
await
‡‡ 
transaction
‡‡ 
.
‡‡ 
CommitAsync
‡‡ )
(
‡‡) *
)
‡‡* +
;
‡‡+ ,
var
‰‰ 
recordWithDetails
‰‰ !
=
‰‰" #
await
‰‰$ )$
healthRecordRepository
‰‰* @
.
‰‰@ A1
#GetHealthRecordByIdWithDetailsAsync
‰‰A d
(
‰‰d e
createdRecord
‰‰e r
.
‰‰r s
Id
‰‰s u
)
‰‰u v
;
‰‰v w
return
‹‹ 
recordWithDetails
‹‹ $
==
‹‹% '
null
‹‹( ,
?
 
throw
 
new
 
NotFoundException
 -
(
- .
ErrorMessages
. ;
.
; </
!HealthRecordNotFoundAfterCreation
< ]
)
] ^
:
 
mapper
 
.
 
Map
 
<
 
HealthRecordDto
 ,
>
, -
(
- .
recordWithDetails
. ?
)
? @
;
@ A
}
 	
catch
 
{
 	
await
‘‘ 
transaction
‘‘ 
.
‘‘ 
RollbackAsync
‘‘ +
(
‘‘+ ,
)
‘‘, -
;
‘‘- .
throw
’’ 
;
’’ 
}
““ 	
}
”” 
public
–– 

async
–– 
Task
–– 
<
–– 
PagedResultDto
–– $
<
––$ %
HealthRecordDto
––% 4
>
––4 5
>
––5 6-
GetHealthRecordsByDoctorIdAsync
––7 V
(
––V W
int
—— 
doctorId
—— 
,
——  
PaginationQueryDto
 

pagination
 %
)
% &
{
™™ 
var
 
records
 
=
 
await
 $
healthRecordRepository
 2
.
2 3-
GetHealthRecordsByDoctorIdAsync
3 R
(
R S
doctorId
›› 
,
›› 

pagination
 
.
 

PageNumber
 !
,
! "

pagination
 
.
 
PageSize
 
)
  
;
  !
return
 
MapPagedResult
 
<
 
HealthRecord
 *
,
* +
HealthRecordDto
, ;
>
; <
(
< =
records
= D
)
D E
;
E F
}
   
private
ΆΆ 
static
ΆΆ 
int
ΆΆ 
CalculateAge
ΆΆ #
(
ΆΆ# $
DateOnly
ΆΆ$ ,
dateOfBirth
ΆΆ- 8
,
ΆΆ8 9
DateOnly
ΆΆ: B
referenceDate
ΆΆC P
)
ΆΆP Q
{
££ 
var
¤¤ 
age
¤¤ 
=
¤¤ 
referenceDate
¤¤ 
.
¤¤  
Year
¤¤  $
-
¤¤% &
dateOfBirth
¤¤' 2
.
¤¤2 3
Year
¤¤3 7
;
¤¤7 8
if
¦¦ 

(
¦¦ 
referenceDate
¦¦ 
<
¦¦ 
dateOfBirth
¦¦ '
.
¦¦' (
AddYears
¦¦( 0
(
¦¦0 1
age
¦¦1 4
)
¦¦4 5
)
¦¦5 6
{
§§ 	
age
¨¨ 
--
¨¨ 
;
¨¨ 
}
©© 	
return
«« 
age
«« 
;
«« 
}
¬¬ 
private
®® 
PagedResultDto
®® 
<
®® 
TDestination
®® '
>
®®' (
MapPagedResult
®®) 7
<
®®7 8
TSource
®®8 ?
,
®®? @
TDestination
®®A M
>
®®M N
(
®®N O
PagedResult
®®O Z
<
®®Z [
TSource
®®[ b
>
®®b c
pagedResult
®®d o
)
®®o p
{
―― 
return
°° 
new
°° 
PagedResultDto
°° !
<
°°! "
TDestination
°°" .
>
°°. /
{
±± 	
Items
²² 
=
²² 
mapper
²² 
.
²² 
Map
²² 
<
²² 
List
²² #
<
²²# $
TDestination
²²$ 0
>
²²0 1
>
²²1 2
(
²²2 3
pagedResult
²²3 >
.
²²> ?
Items
²²? D
)
²²D E
,
²²E F

PageNumber
³³ 
=
³³ 
pagedResult
³³ $
.
³³$ %

PageNumber
³³% /
,
³³/ 0
PageSize
΄΄ 
=
΄΄ 
pagedResult
΄΄ "
.
΄΄" #
PageSize
΄΄# +
,
΄΄+ ,

TotalCount
µµ 
=
µµ 
pagedResult
µµ $
.
µµ$ %

TotalCount
µµ% /
,
µµ/ 0

TotalPages
¶¶ 
=
¶¶ 
pagedResult
¶¶ $
.
¶¶$ %

TotalPages
¶¶% /
}
·· 	
;
··	 

}
ΈΈ 
}ΉΉ οε
UC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\DoctorService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
.! "
Impl" &
;& '
public 
class 
DoctorService 
( 
IDoctorRepository 
doctorRepository &
,& '
IMapper 
mapper 
, "
IAppointmentRepository !
appointmentRepository 0
)0 1
:2 3
IDoctorService4 B
{ 
private 
static 
readonly 
TimeOnly $
WorkDayStart% 1
=2 3
new4 7
(7 8
$num8 9
,9 :
$num; <
)< =
;= >
private 
static 
readonly 
TimeOnly $

LunchStart% /
=0 1
new2 5
(5 6
$num6 8
,8 9
$num: ;
); <
;< =
private 
static 
readonly 
TimeOnly $
LunchEnd% -
=. /
new0 3
(3 4
$num4 6
,6 7
$num8 9
)9 :
;: ;
private 
static 
readonly 
TimeOnly $

WorkDayEnd% /
=0 1
new2 5
(5 6
$num6 8
,8 9
$num: ;
); <
;< =
private 
static 
readonly 
TimeSpan $
SlotDuration% 1
=2 3
TimeSpan4 <
.< =
FromMinutes= H
(H I
$numI K
)K L
;L M
private 
const 
int 0
$MinimumBookingHoursBeforeAppointment :
=; <
$num= ?
;? @
public 

async 
Task 
< 
PagedResultDto $
<$ %
PublicDoctorDto% 4
>4 5
>5 6
GetAllDoctorsAsync7 I
(I J 
DoctorSearchQueryDtoJ ^
query_ d
)d e
{ 
var 
doctors 
= 
await 
doctorRepository ,
., -
GetAllDoctorsAsync- ?
(? @
query 
. 

PageNumber 
, 
query 
. 
PageSize 
, 
query 
. 
Search 
, 
query   
.   
Specialisation    
,    !
query!! 
.!! 
IsAvailable!! 
,!! 
query"" 
."" 
SortBy"" 
,"" 
query## 
.## 
SortDirection## 
)##  
;##  !
return%% 
MapPagedResult%% 
<%% 
Doctor%% $
,%%$ %
PublicDoctorDto%%& 5
>%%5 6
(%%6 7
doctors%%7 >
)%%> ?
;%%? @
}&& 
public(( 

async(( 
Task(( 
<(( 
PublicDoctorDto(( %
?((% &
>((& '
GetDoctorByIdAsync((( :
(((: ;
int((; >
id((? A
)((A B
{)) 
var** 
doctor** 
=** 
await** 
doctorRepository** +
.**+ ,
GetDoctorByIdAsync**, >
(**> ?
id**? A
)**A B
;**B C
if,, 

(,, 
doctor,, 
==,, 
null,, 
),, 
{-- 	
return.. 
null.. 
;.. 
}// 	
return11 
mapper11 
.11 
Map11 
<11 
PublicDoctorDto11 )
>11) *
(11* +
doctor11+ 1
)111 2
;112 3
}22 
public44 

async44 
Task44 
<44 
PublicDoctorDto44 %
?44% &
>44& '"
GetDoctorByUserIdAsync44( >
(44> ?
string44? E
userId44F L
)44L M
{55 
var66 
doctor66 
=66 
await66 
doctorRepository66 +
.66+ ,"
GetDoctorByUserIdAsync66, B
(66B C
userId66C I
)66I J
;66J K
if88 

(88 
doctor88 
==88 
null88 
)88 
{99 	
return:: 
null:: 
;:: 
};; 	
return== 
mapper== 
.== 
Map== 
<== 
PublicDoctorDto== )
>==) *
(==* +
doctor==+ 1
)==1 2
;==2 3
}>> 
public@@ 

async@@ 
Task@@ 
<@@ !
DoctorAvailabilityDto@@ +
?@@+ ,
>@@, - 
GetAvailabilityAsync@@. B
(@@B C
int@@C F
id@@G I
)@@I J
{AA 
varBB 
availabilityBB 
=BB 
awaitBB  
doctorRepositoryBB! 1
.BB1 2 
GetAvailabilityAsyncBB2 F
(BBF G
idBBG I
)BBI J
;BBJ K
ifDD 

(DD 
availabilityDD 
==DD 
nullDD  
)DD  !
{EE 	
returnFF 
nullFF 
;FF 
}GG 	
returnII 
newII !
DoctorAvailabilityDtoII (
{JJ 	
DoctorIdKK 
=KK 
idKK 
,KK 
IsAvailableLL 
=LL 
availabilityLL &
.LL& '
ValueLL' ,
,LL, -
MessageMM 
=MM 
availabilityMM "
.MM" #
ValueMM# (
?NN 
ErrorMessagesNN 
.NN  "
DoctorAvailableMessageNN  6
:OO 
ErrorMessagesOO 
.OO  $
DoctorUnavailableMessageOO  8
}PP 	
;PP	 

}QQ 
publicSS 

asyncSS 
TaskSS 
<SS #
DoctorAvailableSlotsDtoSS -
>SS- .
GetDoctorSlotsAsyncSS/ B
(SSB C
intSSC F
idSSG I
,SSI J
DateOnlySSK S
dateSST X
)SSX Y
{TT 
varUU 
doctorUU 
=UU 
awaitUU 
doctorRepositoryUU +
.UU+ ,
GetDoctorByIdAsyncUU, >
(UU> ?
idUU? A
)UUA B
;UUB C
ifWW 

(WW 
doctorWW 
==WW 
nullWW 
)WW 
{XX 	
throwYY 
newYY 
NotFoundExceptionYY '
(YY' (
ErrorMessagesYY( 5
.YY5 6
DoctorNotFoundYY6 D
)YYD E
;YYE F
}ZZ 	
var\\ 
bookedTimes\\ 
=\\ 
await\\ 
GetBookedTimesAsync\\  3
(\\3 4
doctor\\4 :
.\\: ;
Id\\; =
,\\= >
date\\? C
)\\C D
;\\D E
return^^ )
CreateDoctorAvailableSlotsDto^^ ,
(^^, -
doctor^^- 3
,^^3 4
date^^5 9
,^^9 :
bookedTimes^^; F
)^^F G
;^^G H
}__ 
publicaa 

asyncaa 
Taskaa 
<aa 
PagedResultDtoaa $
<aa$ %#
DoctorAvailableSlotsDtoaa% <
>aa< =
>aa= >"
GetAvailableSlotsAsyncaa? U
(aaU V
DateOnlybb 
datebb 
,bb  
DoctorSpecialisationcc 
?cc 
specialisationcc ,
,cc, -
PaginationQueryDtodd 

paginationdd %
)dd% &
{ee 
varff 
doctorsff 
=ff 
awaitff 
doctorRepositoryff ,
.ff, -$
GetAvailableDoctorsAsyncff- E
(ffE F
specialisationffF T
)ffT U
;ffU V
vargg 
appointmentsgg 
=gg 
awaitgg  !
appointmentRepositorygg! 6
.gg6 72
&GetNonCancelledAppointmentsByDateAsyncgg7 ]
(gg] ^
dategg^ b
)ggb c
;ggc d
varii 
bookedTimesByDoctorii 
=ii  !
appointmentsii" .
.jj 
GroupByjj 
(jj 
appointmentjj  
=>jj! #
appointmentjj$ /
.jj/ 0
DoctorIdjj0 8
)jj8 9
.kk 
ToDictionarykk 
(kk 
groupll 
=>ll 
groupll 
.ll 
Keyll "
,ll" #
groupmm 
=>mm 
groupmm 
.nn 
Selectnn 
(nn 
appointmentnn '
=>nn( *
appointmentnn+ 6
.nn6 7
AppointmentTimenn7 F
)nnF G
.oo 
	ToHashSetoo 
(oo 
)oo  
)oo  !
;oo! "
varqq %
doctorsWithAvailableSlotsqq %
=qq& '
newqq( +
Listqq, 0
<qq0 1#
DoctorAvailableSlotsDtoqq1 H
>qqH I
(qqI J
)qqJ K
;qqK L
foreachss 
(ss 
varss 
doctorss 
inss 
doctorsss &
)ss& '
{tt 	
bookedTimesByDoctoruu 
.uu  
TryGetValueuu  +
(uu+ ,
doctoruu, 2
.uu2 3
Iduu3 5
,uu5 6
outuu7 :
varuu; >
bookedTimesuu? J
)uuJ K
;uuK L
bookedTimesvv 
??=vv 
[vv 
]vv 
;vv 
varxx 
doctorSlotsxx 
=xx )
CreateDoctorAvailableSlotsDtoxx ;
(xx; <
doctorxx< B
,xxB C
datexxD H
,xxH I
bookedTimesxxJ U
)xxU V
;xxV W
ifzz 
(zz 
doctorSlotszz 
.zz 
AvailableSlotszz *
.zz* +
Countzz+ 0
>zz1 2
$numzz3 4
)zz4 5
{{{ %
doctorsWithAvailableSlots|| )
.||) *
Add||* -
(||- .
doctorSlots||. 9
)||9 :
;||: ;
}}} 
}~~ 	
var
€€ 

totalCount
€€ 
=
€€ '
doctorsWithAvailableSlots
€€ 2
.
€€2 3
Count
€€3 8
;
€€8 9
var
 

totalPages
 
=
 

totalCount
 #
==
$ &
$num
' (
?
‚‚ 
$num
‚‚ 
:
ƒƒ 
(
ƒƒ 
int
ƒƒ 
)
ƒƒ 
Math
ƒƒ 
.
ƒƒ 
Ceiling
ƒƒ 
(
ƒƒ  

totalCount
ƒƒ  *
/
ƒƒ+ ,
(
ƒƒ- .
double
ƒƒ. 4
)
ƒƒ4 5

pagination
ƒƒ5 ?
.
ƒƒ? @
PageSize
ƒƒ@ H
)
ƒƒH I
;
ƒƒI J
var
…… 

pagedItems
…… 
=
…… '
doctorsWithAvailableSlots
…… 2
.
†† 
Skip
†† 
(
†† 
(
†† 

pagination
†† 
.
†† 

PageNumber
†† (
-
††) *
$num
††+ ,
)
††, -
*
††. /

pagination
††0 :
.
††: ;
PageSize
††; C
)
††C D
.
‡‡ 
Take
‡‡ 
(
‡‡ 

pagination
‡‡ 
.
‡‡ 
PageSize
‡‡ %
)
‡‡% &
.
 
ToList
 
(
 
)
 
;
 
return
 
new
 
PagedResultDto
 !
<
! "%
DoctorAvailableSlotsDto
" 9
>
9 :
{
‹‹ 	
Items
 
=
 

pagedItems
 
,
 

PageNumber
 
=
 

pagination
 #
.
# $

PageNumber
$ .
,
. /
PageSize
 
=
 

pagination
 !
.
! "
PageSize
" *
,
* +

TotalCount
 
=
 

totalCount
 #
,
# $

TotalPages
 
=
 

totalPages
 #
}
‘‘ 	
;
‘‘	 

}
’’ 
public
”” 

async
”” 
Task
”” 
<
”” #
DoctorAvailabilityDto
”” +
>
””+ ,%
UpdateAvailabilityAsync
””- D
(
””D E
int
•• 
id
•• 
,
•• )
UpdateDoctorAvailabilityDto
–– #
dto
––$ '
,
––' (
string
—— 
currentRole
—— 
,
—— 
int
 
?
 
currentDoctorId
 
)
 
{
™™ 
var
 
doctor
 
=
 
await
 
doctorRepository
 +
.
+ , 
GetDoctorByIdAsync
, >
(
> ?
id
? A
)
A B
;
B C
if
 

(
 
doctor
 
==
 
null
 
)
 
{
 	
throw
 
new
 
NotFoundException
 '
(
' (
ErrorMessages
( 5
.
5 6
DoctorNotFound
6 D
)
D E
;
E F
}
 	2
$ValidateAvailabilityUpdatePermission
΅΅ ,
(
΅΅, -
id
΅΅- /
,
΅΅/ 0
currentRole
΅΅1 <
,
΅΅< =
currentDoctorId
΅΅> M
)
΅΅M N
;
΅΅N O
var
££ 
isDeactivation
££ 
=
££ 
doctor
££ #
.
££# $
IsAvailable
££$ /
&&
££0 2
!
££3 4
dto
££4 7
.
££7 8
IsAvailable
££8 C
;
££C D
if
¥¥ 

(
¥¥ 
isDeactivation
¥¥ 
)
¥¥ 
{
¦¦ 	
await
§§ %
HandleDeactivationAsync
§§ )
(
§§) *
id
§§* ,
,
§§, -
currentRole
§§. 9
)
§§9 :
;
§§: ;
}
¨¨ 	
doctor
ªª 
.
ªª 
IsAvailable
ªª 
=
ªª 
dto
ªª  
.
ªª  !
IsAvailable
ªª! ,
;
ªª, -
var
¬¬ 
updatedDoctor
¬¬ 
=
¬¬ 
await
¬¬ !
doctorRepository
¬¬" 2
.
¬¬2 3
UpdateAsync
¬¬3 >
(
¬¬> ?
doctor
¬¬? E
)
¬¬E F
;
¬¬F G
if
®® 

(
®® 
updatedDoctor
®® 
==
®® 
null
®® !
)
®®! "
{
―― 	
throw
°° 
new
°° 
NotFoundException
°° '
(
°°' (
ErrorMessages
°°( 5
.
°°5 6
DoctorNotFound
°°6 D
)
°°D E
;
°°E F
}
±± 	
return
³³ #
CreateAvailabilityDto
³³ $
(
³³$ %
updatedDoctor
³³% 2
.
³³2 3
Id
³³3 5
,
³³5 6
updatedDoctor
³³7 D
.
³³D E
IsAvailable
³³E P
)
³³P Q
;
³³Q R
}
΄΄ 
public
µµ 

async
µµ 
Task
µµ 
<
µµ 
	DoctorDto
µµ 
?
µµ  
>
µµ  !'
GetDoctorProfileByIdAsync
µµ" ;
(
µµ; <
int
µµ< ?
id
µµ@ B
)
µµB C
{
¶¶ 
var
·· 
doctor
·· 
=
·· 
await
·· 
doctorRepository
·· +
.
··+ ,(
GetDoctorByIdWithUserAsync
··, F
(
··F G
id
··G I
)
··I J
;
··J K
if
ΉΉ 

(
ΉΉ 
doctor
ΉΉ 
==
ΉΉ 
null
ΉΉ 
)
ΉΉ 
{
ΊΊ 	
return
»» 
null
»» 
;
»» 
}
ΌΌ 	
return
ΎΎ 
mapper
ΎΎ 
.
ΎΎ 
Map
ΎΎ 
<
ΎΎ 
	DoctorDto
ΎΎ #
>
ΎΎ# $
(
ΎΎ$ %
doctor
ΎΎ% +
)
ΎΎ+ ,
;
ΎΎ, -
}
ΏΏ 
private
ΑΑ 
static
ΑΑ %
DoctorAvailableSlotsDto
ΑΑ *+
CreateDoctorAvailableSlotsDto
ΑΑ+ H
(
ΑΑH I
Doctor
ΒΒ 
doctor
ΒΒ 
,
ΒΒ 
DateOnly
ΓΓ 
date
ΓΓ 
,
ΓΓ 
HashSet
ΔΔ 
<
ΔΔ 
TimeOnly
ΔΔ 
>
ΔΔ 
bookedTimes
ΔΔ %
)
ΔΔ% &
{
ΕΕ 
return
ΖΖ 
new
ΖΖ %
DoctorAvailableSlotsDto
ΖΖ *
{
ΗΗ 	
DoctorId
ΘΘ 
=
ΘΘ 
doctor
ΘΘ 
.
ΘΘ 
Id
ΘΘ  
,
ΘΘ  !

DoctorName
ΙΙ 
=
ΙΙ 
doctor
ΙΙ 
.
ΙΙ  
FullName
ΙΙ  (
,
ΙΙ( )
Specialisation
ΚΚ 
=
ΚΚ 
doctor
ΚΚ #
.
ΚΚ# $
Specialisation
ΚΚ$ 2
,
ΚΚ2 3
YearsOfExperience
ΛΛ 
=
ΛΛ 
doctor
ΛΛ  &
.
ΛΛ& '(
CalculateYearsOfExperience
ΛΛ' A
(
ΛΛA B
)
ΛΛB C
,
ΛΛC D
ConsultationFee
ΜΜ 
=
ΜΜ 
doctor
ΜΜ $
.
ΜΜ$ %
ConsultationFee
ΜΜ% 4
,
ΜΜ4 5
IsAvailable
ΝΝ 
=
ΝΝ 
doctor
ΝΝ  
.
ΝΝ  !
IsAvailable
ΝΝ! ,
,
ΝΝ, -
AvailableSlots
ΞΞ 
=
ΞΞ $
GenerateAvailableSlots
ΞΞ 3
(
ΞΞ3 4
date
ΞΞ4 8
,
ΞΞ8 9
doctor
ΞΞ: @
.
ΞΞ@ A
IsAvailable
ΞΞA L
,
ΞΞL M
bookedTimes
ΞΞN Y
)
ΞΞY Z
}
ΟΟ 	
;
ΟΟ	 

}
ΠΠ 
private
ÒÒ 
async
ÒÒ 
Task
ÒÒ 
<
ÒÒ 
HashSet
ÒÒ 
<
ÒÒ 
TimeOnly
ÒÒ '
>
ÒÒ' (
>
ÒÒ( )!
GetBookedTimesAsync
ÒÒ* =
(
ÒÒ= >
int
ΣΣ 
doctorId
ΣΣ 
,
ΣΣ 
DateOnly
ΤΤ 
date
ΤΤ 
)
ΤΤ 
{
ΥΥ 
var
ΦΦ 
appointments
ΦΦ 
=
ΦΦ 
await
ΦΦ  #
appointmentRepository
ΦΦ! 6
.
ΦΦ6 7?
1GetNonCancelledAppointmentsByDoctorIdAndDateAsync
ΦΦ7 h
(
ΦΦh i
doctorId
ΧΧ 
,
ΧΧ 
date
ΨΨ 
)
ΨΨ 
;
ΨΨ 
return
ΪΪ 
appointments
ΪΪ 
.
ΫΫ 
Select
ΫΫ 
(
ΫΫ 
appointment
ΫΫ 
=>
ΫΫ  "
appointment
ΫΫ# .
.
ΫΫ. /
AppointmentTime
ΫΫ/ >
)
ΫΫ> ?
.
άά 
	ToHashSet
άά 
(
άά 
)
άά 
;
άά 
}
έέ 
private
ίί 
static
ίί 
List
ίί 
<
ίί 
TimeOnly
ίί  
>
ίί  !$
GenerateAvailableSlots
ίί" 8
(
ίί8 9
DateOnly
ΰΰ 
date
ΰΰ 
,
ΰΰ 
bool
αα 
doctorIsAvailable
αα 
,
αα 
HashSet
ββ 
<
ββ 
TimeOnly
ββ 
>
ββ 
bookedTimes
ββ %
)
ββ% &
{
γγ 
var
δδ 
slots
δδ 
=
δδ 
new
δδ 
List
δδ 
<
δδ 
TimeOnly
δδ %
>
δδ% &
(
δδ& '
)
δδ' (
;
δδ( )
if
ζζ 

(
ζζ 
!
ζζ 
doctorIsAvailable
ζζ 
)
ζζ 
{
ηη 	
return
θθ 
slots
θθ 
;
θθ 
}
ιι 	
for
λλ 
(
λλ 
var
λλ 
current
λλ 
=
λλ 
WorkDayStart
λλ '
;
λλ' (
current
λλ) 0
<
λλ1 2

WorkDayEnd
λλ3 =
;
λλ= >
current
λλ? F
=
λλG H
current
λλI P
.
λλP Q
Add
λλQ T
(
λλT U
SlotDuration
λλU a
)
λλa b
)
λλb c
{
μμ 	
if
νν 
(
νν 
current
νν 
>=
νν 

LunchStart
νν %
&&
νν& (
current
νν) 0
<
νν1 2
LunchEnd
νν3 ;
)
νν; <
{
ξξ 
continue
οο 
;
οο 
}
ππ 
if
ςς 
(
ςς 
!
ςς !
IsAtLeastHoursAhead
ςς $
(
ςς$ %
date
ςς% )
,
ςς) *
current
ςς+ 2
,
ςς2 32
$MinimumBookingHoursBeforeAppointment
ςς4 X
)
ςςX Y
)
ςςY Z
{
σσ 
continue
ττ 
;
ττ 
}
υυ 
if
χχ 
(
χχ 
bookedTimes
χχ 
.
χχ 
Contains
χχ $
(
χχ$ %
current
χχ% ,
)
χχ, -
)
χχ- .
{
ψψ 
continue
ωω 
;
ωω 
}
ϊϊ 
slots
όό 
.
όό 
Add
όό 
(
όό 
current
όό 
)
όό 
;
όό 
}
ύύ 	
return
ÿÿ 
slots
ÿÿ 
;
ÿÿ 
}
€€ 
private
‚‚ 
static
‚‚ 
bool
‚‚ !
IsAtLeastHoursAhead
‚‚ +
(
‚‚+ ,
DateOnly
‚‚, 4
date
‚‚5 9
,
‚‚9 :
TimeOnly
‚‚; C
time
‚‚D H
,
‚‚H I
int
‚‚J M
minimumHours
‚‚N Z
)
‚‚Z [
{
ƒƒ 
var
„„ 
scheduledAt
„„ 
=
„„ 
date
„„ 
.
„„ 

ToDateTime
„„ )
(
„„) *
time
„„* .
)
„„. /
;
„„/ 0
return
†† 
scheduledAt
†† 
>=
†† 
DateTime
†† &
.
††& '
Now
††' *
.
††* +
AddHours
††+ 3
(
††3 4
minimumHours
††4 @
)
††@ A
;
††A B
}
‡‡ 
private
‰‰ 
PagedResultDto
‰‰ 
<
‰‰ 
TDestination
‰‰ '
>
‰‰' (
MapPagedResult
‰‰) 7
<
‰‰7 8
TSource
‰‰8 ?
,
‰‰? @
TDestination
‰‰A M
>
‰‰M N
(
‰‰N O
PagedResult
 
<
 
TSource
 
>
 
pagedResult
 (
)
( )
{
‹‹ 
return
 
new
 
PagedResultDto
 !
<
! "
TDestination
" .
>
. /
{
 	
Items
 
=
 
mapper
 
.
 
Map
 
<
 
List
 #
<
# $
TDestination
$ 0
>
0 1
>
1 2
(
2 3
pagedResult
3 >
.
> ?
Items
? D
)
D E
,
E F

PageNumber
 
=
 
pagedResult
 $
.
$ %

PageNumber
% /
,
/ 0
PageSize
 
=
 
pagedResult
 "
.
" #
PageSize
# +
,
+ ,

TotalCount
‘‘ 
=
‘‘ 
pagedResult
‘‘ $
.
‘‘$ %

TotalCount
‘‘% /
,
‘‘/ 0

TotalPages
’’ 
=
’’ 
pagedResult
’’ $
.
’’$ %

TotalPages
’’% /
}
““ 	
;
““	 

}
”” 
private
–– 
static
–– 
void
–– 2
$ValidateAvailabilityUpdatePermission
–– <
(
––< =
int
—— 
doctorId
—— 
,
—— 
string
 
currentRole
 
,
 
int
™™ 
?
™™ 
currentDoctorId
™™ 
)
™™ 
{
 
if
›› 

(
›› 
currentRole
›› 
==
›› 
AppRoles
›› #
.
››# $
Doctor
››$ *
&&
››+ -
currentDoctorId
››. =
!=
››> @
doctorId
››A I
)
››I J
{
 	
throw
 
new
  
ForbiddenException
 (
(
( )
ErrorMessages
) 6
.
6 71
#DoctorsCanUpdateOnlyOwnAvailability
7 Z
)
Z [
;
[ \
}
 	
if
   

(
   
currentRole
   
!=
   
AppRoles
   #
.
  # $
Doctor
  $ *
&&
  + -
currentRole
  . 9
!=
  : <
AppRoles
  = E
.
  E F
Admin
  F K
)
  K L
{
΅΅ 	
throw
ΆΆ 
new
ΆΆ  
ForbiddenException
ΆΆ (
(
ΆΆ( )
ErrorMessages
ΆΆ) 6
.
ΆΆ6 74
&UnsupportedAppointmentStatusTransition
ΆΆ7 ]
)
ΆΆ] ^
;
ΆΆ^ _
}
££ 	
}
¤¤ 
private
¦¦ 
static
¦¦ #
DoctorAvailabilityDto
¦¦ (#
CreateAvailabilityDto
¦¦) >
(
¦¦> ?
int
¦¦? B
doctorId
¦¦C K
,
¦¦K L
bool
¦¦M Q
isAvailable
¦¦R ]
)
¦¦] ^
{
§§ 
return
¨¨ 
new
¨¨ #
DoctorAvailabilityDto
¨¨ (
{
©© 	
DoctorId
ªª 
=
ªª 
doctorId
ªª 
,
ªª  
IsAvailable
«« 
=
«« 
isAvailable
«« %
,
««% &
Message
¬¬ 
=
¬¬ 
isAvailable
¬¬ !
?
­­ 
ErrorMessages
­­ 
.
­­  $
DoctorAvailableMessage
­­  6
:
®® 
ErrorMessages
®® 
.
®®  &
DoctorUnavailableMessage
®®  8
}
―― 	
;
――	 

}
°° 
private
²² 
async
²² 
Task
²² %
HandleDeactivationAsync
²² .
(
²². /
int
³³ 
doctorId
³³ 
,
³³ 
string
΄΄ 
currentRole
΄΄ 
)
΄΄ 
{
µµ 
var
¶¶ 
today
¶¶ 
=
¶¶ 
DateOnly
¶¶ 
.
¶¶ 
FromDateTime
¶¶ )
(
¶¶) *
DateTime
¶¶* 2
.
¶¶2 3
Today
¶¶3 8
)
¶¶8 9
;
¶¶9 :
if
ΈΈ 

(
ΈΈ 
currentRole
ΈΈ 
==
ΈΈ 
AppRoles
ΈΈ #
.
ΈΈ# $
Doctor
ΈΈ$ *
)
ΈΈ* +
{
ΉΉ 	
await
ΊΊ 0
"EnsureDoctorCanDeactivateSelfAsync
ΊΊ 4
(
ΊΊ4 5
doctorId
ΊΊ5 =
,
ΊΊ= >
today
ΊΊ? D
)
ΊΊD E
;
ΊΊE F
return
»» 
;
»» 
}
ΌΌ 	
if
ΎΎ 

(
ΎΎ 
currentRole
ΎΎ 
==
ΎΎ 
AppRoles
ΎΎ #
.
ΎΎ# $
Admin
ΎΎ$ )
)
ΎΎ) *
{
ΏΏ 	
await
ΐΐ ?
1CancelTodaysAppointmentsForAdminDeactivationAsync
ΐΐ C
(
ΐΐC D
doctorId
ΐΐD L
,
ΐΐL M
today
ΐΐN S
)
ΐΐS T
;
ΐΐT U
}
ΑΑ 	
}
ΒΒ 
private
ΔΔ 
async
ΔΔ 
Task
ΔΔ 0
"EnsureDoctorCanDeactivateSelfAsync
ΔΔ 9
(
ΔΔ9 :
int
ΕΕ 
doctorId
ΕΕ 
,
ΕΕ 
DateOnly
ΖΖ 
today
ΖΖ 
)
ΖΖ 
{
ΗΗ 
var
ΘΘ +
hasConfirmedAppointmentsToday
ΘΘ )
=
ΘΘ* +
await
ΘΘ, 1#
appointmentRepository
ΘΘ2 G
.
ΙΙ 7
)DoctorHasConfirmedAppointmentsOnDateAsync
ΙΙ 6
(
ΙΙ6 7
doctorId
ΙΙ7 ?
,
ΙΙ? @
today
ΙΙA F
)
ΙΙF G
;
ΙΙG H
if
ΛΛ 

(
ΛΛ +
hasConfirmedAppointmentsToday
ΛΛ )
)
ΛΛ) *
{
ΜΜ 	
throw
ΝΝ 
new
ΝΝ #
BusinessRuleException
ΝΝ +
(
ΝΝ+ ,
ErrorMessages
ΝΝ, 9
.
ΝΝ9 :B
4DoctorCannotDeactivateWithConfirmedAppointmentsToday
ΝΝ: n
)
ΝΝn o
;
ΝΝo p
}
ΞΞ 	
}
ΟΟ 
private
ΡΡ 
async
ΡΡ 
Task
ΡΡ ?
1CancelTodaysAppointmentsForAdminDeactivationAsync
ΡΡ H
(
ΡΡH I
int
ÒÒ 
doctorId
ÒÒ 
,
ÒÒ 
DateOnly
ΣΣ 
today
ΣΣ 
)
ΣΣ 
{
ΤΤ 
var
ΥΥ "
appointmentsToCancel
ΥΥ  
=
ΥΥ! "
await
ΥΥ# (#
appointmentRepository
ΥΥ) >
.
ΦΦ E
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync
ΦΦ D
(
ΦΦD E
doctorId
ΦΦE M
,
ΦΦM N
today
ΦΦO T
)
ΦΦT U
;
ΦΦU V
foreach
ΨΨ 
(
ΨΨ 
var
ΨΨ 
appointment
ΨΨ  
in
ΨΨ! #"
appointmentsToCancel
ΨΨ$ 8
)
ΨΨ8 9
{
ΩΩ 	
appointment
ΪΪ 
.
ΪΪ 
Status
ΪΪ 
=
ΪΪ  
AppointmentStatus
ΪΪ! 2
.
ΪΪ2 3
	Cancelled
ΪΪ3 <
;
ΪΪ< =
appointment
ΫΫ 
.
ΫΫ  
CancellationReason
ΫΫ *
=
ΫΫ+ ,
ErrorMessages
ΫΫ- :
.
ΫΫ: ;/
!DoctorEmergencyCancellationReason
ΫΫ; \
;
ΫΫ\ ]
await
έέ #
appointmentRepository
έέ '
.
έέ' (
UpdateAsync
έέ( 3
(
έέ3 4
appointment
έέ4 ?
)
έέ? @
;
έέ@ A
}
ήή 	
}
ίί 
}ΰΰ ®Β
SC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\AuthService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
.! "
Impl" &
;& '
public 
class 
AuthService 
( 
UserManager 
< 
IdentityUser 
> 
userManager )
,) *
HealthAxisDbContext 
context 
,  
IPatientRepository 
patientRepository (
,( )
IDoctorRepository 
doctorRepository &
,& '
IConfiguration 
configuration  
)  !
:" #
IAuthService$ 0
{ 
public 

async 
Task 
< 
( 
bool 
Success #
,# $
string% +
Message, 3
,3 4
string5 ;
UserId< B
)B C
>C D
RegisterAsyncE R
(R S
RegisterDtoS ^
request_ f
)f g
{ 
if 

( 
request 
. 
Password 
!= 
request  '
.' (
ConfirmPassword( 7
)7 8
{ 	
return   
(   
false   
,   
ErrorMessages   (
.  ( )
PasswordsDoNotMatch  ) <
,  < =
string  > D
.  D E
Empty  E J
)  J K
;  K L
}!! 	
var## 
existingUser## 
=## 
await##  
userManager##! ,
.##, -
FindByEmailAsync##- =
(##= >
request##> E
.##E F
Email##F K
)##K L
;##L M
if%% 

(%% 
existingUser%% 
!=%% 
null%%  
)%%  !
{&& 	
return'' 
('' 
false'' 
,'' 
ErrorMessages'' (
.''( )"
EmailAlreadyRegistered'') ?
,''? @
string''A G
.''G H
Empty''H M
)''M N
;''N O
}(( 	
await** 
using** 
var** 
transaction** #
=**$ %
await**& +
context**, 3
.**3 4
Database**4 <
.**< =!
BeginTransactionAsync**= R
(**R S
)**S T
;**T U
try,, 
{-- 	
var.. 
user.. 
=.. 
new.. 
IdentityUser.. '
{// 
UserName00 
=00 
request00 "
.00" #
Email00# (
,00( )
Email11 
=11 
request11 
.11  
Email11  %
,11% &
EmailConfirmed22 
=22  
true22! %
,22% &
PhoneNumber33 
=33 
request33 %
.33% &
PhoneNumber33& 1
}44 
;44 
var66 
createResult66 
=66 
await66 $
userManager66% 0
.660 1
CreateAsync661 <
(66< =
user66= A
,66A B
request66C J
.66J K
Password66K S
)66S T
;66T U
if88 
(88 
!88 
createResult88 
.88 
	Succeeded88 '
)88' (
{99 
var:: 
errors:: 
=:: 
string:: #
.::# $
Join::$ (
(::( )
$str::) -
,::- .
createResult::/ ;
.::; <
Errors::< B
.::B C
Select::C I
(::I J
error::J O
=>::P R
error::S X
.::X Y
Description::Y d
)::d e
)::e f
;::f g
await;; 
transaction;; !
.;;! "
RollbackAsync;;" /
(;;/ 0
);;0 1
;;;1 2
return<< 
(<< 
false<< 
,<< 
errors<< %
,<<% &
string<<' -
.<<- .
Empty<<. 3
)<<3 4
;<<4 5
}== 
var?? 

roleResult?? 
=?? 
await?? "
userManager??# .
.??. /
AddToRoleAsync??/ =
(??= >
user??> B
,??B C
AppRoles??D L
.??L M
Patient??M T
)??T U
;??U V
ifAA 
(AA 
!AA 

roleResultAA 
.AA 
	SucceededAA %
)AA% &
{BB 
varCC 
errorsCC 
=CC 
stringCC #
.CC# $
JoinCC$ (
(CC( )
$strCC) -
,CC- .

roleResultCC/ 9
.CC9 :
ErrorsCC: @
.CC@ A
SelectCCA G
(CCG H
errorCCH M
=>CCN P
errorCCQ V
.CCV W
DescriptionCCW b
)CCb c
)CCc d
;CCd e
awaitDD 
transactionDD !
.DD! "
RollbackAsyncDD" /
(DD/ 0
)DD0 1
;DD1 2
returnEE 
(EE 
falseEE 
,EE 
errorsEE %
,EE% &
stringEE' -
.EE- .
EmptyEE. 3
)EE3 4
;EE4 5
}FF 
varHH 
patientHH 
=HH 
newHH 
PatientHH %
{II 
UserIdJJ 
=JJ 
userJJ 
.JJ 
IdJJ  
,JJ  !
FullNameKK 
=KK 
requestKK "
.KK" #
FullNameKK# +
,KK+ ,
DateOfBirthLL 
=LL 
requestLL %
.LL% &
DateOfBirthLL& 1
,LL1 2
GenderMM 
=MM 
requestMM  
.MM  !
GenderMM! '
,MM' (
AddressNN 
=NN 
requestNN !
.NN! "
AddressNN" )
}OO 
;OO 
awaitQQ 
contextQQ 
.QQ 
PatientsQQ "
.QQ" #
AddAsyncQQ# +
(QQ+ ,
patientQQ, 3
)QQ3 4
;QQ4 5
awaitRR 
contextRR 
.RR 
SaveChangesAsyncRR *
(RR* +
)RR+ ,
;RR, -
awaitTT 
transactionTT 
.TT 
CommitAsyncTT )
(TT) *
)TT* +
;TT+ ,
returnVV 
(VV 
trueVV 
,VV 
$strVV 9
,VV9 :
userVV; ?
.VV? @
IdVV@ B
)VVB C
;VVC D
}WW 	
catchXX 
{YY 	
awaitZZ 
transactionZZ 
.ZZ 
RollbackAsyncZZ +
(ZZ+ ,
)ZZ, -
;ZZ- .
throw[[ 
;[[ 
}\\ 	
}]] 
public__ 

async__ 
Task__ 
<__ 
(__ 
bool__ 
Success__ #
,__# $
string__% +
Message__, 3
,__3 4
AuthResponseDto__5 D
?__D E
Response__F N
)__N O
>__O P

LoginAsync__Q [
(__[ \
LoginDto__\ d
request__e l
)__l m
{`` 
varaa 
useraa 
=aa 
awaitaa 
userManageraa $
.aa$ %
FindByEmailAsyncaa% 5
(aa5 6
requestaa6 =
.aa= >
Emailaa> C
)aaC D
;aaD E
ifcc 

(cc 
usercc 
==cc 
nullcc 
)cc 
{dd 	
returnee 
(ee 
falseee 
,ee 
ErrorMessagesee (
.ee( )
InvalidCredentialsee) ;
,ee; <
nullee= A
)eeA B
;eeB C
}ff 	
varhh 
isPasswordValidhh 
=hh 
awaithh #
userManagerhh$ /
.hh/ 0
CheckPasswordAsynchh0 B
(hhB C
userhhC G
,hhG H
requesthhI P
.hhP Q
PasswordhhQ Y
)hhY Z
;hhZ [
ifjj 

(jj 
!jj 
isPasswordValidjj 
)jj 
{kk 	
returnll 
(ll 
falsell 
,ll 
ErrorMessagesll (
.ll( )
InvalidCredentialsll) ;
,ll; <
nullll= A
)llA B
;llB C
}mm 	
varoo 
profileResultoo 
=oo 
awaitoo !!
BuildUserProfileAsyncoo" 7
(oo7 8
useroo8 <
)oo< =
;oo= >
ifqq 

(qq 
!qq 
profileResultqq 
.qq 
Successqq "
)qq" #
{rr 	
returnss 
(ss 
falsess 
,ss 
profileResultss (
.ss( )
Messagess) 0
,ss0 1
nullss2 6
)ss6 7
;ss7 8
}tt 	
varvv 
responsevv 
=vv 
awaitvv %
GenerateAuthResponseAsyncvv 6
(vv6 7
userww 
,ww 
profileResultxx 
.xx 
Rolesxx 
,xx  
profileResultyy 
.yy 
Roleyy 
,yy 
profileResultzz 
.zz 
	PatientIdzz #
,zz# $
profileResult{{ 
.{{ 
DoctorId{{ "
,{{" #
$str|| *
)||* +
;||+ ,
return~~ 
(~~ 
true~~ 
,~~ 
response~~ 
.~~ 
Message~~ &
,~~& '
response~~( 0
)~~0 1
;~~1 2
} 
private
ΕΕ 
async
ΕΕ 
Task
ΕΕ 
<
ΕΕ 
(
ΕΕ 
bool
ΕΕ 
Success
ΕΕ $
,
ΕΕ$ %
string
ΕΕ& ,
Message
ΕΕ- 4
,
ΕΕ4 5
IList
ΕΕ6 ;
<
ΕΕ; <
string
ΕΕ< B
>
ΕΕB C
Roles
ΕΕD I
,
ΕΕI J
string
ΕΕK Q
Role
ΕΕR V
,
ΕΕV W
int
ΕΕX [
?
ΕΕ[ \
	PatientId
ΕΕ] f
,
ΕΕf g
int
ΕΕh k
?
ΕΕk l
DoctorId
ΕΕm u
)
ΕΕu v
>
ΕΕv w$
BuildUserProfileAsyncΕΕx 
(ΕΕ 
IdentityUserΕΕ 
userΕΕ› 
)ΕΕ  
{
ΖΖ 
var
ΗΗ 
roles
ΗΗ 
=
ΗΗ 
await
ΗΗ 
userManager
ΗΗ %
.
ΗΗ% &
GetRolesAsync
ΗΗ& 3
(
ΗΗ3 4
user
ΗΗ4 8
)
ΗΗ8 9
;
ΗΗ9 :
var
ΘΘ 
role
ΘΘ 
=
ΘΘ 
roles
ΘΘ 
.
ΘΘ 
FirstOrDefault
ΘΘ '
(
ΘΘ' (
)
ΘΘ( )
??
ΘΘ* ,
string
ΘΘ- 3
.
ΘΘ3 4
Empty
ΘΘ4 9
;
ΘΘ9 :
int
ΚΚ 
?
ΚΚ 
	patientId
ΚΚ 
=
ΚΚ 
null
ΚΚ 
;
ΚΚ 
int
ΛΛ 
?
ΛΛ 
doctorId
ΛΛ 
=
ΛΛ 
null
ΛΛ 
;
ΛΛ 
if
ΝΝ 

(
ΝΝ 
string
ΝΝ 
.
ΝΝ 
Equals
ΝΝ 
(
ΝΝ 
role
ΝΝ 
,
ΝΝ 
AppRoles
ΝΝ  (
.
ΝΝ( )
Patient
ΝΝ) 0
,
ΝΝ0 1
StringComparison
ΝΝ2 B
.
ΝΝB C
OrdinalIgnoreCase
ΝΝC T
)
ΝΝT U
)
ΝΝU V
{
ΞΞ 	
var
ΟΟ 
patient
ΟΟ 
=
ΟΟ 
await
ΟΟ 
patientRepository
ΟΟ  1
.
ΟΟ1 2%
GetPatientByUserIdAsync
ΟΟ2 I
(
ΟΟI J
user
ΟΟJ N
.
ΟΟN O
Id
ΟΟO Q
)
ΟΟQ R
;
ΟΟR S
if
ΡΡ 
(
ΡΡ 
patient
ΡΡ 
==
ΡΡ 
null
ΡΡ 
)
ΡΡ  
{
ÒÒ 
return
ΣΣ 
(
ΣΣ 
false
ΣΣ 
,
ΣΣ 
ErrorMessages
ΣΣ ,
.
ΣΣ, -$
PatientProfileNotFound
ΣΣ- C
,
ΣΣC D
roles
ΣΣE J
,
ΣΣJ K
role
ΣΣL P
,
ΣΣP Q
null
ΣΣR V
,
ΣΣV W
null
ΣΣX \
)
ΣΣ\ ]
;
ΣΣ] ^
}
ΤΤ 
	patientId
ΦΦ 
=
ΦΦ 
patient
ΦΦ 
.
ΦΦ  
Id
ΦΦ  "
;
ΦΦ" #
}
ΧΧ 	
if
ΩΩ 

(
ΩΩ 
string
ΩΩ 
.
ΩΩ 
Equals
ΩΩ 
(
ΩΩ 
role
ΩΩ 
,
ΩΩ 
AppRoles
ΩΩ  (
.
ΩΩ( )
Doctor
ΩΩ) /
,
ΩΩ/ 0
StringComparison
ΩΩ1 A
.
ΩΩA B
OrdinalIgnoreCase
ΩΩB S
)
ΩΩS T
)
ΩΩT U
{
ΪΪ 	
var
ΫΫ 
doctor
ΫΫ 
=
ΫΫ 
await
ΫΫ 
doctorRepository
ΫΫ /
.
ΫΫ/ 0$
GetDoctorByUserIdAsync
ΫΫ0 F
(
ΫΫF G
user
ΫΫG K
.
ΫΫK L
Id
ΫΫL N
)
ΫΫN O
;
ΫΫO P
if
έέ 
(
έέ 
doctor
έέ 
==
έέ 
null
έέ 
)
έέ 
{
ήή 
return
ίί 
(
ίί 
false
ίί 
,
ίί 
ErrorMessages
ίί ,
.
ίί, -#
DoctorProfileNotFound
ίί- B
,
ίίB C
roles
ίίD I
,
ίίI J
role
ίίK O
,
ίίO P
null
ίίQ U
,
ίίU V
null
ίίW [
)
ίί[ \
;
ίί\ ]
}
ΰΰ 
doctorId
ββ 
=
ββ 
doctor
ββ 
.
ββ 
Id
ββ  
;
ββ  !
}
γγ 	
return
εε 
(
εε 
true
εε 
,
εε 
string
εε 
.
εε 
Empty
εε "
,
εε" #
roles
εε$ )
,
εε) *
role
εε+ /
,
εε/ 0
	patientId
εε1 :
,
εε: ;
doctorId
εε< D
)
εεD E
;
εεE F
}
ζζ 
private
θθ 
async
θθ 
Task
θθ 
<
θθ 
AuthResponseDto
θθ &
>
θθ& ''
GenerateAuthResponseAsync
θθ( A
(
θθA B
IdentityUser
ιι 
user
ιι 
,
ιι 
IList
κκ 
<
κκ 
string
κκ 
>
κκ 
roles
κκ 
,
κκ 
string
λλ 
role
λλ 
,
λλ 
int
μμ 
?
μμ 
	patientId
μμ 
,
μμ 
int
νν 
?
νν 
doctorId
νν 
,
νν 
string
ξξ 
message
ξξ 
)
ξξ 
{
οο 
var
ππ 
	expiresIn
ππ 
=
ππ 
int
ππ 
.
ππ 
Parse
ππ !
(
ππ! "
configuration
ππ" /
.
ππ/ 0

GetSection
ππ0 :
(
ππ: ;
$str
ππ; @
)
ππ@ A
[
ππA B
$str
ππB `
]
ππ` a
!
ππa b
)
ππb c
;
ππc d
var
ρρ 
token
ρρ 
=
ρρ 
GenerateToken
ρρ !
(
ρρ! "
user
ρρ" &
,
ρρ& '
roles
ρρ( -
,
ρρ- .
	expiresIn
ρρ/ 8
,
ρρ8 9
	patientId
ρρ: C
,
ρρC D
doctorId
ρρE M
)
ρρM N
;
ρρN O
return
χχ 
new
χχ 
AuthResponseDto
χχ "
{
ψψ 	
AccessToken
ωω 
=
ωω 
token
ωω 
,
ωω  
Message
ϋϋ 
=
ϋϋ 
message
ϋϋ 
,
ϋϋ 
	ExpiresIn
όό 
=
όό 
	expiresIn
όό !
,
όό! "
UserId
ύύ 
=
ύύ 
user
ύύ 
.
ύύ 
Id
ύύ 
,
ύύ 
	PatientId
ώώ 
=
ώώ 
	patientId
ώώ !
,
ώώ! "
DoctorId
ÿÿ 
=
ÿÿ 
doctorId
ÿÿ 
,
ÿÿ  
Email
€€ 
=
€€ 
user
€€ 
.
€€ 
Email
€€ 
??
€€ !
string
€€" (
.
€€( )
Empty
€€) .
,
€€. /
Role
 
=
 
role
 
}
‚‚ 	
;
‚‚	 

}
ƒƒ 
private
¦¦ 
string
¦¦ 
GenerateToken
¦¦  
(
¦¦  !
IdentityUser
§§ 
user
§§ 
,
§§ 
IList
¨¨ 
<
¨¨ 
string
¨¨ 
>
¨¨ 
roles
¨¨ 
,
¨¨ 
int
©© 
	expiresIn
©© 
,
©© 
int
ªª 
?
ªª 
	patientId
ªª 
,
ªª 
int
«« 
?
«« 
doctorId
«« 
)
«« 
{
¬¬ 
var
­­ 
jwtSettings
­­ 
=
­­ 
configuration
­­ '
.
­­' (

GetSection
­­( 2
(
­­2 3
$str
­­3 8
)
­­8 9
;
­­9 :
var
―― 
key
―― 
=
―― 
new
―― "
SymmetricSecurityKey
―― *
(
――* +
Encoding
°° 
.
°° 
UTF8
°° 
.
°° 
GetBytes
°° "
(
°°" #
jwtSettings
°°# .
[
°°. /
$str
°°/ 4
]
°°4 5
!
°°5 6
)
°°6 7
)
±± 	
;
±±	 

var
³³ 
credentials
³³ 
=
³³ 
new
³³  
SigningCredentials
³³ 0
(
³³0 1
key
³³1 4
,
³³4 5 
SecurityAlgorithms
³³6 H
.
³³H I

HmacSha256
³³I S
)
³³S T
;
³³T U
var
µµ 
claims
µµ 
=
µµ 
new
µµ 
List
µµ 
<
µµ 
Claim
µµ #
>
µµ# $
{
¶¶ 	
new
·· 
Claim
·· 
(
·· 
AppClaimTypes
·· #
.
··# $
UserId
··$ *
,
··* +
user
··, 0
.
··0 1
Id
··1 3
)
··3 4
,
··4 5
new
ΈΈ 
Claim
ΈΈ 
(
ΈΈ %
JwtRegisteredClaimNames
ΈΈ -
.
ΈΈ- .
Sub
ΈΈ. 1
,
ΈΈ1 2
user
ΈΈ3 7
.
ΈΈ7 8
Id
ΈΈ8 :
)
ΈΈ: ;
,
ΈΈ; <
new
ΉΉ 
Claim
ΉΉ 
(
ΉΉ %
JwtRegisteredClaimNames
ΉΉ -
.
ΉΉ- .
Email
ΉΉ. 3
,
ΉΉ3 4
user
ΉΉ5 9
.
ΉΉ9 :
Email
ΉΉ: ?
??
ΉΉ@ B
string
ΉΉC I
.
ΉΉI J
Empty
ΉΉJ O
)
ΉΉO P
,
ΉΉP Q
new
ΊΊ 
Claim
ΊΊ 
(
ΊΊ 

ClaimTypes
ΊΊ  
.
ΊΊ  !
NameIdentifier
ΊΊ! /
,
ΊΊ/ 0
user
ΊΊ1 5
.
ΊΊ5 6
Id
ΊΊ6 8
)
ΊΊ8 9
,
ΊΊ9 :
new
»» 
Claim
»» 
(
»» 

ClaimTypes
»»  
.
»»  !
Email
»»! &
,
»»& '
user
»»( ,
.
»», -
Email
»»- 2
??
»»3 5
string
»»6 <
.
»»< =
Empty
»»= B
)
»»B C
,
»»C D
new
ΌΌ 
Claim
ΌΌ 
(
ΌΌ %
JwtRegisteredClaimNames
ΌΌ -
.
ΌΌ- .
Jti
ΌΌ. 1
,
ΌΌ1 2
Guid
ΌΌ3 7
.
ΌΌ7 8
NewGuid
ΌΌ8 ?
(
ΌΌ? @
)
ΌΌ@ A
.
ΌΌA B
ToString
ΌΌB J
(
ΌΌJ K
)
ΌΌK L
)
ΌΌL M
}
½½ 	
;
½½	 

foreach
ΏΏ 
(
ΏΏ 
var
ΏΏ 
role
ΏΏ 
in
ΏΏ 
roles
ΏΏ "
)
ΏΏ" #
{
ΐΐ 	
claims
ΑΑ 
.
ΑΑ 
Add
ΑΑ 
(
ΑΑ 
new
ΑΑ 
Claim
ΑΑ  
(
ΑΑ  !
AppClaimTypes
ΑΑ! .
.
ΑΑ. /
Role
ΑΑ/ 3
,
ΑΑ3 4
role
ΑΑ5 9
)
ΑΑ9 :
)
ΑΑ: ;
;
ΑΑ; <
claims
ΒΒ 
.
ΒΒ 
Add
ΒΒ 
(
ΒΒ 
new
ΒΒ 
Claim
ΒΒ  
(
ΒΒ  !

ClaimTypes
ΒΒ! +
.
ΒΒ+ ,
Role
ΒΒ, 0
,
ΒΒ0 1
role
ΒΒ2 6
)
ΒΒ6 7
)
ΒΒ7 8
;
ΒΒ8 9
}
ΓΓ 	
if
ΕΕ 

(
ΕΕ 
	patientId
ΕΕ 
.
ΕΕ 
HasValue
ΕΕ 
)
ΕΕ 
{
ΖΖ 	
claims
ΗΗ 
.
ΗΗ 
Add
ΗΗ 
(
ΗΗ 
new
ΗΗ 
Claim
ΗΗ  
(
ΗΗ  !
AppClaimTypes
ΗΗ! .
.
ΗΗ. /
	PatientId
ΗΗ/ 8
,
ΗΗ8 9
	patientId
ΗΗ: C
.
ΗΗC D
Value
ΗΗD I
.
ΗΗI J
ToString
ΗΗJ R
(
ΗΗR S
)
ΗΗS T
)
ΗΗT U
)
ΗΗU V
;
ΗΗV W
}
ΘΘ 	
if
ΚΚ 

(
ΚΚ 
doctorId
ΚΚ 
.
ΚΚ 
HasValue
ΚΚ 
)
ΚΚ 
{
ΛΛ 	
claims
ΜΜ 
.
ΜΜ 
Add
ΜΜ 
(
ΜΜ 
new
ΜΜ 
Claim
ΜΜ  
(
ΜΜ  !
AppClaimTypes
ΜΜ! .
.
ΜΜ. /
DoctorId
ΜΜ/ 7
,
ΜΜ7 8
doctorId
ΜΜ9 A
.
ΜΜA B
Value
ΜΜB G
.
ΜΜG H
ToString
ΜΜH P
(
ΜΜP Q
)
ΜΜQ R
)
ΜΜR S
)
ΜΜS T
;
ΜΜT U
}
ΝΝ 	
var
ΟΟ 
token
ΟΟ 
=
ΟΟ 
new
ΟΟ 
JwtSecurityToken
ΟΟ (
(
ΟΟ( )
issuer
ΠΠ 
:
ΠΠ 
jwtSettings
ΠΠ 
[
ΠΠ  
$str
ΠΠ  (
]
ΠΠ( )
,
ΠΠ) *
audience
ΡΡ 
:
ΡΡ 
jwtSettings
ΡΡ !
[
ΡΡ! "
$str
ΡΡ" ,
]
ΡΡ, -
,
ΡΡ- .
claims
ÒÒ 
:
ÒÒ 
claims
ÒÒ 
,
ÒÒ 
expires
ΣΣ 
:
ΣΣ 
DateTime
ΣΣ 
.
ΣΣ 
UtcNow
ΣΣ $
.
ΣΣ$ %

AddMinutes
ΣΣ% /
(
ΣΣ/ 0
	expiresIn
ΣΣ0 9
)
ΣΣ9 :
,
ΣΣ: ; 
signingCredentials
ΤΤ 
:
ΤΤ 
credentials
ΤΤ  +
)
ΥΥ 	
;
ΥΥ	 

return
ΧΧ 
new
ΧΧ %
JwtSecurityTokenHandler
ΧΧ *
(
ΧΧ* +
)
ΧΧ+ ,
.
ΧΧ, -

WriteToken
ΧΧ- 7
(
ΧΧ7 8
token
ΧΧ8 =
)
ΧΧ= >
;
ΧΧ> ?
}
ΨΨ 
public
ΪΪ 

async
ΪΪ 
Task
ΪΪ 
<
ΪΪ 
(
ΪΪ 
bool
ΪΪ 
Success
ΪΪ #
,
ΪΪ# $
string
ΪΪ% +
Message
ΪΪ, 3
,
ΪΪ3 4
AuthResponseDto
ΪΪ5 D
?
ΪΪD E
Response
ΪΪF N
)
ΪΪN O
>
ΪΪO P.
 CreateAuthResponseForUserIdAsync
ΪΪQ q
(
ΪΪq r
string
ΪΪr x
userId
ΪΪy 
)ΪΪ €
{
ΫΫ 
var
άά 
user
άά 
=
άά 
await
άά 
userManager
άά $
.
άά$ %
FindByIdAsync
άά% 2
(
άά2 3
userId
άά3 9
)
άά9 :
;
άά: ;
if
ήή 

(
ήή 
user
ήή 
==
ήή 
null
ήή 
)
ήή 
{
ίί 	
return
ΰΰ 
(
ΰΰ 
false
ΰΰ 
,
ΰΰ 
$str
ΰΰ 4
,
ΰΰ4 5
null
ΰΰ6 :
)
ΰΰ: ;
;
ΰΰ; <
}
αα 	
var
γγ 
profileResult
γγ 
=
γγ 
await
γγ !#
BuildUserProfileAsync
γγ" 7
(
γγ7 8
user
γγ8 <
)
γγ< =
;
γγ= >
if
εε 

(
εε 
!
εε 
profileResult
εε 
.
εε 
Success
εε "
)
εε" #
{
ζζ 	
return
ηη 
(
ηη 
false
ηη 
,
ηη 
profileResult
ηη (
.
ηη( )
Message
ηη) 0
,
ηη0 1
null
ηη2 6
)
ηη6 7
;
ηη7 8
}
θθ 	
var
κκ 
response
κκ 
=
κκ 
await
κκ '
GenerateAuthResponseAsync
κκ 6
(
κκ6 7
user
λλ 
,
λλ 
profileResult
μμ 
.
μμ 
Roles
μμ 
,
μμ  
profileResult
νν 
.
νν 
Role
νν 
,
νν 
profileResult
ξξ 
.
ξξ 
	PatientId
ξξ #
,
ξξ# $
profileResult
οο 
.
οο 
DoctorId
οο "
,
οο" #
$str
ππ .
)
ππ. /
;
ππ/ 0
return
ςς 
(
ςς 
true
ςς 
,
ςς 
response
ςς 
.
ςς 
Message
ςς &
,
ςς& '
response
ςς( 0
)
ςς0 1
;
ςς1 2
}
σσ 
}„„ ή
ZC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\AppointmentService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
.! "
Impl" &
;& '
public 
class 
AppointmentService 
(  "
IAppointmentRepository !
appointmentRepository 0
,0 1
IPatientRepository 
patientRepository (
,( )
IDoctorRepository 
doctorRepository &
,& '
IMapper 
mapper 
) 
: 
IAppointmentService )
{ 
private 
const 
int 0
$MinimumBookingHoursBeforeAppointment :
=; <
$num= ?
;? @
private 
const 
int 5
)MinimumCancellationHoursBeforeAppointment ?
=@ A
$numB D
;D E
private 
const 
int 3
'PendingAutoCancelHoursBeforeAppointment =
=> ?
$num@ B
;B C
private 
const 
int %
MaximumBookingMonthsAhead /
=0 1
$num2 3
;3 4
public 

async 
Task 
< 
PagedResultDto $
<$ %
AppointmentDto% 3
>3 4
>4 5#
GetAllAppointmentsAsync6 M
(M N
PaginationQueryDtoN `

paginationa k
)k l
{ 
await 5
)AutoCancelExpiredPendingAppointmentsAsync 7
(7 8
)8 9
;9 :
var 
appointments 
= 
await  !
appointmentRepository! 6
.6 7#
GetAllAppointmentsAsync7 N
(N O

pagination 
. 

PageNumber !
,! "

pagination 
. 
PageSize 
)  
;  !
return   
MapPagedResult   
<   
Appointment   )
,  ) *
AppointmentDto  + 9
>  9 :
(  : ;
appointments  ; G
)  G H
;  H I
}!! 
public## 

async## 
Task## 
<## 
AppointmentDto## $
>##$ %#
GetAppointmentByIdAsync##& =
(##= >
int##> A
id##B D
)##D E
{$$ 
await%% 5
)AutoCancelExpiredPendingAppointmentsAsync%% 7
(%%7 8
)%%8 9
;%%9 :
var'' 
appointment'' 
='' 
await'' !
appointmentRepository''  5
.''5 6.
"GetAppointmentByIdWithDetailsAsync''6 X
(''X Y
id''Y [
)''[ \
;''\ ]
if)) 

()) 
appointment)) 
==)) 
null)) 
)))  
{** 	
throw++ 
new++ 
NotFoundException++ '
(++' (
ErrorMessages++( 5
.++5 6
AppointmentNotFound++6 I
)++I J
;++J K
},, 	
return.. 
mapper.. 
... 
Map.. 
<.. 
AppointmentDto.. (
>..( )
(..) *
appointment..* 5
)..5 6
;..6 7
}// 
public11 

async11 
Task11 
<11 
AppointmentDto11 $
?11$ %
>11% &"
CreateAppointmentAsync11' =
(11= > 
CreateAppointmentDto11> R
dto11S V
)11V W
{22 
await33 0
$ValidateAppointmentCanBeCreatedAsync33 2
(332 3
dto333 6
)336 7
;337 8
var55 
appointment55 
=55 
new55 
Appointment55 )
{66 	
	PatientId77 
=77 
dto77 
.77 
	PatientId77 %
,77% &
DoctorId88 
=88 
dto88 
.88 
DoctorId88 #
,88# $
AppointmentDate99 
=99 
dto99 !
.99! "
AppointmentDate99" 1
,991 2
AppointmentTime:: 
=:: 
dto:: !
.::! "
AppointmentTime::" 1
,::1 2
Status;; 
=;; 
AppointmentStatus;; &
.;;& '
Pending;;' .
}<< 	
;<<	 

var>> 
createdAppointment>> 
=>>  
await>>! &!
appointmentRepository>>' <
.>>< =
AddAsync>>= E
(>>E F
appointment>>F Q
)>>Q R
;>>R S
var@@ "
appointmentWithDetails@@ "
=@@# $
await@@% *!
appointmentRepository@@+ @
.@@@ A.
"GetAppointmentByIdWithDetailsAsync@@A c
(@@c d
createdAppointment@@d v
.@@v w
Id@@w y
)@@y z
;@@z {
returnBB "
appointmentWithDetailsBB %
==BB& (
nullBB) -
?CC 
throwCC 
newCC 
NotFoundExceptionCC )
(CC) *
ErrorMessagesCC* 7
.CC7 8,
 AppointmentNotFoundAfterCreationCC8 X
)CCX Y
:DD 
mapperDD 
.DD 
MapDD 
<DD 
AppointmentDtoDD '
>DD' (
(DD( )"
appointmentWithDetailsDD) ?
)DD? @
;DD@ A
}EE 
publicGG 

asyncGG 
TaskGG 
<GG 
PagedResultDtoGG $
<GG$ %
AppointmentDtoGG% 3
>GG3 4
>GG4 5*
GetAppointmentsByDoctorIdAsyncGG6 T
(GGT U
intHH 
doctorIdHH 
,HH 
AppointmentStatusII 
?II 
statusII !
,II! "
PaginationQueryDtoJJ 

paginationJJ %
)JJ% &
{KK 
awaitLL 5
)AutoCancelExpiredPendingAppointmentsAsyncLL 7
(LL7 8
)LL8 9
;LL9 :
varNN 
appointmentsNN 
=NN 
awaitNN  !
appointmentRepositoryNN! 6
.NN6 7*
GetAppointmentsByDoctorIdAsyncNN7 U
(NNU V
doctorIdOO 
,OO 
statusPP 
,PP 

paginationQQ 
.QQ 

PageNumberQQ !
,QQ! "

paginationRR 
.RR 
PageSizeRR 
)RR  
;RR  !
returnTT 
MapPagedResultTT 
<TT 
AppointmentTT )
,TT) *
AppointmentDtoTT+ 9
>TT9 :
(TT: ;
appointmentsTT; G
)TTG H
;TTH I
}UU 
publicWW 

asyncWW 
TaskWW 
<WW 
PagedResultDtoWW $
<WW$ %
AppointmentDtoWW% 3
>WW3 4
>WW4 5+
GetAppointmentsByPatientIdAsyncWW6 U
(WWU V
intXX 
	patientIdXX 
,XX 
AppointmentStatusYY 
?YY 
statusYY !
,YY! "
PaginationQueryDtoZZ 

paginationZZ %
)ZZ% &
{[[ 
await\\ 5
)AutoCancelExpiredPendingAppointmentsAsync\\ 7
(\\7 8
)\\8 9
;\\9 :
var^^ 
appointments^^ 
=^^ 
await^^  !
appointmentRepository^^! 6
.^^6 7+
GetAppointmentsByPatientIdAsync^^7 V
(^^V W
	patientId__ 
,__ 
status`` 
,`` 

paginationaa 
.aa 

PageNumberaa !
,aa! "

paginationbb 
.bb 
PageSizebb 
)bb  
;bb  !
returndd 
MapPagedResultdd 
<dd 
Appointmentdd )
,dd) *
AppointmentDtodd+ 9
>dd9 :
(dd: ;
appointmentsdd; G
)ddG H
;ddH I
}ee 
publicgg 

asyncgg 
Taskgg 
<gg 
PagedResultDtogg $
<gg$ %
AppointmentDtogg% 3
>gg3 4
>gg4 51
%GetAppointmentsByDoctorIdAndDateAsyncgg6 [
(gg[ \
inthh 
doctorIdhh 
,hh 
DateOnlyii 
dateii 
,ii 
PaginationQueryDtojj 

paginationjj %
)jj% &
{kk 
awaitll 5
)AutoCancelExpiredPendingAppointmentsAsyncll 7
(ll7 8
)ll8 9
;ll9 :
varnn 
appointmentsnn 
=nn 
awaitnn  !
appointmentRepositorynn! 6
.nn6 71
%GetAppointmentsByDoctorIdAndDateAsyncnn7 \
(nn\ ]
doctorIdoo 
,oo 
datepp 
,pp 

paginationqq 
.qq 

PageNumberqq !
,qq! "

paginationrr 
.rr 
PageSizerr 
)rr  
;rr  !
returntt 
MapPagedResulttt 
<tt 
Appointmenttt )
,tt) *
AppointmentDtott+ 9
>tt9 :
(tt: ;
appointmentstt; G
)ttG H
;ttH I
}uu 
publicww 

asyncww 
Taskww 
<ww 
PagedResultDtoww $
<ww$ %
AppointmentDtoww% 3
>ww3 4
>ww4 5/
#GetAppointmentsByDateAndStatusAsyncww6 Y
(wwY Z
DateOnlyxx 
datexx 
,xx 
AppointmentStatusyy 
?yy 
statusyy !
,yy! "
PaginationQueryDtozz 

paginationzz %
)zz% &
{{{ 
await|| 5
)AutoCancelExpiredPendingAppointmentsAsync|| 7
(||7 8
)||8 9
;||9 :
var~~ 
appointments~~ 
=~~ 
await~~  !
appointmentRepository~~! 6
.~~6 7/
#GetAppointmentsByDateAndStatusAsync~~7 Z
(~~Z [
date 
, 
status
€€ 
,
€€ 

pagination
 
.
 

PageNumber
 !
,
! "

pagination
‚‚ 
.
‚‚ 
PageSize
‚‚ 
)
‚‚  
;
‚‚  !
return
„„ 
MapPagedResult
„„ 
<
„„ 
Appointment
„„ )
,
„„) *
AppointmentDto
„„+ 9
>
„„9 :
(
„„: ;
appointments
„„; G
)
„„G H
;
„„H I
}
…… 
public
‡‡ 

async
‡‡ 
Task
‡‡ 
<
‡‡ 
AppointmentDto
‡‡ $
?
‡‡$ %
>
‡‡% &*
UpdateAppointmentStatusAsync
‡‡' C
(
‡‡C D
int
 
id
 
,
 (
UpdateAppointmentStatusDto
‰‰ "
dto
‰‰# &
,
‰‰& '
string
 
currentRole
 
,
 
int
‹‹ 
?
‹‹ 
currentPatientId
‹‹ 
,
‹‹ 
int
 
?
 
currentDoctorId
 
)
 
{
 
await
 7
)AutoCancelExpiredPendingAppointmentsAsync
 7
(
7 8
)
8 9
;
9 :
var
 
appointment
 
=
 
await
 #
appointmentRepository
  5
.
5 60
"GetAppointmentByIdWithDetailsAsync
6 X
(
X Y
id
Y [
)
[ \
;
\ ]
if
’’ 

(
’’ 
appointment
’’ 
==
’’ 
null
’’ 
)
’’  
{
““ 	
throw
”” 
new
”” 
NotFoundException
”” '
(
””' (
ErrorMessages
””( 5
.
””5 6!
AppointmentNotFound
””6 I
)
””I J
;
””J K
}
•• 	
switch
—— 
(
—— 
dto
—— 
.
—— 
Status
—— 
)
—— 
{
 	
case
™™ 
AppointmentStatus
™™ "
.
™™" #
	Confirmed
™™# ,
:
™™, - 
ConfirmAppointment
 "
(
" #
appointment
# .
,
. /
currentRole
0 ;
,
; <
currentDoctorId
= L
)
L M
;
M N
break
›› 
;
›› 
case
 
AppointmentStatus
 "
.
" #
	Cancelled
# ,
:
, -
CancelAppointment
 !
(
! "
appointment
" -
,
- .
dto
/ 2
,
2 3
currentRole
4 ?
,
? @
currentPatientId
A Q
,
Q R
currentDoctorId
S b
)
b c
;
c d
break
 
;
 
case
΅΅ 
AppointmentStatus
΅΅ "
.
΅΅" #
	Completed
΅΅# ,
:
΅΅, -
throw
ΆΆ 
new
ΆΆ #
BusinessRuleException
ΆΆ /
(
ΆΆ/ 0
ErrorMessages
ΆΆ0 =
.
ΆΆ= >9
+AppointmentCompletedOnlyThroughHealthRecord
ΆΆ> i
)
ΆΆi j
;
ΆΆj k
default
¤¤ 
:
¤¤ 
throw
¥¥ 
new
¥¥ #
BusinessRuleException
¥¥ /
(
¥¥/ 0
ErrorMessages
¥¥0 =
.
¥¥= >4
&UnsupportedAppointmentStatusTransition
¥¥> d
)
¥¥d e
;
¥¥e f
}
¦¦ 	
await
¨¨ #
appointmentRepository
¨¨ #
.
¨¨# $
UpdateAsync
¨¨$ /
(
¨¨/ 0
appointment
¨¨0 ;
)
¨¨; <
;
¨¨< =
var
ªª $
appointmentWithDetails
ªª "
=
ªª# $
await
ªª% *#
appointmentRepository
ªª+ @
.
ªª@ A0
"GetAppointmentByIdWithDetailsAsync
ªªA c
(
ªªc d
id
ªªd f
)
ªªf g
;
ªªg h
return
¬¬ $
appointmentWithDetails
¬¬ %
==
¬¬& (
null
¬¬) -
?
­­ 
throw
­­ 
new
­­ 
NotFoundException
­­ )
(
­­) *
ErrorMessages
­­* 7
.
­­7 8!
AppointmentNotFound
­­8 K
)
­­K L
:
®® 
mapper
®® 
.
®® 
Map
®® 
<
®® 
AppointmentDto
®® '
>
®®' (
(
®®( )$
appointmentWithDetails
®®) ?
)
®®? @
;
®®@ A
}
―― 
public
±± 

async
±± 
Task
±± 
<
±± 
List
±± 
<
±± "
AppointmentReportDto
±± /
>
±±/ 0
>
±±0 1(
GetAppointmentReportsAsync
±±2 L
(
±±L M
)
±±M N
{
²² 
await
³³ 7
)AutoCancelExpiredPendingAppointmentsAsync
³³ 7
(
³³7 8
)
³³8 9
;
³³9 :
return
µµ 
await
µµ #
appointmentRepository
µµ *
.
µµ* +(
GetAppointmentReportsAsync
µµ+ E
(
µµE F
)
µµF G
;
µµG H
}
¶¶ 
private
ΈΈ 
async
ΈΈ 
Task
ΈΈ 2
$ValidateAppointmentCanBeCreatedAsync
ΈΈ ;
(
ΈΈ; <"
CreateAppointmentDto
ΈΈ< P
dto
ΈΈQ T
)
ΈΈT U
{
ΉΉ 
var
ΊΊ 
patient
ΊΊ 
=
ΊΊ 
await
ΊΊ 
patientRepository
ΊΊ -
.
ΊΊ- .
GetByIdAsync
ΊΊ. :
(
ΊΊ: ;
dto
ΊΊ; >
.
ΊΊ> ?
	PatientId
ΊΊ? H
)
ΊΊH I
;
ΊΊI J
if
ΌΌ 

(
ΌΌ 
patient
ΌΌ 
==
ΌΌ 
null
ΌΌ 
)
ΌΌ 
{
½½ 	
throw
ΎΎ 
new
ΎΎ 
NotFoundException
ΎΎ '
(
ΎΎ' (
ErrorMessages
ΎΎ( 5
.
ΎΎ5 6
PatientNotFound
ΎΎ6 E
)
ΎΎE F
;
ΎΎF G
}
ΏΏ 	
var
ΑΑ 
doctor
ΑΑ 
=
ΑΑ 
await
ΑΑ 
doctorRepository
ΑΑ +
.
ΑΑ+ , 
GetDoctorByIdAsync
ΑΑ, >
(
ΑΑ> ?
dto
ΑΑ? B
.
ΑΑB C
DoctorId
ΑΑC K
)
ΑΑK L
;
ΑΑL M
if
ΓΓ 

(
ΓΓ 
doctor
ΓΓ 
==
ΓΓ 
null
ΓΓ 
)
ΓΓ 
{
ΔΔ 	
throw
ΕΕ 
new
ΕΕ 
NotFoundException
ΕΕ '
(
ΕΕ' (
ErrorMessages
ΕΕ( 5
.
ΕΕ5 6
DoctorNotFound
ΕΕ6 D
)
ΕΕD E
;
ΕΕE F
}
ΖΖ 	
if
ΘΘ 

(
ΘΘ 
!
ΘΘ 
doctor
ΘΘ 
.
ΘΘ 
IsAvailable
ΘΘ 
)
ΘΘ  
{
ΙΙ 	
throw
ΚΚ 
new
ΚΚ #
BusinessRuleException
ΚΚ +
(
ΚΚ+ ,
ErrorMessages
ΚΚ, 9
.
ΚΚ9 :
DoctorUnavailable
ΚΚ: K
)
ΚΚK L
;
ΚΚL M
}
ΛΛ 	
if
ΝΝ 

(
ΝΝ 
!
ΝΝ !
IsAtLeastHoursAhead
ΝΝ  
(
ΝΝ  !
dto
ΝΝ! $
.
ΝΝ$ %
AppointmentDate
ΝΝ% 4
,
ΝΝ4 5
dto
ΝΝ6 9
.
ΝΝ9 :
AppointmentTime
ΝΝ: I
,
ΝΝI J2
$MinimumBookingHoursBeforeAppointment
ΝΝK o
)
ΝΝo p
)
ΝΝp q
{
ΞΞ 	
throw
ΟΟ 
new
ΟΟ #
BusinessRuleException
ΟΟ +
(
ΟΟ+ ,
ErrorMessages
ΟΟ, 9
.
ΟΟ9 :8
*AppointmentMustBeBookedAtLeast48HoursAhead
ΟΟ: d
)
ΟΟd e
;
ΟΟe f
}
ΠΠ 	
if
ΡΡ 

(
ΡΡ #
IsMoreThanMonthsAhead
ΡΡ !
(
ΡΡ! "
dto
ΡΡ" %
.
ΡΡ% &
AppointmentDate
ΡΡ& 5
,
ΡΡ5 6'
MaximumBookingMonthsAhead
ΡΡ7 P
)
ΡΡP Q
)
ΡΡQ R
{
ÒÒ 	
throw
ΣΣ 
new
ΣΣ #
BusinessRuleException
ΣΣ +
(
ΣΣ+ ,
ErrorMessages
ΣΣ, 9
.
ΣΣ9 :=
/AppointmentCannotBeBookedMoreThanSixMonthsAhead
ΣΣ: i
)
ΣΣi j
;
ΣΣj k
}
ΤΤ 	
if
ΥΥ 

(
ΥΥ 
await
ΥΥ #
appointmentRepository
ΥΥ '
.
ΥΥ' (5
'DoctorHasNonCancelledAppointmentAtAsync
ΥΥ( O
(
ΥΥO P
dto
ΦΦ 
.
ΦΦ 
DoctorId
ΦΦ 
,
ΦΦ 
dto
ΧΧ 
.
ΧΧ 
AppointmentDate
ΧΧ #
,
ΧΧ# $
dto
ΨΨ 
.
ΨΨ 
AppointmentTime
ΨΨ #
)
ΨΨ# $
)
ΨΨ$ %
{
ΩΩ 	
throw
ΪΪ 
new
ΪΪ 
ConflictException
ΪΪ '
(
ΪΪ' (
ErrorMessages
ΪΪ( 5
.
ΪΪ5 6%
DoctorSlotAlreadyBooked
ΪΪ6 M
)
ΪΪM N
;
ΪΪN O
}
ΫΫ 	
if
έέ 

(
έέ 
await
έέ #
appointmentRepository
έέ '
.
έέ' (6
(PatientHasNonCancelledAppointmentAtAsync
έέ( P
(
έέP Q
dto
ήή 
.
ήή 
	PatientId
ήή 
,
ήή 
dto
ίί 
.
ίί 
AppointmentDate
ίί #
,
ίί# $
dto
ΰΰ 
.
ΰΰ 
AppointmentTime
ΰΰ #
)
ΰΰ# $
)
ΰΰ$ %
{
αα 	
throw
ββ 
new
ββ 
ConflictException
ββ '
(
ββ' (
ErrorMessages
ββ( 5
.
ββ5 6&
PatientSlotAlreadyBooked
ββ6 N
)
ββN O
;
ββO P
}
γγ 	
if
εε 

(
εε 
await
εε #
appointmentRepository
εε '
.
εε' (D
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsync
εε( ^
(
εε^ _
dto
ζζ 
.
ζζ 
	PatientId
ζζ 
,
ζζ 
dto
ηη 
.
ηη 
DoctorId
ηη 
,
ηη 
dto
θθ 
.
θθ 
AppointmentDate
θθ #
)
θθ# $
)
θθ$ %
{
ιι 	
throw
κκ 
new
κκ 
ConflictException
κκ '
(
κκ' (
ErrorMessages
κκ( 5
.
κκ5 6:
,PatientAlreadyHasAppointmentWithDoctorOnDate
κκ6 b
)
κκb c
;
κκc d
}
λλ 	
}
μμ 
private
ξξ 
static
ξξ 
void
ξξ  
ConfirmAppointment
ξξ *
(
ξξ* +
Appointment
ξξ+ 6
appointment
ξξ7 B
,
ξξB C
string
ξξD J
currentRole
ξξK V
,
ξξV W
int
ξξX [
?
ξξ[ \
currentDoctorId
ξξ] l
)
ξξl m
{
οο 
if
ππ 

(
ππ 
appointment
ππ 
.
ππ 
Status
ππ 
!=
ππ !
AppointmentStatus
ππ" 3
.
ππ3 4
Pending
ππ4 ;
)
ππ; <
{
ρρ 	
throw
ςς 
new
ςς #
BusinessRuleException
ςς +
(
ςς+ ,
ErrorMessages
ςς, 9
.
ςς9 :3
%OnlyPendingAppointmentsCanBeConfirmed
ςς: _
)
ςς_ `
;
ςς` a
}
σσ 	
if
υυ 

(
υυ 
currentRole
υυ 
==
υυ 
AppRoles
υυ #
.
υυ# $
Patient
υυ$ +
)
υυ+ ,
{
φφ 	
throw
χχ 
new
χχ  
ForbiddenException
χχ (
(
χχ( )
ErrorMessages
χχ) 6
.
χχ6 74
&UnsupportedAppointmentStatusTransition
χχ7 ]
)
χχ] ^
;
χχ^ _
}
ψψ 	
if
ϊϊ 

(
ϊϊ 
currentRole
ϊϊ 
==
ϊϊ 
AppRoles
ϊϊ #
.
ϊϊ# $
Doctor
ϊϊ$ *
&&
ϊϊ+ -
currentDoctorId
ϊϊ. =
!=
ϊϊ> @
appointment
ϊϊA L
.
ϊϊL M
DoctorId
ϊϊM U
)
ϊϊU V
{
ϋϋ 	
throw
όό 
new
όό  
ForbiddenException
όό (
(
όό( )
ErrorMessages
όό) 6
.
όό6 71
#DoctorsCanManageOnlyOwnAppointments
όό7 Z
)
όόZ [
;
όό[ \
}
ύύ 	
appointment
ÿÿ 
.
ÿÿ 
Status
ÿÿ 
=
ÿÿ 
AppointmentStatus
ÿÿ .
.
ÿÿ. /
	Confirmed
ÿÿ/ 8
;
ÿÿ8 9
appointment
€€ 
.
€€  
CancellationReason
€€ &
=
€€' (
null
€€) -
;
€€- .
}
 
private
ƒƒ 
static
ƒƒ 
void
ƒƒ 
CancelAppointment
ƒƒ )
(
ƒƒ) *
Appointment
„„ 
appointment
„„ 
,
„„ (
UpdateAppointmentStatusDto
…… 
dto
…… "
,
……" #
string
†† 

currentRole
†† 
,
†† 
int
‡‡ 
?
‡‡ 
currentPatientId
‡‡	 
,
‡‡ 
int
 
?
 
currentDoctorId
	 
)
 
{
‰‰ -
EnsureAppointmentCanBeCancelled
 '
(
' (
appointment
( 3
,
3 4
dto
5 8
)
8 9
;
9 :
var
 
reason
 
=
 
dto
 
.
  
CancellationReason
 +
!
+ ,
.
, -
Trim
- 1
(
1 2
)
2 3
;
3 4
appointment
 
.
  
CancellationReason
 &
=
' (
currentRole
) 4
switch
5 ;
{
 	
AppRoles
 
.
 
Patient
 
=>
 ,
BuildPatientCancellationReason
  >
(
> ?
appointment
‘‘ 
,
‘‘ 
reason
’’ 
,
’’ 
currentPatientId
““  
)
““  !
,
““! "
AppRoles
•• 
.
•• 
Doctor
•• 
=>
•• +
BuildDoctorCancellationReason
•• <
(
••< =
appointment
–– 
,
–– 
reason
—— 
,
—— 
currentDoctorId
 
)
  
,
  !
AppRoles
 
.
 
Admin
 
=>
 
reason
 $
+
% &
ErrorMessages
' 4
.
4 5$
CancelledByAdminSuffix
5 K
,
K L
_
 
=>
 
throw
 
new
  
ForbiddenException
 -
(
- .
ErrorMessages
. ;
.
; <4
&UnsupportedAppointmentStatusTransition
< b
)
b c
}
 	
;
	 

appointment
 
.
 
Status
 
=
 
AppointmentStatus
 .
.
. /
	Cancelled
/ 8
;
8 9
}
   
private
ΆΆ 
static
ΆΆ 
void
ΆΆ -
EnsureAppointmentCanBeCancelled
ΆΆ 7
(
ΆΆ7 8
Appointment
££ 
appointment
££ 
,
££ (
UpdateAppointmentStatusDto
¤¤ 
dto
¤¤ "
)
¤¤" #
{
¥¥ 
if
¦¦ 

(
¦¦ 
string
¦¦ 
.
¦¦  
IsNullOrWhiteSpace
¦¦ %
(
¦¦% &
dto
¦¦& )
.
¦¦) * 
CancellationReason
¦¦* <
)
¦¦< =
)
¦¦= >
{
§§ 	
throw
¨¨ 
new
¨¨ #
BusinessRuleException
¨¨ +
(
¨¨+ ,
ErrorMessages
¨¨, 9
.
¨¨9 :(
CancellationReasonRequired
¨¨: T
)
¨¨T U
;
¨¨U V
}
©© 	
if
«« 

(
«« 
appointment
«« 
.
«« 
Status
«« 
==
«« !
AppointmentStatus
««" 3
.
««3 4
	Completed
««4 =
)
««= >
{
¬¬ 	
throw
­­ 
new
­­ #
BusinessRuleException
­­ +
(
­­+ ,
ErrorMessages
­­, 9
.
­­9 :4
&CompletedAppointmentsCannotBeCancelled
­­: `
)
­­` a
;
­­a b
}
®® 	
if
°° 

(
°° 
appointment
°° 
.
°° 
Status
°° 
==
°° !
AppointmentStatus
°°" 3
.
°°3 4
	Cancelled
°°4 =
)
°°= >
{
±± 	
throw
²² 
new
²² #
BusinessRuleException
²² +
(
²²+ ,
ErrorMessages
²², 9
.
²²9 :9
+CancelledAppointmentsCannotBeCancelledAgain
²²: e
)
²²e f
;
²²f g
}
³³ 	
}
΄΄ 
private
¶¶ 
static
¶¶ 
string
¶¶ ,
BuildPatientCancellationReason
¶¶ 8
(
¶¶8 9
Appointment
·· 
appointment
·· 
,
··  
string
ΈΈ 
reason
ΈΈ 
,
ΈΈ 
int
ΉΉ 
?
ΉΉ 
currentPatientId
ΉΉ 
)
ΉΉ 
{
ΊΊ 
if
»» 

(
»» 
currentPatientId
»» 
!=
»» 
appointment
»»  +
.
»»+ ,
	PatientId
»», 5
)
»»5 6
{
ΌΌ 	
throw
½½ 
new
½½  
ForbiddenException
½½ (
(
½½( )
ErrorMessages
½½) 6
.
½½6 72
$PatientsCanManageOnlyOwnAppointments
½½7 [
)
½½[ \
;
½½\ ]
}
ΎΎ 	
if
ΐΐ 

(
ΐΐ 
appointment
ΐΐ 
.
ΐΐ 
Status
ΐΐ 
!=
ΐΐ !
AppointmentStatus
ΐΐ" 3
.
ΐΐ3 4
Pending
ΐΐ4 ;
)
ΐΐ; <
{
ΑΑ 	
throw
ΒΒ 
new
ΒΒ #
BusinessRuleException
ΒΒ +
(
ΒΒ+ ,
ErrorMessages
ΒΒ, 9
.
ΒΒ9 :6
(PatientsCanCancelOnlyPendingAppointments
ΒΒ: b
)
ΒΒb c
;
ΒΒc d
}
ΓΓ 	
return
ΕΕ 
reason
ΕΕ 
+
ΕΕ 
ErrorMessages
ΕΕ %
.
ΕΕ% &&
CancelledByPatientSuffix
ΕΕ& >
;
ΕΕ> ?
}
ΖΖ 
private
ΘΘ 
static
ΘΘ 
string
ΘΘ +
BuildDoctorCancellationReason
ΘΘ 7
(
ΘΘ7 8
Appointment
ΙΙ 
appointment
ΙΙ 
,
ΙΙ  
string
ΚΚ 
reason
ΚΚ 
,
ΚΚ 
int
ΛΛ 
?
ΛΛ 
currentDoctorId
ΛΛ 
)
ΛΛ 
{
ΜΜ 
if
ΝΝ 

(
ΝΝ 
currentDoctorId
ΝΝ 
!=
ΝΝ 
appointment
ΝΝ *
.
ΝΝ* +
DoctorId
ΝΝ+ 3
)
ΝΝ3 4
{
ΞΞ 	
throw
ΟΟ 
new
ΟΟ  
ForbiddenException
ΟΟ (
(
ΟΟ( )
ErrorMessages
ΟΟ) 6
.
ΟΟ6 71
#DoctorsCanManageOnlyOwnAppointments
ΟΟ7 Z
)
ΟΟZ [
;
ΟΟ[ \
}
ΠΠ 	
if
ÒÒ 

(
ÒÒ 
appointment
ÒÒ 
.
ÒÒ 
Status
ÒÒ 
!=
ÒÒ !
AppointmentStatus
ÒÒ" 3
.
ÒÒ3 4
Pending
ÒÒ4 ;
&&
ÒÒ< >
appointment
ΣΣ 
.
ΣΣ 
Status
ΣΣ 
!=
ΣΣ !
AppointmentStatus
ΣΣ" 3
.
ΣΣ3 4
	Confirmed
ΣΣ4 =
)
ΣΣ= >
{
ΤΤ 	
throw
ΥΥ 
new
ΥΥ #
BusinessRuleException
ΥΥ +
(
ΥΥ+ ,
ErrorMessages
ΥΥ, 9
.
ΥΥ9 :@
2DoctorsCanCancelOnlyPendingOrConfirmedAppointments
ΥΥ: l
)
ΥΥl m
;
ΥΥm n
}
ΦΦ 	
if
ΨΨ 

(
ΨΨ 
!
ΨΨ !
IsAtLeastHoursAhead
ΨΨ  
(
ΨΨ  !
appointment
ΩΩ 
.
ΩΩ 
AppointmentDate
ΩΩ +
,
ΩΩ+ ,
appointment
ΪΪ 
.
ΪΪ 
AppointmentTime
ΪΪ +
,
ΪΪ+ ,7
)MinimumCancellationHoursBeforeAppointment
ΫΫ 9
)
ΫΫ9 :
)
ΫΫ: ;
{
άά 	
throw
έέ 
new
έέ #
BusinessRuleException
έέ +
(
έέ+ ,
ErrorMessages
έέ, 9
.
έέ9 :7
)AppointmentCannotBeCancelledWithin24Hours
έέ: c
)
έέc d
;
έέd e
}
ήή 	
return
ΰΰ 
reason
ΰΰ 
+
ΰΰ 
ErrorMessages
ΰΰ %
.
ΰΰ% &%
CancelledByDoctorSuffix
ΰΰ& =
;
ΰΰ= >
}
αα 
private
γγ 
async
γγ 
Task
γγ 7
)AutoCancelExpiredPendingAppointmentsAsync
γγ @
(
γγ@ A
)
γγA B
{
δδ 
var
εε 
cutoffDateTime
εε 
=
εε 
DateTime
εε %
.
εε% &
Now
εε& )
.
εε) *
AddHours
εε* 2
(
εε2 35
'PendingAutoCancelHoursBeforeAppointment
εε3 Z
)
εεZ [
;
εε[ \
var
ζζ (
expiredPendingAppointments
ζζ &
=
ζζ' (
await
ζζ) .#
appointmentRepository
ζζ/ D
.
ζζD E0
"GetExpiredPendingAppointmentsAsync
ζζE g
(
ζζg h
cutoffDateTime
ζζh v
)
ζζv w
;
ζζw x
foreach
θθ 
(
θθ 
var
θθ 
appointment
θθ  
in
θθ! #(
expiredPendingAppointments
θθ$ >
)
θθ> ?
{
ιι 	
appointment
κκ 
.
κκ 
Status
κκ 
=
κκ  
AppointmentStatus
κκ! 2
.
κκ2 3
	Cancelled
κκ3 <
;
κκ< =
appointment
λλ 
.
λλ  
CancellationReason
λλ *
=
λλ+ ,
ErrorMessages
λλ- :
.
λλ: ;3
%PendingAppointmentAutoCancelledReason
λλ; `
;
λλ` a
await
νν #
appointmentRepository
νν '
.
νν' (
UpdateAsync
νν( 3
(
νν3 4
appointment
νν4 ?
)
νν? @
;
νν@ A
}
ξξ 	
}
οο 
private
ρρ 
static
ρρ 
bool
ρρ !
IsAtLeastHoursAhead
ρρ +
(
ρρ+ ,
DateOnly
ρρ, 4
date
ρρ5 9
,
ρρ9 :
TimeOnly
ρρ; C
time
ρρD H
,
ρρH I
int
ρρJ M
minimumHours
ρρN Z
)
ρρZ [
{
ςς 
var
σσ 
scheduledAt
σσ 
=
σσ 
date
σσ 
.
σσ 

ToDateTime
σσ )
(
σσ) *
time
σσ* .
)
σσ. /
;
σσ/ 0
return
υυ 
scheduledAt
υυ 
>=
υυ 
DateTime
υυ &
.
υυ& '
Now
υυ' *
.
υυ* +
AddHours
υυ+ 3
(
υυ3 4
minimumHours
υυ4 @
)
υυ@ A
;
υυA B
}
φφ 
private
χχ 
static
χχ 
bool
χχ #
IsMoreThanMonthsAhead
χχ -
(
χχ- .
DateOnly
χχ. 6
date
χχ7 ;
,
χχ; <
int
χχ= @
maximumMonths
χχA N
)
χχN O
{
ψψ 
var
ωω 
latestAllowedDate
ωω 
=
ωω 
DateOnly
ωω  (
.
ωω( )
FromDateTime
ωω) 5
(
ωω5 6
DateTime
ωω6 >
.
ωω> ?
Today
ωω? D
)
ωωD E
.
ωωE F
	AddMonths
ωωF O
(
ωωO P
maximumMonths
ωωP ]
)
ωω] ^
;
ωω^ _
return
ϋϋ 
date
ϋϋ 
>
ϋϋ 
latestAllowedDate
ϋϋ '
;
ϋϋ' (
}
όό 
private
ύύ 
PagedResultDto
ύύ 
<
ύύ 
TDestination
ύύ '
>
ύύ' (
MapPagedResult
ύύ) 7
<
ύύ7 8
TSource
ύύ8 ?
,
ύύ? @
TDestination
ύύA M
>
ύύM N
(
ύύN O
PagedResult
ύύO Z
<
ύύZ [
TSource
ύύ[ b
>
ύύb c
pagedResult
ύύd o
)
ύύo p
{
ώώ 
return
ÿÿ 
new
ÿÿ 
PagedResultDto
ÿÿ !
<
ÿÿ! "
TDestination
ÿÿ" .
>
ÿÿ. /
{
€€ 	
Items
 
=
 
mapper
 
.
 
Map
 
<
 
List
 #
<
# $
TDestination
$ 0
>
0 1
>
1 2
(
2 3
pagedResult
3 >
.
> ?
Items
? D
)
D E
,
E F

PageNumber
‚‚ 
=
‚‚ 
pagedResult
‚‚ $
.
‚‚$ %

PageNumber
‚‚% /
,
‚‚/ 0
PageSize
ƒƒ 
=
ƒƒ 
pagedResult
ƒƒ "
.
ƒƒ" #
PageSize
ƒƒ# +
,
ƒƒ+ ,

TotalCount
„„ 
=
„„ 
pagedResult
„„ $
.
„„$ %

TotalCount
„„% /
,
„„/ 0

TotalPages
…… 
=
…… 
pagedResult
…… $
.
……$ %

TotalPages
……% /
}
†† 	
;
††	 

}
‡‡ 
} 
[C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\AdminHandoffService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
.! "
Impl" &
;& '
public 
class 
AdminHandoffService  
(  !
IMemoryCache! -
cache. 3
)3 4
:5 6 
IAdminHandoffService7 K
{ 
private 
const 
int 
ExpirySeconds #
=$ %
$num& (
;( )
public

 

string

 

CreateCode

 
(

 
string

 #
userId

$ *
)

* +
{ 
var 
bytes 
= !
RandomNumberGenerator )
.) *
GetBytes* 2
(2 3
$num3 5
)5 6
;6 7
var 
code 
= 
Convert 
. 
ToBase64String )
() *
bytes* /
)/ 0
. 
Replace 
( 
$char 
, 
$char 
) 
. 
Replace 
( 
$char 
, 
$char 
) 
. 
Replace 
( 
$str 
, 
string  
.  !
Empty! &
)& '
;' (
cache 
. 
Set 
( 
GetCacheKey 
( 
code 
) 
, 
userId 
, 
TimeSpan 
. 
FromSeconds  
(  !
ExpirySeconds! .
). /
)/ 0
;0 1
return 
code 
; 
} 
public 

string 
? 
ConsumeCode 
( 
string %
code& *
)* +
{ 
var 
cacheKey 
= 
GetCacheKey "
(" #
code# '
)' (
;( )
if 

( 
! 
cache 
. 
TryGetValue 
< 
string %
>% &
(& '
cacheKey' /
,/ 0
out1 4
var5 8
userId9 ?
)? @
)@ A
{ 	
return   
null   
;   
}!! 	
cache## 
.## 
Remove## 
(## 
cacheKey## 
)## 
;## 
return%% 
userId%% 
;%% 
}&& 
private(( 
static(( 
string(( 
GetCacheKey(( %
(((% &
string((& ,
code((- 1
)((1 2
{)) 
return** 
$"** 
$str** 
{**  
code**  $
}**$ %
"**% &
;**& '
}++ 
},, φ 
TC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\AdminService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
.! "
Impl" &
;& '
public 
class 
AdminService 
( 
HealthAxisDbContext 
context 
,  
IDoctorRepository 
doctorRepository &
,& '
IPatientRepository 
patientRepository (
,( )
IAppointmentService 
appointmentService *
,* +
IMapper 
mapper 
, 
UserManager 
< 
IdentityUser 
> 
userManager )
)) *
:+ ,
IAdminService- :
{ 
public 

async 
Task 
< $
AdminDashboardSummaryDto .
>. /$
GetDashboardSummaryAsync0 H
(H I
)I J
{ 
var 
today 
= 
DateOnly 
. 
FromDateTime )
() *
DateTime* 2
.2 3
Today3 8
)8 9
;9 :
return 
new $
AdminDashboardSummaryDto +
{   	
ActiveDoctorsCount!! 
=!!  
await!!! &
context!!' .
.!!. /
Doctors!!/ 6
.!!6 7

CountAsync!!7 A
(!!A B
doctor!!B H
=>!!I K
doctor!!L R
.!!R S
IsAvailable!!S ^
)!!^ _
,!!_ `#
RegisteredPatientsCount"" #
=""$ %
await""& +
context"", 3
.""3 4
Patients""4 <
.""< =

CountAsync""= G
(""G H
)""H I
,""I J$
PendingAppointmentsCount## $
=##% &
await##' ,
context##- 4
.##4 5
Appointments##5 A
.##A B

CountAsync##B L
(##L M
appointment##M X
=>##Y [
appointment##\ g
.##g h
Status##h n
==##o q
AppointmentStatus	##r ƒ
.
##ƒ „
Pending
##„ ‹
)
##‹ 
,
## &
ConfirmedAppointmentsCount$$ &
=$$' (
await$$) .
context$$/ 6
.$$6 7
Appointments$$7 C
.$$C D

CountAsync$$D N
($$N O
appointment$$O Z
=>$$[ ]
appointment$$^ i
.$$i j
Status$$j p
==$$q s
AppointmentStatus	$$t …
.
$$… †
	Confirmed
$$† 
)
$$ 
,
$$ ‘&
CompletedAppointmentsCount%% &
=%%' (
await%%) .
context%%/ 6
.%%6 7
Appointments%%7 C
.%%C D

CountAsync%%D N
(%%N O
appointment%%O Z
=>%%[ ]
appointment%%^ i
.%%i j
Status%%j p
==%%q s
AppointmentStatus	%%t …
.
%%… †
	Completed
%%† 
)
%% 
,
%% ‘&
CancelledAppointmentsCount&& &
=&&' (
await&&) .
context&&/ 6
.&&6 7
Appointments&&7 C
.&&C D

CountAsync&&D N
(&&N O
appointment&&O Z
=>&&[ ]
appointment&&^ i
.&&i j
Status&&j p
==&&q s
AppointmentStatus	&&t …
.
&&… †
	Cancelled
&&† 
)
&& 
,
&& ‘#
TodaysAppointmentsCount'' #
=''$ %
await''& +
context'', 3
.''3 4
Appointments''4 @
.''@ A

CountAsync''A K
(''K L
appointment''L W
=>''X Z
appointment''[ f
.''f g
AppointmentDate''g v
==''w y
today''z 
)	'' €
,
''€ *
TodaysPendingAppointmentsCount(( *
=((+ ,
await((- 2
context((3 :
.((: ;
Appointments((; G
.((G H

CountAsync((H R
(((R S
appointment((S ^
=>((_ a
appointment((b m
.((m n
AppointmentDate((n }
==	((~ €
today
(( †
&&
((‡ ‰
appointment
(( •
.
((• –
Status
((– 
==
(( 
AppointmentStatus
((  ±
.
((± ²
Pending
((² Ή
)
((Ή Ί
,
((Ί »,
 TodaysConfirmedAppointmentsCount)) ,
=))- .
await))/ 4
context))5 <
.))< =
Appointments))= I
.))I J

CountAsync))J T
())T U
appointment))U `
=>))a c
appointment))d o
.))o p
AppointmentDate))p 
==
))€ ‚
today
))ƒ 
&&
))‰ ‹
appointment
)) —
.
))— 
Status
)) 
==
)) ΅
AppointmentStatus
))Ά ³
.
))³ ΄
	Confirmed
))΄ ½
)
))½ Ύ
,
))Ύ Ώ,
 TodaysCompletedAppointmentsCount** ,
=**- .
await**/ 4
context**5 <
.**< =
Appointments**= I
.**I J

CountAsync**J T
(**T U
appointment**U `
=>**a c
appointment**d o
.**o p
AppointmentDate**p 
==
**€ ‚
today
**ƒ 
&&
**‰ ‹
appointment
** —
.
**— 
Status
** 
==
** ΅
AppointmentStatus
**Ά ³
.
**³ ΄
	Completed
**΄ ½
)
**½ Ύ
,
**Ύ Ώ,
 TodaysCancelledAppointmentsCount++ ,
=++- .
await++/ 4
context++5 <
.++< =
Appointments++= I
.++I J

CountAsync++J T
(++T U
appointment++U `
=>++a c
appointment++d o
.++o p
AppointmentDate++p 
==
++€ ‚
today
++ƒ 
&&
++‰ ‹
appointment
++ —
.
++— 
Status
++ 
==
++ ΅
AppointmentStatus
++Ά ³
.
++³ ΄
	Cancelled
++΄ ½
)
++½ Ύ
},, 	
;,,	 

}-- 
public// 

async// 
Task// 
<// 
PagedResultDto// $
<//$ %
	DoctorDto//% .
>//. /
>/// 0
GetDoctorsAsync//1 @
(//@ A
PaginationQueryDto00 

pagination00 %
,00% &
string11 
?11 
search11 
=11 
null11 
,11  
DoctorSpecialisation22 
?22 
specialisation22 ,
=22- .
null22/ 3
)223 4
{33 
var44 
doctors44 
=44 
await44 
doctorRepository44 ,
.44, -&
GetAllDoctorsWithUserAsync44- G
(44G H

pagination55 
.55 

PageNumber55 !
,55! "

pagination66 
.66 
PageSize66 
,66  
search77 
,77 
specialisation88 
)88 
;88 
return:: 
MapPagedResult:: 
<:: 
Doctor:: $
,::$ %
	DoctorDto::& /
>::/ 0
(::0 1
doctors::1 8
)::8 9
;::9 :
};; 
public== 

async== 
Task== 
<== 
	DoctorDto== 
?==  
>==  !
CreateDoctorAsync==" 3
(==3 4
CreateDoctorDto==4 C
dto==D G
)==G H
{>> 
var?? 
existingUser?? 
=?? 
await??  
userManager??! ,
.??, -
FindByEmailAsync??- =
(??= >
dto??> A
.??A B
Email??B G
)??G H
;??H I
ifAA 

(AA 
existingUserAA 
!=AA 
nullAA  
)AA  !
{BB 	
throwCC 
newCC 
ConflictExceptionCC '
(CC' (
ErrorMessagesCC( 5
.CC5 6
EmailAlreadyExistsCC6 H
)CCH I
;CCI J
}DD 	
awaitFF 
usingFF 
varFF 
transactionFF #
=FF$ %
awaitFF& +
contextFF, 3
.FF3 4
DatabaseFF4 <
.FF< =!
BeginTransactionAsyncFF= R
(FFR S
)FFS T
;FFT U
tryHH 
{II 	
varJJ 
userJJ 
=JJ 
newJJ 
IdentityUserJJ '
{KK 
UserNameLL 
=LL 
dtoLL 
.LL 
EmailLL $
,LL$ %
EmailMM 
=MM 
dtoMM 
.MM 
EmailMM !
,MM! "
PhoneNumberNN 
=NN 
dtoNN !
.NN! "
PhoneNumberNN" -
,NN- .
EmailConfirmedOO 
=OO  
trueOO! %
}PP 
;PP 
varRR 
createUserResultRR  
=RR! "
awaitRR# (
userManagerRR) 4
.RR4 5
CreateAsyncRR5 @
(RR@ A
userRRA E
,RRE F
dtoRRG J
.RRJ K
PasswordRRK S
)RRS T
;RRT U
ifTT 
(TT 
!TT 
createUserResultTT !
.TT! "
	SucceededTT" +
)TT+ ,
{UU 
varVV 
errorsVV 
=VV 
stringVV #
.VV# $
JoinVV$ (
(VV( )
$strVV) ,
,VV, -
createUserResultVV. >
.VV> ?
ErrorsVV? E
.VVE F
SelectVVF L
(VVL M
errorVVM R
=>VVS U
errorVVV [
.VV[ \
DescriptionVV\ g
)VVg h
)VVh i
;VVi j
throwWW 
newWW 
BadRequestExceptionWW -
(WW- .
errorsWW. 4
)WW4 5
;WW5 6
}XX 
varZZ 
addRoleResultZZ 
=ZZ 
awaitZZ  %
userManagerZZ& 1
.ZZ1 2
AddToRoleAsyncZZ2 @
(ZZ@ A
userZZA E
,ZZE F
AppRolesZZG O
.ZZO P
DoctorZZP V
)ZZV W
;ZZW X
if\\ 
(\\ 
!\\ 
addRoleResult\\ 
.\\ 
	Succeeded\\ (
)\\( )
{]] 
var^^ 
errors^^ 
=^^ 
string^^ #
.^^# $
Join^^$ (
(^^( )
$str^^) ,
,^^, -
addRoleResult^^. ;
.^^; <
Errors^^< B
.^^B C
Select^^C I
(^^I J
error^^J O
=>^^P R
error^^S X
.^^X Y
Description^^Y d
)^^d e
)^^e f
;^^f g
throw__ 
new__ 
BadRequestException__ -
(__- .
errors__. 4
)__4 5
;__5 6
}`` 
varbb 
doctorbb 
=bb 
newbb 
Doctorbb #
{cc 
UserIddd 
=dd 
userdd 
.dd 
Iddd  
,dd  !
FullNameee 
=ee 
dtoee 
.ee 
FullNameee '
,ee' (
Specialisationff 
=ff  
dtoff! $
.ff$ %
Specialisationff% 3
,ff3 4
PracticeStartDategg !
=gg" #
dtogg$ '
.gg' (
PracticeStartDategg( 9
,gg9 :
ConsultationFeehh 
=hh  !
dtohh" %
.hh% &
ConsultationFeehh& 5
,hh5 6
IsAvailableii 
=ii 
dtoii !
.ii! "
IsAvailableii" -
}jj 
;jj 
varll 
createdDoctorll 
=ll 
awaitll  %
doctorRepositoryll& 6
.ll6 7
AddAsyncll7 ?
(ll? @
doctorll@ F
)llF G
;llG H
awaitnn 
transactionnn 
.nn 
CommitAsyncnn )
(nn) *
)nn* +
;nn+ ,
varpp 
doctorWithUserpp 
=pp  
awaitpp! &
doctorRepositorypp' 7
.pp7 8&
GetDoctorByIdWithUserAsyncpp8 R
(ppR S
createdDoctorppS `
.pp` a
Idppa c
)ppc d
;ppd e
returnrr 
doctorWithUserrr !
==rr" $
nullrr% )
?ss 
throwss 
newss 
NotFoundExceptionss -
(ss- .
ErrorMessagesss. ;
.ss; <'
DoctorNotFoundAfterCreationss< W
)ssW X
:tt 
mappertt 
.tt 
Maptt 
<tt 
	DoctorDtott &
>tt& '
(tt' (
doctorWithUsertt( 6
)tt6 7
;tt7 8
}uu 	
catchvv 
{ww 	
awaitxx 
transactionxx 
.xx 
RollbackAsyncxx +
(xx+ ,
)xx, -
;xx- .
throwyy 
;yy 
}zz 	
}{{ 
public}} 

async}} 
Task}} 
<}} 
	DoctorDto}} 
?}}  
>}}  !
UpdateDoctorAsync}}" 3
(}}3 4
int}}4 7
id}}8 :
,}}: ;
UpdateDoctorDto}}< K
dto}}L O
)}}O P
{~~ 
var 
doctor 
= 
await 
doctorRepository +
.+ ,&
GetDoctorByIdWithUserAsync, F
(F G
idG I
)I J
;J K
if
 

(
 
doctor
 
==
 
null
 
)
 
{
‚‚ 	
throw
ƒƒ 
new
ƒƒ 
NotFoundException
ƒƒ '
(
ƒƒ' (
ErrorMessages
ƒƒ( 5
.
ƒƒ5 6
DoctorNotFound
ƒƒ6 D
)
ƒƒD E
;
ƒƒE F
}
„„ 	
if
†† 

(
†† 
doctor
†† 
.
†† 
User
†† 
==
†† 
null
†† 
)
††  
{
‡‡ 	
throw
 
new
 
NotFoundException
 '
(
' (
ErrorMessages
( 5
.
5 6
DoctorNotFound
6 D
)
D E
;
E F
}
‰‰ 	
await
‹‹ 0
"EnsureEmailIsAvailableForUserAsync
‹‹ 0
(
‹‹0 1
dto
‹‹1 4
.
‹‹4 5
Email
‹‹5 :
,
‹‹: ;
doctor
‹‹< B
.
‹‹B C
UserId
‹‹C I
)
‹‹I J
;
‹‹J K
doctor
 
.
 
FullName
 
=
 
dto
 
.
 
FullName
 &
;
& '
doctor
 
.
 
Specialisation
 
=
 
dto
  #
.
# $
Specialisation
$ 2
;
2 3
doctor
 
.
 
PracticeStartDate
  
=
! "
dto
# &
.
& '
PracticeStartDate
' 8
;
8 9
doctor
 
.
 
ConsultationFee
 
=
  
dto
! $
.
$ %
ConsultationFee
% 4
;
4 5
doctor
‘‘ 
.
‘‘ 
User
‘‘ 
.
‘‘ 
Email
‘‘ 
=
‘‘ 
dto
‘‘ 
.
‘‘  
Email
‘‘  %
.
‘‘% &
Trim
‘‘& *
(
‘‘* +
)
‘‘+ ,
;
‘‘, -
doctor
’’ 
.
’’ 
User
’’ 
.
’’ 
UserName
’’ 
=
’’ 
dto
’’ "
.
’’" #
Email
’’# (
.
’’( )
Trim
’’) -
(
’’- .
)
’’. /
;
’’/ 0
doctor
““ 
.
““ 
User
““ 
.
““ 
PhoneNumber
““ 
=
““  !
dto
““" %
.
““% &
PhoneNumber
““& 1
;
““1 2
doctor
”” 
.
”” 
User
”” 
.
”” 
EmailConfirmed
”” "
=
””# $
true
””% )
;
””) *
var
–– 
updateUserResult
–– 
=
–– 
await
–– $
userManager
––% 0
.
––0 1
UpdateAsync
––1 <
(
––< =
doctor
––= C
.
––C D
User
––D H
)
––H I
;
––I J
if
 

(
 
!
 
updateUserResult
 
.
 
	Succeeded
 '
)
' (
{
™™ 	
var
 
errors
 
=
 
string
 
.
  
Join
  $
(
$ %
$str
% (
,
( )
updateUserResult
* :
.
: ;
Errors
; A
.
A B
Select
B H
(
H I
error
I N
=>
O Q
error
R W
.
W X
Description
X c
)
c d
)
d e
;
e f
throw
›› 
new
›› !
BadRequestException
›› )
(
››) *
errors
››* 0
)
››0 1
;
››1 2
}
 	
await
 
doctorRepository
 
.
 
UpdateAsync
 *
(
* +
doctor
+ 1
)
1 2
;
2 3
var
   
updatedDoctor
   
=
   
await
   !
doctorRepository
  " 2
.
  2 3(
GetDoctorByIdWithUserAsync
  3 M
(
  M N
id
  N P
)
  P Q
;
  Q R
return
ΆΆ 
updatedDoctor
ΆΆ 
==
ΆΆ 
null
ΆΆ  $
?
££ 
throw
££ 
new
££ 
NotFoundException
££ )
(
££) *
ErrorMessages
££* 7
.
££7 8
DoctorNotFound
££8 F
)
££F G
:
¤¤ 
mapper
¤¤ 
.
¤¤ 
Map
¤¤ 
<
¤¤ 
	DoctorDto
¤¤ "
>
¤¤" #
(
¤¤# $
updatedDoctor
¤¤$ 1
)
¤¤1 2
;
¤¤2 3
}
¥¥ 
public
§§ 

async
§§ 
Task
§§ &
ResetDoctorPasswordAsync
§§ .
(
§§. /
int
§§/ 2
id
§§3 5
,
§§5 6#
AdminResetPasswordDto
§§7 L
dto
§§M P
)
§§P Q
{
¨¨ 
var
©© 
doctor
©© 
=
©© 
await
©© 
doctorRepository
©© +
.
©©+ ,(
GetDoctorByIdWithUserAsync
©©, F
(
©©F G
id
©©G I
)
©©I J
;
©©J K
if
«« 

(
«« 
doctor
«« 
==
«« 
null
«« 
||
«« 
doctor
«« $
.
««$ %
User
««% )
==
««* ,
null
««- 1
)
««1 2
{
¬¬ 	
throw
­­ 
new
­­ 
NotFoundException
­­ '
(
­­' (
ErrorMessages
­­( 5
.
­­5 6
DoctorNotFound
­­6 D
)
­­D E
;
­­E F
}
®® 	
await
°° $
ResetUserPasswordAsync
°° $
(
°°$ %
doctor
°°% +
.
°°+ ,
User
°°, 0
,
°°0 1
dto
°°2 5
)
°°5 6
;
°°6 7
}
±± 
public
³³ 

async
³³ 
Task
³³ 
<
³³ 
PagedResultDto
³³ $
<
³³$ %
AppointmentDto
³³% 3
>
³³3 4
>
³³4 5(
GetDoctorAppointmentsAsync
³³6 P
(
³³P Q
int
³³Q T
doctorId
³³U ]
,
³³] ^
AppointmentStatus
³³_ p
?
³³p q
status
³³r x
,
³³x y!
PaginationQueryDto³³z 

pagination³³ —
)³³— 
{
΄΄ 
var
µµ 
doctorExists
µµ 
=
µµ 
await
µµ  
doctorRepository
µµ! 1
.
µµ1 2 
GetDoctorByIdAsync
µµ2 D
(
µµD E
doctorId
µµE M
)
µµM N
;
µµN O
if
·· 

(
·· 
doctorExists
·· 
==
·· 
null
··  
)
··  !
{
ΈΈ 	
throw
ΉΉ 
new
ΉΉ 
NotFoundException
ΉΉ '
(
ΉΉ' (
ErrorMessages
ΉΉ( 5
.
ΉΉ5 6
DoctorNotFound
ΉΉ6 D
)
ΉΉD E
;
ΉΉE F
}
ΊΊ 	
return
ΌΌ 
await
ΌΌ  
appointmentService
ΌΌ '
.
ΌΌ' (,
GetAppointmentsByDoctorIdAsync
ΌΌ( F
(
ΌΌF G
doctorId
ΌΌG O
,
ΌΌO P
status
ΌΌQ W
,
ΌΌW X

pagination
ΌΌY c
)
ΌΌc d
;
ΌΌd e
}
½½ 
public
ΏΏ 

async
ΏΏ 
Task
ΏΏ 
<
ΏΏ 
PagedResultDto
ΏΏ $
<
ΏΏ$ %

PatientDto
ΏΏ% /
>
ΏΏ/ 0
>
ΏΏ0 1
GetPatientsAsync
ΏΏ2 B
(
ΏΏB C 
PaginationQueryDto
ΏΏC U

pagination
ΏΏV `
,
ΏΏ` a
string
ΏΏb h
?
ΏΏh i
search
ΏΏj p
)
ΏΏp q
{
ΐΐ 
var
ΑΑ 
patients
ΑΑ 
=
ΑΑ 
await
ΑΑ 
patientRepository
ΑΑ .
.
ΑΑ. /)
GetAllPatientsWithUserAsync
ΑΑ/ J
(
ΑΑJ K

pagination
ΒΒ 
.
ΒΒ 

PageNumber
ΒΒ !
,
ΒΒ! "

pagination
ΓΓ 
.
ΓΓ 
PageSize
ΓΓ 
,
ΓΓ  
search
ΔΔ 
)
ΔΔ 
;
ΔΔ 
return
ΖΖ 
MapPagedResult
ΖΖ 
<
ΖΖ 
Patient
ΖΖ %
,
ΖΖ% &

PatientDto
ΖΖ' 1
>
ΖΖ1 2
(
ΖΖ2 3
patients
ΖΖ3 ;
)
ΖΖ; <
;
ΖΖ< =
}
ΗΗ 
public
ΙΙ 

async
ΙΙ 
Task
ΙΙ 
<
ΙΙ 

PatientDto
ΙΙ  
?
ΙΙ  !
>
ΙΙ! " 
UpdatePatientAsync
ΙΙ# 5
(
ΙΙ5 6
int
ΙΙ6 9
id
ΙΙ: <
,
ΙΙ< =
UpdatePatientDto
ΙΙ> N
dto
ΙΙO R
)
ΙΙR S
{
ΚΚ 
var
ΛΛ 
patient
ΛΛ 
=
ΛΛ 
await
ΛΛ 
patientRepository
ΛΛ -
.
ΛΛ- .)
GetPatientByIdWithUserAsync
ΛΛ. I
(
ΛΛI J
id
ΛΛJ L
)
ΛΛL M
;
ΛΛM N
if
ΝΝ 

(
ΝΝ 
patient
ΝΝ 
==
ΝΝ 
null
ΝΝ 
)
ΝΝ 
{
ΞΞ 	
throw
ΟΟ 
new
ΟΟ 
NotFoundException
ΟΟ '
(
ΟΟ' (
ErrorMessages
ΟΟ( 5
.
ΟΟ5 6
PatientNotFound
ΟΟ6 E
)
ΟΟE F
;
ΟΟF G
}
ΠΠ 	
if
ÒÒ 

(
ÒÒ 
patient
ÒÒ 
.
ÒÒ 
User
ÒÒ 
==
ÒÒ 
null
ÒÒ  
)
ÒÒ  !
{
ΣΣ 	
throw
ΤΤ 
new
ΤΤ 
NotFoundException
ΤΤ '
(
ΤΤ' (
ErrorMessages
ΤΤ( 5
.
ΤΤ5 6$
PatientAccountNotFound
ΤΤ6 L
)
ΤΤL M
;
ΤΤM N
}
ΥΥ 	
await
ΧΧ 0
"EnsureEmailIsAvailableForUserAsync
ΧΧ 0
(
ΧΧ0 1
dto
ΧΧ1 4
.
ΧΧ4 5
Email
ΧΧ5 :
,
ΧΧ: ;
patient
ΧΧ< C
.
ΧΧC D
UserId
ΧΧD J
)
ΧΧJ K
;
ΧΧK L
patient
ΩΩ 
.
ΩΩ 
FullName
ΩΩ 
=
ΩΩ 
dto
ΩΩ 
.
ΩΩ 
FullName
ΩΩ '
;
ΩΩ' (
patient
ΪΪ 
.
ΪΪ 
DateOfBirth
ΪΪ 
=
ΪΪ 
dto
ΪΪ !
.
ΪΪ! "
DateOfBirth
ΪΪ" -
;
ΪΪ- .
patient
ΫΫ 
.
ΫΫ 
Gender
ΫΫ 
=
ΫΫ 
dto
ΫΫ 
.
ΫΫ 
Gender
ΫΫ #
;
ΫΫ# $
patient
άά 
.
άά 
Address
άά 
=
άά 
dto
άά 
.
άά 
Address
άά %
;
άά% &
patient
έέ 
.
έέ 
User
έέ 
.
έέ 
Email
έέ 
=
έέ 
dto
έέ  
.
έέ  !
Email
έέ! &
.
έέ& '
Trim
έέ' +
(
έέ+ ,
)
έέ, -
;
έέ- .
patient
ήή 
.
ήή 
User
ήή 
.
ήή 
UserName
ήή 
=
ήή 
dto
ήή  #
.
ήή# $
Email
ήή$ )
.
ήή) *
Trim
ήή* .
(
ήή. /
)
ήή/ 0
;
ήή0 1
patient
ίί 
.
ίί 
User
ίί 
.
ίί 
PhoneNumber
ίί  
=
ίί! "
dto
ίί# &
.
ίί& '
PhoneNumber
ίί' 2
;
ίί2 3
patient
ΰΰ 
.
ΰΰ 
User
ΰΰ 
.
ΰΰ 
EmailConfirmed
ΰΰ #
=
ΰΰ$ %
true
ΰΰ& *
;
ΰΰ* +
var
ββ 
updateUserResult
ββ 
=
ββ 
await
ββ $
userManager
ββ% 0
.
ββ0 1
UpdateAsync
ββ1 <
(
ββ< =
patient
ββ= D
.
ββD E
User
ββE I
)
ββI J
;
ββJ K
if
δδ 

(
δδ 
!
δδ 
updateUserResult
δδ 
.
δδ 
	Succeeded
δδ '
)
δδ' (
{
εε 	
var
ζζ 
errors
ζζ 
=
ζζ 
string
ζζ 
.
ζζ  
Join
ζζ  $
(
ζζ$ %
$str
ζζ% (
,
ζζ( )
updateUserResult
ζζ* :
.
ζζ: ;
Errors
ζζ; A
.
ζζA B
Select
ζζB H
(
ζζH I
error
ζζI N
=>
ζζO Q
error
ζζR W
.
ζζW X
Description
ζζX c
)
ζζc d
)
ζζd e
;
ζζe f
throw
ηη 
new
ηη !
BadRequestException
ηη )
(
ηη) *
errors
ηη* 0
)
ηη0 1
;
ηη1 2
}
θθ 	
await
κκ 
patientRepository
κκ 
.
κκ  
UpdateAsync
κκ  +
(
κκ+ ,
patient
κκ, 3
)
κκ3 4
;
κκ4 5
var
μμ 
updatedPatient
μμ 
=
μμ 
await
μμ "
patientRepository
μμ# 4
.
μμ4 5)
GetPatientByIdWithUserAsync
μμ5 P
(
μμP Q
id
μμQ S
)
μμS T
;
μμT U
return
ξξ 
updatedPatient
ξξ 
==
ξξ  
null
ξξ! %
?
οο 
throw
οο 
new
οο 
NotFoundException
οο )
(
οο) *
ErrorMessages
οο* 7
.
οο7 8
PatientNotFound
οο8 G
)
οοG H
:
ππ 
mapper
ππ 
.
ππ 
Map
ππ 
<
ππ 

PatientDto
ππ #
>
ππ# $
(
ππ$ %
updatedPatient
ππ% 3
)
ππ3 4
;
ππ4 5
}
ρρ 
public
σσ 

async
σσ 
Task
σσ '
ResetPatientPasswordAsync
σσ /
(
σσ/ 0
int
σσ0 3
id
σσ4 6
,
σσ6 7#
AdminResetPasswordDto
σσ8 M
dto
σσN Q
)
σσQ R
{
ττ 
var
υυ 
patient
υυ 
=
υυ 
await
υυ 
patientRepository
υυ -
.
υυ- .)
GetPatientByIdWithUserAsync
υυ. I
(
υυI J
id
υυJ L
)
υυL M
;
υυM N
if
χχ 

(
χχ 
patient
χχ 
==
χχ 
null
χχ 
)
χχ 
{
ψψ 	
throw
ωω 
new
ωω 
NotFoundException
ωω '
(
ωω' (
ErrorMessages
ωω( 5
.
ωω5 6
PatientNotFound
ωω6 E
)
ωωE F
;
ωωF G
}
ϊϊ 	
if
όό 

(
όό 
patient
όό 
.
όό 
User
όό 
==
όό 
null
όό  
)
όό  !
{
ύύ 	
throw
ώώ 
new
ώώ 
NotFoundException
ώώ '
(
ώώ' (
ErrorMessages
ώώ( 5
.
ώώ5 6$
PatientAccountNotFound
ώώ6 L
)
ώώL M
;
ώώM N
}
ÿÿ 	
await
 $
ResetUserPasswordAsync
 $
(
$ %
patient
% ,
.
, -
User
- 1
,
1 2
dto
3 6
)
6 7
;
7 8
}
‚‚ 
public
„„ 

async
„„ 
Task
„„ 
<
„„ 
PagedResultDto
„„ $
<
„„$ %
AppointmentDto
„„% 3
>
„„3 4
>
„„4 5)
GetPatientAppointmentsAsync
„„6 Q
(
„„Q R
int
„„R U
	patientId
„„V _
,
„„_ `
AppointmentStatus
„„a r
?
„„r s
status
„„t z
,
„„z {!
PaginationQueryDto„„| 

pagination„„ ™
)„„™ 
{
…… 
return
†† 
await
††  
appointmentService
†† '
.
††' (-
GetAppointmentsByPatientIdAsync
††( G
(
††G H
	patientId
††H Q
,
††Q R
status
††S Y
,
††Y Z

pagination
††[ e
)
††e f
;
††f g
}
‡‡ 
public
‰‰ 

async
‰‰ 
Task
‰‰ 
<
‰‰ 
PagedResultDto
‰‰ $
<
‰‰$ %"
AppointmentReportDto
‰‰% 9
>
‰‰9 :
>
‰‰: ;(
GetAppointmentReportsAsync
‰‰< V
(
‰‰V W 
PaginationQueryDto
‰‰W i

pagination
‰‰j t
)
‰‰t u
{
 
var
‹‹ 
reports
‹‹ 
=
‹‹ 
await
‹‹  
appointmentService
‹‹ .
.
‹‹. /(
GetAppointmentReportsAsync
‹‹/ I
(
‹‹I J
)
‹‹J K
;
‹‹K L
var
 
orderedReports
 
=
 
reports
 $
.
 
OrderByDescending
 
(
 
report
 %
=>
& (
report
) /
.
/ 0
Date
0 4
)
4 5
.
 
ToList
 
(
 
)
 
;
 
var
‘‘ 

totalCount
‘‘ 
=
‘‘ 
orderedReports
‘‘ '
.
‘‘' (
Count
‘‘( -
;
‘‘- .
var
’’ 

totalPages
’’ 
=
’’ 
(
’’ 
int
’’ 
)
’’ 
Math
’’ "
.
’’" #
Ceiling
’’# *
(
’’* +

totalCount
’’+ 5
/
’’6 7
(
’’8 9
double
’’9 ?
)
’’? @

pagination
’’@ J
.
’’J K
PageSize
’’K S
)
’’S T
;
’’T U
var
”” 
items
”” 
=
”” 
orderedReports
”” "
.
•• 
Skip
•• 
(
•• 
(
•• 

pagination
•• 
.
•• 

PageNumber
•• (
-
••) *
$num
••+ ,
)
••, -
*
••. /

pagination
••0 :
.
••: ;
PageSize
••; C
)
••C D
.
–– 
Take
–– 
(
–– 

pagination
–– 
.
–– 
PageSize
–– %
)
––% &
.
—— 
ToList
—— 
(
—— 
)
—— 
;
—— 
return
™™ 
new
™™ 
PagedResultDto
™™ !
<
™™! ""
AppointmentReportDto
™™" 6
>
™™6 7
{
 	
Items
›› 
=
›› 
items
›› 
,
›› 

PageNumber
 
=
 

pagination
 #
.
# $

PageNumber
$ .
,
. /
PageSize
 
=
 

pagination
 !
.
! "
PageSize
" *
,
* +

TotalCount
 
=
 

totalCount
 #
,
# $

TotalPages
 
=
 

totalPages
 #
}
   	
;
  	 

}
΅΅ 
public
££ 

async
££ 
Task
££ 
<
££ 
PagedResultDto
££ $
<
££$ %
AppointmentDto
££% 3
>
££3 4
>
££4 5.
 GetAppointmentReportDetailsAsync
££6 V
(
££V W
DateOnly
¤¤ 
date
¤¤ 
,
¤¤ 
AppointmentStatus
¥¥ 
?
¥¥ 
status
¥¥ !
,
¥¥! " 
PaginationQueryDto
¦¦ 

pagination
¦¦ %
)
¦¦% &
{
§§ 
return
¨¨ 
await
¨¨  
appointmentService
¨¨ '
.
¨¨' (1
#GetAppointmentsByDateAndStatusAsync
¨¨( K
(
¨¨K L
date
¨¨L P
,
¨¨P Q
status
¨¨R X
,
¨¨X Y

pagination
¨¨Z d
)
¨¨d e
;
¨¨e f
}
©© 
private
«« 
async
«« 
Task
«« $
ResetUserPasswordAsync
«« -
(
««- .
IdentityUser
««. :
user
««; ?
,
««? @#
AdminResetPasswordDto
««A V
dto
««W Z
)
««Z [
{
¬¬ 
var
­­ 

resetToken
­­ 
=
­­ 
await
­­ 
userManager
­­ *
.
­­* +-
GeneratePasswordResetTokenAsync
­­+ J
(
­­J K
user
­­K O
)
­­O P
;
­­P Q
var
®® 
resetResult
®® 
=
®® 
await
®® 
userManager
®®  +
.
®®+ , 
ResetPasswordAsync
®®, >
(
®®> ?
user
®®? C
,
®®C D

resetToken
®®E O
,
®®O P
dto
®®Q T
.
®®T U
NewPassword
®®U `
)
®®` a
;
®®a b
if
°° 

(
°° 
!
°° 
resetResult
°° 
.
°° 
	Succeeded
°° "
)
°°" #
{
±± 	
var
²² 
errors
²² 
=
²² 
string
²² 
.
²²  
Join
²²  $
(
²²$ %
$str
²²% (
,
²²( )
resetResult
²²* 5
.
²²5 6
Errors
²²6 <
.
²²< =
Select
²²= C
(
²²C D
error
²²D I
=>
²²J L
error
²²M R
.
²²R S
Description
²²S ^
)
²²^ _
)
²²_ `
;
²²` a
throw
³³ 
new
³³ !
BadRequestException
³³ )
(
³³) *
errors
³³* 0
)
³³0 1
;
³³1 2
}
΄΄ 	
}
µµ 
private
·· 
async
·· 
Task
·· 0
"EnsureEmailIsAvailableForUserAsync
·· 9
(
··9 :
string
··: @
email
··A F
,
··F G
string
··H N
currentUserId
··O \
)
··\ ]
{
ΈΈ 
var
ΉΉ 
normalizedEmail
ΉΉ 
=
ΉΉ 
email
ΉΉ #
.
ΉΉ# $
Trim
ΉΉ$ (
(
ΉΉ( )
)
ΉΉ) *
;
ΉΉ* +
var
ΊΊ 
existingUser
ΊΊ 
=
ΊΊ 
await
ΊΊ  
userManager
ΊΊ! ,
.
ΊΊ, -
FindByEmailAsync
ΊΊ- =
(
ΊΊ= >
normalizedEmail
ΊΊ> M
)
ΊΊM N
;
ΊΊN O
if
ΌΌ 

(
ΌΌ 
existingUser
ΌΌ 
!=
ΌΌ 
null
ΌΌ  
&&
ΌΌ! #
existingUser
ΌΌ$ 0
.
ΌΌ0 1
Id
ΌΌ1 3
!=
ΌΌ4 6
currentUserId
ΌΌ7 D
)
ΌΌD E
{
½½ 	
throw
ΎΎ 
new
ΎΎ 
ConflictException
ΎΎ '
(
ΎΎ' (
ErrorMessages
ΎΎ( 5
.
ΎΎ5 6 
EmailAlreadyExists
ΎΎ6 H
)
ΎΎH I
;
ΎΎI J
}
ΏΏ 	
}
ΐΐ 
private
ΒΒ 
PagedResultDto
ΒΒ 
<
ΒΒ 
TDestination
ΒΒ '
>
ΒΒ' (
MapPagedResult
ΒΒ) 7
<
ΒΒ7 8
TSource
ΒΒ8 ?
,
ΒΒ? @
TDestination
ΒΒA M
>
ΒΒM N
(
ΒΒN O
PagedResult
ΒΒO Z
<
ΒΒZ [
TSource
ΒΒ[ b
>
ΒΒb c
pagedResult
ΒΒd o
)
ΒΒo p
{
ΓΓ 
return
ΔΔ 
new
ΔΔ 
PagedResultDto
ΔΔ !
<
ΔΔ! "
TDestination
ΔΔ" .
>
ΔΔ. /
{
ΕΕ 	
Items
ΖΖ 
=
ΖΖ 
mapper
ΖΖ 
.
ΖΖ 
Map
ΖΖ 
<
ΖΖ 
List
ΖΖ #
<
ΖΖ# $
TDestination
ΖΖ$ 0
>
ΖΖ0 1
>
ΖΖ1 2
(
ΖΖ2 3
pagedResult
ΖΖ3 >
.
ΖΖ> ?
Items
ΖΖ? D
)
ΖΖD E
,
ΖΖE F

PageNumber
ΗΗ 
=
ΗΗ 
pagedResult
ΗΗ $
.
ΗΗ$ %

PageNumber
ΗΗ% /
,
ΗΗ/ 0
PageSize
ΘΘ 
=
ΘΘ 
pagedResult
ΘΘ "
.
ΘΘ" #
PageSize
ΘΘ# +
,
ΘΘ+ ,

TotalCount
ΙΙ 
=
ΙΙ 
pagedResult
ΙΙ $
.
ΙΙ$ %

TotalCount
ΙΙ% /
,
ΙΙ/ 0

TotalPages
ΚΚ 
=
ΚΚ 
pagedResult
ΚΚ $
.
ΚΚ$ %

TotalPages
ΚΚ% /
}
ΛΛ 	
;
ΛΛ	 

}
ΜΜ 
}ΝΝ Λ
WC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IHealthRecordService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
;! "
public 
	interface  
IHealthRecordService %
{ 
Task 
< 	
PagedResultDto	 
< 
HealthRecordDto '
>' (
>( ),
 GetHealthRecordsByPatientIdAsync* J
(J K
int 
	patientId 
, 
PaginationQueryDto		 

pagination		 %
)		% &
;		& '
Task 
< 	
PagedResultDto	 
< 
HealthRecordDto '
>' (
>( )5
)GetHealthRecordsForDoctorPatientViewAsync* S
(S T
int 
	patientId 
, 
int 
doctorId 
, 
PaginationQueryDto 

pagination %
)% &
;& '
Task 
< 	
PagedResultDto	 
< 
HealthRecordDto '
>' (
>( )7
+GetHealthRecordsByPatientIdAndDoctorIdAsync* U
(U V
int 
	patientId 
, 
int 
doctorId 
, 
PaginationQueryDto 

pagination %
)% &
;& '
Task 
< 	
HealthRecordDto	 
> $
GetHealthRecordByIdAsync 2
(2 3
int3 6
id7 9
)9 :
;: ;
Task 
< 	
HealthRecordDto	 
> #
CreateHealthRecordAsync 1
(1 2!
CreateHealthRecordDto2 G
dtoH K
,K L
intM P
doctorIdQ Y
)Y Z
;Z [
Task 
< 	
PagedResultDto	 
< 
HealthRecordDto '
>' (
>( )+
GetHealthRecordsByDoctorIdAsync* I
(I J
int 
doctorId 
, 
PaginationQueryDto 

pagination %
)% &
;& '
} µ
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IDoctorService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
;! "
public 
	interface 
IDoctorService 
{ 
Task		 
<		 	
PagedResultDto			 
<		 
PublicDoctorDto		 '
>		' (
>		( )
GetAllDoctorsAsync		* <
(		< = 
DoctorSearchQueryDto		= Q
query		R W
)		W X
;		X Y
Task 
< 	
PublicDoctorDto	 
? 
> 
GetDoctorByIdAsync -
(- .
int. 1
id2 4
)4 5
;5 6
Task 
< 	
	DoctorDto	 
? 
> %
GetDoctorProfileByIdAsync .
(. /
int/ 2
id3 5
)5 6
;6 7
Task 
< 	
PublicDoctorDto	 
? 
> "
GetDoctorByUserIdAsync 1
(1 2
string2 8
userId9 ?
)? @
;@ A
Task 
< 	!
DoctorAvailabilityDto	 
? 
>   
GetAvailabilityAsync! 5
(5 6
int6 9
id: <
)< =
;= >
Task 
< 	#
DoctorAvailableSlotsDto	  
>  !
GetDoctorSlotsAsync" 5
(5 6
int6 9
id: <
,< =
DateOnly> F
dateG K
)K L
;L M
Task 
< 	
PagedResultDto	 
< #
DoctorAvailableSlotsDto /
>/ 0
>0 1"
GetAvailableSlotsAsync2 H
(H I
DateOnly 
date 
,  
DoctorSpecialisation 
? 
specialisation ,
,, -
PaginationQueryDto 

pagination %
)% &
;& '
Task 
< 	!
DoctorAvailabilityDto	 
> #
UpdateAvailabilityAsync  7
(7 8
int 
id 
, '
UpdateDoctorAvailabilityDto #
dto$ '
,' (
string 
currentRole 
, 
int 
? 
currentDoctorId 
) 
; 
} ψ

OC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IAuthService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
;! "
public 
	interface 
IAuthService 
{ 
Task 
< 	
(	 

bool
 
Success 
, 
string 
Message &
,& '
string( .
UserId/ 5
)5 6
>6 7
RegisterAsync8 E
(E F
RegisterDtoF Q
requestR Y
)Y Z
;Z [
Task		 
<		 	
(			 

bool		
 
Success		 
,		 
string		 
Message		 &
,		& '
AuthResponseDto		( 7
?		7 8
Response		9 A
)		A B
>		B C

LoginAsync		D N
(		N O
LoginDto		O W
request		X _
)		_ `
;		` a
Task 
< 	
(	 

bool
 
Success 
, 
string 
Message &
,& '
AuthResponseDto( 7
?7 8
Response9 A
)A B
>B C,
 CreateAuthResponseForUserIdAsyncD d
(d e
stringe k
userIdl r
)r s
;s t
} ²
VC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IAppointmentService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
;! "
public 
	interface 
IAppointmentService $
{ 
Task		 
<		 	
PagedResultDto			 
<		 
AppointmentDto		 &
>		& '
>		' (#
GetAllAppointmentsAsync		) @
(		@ A
PaginationQueryDto		A S

pagination		T ^
)		^ _
;		_ `
Task 
< 	
AppointmentDto	 
> #
GetAppointmentByIdAsync 0
(0 1
int1 4
id5 7
)7 8
;8 9
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (+
GetAppointmentsByPatientIdAsync) H
(H I
intI L
	patientIdM V
,V W
AppointmentStatusX i
?i j
statusk q
,q r
PaginationQueryDto	s …

pagination
† 
)
 ‘
;
‘ ’
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (*
GetAppointmentsByDoctorIdAsync) G
(G H
intH K
doctorIdL T
,T U
AppointmentStatusV g
?g h
statusi o
,o p
PaginationQueryDto	q ƒ

pagination
„ 
)
 
;
 
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (1
%GetAppointmentsByDoctorIdAndDateAsync) N
(N O
intO R
doctorIdS [
,[ \
DateOnly] e
datef j
,j k
PaginationQueryDtol ~

pagination	 ‰
)
‰ 
;
 ‹
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (/
#GetAppointmentsByDateAndStatusAsync) L
(L M
DateOnly 
date 
, 
AppointmentStatus 
? 
status !
,! "
PaginationQueryDto 

pagination %
)% &
;& '
Task 
< 	
AppointmentDto	 
? 
> "
CreateAppointmentAsync 0
(0 1 
CreateAppointmentDto1 E
dtoF I
)I J
;J K
Task 
< 	
AppointmentDto	 
? 
> (
UpdateAppointmentStatusAsync 6
(6 7
int 
id 
, &
UpdateAppointmentStatusDto "
dto# &
,& '
string 
currentRole 
, 
int 
? 
currentPatientId 
, 
int 
? 
currentDoctorId 
) 
; 
Task!! 
<!! 	
List!!	 
<!!  
AppointmentReportDto!! "
>!!" #
>!!# $&
GetAppointmentReportsAsync!!% ?
(!!? @
)!!@ A
;!!A B
}"" ο
PC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IAdminService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
;! "
public

 
	interface

 
IAdminService

 
{ 
Task 
< 	$
AdminDashboardSummaryDto	 !
>! "$
GetDashboardSummaryAsync# ;
(; <
)< =
;= >
Task 
< 	
PagedResultDto	 
< 
	DoctorDto !
>! "
>" #
GetDoctorsAsync$ 3
(3 4
PaginationQueryDto 

pagination %
,% &
string 
? 
search 
= 
null 
,  
DoctorSpecialisation 
? 
specialisation ,
=- .
null/ 3
)3 4
;4 5
Task 
< 	
	DoctorDto	 
? 
> 
CreateDoctorAsync &
(& '
CreateDoctorDto' 6
dto7 :
): ;
;; <
Task 
< 	
	DoctorDto	 
? 
> 
UpdateDoctorAsync &
(& '
int' *
id+ -
,- .
UpdateDoctorDto/ >
dto? B
)B C
;C D
Task $
ResetDoctorPasswordAsync	 !
(! "
int" %
id& (
,( )!
AdminResetPasswordDto* ?
dto@ C
)C D
;D E
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (&
GetDoctorAppointmentsAsync) C
(C D
intD G
doctorIdH P
,P Q
AppointmentStatusR c
?c d
statuse k
,k l
PaginationQueryDtom 

pagination
€ 
)
 ‹
;
‹ 
Task 
< 	
PagedResultDto	 
< 

PatientDto "
>" #
># $
GetPatientsAsync% 5
(5 6
PaginationQueryDto6 H

paginationI S
,S T
stringU [
?[ \
search] c
)c d
;d e
Task 
< 	

PatientDto	 
? 
> 
UpdatePatientAsync (
(( )
int) ,
id- /
,/ 0
UpdatePatientDto1 A
dtoB E
)E F
;F G
Task %
ResetPatientPasswordAsync	 "
(" #
int# &
id' )
,) *!
AdminResetPasswordDto+ @
dtoA D
)D E
;E F
Task!! 
<!! 	
PagedResultDto!!	 
<!! 
AppointmentDto!! &
>!!& '
>!!' ('
GetPatientAppointmentsAsync!!) D
(!!D E
int!!E H
	patientId!!I R
,!!R S
AppointmentStatus!!T e
?!!e f
status!!g m
,!!m n
PaginationQueryDto	!!o 

pagination
!!‚ 
)
!! 
;
!! 
Task## 
<## 	
PagedResultDto##	 
<##  
AppointmentReportDto## ,
>##, -
>##- .&
GetAppointmentReportsAsync##/ I
(##I J
PaginationQueryDto##J \

pagination##] g
)##g h
;##h i
Task%% 
<%% 	
PagedResultDto%%	 
<%% 
AppointmentDto%% &
>%%& '
>%%' (,
 GetAppointmentReportDetailsAsync%%) I
(%%I J
DateOnly&& 
date&& 
,&& 
AppointmentStatus'' 
?'' 
status'' !
,''! "
PaginationQueryDto(( 

pagination(( %
)((% &
;((& '
})) Ο
WC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IAdminHandoffService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
;! "
public 
	interface  
IAdminHandoffService %
{ 
string 


CreateCode 
( 
string 
userId #
)# $
;$ %
string 

?
 
ConsumeCode 
( 
string 
code #
)# $
;$ %
} Θ	
RC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\PagedResult.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
;% &
public 
class 
PagedResult 
< 
T 
> 
{ 
public 

List 
< 
T 
> 
Items 
{ 
get 
; 
set  #
;# $
}% &
=' (
[) *
]* +
;+ ,
public 

int 

PageNumber 
{ 
get 
;  
set! $
;$ %
}& '
public		 

int		 
PageSize		 
{		 
get		 
;		 
set		 "
;		" #
}		$ %
public 

int 

TotalCount 
{ 
get 
;  
set! $
;$ %
}& '
public 

int 

TotalPages 
{ 
get 
;  
set! $
;$ %
}& '
} ν
RC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\IRepository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
;% &
public 
	interface 
IRepository 
< 
T 
> 
where  %
T& '
:( )
class* /
{ 
Task 
< 	
List	 
< 
T 
> 
> 
GetAllAsync 
( 
) 
;  
Task		 
<		 	
T			 

?		
 
>		 
GetByIdAsync		 
(		 
int		 
id		  
)		  !
;		! "
Task 
< 	
T	 

>
 
AddAsync 
( 
T 
entity 
) 
; 
Task 
< 	
T	 

?
 
> 
UpdateAsync 
( 
T 
entity !
)! "
;" #
} ®	
YC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\IPatientRepository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
;% &
public 
	interface 
IPatientRepository #
:$ %
IRepository& 1
<1 2
Patient2 9
>9 :
{ 
Task 
< 	
PagedResult	 
< 
Patient 
> 
> '
GetAllPatientsWithUserAsync :
(: ;
int 

pageNumber 
, 
int		 
pageSize		 
,		 
string

 
?

 
search

 
)

 
;

 
Task 
< 	
Patient	 
? 
> '
GetPatientByIdWithUserAsync .
(. /
int/ 2
id3 5
)5 6
;6 7
Task 
< 	
Patient	 
? 
> #
GetPatientByUserIdAsync *
(* +
string+ 1
userId2 8
)8 9
;9 :
} Ύ+
VC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\Impl\Repository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
.% &
Impl& *
;* +
public 
class 

Repository 
< 
T 
> 
: 
IRepository (
<( )
T) *
>* +
where, 1
T2 3
:4 5
class6 ;
{ 
	protected		 
readonly		 
HealthAxisDbContext		 *
_context		+ 3
;		3 4
	protected

 
readonly

 
DbSet

 
<

 
T

 
>

 
_dbSet

  &
;

& '
public 


Repository 
( 
HealthAxisDbContext )
context* 1
)1 2
{ 
_context 
= 
context 
; 
_dbSet 
= 
context 
. 
Set 
< 
T 
> 
(  
)  !
;! "
} 
public 

async 
Task 
< 
List 
< 
T 
> 
> 
GetAllAsync *
(* +
)+ ,
{ 
return 
await 
_dbSet 
. 
ToListAsync '
(' (
)( )
;) *
} 
public 

async 
Task 
< 
T 
? 
> 
GetByIdAsync &
(& '
int' *
id+ -
)- .
{ 
return 
await 
_dbSet 
. 
	FindAsync %
(% &
id& (
)( )
;) *
} 
public 

async 
Task 
< 
T 
> 
AddAsync !
(! "
T" #
entity$ *
)* +
{ 
await 
_dbSet 
. 
AddAsync 
( 
entity $
)$ %
;% &
await 
_context 
. 
SaveChangesAsync '
(' (
)( )
;) *
return   
entity   
;   
}!! 
public## 

async## 
Task## 
<## 
T## 
?## 
>## 
UpdateAsync## %
(##% &
T##& '
entity##( .
)##. /
{$$ 
var%% 
exists%% 
=%% 
await%% 
_dbSet%% !
.%%! "
	FindAsync%%" +
(%%+ ,
entity&& 
.&& 
GetType&& 
(&& 
)&& 
.&& 
GetProperty&& (
(&&( )
$str&&) -
)&&- .
?&&. /
.&&/ 0
GetValue&&0 8
(&&8 9
entity&&9 ?
)&&? @
)'' 	
;''	 

if)) 

()) 
exists)) 
==)) 
null)) 
))) 
return)) "
null))# '
;))' (
_dbSet++ 
.++ 
Update++ 
(++ 
entity++ 
)++ 
;++ 
await,, 
_context,, 
.,, 
SaveChangesAsync,, '
(,,' (
),,( )
;,,) *
return-- 
entity-- 
;-- 
}.. 
	protected00 
static00 
async00 
Task00 
<00  
PagedResult00  +
<00+ ,
TResult00, 3
>003 4
>004 5
ToPagedResultAsync006 H
<00H I
TResult00I P
>00P Q
(00Q R

IQueryable11 
<11 
TResult11 
>11 
query11 !
,11! "
int22 

pageNumber22 
,22 
int33 
pageSize33 
)33 
{44 
var55 

totalCount55 
=55 
await55 
query55 $
.55$ %

CountAsync55% /
(55/ 0
)550 1
;551 2
var77 
items77 
=77 
await77 
query77 
.88 
Skip88 
(88 
(88 

pageNumber88 
-88 
$num88  !
)88! "
*88# $
pageSize88% -
)88- .
.99 
Take99 
(99 
pageSize99 
)99 
.:: 
ToListAsync:: 
(:: 
):: 
;:: 
return<< 
new<< 
PagedResult<< 
<<< 
TResult<< &
><<& '
{== 	
Items>> 
=>> 
items>> 
,>> 

PageNumber?? 
=?? 

pageNumber?? #
,??# $
PageSize@@ 
=@@ 
pageSize@@ 
,@@  

TotalCountAA 
=AA 

totalCountAA #
,AA# $

TotalPagesBB 
=BB 
(BB 
intBB 
)BB 
MathBB "
.BB" #
CeilingBB# *
(BB* +

totalCountBB+ 5
/BB6 7
(BB8 9
doubleBB9 ?
)BB? @
pageSizeBB@ H
)BBH I
}CC 	
;CC	 

}DD 
}EE γ'
]C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\Impl\PatientRepository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
.% &
Impl& *
;* +
public 
class 
PatientRepository 
( 
HealthAxisDbContext 2
context3 :
): ;
:< =

Repository> H
<H I
PatientI P
>P Q
(Q R
contextR Y
)Y Z
,Z [
IPatientRepository\ n
{ 
public

 

async

 
Task

 
<

 
PagedResult

 !
<

! "
Patient

" )
>

) *
>

* +'
GetAllPatientsWithUserAsync

, G
(

G H
int 

pageNumber 
, 
int 
pageSize 
, 
string 
? 
search 
) 
{ 
var 
query 
= 
_context 
. 
Patients %
. 
Include 
( 
patient 
=> 
patient  '
.' (
User( ,
), -
. 
AsQueryable 
( 
) 
; 
if 

( 
! 
string 
. 
IsNullOrWhiteSpace &
(& '
search' -
)- .
). /
{ 	
var 

searchText 
= 
search #
.# $
Trim$ (
(( )
)) *
;* +
query 
= 
query 
. 
Where 
(  
patient  '
=>( *
patient 
. 
FullName  
.  !
Contains! )
() *

searchText* 4
)4 5
||6 8
( 
patient 
. 
User 
!=  
null! %
&&& (
patient) 0
.0 1
User1 5
.5 6
Email6 ;
!=< >
null? C
&&D F
patientG N
.N O
UserO S
.S T
EmailT Y
.Y Z
ContainsZ b
(b c

searchTextc m
)m n
)n o
||p r
( 
patient 
. 
User 
!=  
null! %
&&& (
patient) 0
.0 1
User1 5
.5 6
PhoneNumber6 A
!=B D
nullE I
&&J L
patientM T
.T U
UserU Y
.Y Z
PhoneNumberZ e
.e f
Containsf n
(n o

searchTexto y
)y z
)z {
){ |
;| }
} 	
query 
= 
query 
. 
OrderBy 
( 
patient 
=> 
patient  '
.' (
FullName( 0
)0 1
. 
ThenBy 
( 
patient 
=> 
patient &
.& '
Id' )
)) *
;* +
return!! 
await!! 
ToPagedResultAsync!! '
(!!' (
query!!( -
,!!- .

pageNumber!!/ 9
,!!9 :
pageSize!!; C
)!!C D
;!!D E
}"" 
public$$ 

async$$ 
Task$$ 
<$$ 
Patient$$ 
?$$ 
>$$ '
GetPatientByIdWithUserAsync$$  ;
($$; <
int$$< ?
id$$@ B
)$$B C
{%% 
return&& 
await&& 
_context&& 
.&& 
Patients&& &
.'' 
Include'' 
('' 
patient'' 
=>'' 
patient''  '
.''' (
User''( ,
)'', -
.(( 
FirstOrDefaultAsync((  
(((  !
patient((! (
=>(() +
patient((, 3
.((3 4
Id((4 6
==((7 9
id((: <
)((< =
;((= >
})) 
public++ 

async++ 
Task++ 
<++ 
Patient++ 
?++ 
>++ #
GetPatientByUserIdAsync++  7
(++7 8
string++8 >
userId++? E
)++E F
{,, 
return-- 
await-- 
_context-- 
.-- 
Patients-- &
... 
Include.. 
(.. 
patient.. 
=>.. 
patient..  '
...' (
User..( ,
).., -
.// 
FirstOrDefaultAsync//  
(//  !
patient//! (
=>//) +
patient//, 3
.//3 4
UserId//4 :
==//; =
userId//> D
)//D E
;//E F
}00 
}11 ƒ:
bC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\Impl\HealthRecordRepository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
.% &
Impl& *
;* +
public 
class "
HealthRecordRepository #
(# $
HealthAxisDbContext$ 7
context8 ?
)? @
:A B

RepositoryC M
<M N
HealthRecordN Z
>Z [
([ \
context\ c
)c d
,d e#
IHealthRecordRepositoryf }
{ 
public

 

async

 
Task

 
<

 
PagedResult

 !
<

! "
HealthRecord

" .
>

. /
>

/ 0,
 GetHealthRecordsByPatientIdAsync

1 Q
(

Q R
int 
	patientId 
, 
int 

pageNumber 
, 
int 
pageSize 
) 
{ 
var 
query 
= '
GetHealthRecordsWithDetails /
(/ 0
)0 1
. 
Where 
( 
record 
=> 
record #
.# $
Appointment$ /
!=0 2
null3 7
&&8 :
record; A
.A B
AppointmentB M
.M N
	PatientIdN W
==X Z
	patientId[ d
)d e
. 
OrderByDescending 
( 
record %
=>& (
record) /
./ 0
	VisitDate0 9
)9 :
. 
ThenByDescending 
( 
record $
=>% '
record( .
.. /
Id/ 1
)1 2
;2 3
return 
await 
ToPagedResultAsync '
(' (
query( -
,- .

pageNumber/ 9
,9 :
pageSize; C
)C D
;D E
} 
public 

async 
Task 
< 
PagedResult !
<! "
HealthRecord" .
>. /
>/ 07
+GetHealthRecordsByPatientIdAndDoctorIdAsync1 \
(\ ]
int 
	patientId 
, 
int 
doctorId 
, 
int 

pageNumber 
, 
int 
pageSize 
) 
{ 
var 
query 
= '
GetHealthRecordsWithDetails /
(/ 0
)0 1
. 
Where 
( 
record 
=> 
record 
. 
Appointment "
!=# %
null& *
&&+ -
record   
.   
Appointment   "
.  " #
	PatientId  # ,
==  - /
	patientId  0 9
&&  : <
record!! 
.!! 
Appointment!! "
.!!" #
DoctorId!!# +
==!!, .
doctorId!!/ 7
)!!7 8
."" 
OrderByDescending"" 
("" 
record"" %
=>""& (
record"") /
.""/ 0
	VisitDate""0 9
)""9 :
.## 
ThenByDescending## 
(## 
record## $
=>##% '
record##( .
.##. /
Id##/ 1
)##1 2
;##2 3
return%% 
await%% 
ToPagedResultAsync%% '
(%%' (
query%%( -
,%%- .

pageNumber%%/ 9
,%%9 :
pageSize%%; C
)%%C D
;%%D E
}&& 
public(( 

async(( 
Task(( 
<(( 
HealthRecord(( "
?((" #
>((# $/
#GetHealthRecordByIdWithDetailsAsync((% H
(((H I
int((I L
id((M O
)((O P
{)) 
return** 
await** '
GetHealthRecordsWithDetails** 0
(**0 1
)**1 2
.++ 
FirstOrDefaultAsync++  
(++  !
record++! '
=>++( *
record+++ 1
.++1 2
Id++2 4
==++5 7
id++8 :
)++: ;
;++; <
},, 
public.. 

async.. 
Task.. 
<.. 
HealthRecord.. "
?.." #
>..# $/
#GetHealthRecordByAppointmentIdAsync..% H
(..H I
int..I L
appointmentId..M Z
)..Z [
{// 
return00 
await00 '
GetHealthRecordsWithDetails00 0
(000 1
)001 2
.11 
FirstOrDefaultAsync11  
(11  !
record11! '
=>11( *
record11+ 1
.111 2
AppointmentId112 ?
==11@ B
appointmentId11C P
)11P Q
;11Q R
}22 
public44 

async44 
Task44 
<44 
PagedResult44 !
<44! "
HealthRecord44" .
>44. /
>44/ 0+
GetHealthRecordsByDoctorIdAsync441 P
(44P Q
int55 
doctorId55 
,55 
int66 

pageNumber66 
,66 
int77 
pageSize77 
)77 
{88 
var99 
query99 
=99 '
GetHealthRecordsWithDetails99 /
(99/ 0
)990 1
.:: 
Where:: 
(:: 
record:: 
=>:: 
record;; 
.;; 
Appointment;; "
!=;;# %
null;;& *
&&;;+ -
record<< 
.<< 
Appointment<< "
.<<" #
DoctorId<<# +
==<<, .
doctorId<</ 7
)<<7 8
.== 
OrderByDescending== 
(== 
record== %
=>==& (
record==) /
.==/ 0
	VisitDate==0 9
)==9 :
.>> 
ThenByDescending>> 
(>> 
record>> $
=>>>% '
record>>( .
.>>. /
Id>>/ 1
)>>1 2
;>>2 3
return@@ 
await@@ 
ToPagedResultAsync@@ '
(@@' (
query@@( -
,@@- .

pageNumber@@/ 9
,@@9 :
pageSize@@; C
)@@C D
;@@D E
}AA 
privateCC 

IQueryableCC 
<CC 
HealthRecordCC #
>CC# $'
GetHealthRecordsWithDetailsCC% @
(CC@ A
)CCA B
{DD 
returnEE 
_contextEE 
.EE 
HealthRecordsEE %
.FF 
IncludeFF 
(FF 
recordFF 
=>FF 
recordFF %
.FF% &
AppointmentFF& 1
)FF1 2
.GG 
ThenIncludeGG 
(GG 
appointmentGG (
=>GG) +
appointmentGG, 7
!GG7 8
.GG8 9
PatientGG9 @
)GG@ A
.HH 
IncludeHH 
(HH 
recordHH 
=>HH 
recordHH %
.HH% &
AppointmentHH& 1
)HH1 2
.II 
ThenIncludeII 
(II 
appointmentII (
=>II) +
appointmentII, 7
!II7 8
.II8 9
DoctorII9 ?
)II? @
;II@ A
}JJ 
}KK ·{
\C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\Impl\DoctorRepository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
.% &
Impl& *
;* +
public 
class 
DoctorRepository 
( 
HealthAxisDbContext 1
context2 9
)9 :
:; <

Repository= G
<G H
DoctorH N
>N O
(O P
contextP W
)W X
,X Y
IDoctorRepositoryZ k
{		 
public

 

async

 
Task

 
<

 
PagedResult

 !
<

! "
Doctor

" (
>

( )
>

) *
GetAllDoctorsAsync

+ =
(

= >
int 

pageNumber 
, 
int 
pageSize 
, 
string 

?
 
search 
= 
null 
,  
DoctorSpecialisation 
? 
specialisation (
=) *
null+ /
,/ 0
bool 
? 	
isAvailable
 
= 
null 
, 
DoctorSortBy 
sortBy 
= 
DoctorSortBy &
.& '
Name' +
,+ ,
SortDirection 
sortDirection 
=  !
SortDirection" /
./ 0
Asc0 3
)3 4
{ 
var 
query 
= 
_context 
. 
Doctors $
. 
AsNoTracking 
( 
) 
. 
AsQueryable 
( 
) 
; 
if 

( 
! 
string 
. 
IsNullOrWhiteSpace &
(& '
search' -
)- .
). /
{ 	
var 

searchText 
= 
search #
.# $
Trim$ (
(( )
)) *
;* +
query 
= 
query 
. 
Where 
(  
doctor  &
=>' )
doctor 
. 
FullName 
.  
Contains  (
(( )

searchText) 3
)3 4
)4 5
;5 6
} 	
if 

( 
specialisation 
. 
HasValue #
)# $
{   	
query!! 
=!! 
query!! 
.!! 
Where!! 
(!!  
doctor!!  &
=>!!' )
doctor!!* 0
.!!0 1
Specialisation!!1 ?
==!!@ B
specialisation!!C Q
.!!Q R
Value!!R W
)!!W X
;!!X Y
}"" 	
if$$ 

($$ 
isAvailable$$ 
.$$ 
HasValue$$  
)$$  !
{%% 	
query&& 
=&& 
query&& 
.&& 
Where&& 
(&&  
doctor&&  &
=>&&' )
doctor&&* 0
.&&0 1
IsAvailable&&1 <
==&&= ?
isAvailable&&@ K
.&&K L
Value&&L Q
)&&Q R
;&&R S
}'' 	
query)) 
=)) 
ApplySorting)) 
()) 
query)) "
,))" #
sortBy))$ *
,))* +
sortDirection)), 9
)))9 :
;)): ;
return++ 
await++ 
ToPagedResultAsync++ '
(++' (
query++( -
,++- .

pageNumber++/ 9
,++9 :
pageSize++; C
)++C D
;++D E
},, 
public.. 

async.. 
Task.. 
<.. 
List.. 
<.. 
Doctor.. !
>..! "
>.." #$
GetAvailableDoctorsAsync..$ <
(..< = 
DoctorSpecialisation..= Q
?..Q R
specialisation..S a
)..a b
{// 
var00 
query00 
=00 
_context00 
.00 
Doctors00 $
.11 
AsNoTracking11 
(11 
)11 
.22 
Where22 
(22 
doctor22 
=>22 
doctor22 #
.22# $
IsAvailable22$ /
)22/ 0
;220 1
if44 

(44 
specialisation44 
.44 
HasValue44 #
)44# $
{55 	
query66 
=66 
query66 
.66 
Where66 
(66  
doctor66  &
=>66' )
doctor66* 0
.660 1
Specialisation661 ?
==66@ B
specialisation66C Q
.66Q R
Value66R W
)66W X
;66X Y
}77 	
return99 
await99 
query99 
.:: 
OrderBy:: 
(:: 
doctor:: 
=>:: 
doctor:: %
.::% &
Id::& (
)::( )
.;; 
ToListAsync;; 
(;; 
);; 
;;; 
}<< 
public>> 

async>> 
Task>> 
<>> 
Doctor>> 
?>> 
>>> 
GetDoctorByIdAsync>> 1
(>>1 2
int>>2 5
id>>6 8
)>>8 9
{?? 
return@@ 
await@@ 
_context@@ 
.@@ 
Doctors@@ %
.AA 
FirstOrDefaultAsyncAA  
(AA  !
doctorAA! '
=>AA( *
doctorAA+ 1
.AA1 2
IdAA2 4
==AA5 7
idAA8 :
)AA: ;
;AA; <
}BB 
publicDD 

asyncDD 
TaskDD 
<DD 
PagedResultDD !
<DD! "
DoctorDD" (
>DD( )
>DD) *&
GetAllDoctorsWithUserAsyncDD+ E
(DDE F
intEE 

pageNumberEE 
,EE 
intFF 
pageSizeFF 
,FF 
stringGG 
?GG 
searchGG 
=GG 
nullGG 
,GG  
DoctorSpecialisationHH 
?HH 
specialisationHH ,
=HH- .
nullHH/ 3
)HH3 4
{II 
varJJ 
queryJJ 
=JJ 
_contextJJ 
.JJ 
DoctorsJJ $
.KK 
IncludeKK 
(KK 
doctorKK 
=>KK 
doctorKK %
.KK% &
UserKK& *
)KK* +
.LL 
AsQueryableLL 
(LL 
)LL 
;LL 
ifNN 

(NN 
specialisationNN 
.NN 
HasValueNN #
)NN# $
{OO 	
queryPP 
=PP 
queryPP 
.PP 
WherePP 
(PP  
doctorPP  &
=>PP' )
doctorPP* 0
.PP0 1
SpecialisationPP1 ?
==PP@ B
specialisationPPC Q
.PPQ R
ValuePPR W
)PPW X
;PPX Y
}QQ 	
ifSS 

(SS 
!SS 
stringSS 
.SS 
IsNullOrWhiteSpaceSS &
(SS& '
searchSS' -
)SS- .
)SS. /
{TT 	
varUU 

searchTextUU 
=UU 
searchUU #
.UU# $
TrimUU$ (
(UU( )
)UU) *
;UU* +
varVV !
specialisationMatchedVV %
=VV& '
EnumVV( ,
.VV, -
TryParseVV- 5
<VV5 6 
DoctorSpecialisationVV6 J
>VVJ K
(VVK L

searchTextWW 
,WW 

ignoreCaseXX 
:XX 
trueXX  
,XX  !
outYY 
varYY  
parsedSpecialisationYY ,
)YY, -
;YY- .
query[[ 
=[[ 
query[[ 
.[[ 
Where[[ 
([[  
doctor[[  &
=>[[' )
doctor\\ 
.\\ 
FullName\\ 
.\\  
Contains\\  (
(\\( )

searchText\\) 3
)\\3 4
||\\5 7
(]] 
doctor]] 
.]] 
User]] 
!=]] 
null]]  $
&&]]% '
doctor]]( .
.]]. /
User]]/ 3
.]]3 4
Email]]4 9
!=]]: <
null]]= A
&&]]B D
doctor]]E K
.]]K L
User]]L P
.]]P Q
Email]]Q V
.]]V W
Contains]]W _
(]]_ `

searchText]]` j
)]]j k
)]]k l
||]]m o
(^^ 
doctor^^ 
.^^ 
User^^ 
!=^^ 
null^^  $
&&^^% '
doctor^^( .
.^^. /
User^^/ 3
.^^3 4
PhoneNumber^^4 ?
!=^^@ B
null^^C G
&&^^H J
doctor^^K Q
.^^Q R
User^^R V
.^^V W
PhoneNumber^^W b
.^^b c
Contains^^c k
(^^k l

searchText^^l v
)^^v w
)^^w x
||^^y {
(__ !
specialisationMatched__ &
&&__' )
doctor__* 0
.__0 1
Specialisation__1 ?
==__@ B 
parsedSpecialisation__C W
)__W X
)__X Y
;__Y Z
}`` 	
querybb 
=bb 
querybb 
.cc 
OrderBycc 
(cc 
doctorcc 
=>cc 
doctorcc %
.cc% &
FullNamecc& .
)cc. /
.dd 
ThenBydd 
(dd 
doctordd 
=>dd 
doctordd $
.dd$ %
Iddd% '
)dd' (
;dd( )
returnff 
awaitff 
ToPagedResultAsyncff '
(ff' (
queryff( -
,ff- .

pageNumberff/ 9
,ff9 :
pageSizeff; C
)ffC D
;ffD E
}gg 
publicii 

asyncii 
Taskii 
<ii 
Doctorii 
?ii 
>ii &
GetDoctorByIdWithUserAsyncii 9
(ii9 :
intii: =
idii> @
)ii@ A
{jj 
returnkk 
awaitkk 
_contextkk 
.kk 
Doctorskk %
.ll 
Includell 
(ll 
doctorll 
=>ll 
doctorll %
.ll% &
Userll& *
)ll* +
.mm 
FirstOrDefaultAsyncmm  
(mm  !
doctormm! '
=>mm( *
doctormm+ 1
.mm1 2
Idmm2 4
==mm5 7
idmm8 :
)mm: ;
;mm; <
}nn 
publicpp 

asyncpp 
Taskpp 
<pp 
Doctorpp 
?pp 
>pp "
GetDoctorByUserIdAsyncpp 5
(pp5 6
stringpp6 <
userIdpp= C
)ppC D
{qq 
returnrr 
awaitrr 
_contextrr 
.rr 
Doctorsrr %
.ss 
Includess 
(ss 
doctorss 
=>ss 
doctorss %
.ss% &
Userss& *
)ss* +
.tt 
FirstOrDefaultAsynctt  
(tt  !
doctortt! '
=>tt( *
doctortt+ 1
.tt1 2
UserIdtt2 8
==tt9 ;
userIdtt< B
)ttB C
;ttC D
}uu 
publicww 

asyncww 
Taskww 
<ww 
boolww 
?ww 
>ww  
GetAvailabilityAsyncww 1
(ww1 2
intww2 5
idww6 8
)ww8 9
{xx 
returnyy 
awaityy 
_contextyy 
.yy 
Doctorsyy %
.zz 
Wherezz 
(zz 
doctorzz 
=>zz 
doctorzz #
.zz# $
Idzz$ &
==zz' )
idzz* ,
)zz, -
.{{ 
Select{{ 
({{ 
doctor{{ 
=>{{ 
({{ 
bool{{ #
?{{# $
){{$ %
doctor{{% +
.{{+ ,
IsAvailable{{, 7
){{7 8
.|| 
FirstOrDefaultAsync||  
(||  !
)||! "
;||" #
}}} 
private 
static 

IQueryable 
< 
Doctor $
>$ %
ApplySorting& 2
(2 3

IQueryable
€€ 
<
€€ 
Doctor
€€ 
>
€€ 
query
€€ 
,
€€ 
DoctorSortBy
 
sortBy
 
,
 
SortDirection
‚‚ 
sortDirection
‚‚ 
)
‚‚  
{
ƒƒ 
var
„„ 

descending
„„ 
=
„„ 
sortDirection
„„ &
==
„„' )
SortDirection
„„* 7
.
„„7 8
Desc
„„8 <
;
„„< =
return
†† 
sortBy
†† 
switch
†† 
{
‡‡ 	
DoctorSortBy
 
.
 
Fee
 
=>
 

descending
  *
?
‰‰ 
query
‰‰ 
.
‰‰ 
OrderByDescending
‰‰ )
(
‰‰) *
doctor
‰‰* 0
=>
‰‰1 3
doctor
‰‰4 :
.
‰‰: ;
ConsultationFee
‰‰; J
)
‰‰J K
.
‰‰K L
ThenBy
‰‰L R
(
‰‰R S
doctor
‰‰S Y
=>
‰‰Z \
doctor
‰‰] c
.
‰‰c d
FullName
‰‰d l
)
‰‰l m
:
 
query
 
.
 
OrderBy
 
(
  
doctor
  &
=>
' )
doctor
* 0
.
0 1
ConsultationFee
1 @
)
@ A
.
A B
ThenBy
B H
(
H I
doctor
I O
=>
P R
doctor
S Y
.
Y Z
FullName
Z b
)
b c
,
c d
DoctorSortBy
 
.
 

Experience
 #
=>
$ &

descending
' 1
?
 
query
 
.
 
OrderBy
 
(
  
doctor
  &
=>
' )
doctor
* 0
.
0 1
PracticeStartDate
1 B
)
B C
.
C D
ThenBy
D J
(
J K
doctor
K Q
=>
R T
doctor
U [
.
[ \
FullName
\ d
)
d e
:
 
query
 
.
 
OrderByDescending
 )
(
) *
doctor
* 0
=>
1 3
doctor
4 :
.
: ;
PracticeStartDate
; L
)
L M
.
M N
ThenBy
N T
(
T U
doctor
U [
=>
\ ^
doctor
_ e
.
e f
FullName
f n
)
n o
,
o p
_
 
=>
 

descending
 
?
‘‘ 
query
‘‘ 
.
‘‘ 
OrderByDescending
‘‘ )
(
‘‘) *
doctor
‘‘* 0
=>
‘‘1 3
doctor
‘‘4 :
.
‘‘: ;
FullName
‘‘; C
)
‘‘C D
.
‘‘D E
ThenBy
‘‘E K
(
‘‘K L
doctor
‘‘L R
=>
‘‘S U
doctor
‘‘V \
.
‘‘\ ]
Id
‘‘] _
)
‘‘_ `
:
’’ 
query
’’ 
.
’’ 
OrderBy
’’ 
(
’’  
doctor
’’  &
=>
’’' )
doctor
’’* 0
.
’’0 1
FullName
’’1 9
)
’’9 :
.
’’: ;
ThenBy
’’; A
(
’’A B
doctor
’’B H
=>
’’I K
doctor
’’L R
.
’’R S
Id
’’S U
)
’’U V
}
““ 	
;
““	 

}
”” 
}•• ¬Ύ
aC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\Impl\AppointmentRepository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
.% &
Impl& *
;* +
public		 
class		 !
AppointmentRepository		 "
(		" #
HealthAxisDbContext		# 6
context		7 >
)		> ?
:		@ A

Repository		B L
<		L M
Appointment		M X
>		X Y
(		Y Z
context		Z a
)		a b
,		b c"
IAppointmentRepository		d z
{

 
public 

async 
Task 
< 
PagedResult !
<! "
Appointment" -
>- .
>. /#
GetAllAppointmentsAsync0 G
(G H
intH K

pageNumberL V
,V W
intX [
pageSize\ d
)d e
{ 
var 
query 
= &
GetAppointmentsWithDetails .
(. /
)/ 0
. 
OrderBy 
( 
appointment  
=>! #
appointment$ /
./ 0
AppointmentDate0 ?
)? @
. 
ThenBy 
( 
appointment 
=>  "
appointment# .
.. /
AppointmentTime/ >
)> ?
. 
ThenBy 
( 
appointment 
=>  "
appointment# .
.. /
Id/ 1
)1 2
;2 3
return 
await 
ToPagedResultAsync '
(' (
query( -
,- .

pageNumber/ 9
,9 :
pageSize; C
)C D
;D E
} 
public 

async 
Task 
< 
Appointment !
?! "
>" #.
"GetAppointmentByIdWithDetailsAsync$ F
(F G
intG J
appointmentIdK X
)X Y
{ 
return 
await &
GetAppointmentsWithDetails /
(/ 0
)0 1
. 
FirstOrDefaultAsync  
(  !
appointment! ,
=>- /
appointment0 ;
.; <
Id< >
==? A
appointmentIdB O
)O P
;P Q
} 
public 

async 
Task 
< 
PagedResult !
<! "
Appointment" -
>- .
>. /+
GetAppointmentsByPatientIdAsync0 O
(O P
int 
	patientId 
, 
AppointmentStatus 
? 
status !
,! "
int 

pageNumber 
, 
int 
pageSize 
) 
{   
var!! 
query!! 
=!! &
GetAppointmentsWithDetails!! .
(!!. /
)!!/ 0
."" 
Where"" 
("" 
appointment"" 
=>"" !
appointment""" -
.""- .
	PatientId"". 7
==""8 :
	patientId""; D
)""D E
;""E F
if$$ 

($$ 
status$$ 
.$$ 
HasValue$$ 
)$$ 
{%% 	
query&& 
=&& 
query&& 
.&& 
Where&& 
(&&  
appointment&&  +
=>&&, .
appointment&&/ :
.&&: ;
Status&&; A
==&&B D
status&&E K
.&&K L
Value&&L Q
)&&Q R
;&&R S
}'' 	
query)) 
=)) 
query)) 
.** 
OrderBy** 
(** 
appointment**  
=>**! #
appointment**$ /
.**/ 0
AppointmentDate**0 ?
)**? @
.++ 
ThenBy++ 
(++ 
appointment++ 
=>++  "
appointment++# .
.++. /
AppointmentTime++/ >
)++> ?
.,, 
ThenBy,, 
(,, 
appointment,, 
=>,,  "
appointment,,# .
.,,. /
Id,,/ 1
),,1 2
;,,2 3
return.. 
await.. 
ToPagedResultAsync.. '
(..' (
query..( -
,..- .

pageNumber../ 9
,..9 :
pageSize..; C
)..C D
;..D E
}// 
public11 

async11 
Task11 
<11 
PagedResult11 !
<11! "
Appointment11" -
>11- .
>11. /*
GetAppointmentsByDoctorIdAsync110 N
(11N O
int22 
doctorId22 
,22 
AppointmentStatus33 
?33 
status33 !
,33! "
int44 

pageNumber44 
,44 
int55 
pageSize55 
)55 
{66 
var77 
query77 
=77 &
GetAppointmentsWithDetails77 .
(77. /
)77/ 0
.88 
Where88 
(88 
appointment88 
=>88 !
appointment88" -
.88- .
DoctorId88. 6
==887 9
doctorId88: B
)88B C
;88C D
if:: 

(:: 
status:: 
.:: 
HasValue:: 
):: 
{;; 	
query<< 
=<< 
query<< 
.<< 
Where<< 
(<<  
appointment<<  +
=><<, .
appointment<</ :
.<<: ;
Status<<; A
==<<B D
status<<E K
.<<K L
Value<<L Q
)<<Q R
;<<R S
}== 	
query?? 
=?? 
query?? 
.@@ 
OrderBy@@ 
(@@ 
appointment@@  
=>@@! #
appointment@@$ /
.@@/ 0
AppointmentDate@@0 ?
)@@? @
.AA 
ThenByAA 
(AA 
appointmentAA 
=>AA  "
appointmentAA# .
.AA. /
AppointmentTimeAA/ >
)AA> ?
.BB 
ThenByBB 
(BB 
appointmentBB 
=>BB  "
appointmentBB# .
.BB. /
IdBB/ 1
)BB1 2
;BB2 3
returnDD 
awaitDD 
ToPagedResultAsyncDD '
(DD' (
queryDD( -
,DD- .

pageNumberDD/ 9
,DD9 :
pageSizeDD; C
)DDC D
;DDD E
}EE 
publicGG 

asyncGG 
TaskGG 
<GG 
PagedResultGG !
<GG! "
AppointmentGG" -
>GG- .
>GG. /1
%GetAppointmentsByDoctorIdAndDateAsyncGG0 U
(GGU V
intHH 
doctorIdHH 
,HH 
DateOnlyII 
dateII 
,II 
intJJ 

pageNumberJJ 
,JJ 
intKK 
pageSizeKK 
)KK 
{LL 
varMM 
queryMM 
=MM &
GetAppointmentsWithDetailsMM .
(MM. /
)MM/ 0
.NN 
WhereNN 
(NN 
appointmentNN 
=>NN !
appointmentOO 
.OO 
DoctorIdOO $
==OO% '
doctorIdOO( 0
&&OO1 3
appointmentPP 
.PP 
AppointmentDatePP +
==PP, .
datePP/ 3
)PP3 4
.QQ 
OrderByQQ 
(QQ 
appointmentQQ  
=>QQ! #
appointmentQQ$ /
.QQ/ 0
AppointmentTimeQQ0 ?
)QQ? @
.RR 
ThenByRR 
(RR 
appointmentRR 
=>RR  "
appointmentRR# .
.RR. /
IdRR/ 1
)RR1 2
;RR2 3
returnTT 
awaitTT 
ToPagedResultAsyncTT '
(TT' (
queryTT( -
,TT- .

pageNumberTT/ 9
,TT9 :
pageSizeTT; C
)TTC D
;TTD E
}UU 
publicWW 

asyncWW 
TaskWW 
<WW 
PagedResultWW !
<WW! "
AppointmentWW" -
>WW- .
>WW. //
#GetAppointmentsByDateAndStatusAsyncWW0 S
(WWS T
DateOnlyXX 
dateXX 
,XX 
AppointmentStatusYY 
?YY 
statusYY !
,YY! "
intZZ 

pageNumberZZ 
,ZZ 
int[[ 
pageSize[[ 
)[[ 
{\\ 
var]] 
query]] 
=]] &
GetAppointmentsWithDetails]] .
(]]. /
)]]/ 0
.^^ 
Where^^ 
(^^ 
appointment^^ 
=>^^ !
appointment^^" -
.^^- .
AppointmentDate^^. =
==^^> @
date^^A E
)^^E F
;^^F G
if`` 

(`` 
status`` 
.`` 
HasValue`` 
)`` 
{aa 	
querybb 
=bb 
querybb 
.bb 
Wherebb 
(bb  
appointmentbb  +
=>bb, .
appointmentbb/ :
.bb: ;
Statusbb; A
==bbB D
statusbbE K
.bbK L
ValuebbL Q
)bbQ R
;bbR S
}cc 	
queryee 
=ee 
queryee 
.ff 
OrderByff 
(ff 
appointmentff  
=>ff! #
appointmentff$ /
.ff/ 0
AppointmentTimeff0 ?
)ff? @
.gg 
ThenBygg 
(gg 
appointmentgg 
=>gg  "
appointmentgg# .
.gg. /
Idgg/ 1
)gg1 2
;gg2 3
returnii 
awaitii 
ToPagedResultAsyncii '
(ii' (
queryii( -
,ii- .

pageNumberii/ 9
,ii9 :
pageSizeii; C
)iiC D
;iiD E
}jj 
publicll 

asyncll 
Taskll 
<ll 
Listll 
<ll 
Appointmentll &
>ll& '
>ll' (.
"GetExpiredPendingAppointmentsAsyncll) K
(llK L
DateTimellL T
cutoffDateTimellU c
)llc d
{mm 
varnn 

cutoffDatenn 
=nn 
DateOnlynn !
.nn! "
FromDateTimenn" .
(nn. /
cutoffDateTimenn/ =
)nn= >
;nn> ?
varoo 

cutoffTimeoo 
=oo 
TimeOnlyoo !
.oo! "
FromDateTimeoo" .
(oo. /
cutoffDateTimeoo/ =
)oo= >
;oo> ?
returnqq 
awaitqq 
_contextqq 
.qq 
Appointmentsqq *
.rr 
Whererr 
(rr 
appointmentrr 
=>rr !
appointmentss 
.ss 
Statusss "
==ss# %
AppointmentStatusss& 7
.ss7 8
Pendingss8 ?
&&ss@ B
(tt 
appointmenttt 
.tt 
AppointmentDatett ,
<tt- .

cutoffDatett/ 9
||tt: <
appointmentuu 
.uu 
AppointmentDateuu ,
==uu- /

cutoffDateuu0 :
&&uu; =
appointmentuu> I
.uuI J
AppointmentTimeuuJ Y
<=uuZ \

cutoffTimeuu] g
)uug h
)uuh i
.vv 
ToListAsyncvv 
(vv 
)vv 
;vv 
}ww 
publicyy 

asyncyy 
Taskyy 
<yy 
Listyy 
<yy  
AppointmentReportDtoyy /
>yy/ 0
>yy0 1&
GetAppointmentReportsAsyncyy2 L
(yyL M
)yyM N
{zz 
return{{ 
await{{ 
_context{{ 
.{{ 
Appointments{{ *
.|| 
GroupBy|| 
(|| 
appointment||  
=>||! #
appointment||$ /
.||/ 0
AppointmentDate||0 ?
)||? @
.}} 
Select}} 
(}} 
group}} 
=>}} 
new}}   
AppointmentReportDto}}! 5
{~~ 
Date 
= 
group 
. 
Key  
,  !
ConfirmedCount
€€ 
=
€€  
group
€€! &
.
€€& '
Count
€€' ,
(
€€, -
appointment
€€- 8
=>
€€9 ;
appointment
€€< G
.
€€G H
Status
€€H N
==
€€O Q
AppointmentStatus
€€R c
.
€€c d
	Confirmed
€€d m
)
€€m n
,
€€n o
CancelledCount
 
=
  
group
! &
.
& '
Count
' ,
(
, -
appointment
- 8
=>
9 ;
appointment
< G
.
G H
Status
H N
==
O Q
AppointmentStatus
R c
.
c d
	Cancelled
d m
)
m n
,
n o
CompletedCount
‚‚ 
=
‚‚  
group
‚‚! &
.
‚‚& '
Count
‚‚' ,
(
‚‚, -
appointment
‚‚- 8
=>
‚‚9 ;
appointment
‚‚< G
.
‚‚G H
Status
‚‚H N
==
‚‚O Q
AppointmentStatus
‚‚R c
.
‚‚c d
	Completed
‚‚d m
)
‚‚m n
,
‚‚n o
PendingCount
ƒƒ 
=
ƒƒ 
group
ƒƒ $
.
ƒƒ$ %
Count
ƒƒ% *
(
ƒƒ* +
appointment
ƒƒ+ 6
=>
ƒƒ7 9
appointment
ƒƒ: E
.
ƒƒE F
Status
ƒƒF L
==
ƒƒM O
AppointmentStatus
ƒƒP a
.
ƒƒa b
Pending
ƒƒb i
)
ƒƒi j
,
ƒƒj k

TotalCount
„„ 
=
„„ 
group
„„ "
.
„„" #
Count
„„# (
(
„„( )
)
„„) *
}
…… 
)
…… 
.
†† 
OrderByDescending
†† 
(
†† 
report
†† %
=>
††& (
report
††) /
.
††/ 0
Date
††0 4
)
††4 5
.
‡‡ 
ToListAsync
‡‡ 
(
‡‡ 
)
‡‡ 
;
‡‡ 
}
 
public
 

async
 
Task
 
<
 
bool
 
>
 5
'DoctorHasNonCancelledAppointmentAtAsync
 C
(
C D
int
D G
doctorId
H P
,
P Q
DateOnly
R Z
date
[ _
,
_ `
TimeOnly
a i
time
j n
)
n o
{
‹‹ 
return
 
await
 
_context
 
.
 
Appointments
 *
.
 
AnyAsync
 
(
 
appointment
 !
=>
" $
appointment
 
.
 
DoctorId
 $
==
% '
doctorId
( 0
&&
1 3
appointment
 
.
 
AppointmentDate
 +
==
, .
date
/ 3
&&
4 6
appointment
 
.
 
AppointmentTime
 +
==
, .
time
/ 3
&&
4 6
appointment
‘‘ 
.
‘‘ 
Status
‘‘ "
!=
‘‘# %
AppointmentStatus
‘‘& 7
.
‘‘7 8
	Cancelled
‘‘8 A
)
‘‘A B
;
‘‘B C
}
’’ 
public
”” 

async
”” 
Task
”” 
<
”” 
List
”” 
<
”” 
Appointment
”” &
>
””& '
>
””' (?
1GetNonCancelledAppointmentsByDoctorIdAndDateAsync
””) Z
(
””Z [
int
””[ ^
doctorId
””_ g
,
””g h
DateOnly
””i q
date
””r v
)
””v w
{
•• 
return
–– 
await
–– 
_context
–– 
.
–– 
Appointments
–– *
.
—— 
Where
—— 
(
—— 
appointment
—— 
=>
—— !
appointment
 
.
 
DoctorId
 $
==
% '
doctorId
( 0
&&
1 3
appointment
™™ 
.
™™ 
AppointmentDate
™™ +
==
™™, .
date
™™/ 3
&&
™™4 6
appointment
 
.
 
Status
 "
!=
# %
AppointmentStatus
& 7
.
7 8
	Cancelled
8 A
)
A B
.
›› 
ToListAsync
›› 
(
›› 
)
›› 
;
›› 
}
 
public
 

async
 
Task
 
<
 
List
 
<
 
Appointment
 &
>
& '
>
' (4
&GetNonCancelledAppointmentsByDateAsync
) O
(
O P
DateOnly
P X
date
Y ]
)
] ^
{
 
return
   
await
   
_context
   
.
   
Appointments
   *
.
΅΅ 
AsNoTracking
΅΅ 
(
΅΅ 
)
΅΅ 
.
ΆΆ 
Where
ΆΆ 
(
ΆΆ 
appointment
ΆΆ 
=>
ΆΆ !
appointment
££ 
.
££ 
AppointmentDate
££ +
==
££, .
date
££/ 3
&&
££4 6
appointment
¤¤ 
.
¤¤ 
Status
¤¤ "
!=
¤¤# %
AppointmentStatus
¤¤& 7
.
¤¤7 8
	Cancelled
¤¤8 A
)
¤¤A B
.
¥¥ 
ToListAsync
¥¥ 
(
¥¥ 
)
¥¥ 
;
¥¥ 
}
¦¦ 
public
¨¨ 

async
¨¨ 
Task
¨¨ 
<
¨¨ 
bool
¨¨ 
>
¨¨ 6
(PatientHasNonCancelledAppointmentAtAsync
¨¨ D
(
¨¨D E
int
¨¨E H
	patientId
¨¨I R
,
¨¨R S
DateOnly
¨¨T \
date
¨¨] a
,
¨¨a b
TimeOnly
¨¨c k
time
¨¨l p
)
¨¨p q
{
©© 
return
ªª 
await
ªª 
_context
ªª 
.
ªª 
Appointments
ªª *
.
«« 
AnyAsync
«« 
(
«« 
appointment
«« !
=>
««" $
appointment
¬¬ 
.
¬¬ 
	PatientId
¬¬ %
==
¬¬& (
	patientId
¬¬) 2
&&
¬¬3 5
appointment
­­ 
.
­­ 
AppointmentDate
­­ +
==
­­, .
date
­­/ 3
&&
­­4 6
appointment
®® 
.
®® 
AppointmentTime
®® +
==
®®, .
time
®®/ 3
&&
®®4 6
appointment
―― 
.
―― 
Status
―― "
!=
――# %
AppointmentStatus
――& 7
.
――7 8
	Cancelled
――8 A
)
――A B
;
――B C
}
°° 
public
²² 

async
²² 
Task
²² 
<
²² 
bool
²² 
>
²² D
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsync
²² R
(
²²R S
int
²²S V
	patientId
²²W `
,
²²` a
int
²²b e
doctorId
²²f n
,
²²n o
DateOnly
²²p x
date
²²y }
)
²²} ~
{
³³ 
return
΄΄ 
await
΄΄ 
_context
΄΄ 
.
΄΄ 
Appointments
΄΄ *
.
µµ 
AnyAsync
µµ 
(
µµ 
appointment
µµ !
=>
µµ" $
appointment
¶¶ 
.
¶¶ 
	PatientId
¶¶ %
==
¶¶& (
	patientId
¶¶) 2
&&
¶¶3 5
appointment
·· 
.
·· 
DoctorId
·· $
==
··% '
doctorId
··( 0
&&
··1 3
appointment
ΈΈ 
.
ΈΈ 
AppointmentDate
ΈΈ +
==
ΈΈ, .
date
ΈΈ/ 3
&&
ΈΈ4 6
appointment
ΉΉ 
.
ΉΉ 
Status
ΉΉ "
!=
ΉΉ# %
AppointmentStatus
ΉΉ& 7
.
ΉΉ7 8
	Cancelled
ΉΉ8 A
)
ΉΉA B
;
ΉΉB C
}
ΊΊ 
public
ΌΌ 

async
ΌΌ 
Task
ΌΌ 
<
ΌΌ 
bool
ΌΌ 
>
ΌΌ 7
)DoctorHasConfirmedAppointmentsOnDateAsync
ΌΌ E
(
ΌΌE F
int
ΌΌF I
doctorId
ΌΌJ R
,
ΌΌR S
DateOnly
ΌΌT \
date
ΌΌ] a
)
ΌΌa b
{
½½ 
return
ΎΎ 
await
ΎΎ 
_context
ΎΎ 
.
ΎΎ 
Appointments
ΎΎ *
.
ΏΏ 
AnyAsync
ΏΏ 
(
ΏΏ 
appointment
ΏΏ !
=>
ΏΏ" $
appointment
ΐΐ 
.
ΐΐ 
DoctorId
ΐΐ $
==
ΐΐ% '
doctorId
ΐΐ( 0
&&
ΐΐ1 3
appointment
ΑΑ 
.
ΑΑ 
AppointmentDate
ΑΑ +
==
ΑΑ, .
date
ΑΑ/ 3
&&
ΑΑ4 6
appointment
ΒΒ 
.
ΒΒ 
Status
ΒΒ "
==
ΒΒ# %
AppointmentStatus
ΒΒ& 7
.
ΒΒ7 8
	Confirmed
ΒΒ8 A
)
ΒΒA B
;
ΒΒB C
}
ΓΓ 
public
ΕΕ 

async
ΕΕ 
Task
ΕΕ 
<
ΕΕ 
List
ΕΕ 
<
ΕΕ 
Appointment
ΕΕ &
>
ΕΕ& '
>
ΕΕ' (E
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync
ΕΕ) `
(
ΕΕ` a
int
ΕΕa d
doctorId
ΕΕe m
,
ΕΕm n
DateOnly
ΕΕo w
date
ΕΕx |
)
ΕΕ| }
{
ΖΖ 
return
ΗΗ 
await
ΗΗ 
_context
ΗΗ 
.
ΗΗ 
Appointments
ΗΗ *
.
ΘΘ 
Where
ΘΘ 
(
ΘΘ 
appointment
ΘΘ 
=>
ΘΘ !
appointment
ΙΙ 
.
ΙΙ 
DoctorId
ΙΙ $
==
ΙΙ% '
doctorId
ΙΙ( 0
&&
ΙΙ1 3
appointment
ΚΚ 
.
ΚΚ 
AppointmentDate
ΚΚ +
==
ΚΚ, .
date
ΚΚ/ 3
&&
ΚΚ4 6
(
ΛΛ 
appointment
ΛΛ 
.
ΛΛ 
Status
ΛΛ #
==
ΛΛ$ &
AppointmentStatus
ΛΛ' 8
.
ΛΛ8 9
Pending
ΛΛ9 @
||
ΛΛA C
appointment
ΜΜ 
.
ΜΜ 
Status
ΜΜ #
==
ΜΜ$ &
AppointmentStatus
ΜΜ' 8
.
ΜΜ8 9
	Confirmed
ΜΜ9 B
)
ΜΜB C
)
ΜΜC D
.
ΝΝ 
ToListAsync
ΝΝ 
(
ΝΝ 
)
ΝΝ 
;
ΝΝ 
}
ΞΞ 
public
ΠΠ 

async
ΠΠ 
Task
ΠΠ 
<
ΠΠ 
bool
ΠΠ 
>
ΠΠ ;
-DoctorHasConfirmedAppointmentWithPatientAsync
ΠΠ I
(
ΠΠI J
int
ΠΠJ M
doctorId
ΠΠN V
,
ΠΠV W
int
ΠΠX [
	patientId
ΠΠ\ e
)
ΠΠe f
{
ΡΡ 
return
ÒÒ 
await
ÒÒ 
_context
ÒÒ 
.
ÒÒ 
Appointments
ÒÒ *
.
ΣΣ 
AnyAsync
ΣΣ 
(
ΣΣ 
appointment
ΣΣ !
=>
ΣΣ" $
appointment
ΤΤ 
.
ΤΤ 
DoctorId
ΤΤ $
==
ΤΤ% '
doctorId
ΤΤ( 0
&&
ΤΤ1 3
appointment
ΥΥ 
.
ΥΥ 
	PatientId
ΥΥ %
==
ΥΥ& (
	patientId
ΥΥ) 2
&&
ΥΥ3 5
appointment
ΦΦ 
.
ΦΦ 
Status
ΦΦ "
==
ΦΦ# %
AppointmentStatus
ΦΦ& 7
.
ΦΦ7 8
	Confirmed
ΦΦ8 A
)
ΦΦA B
;
ΦΦB C
}
ΧΧ 
private
ΩΩ 

IQueryable
ΩΩ 
<
ΩΩ 
Appointment
ΩΩ "
>
ΩΩ" #(
GetAppointmentsWithDetails
ΩΩ$ >
(
ΩΩ> ?
)
ΩΩ? @
{
ΪΪ 
return
ΫΫ 
_context
ΫΫ 
.
ΫΫ 
Appointments
ΫΫ $
.
άά 
Include
άά 
(
άά 
appointment
άά  
=>
άά! #
appointment
άά$ /
.
άά/ 0
Patient
άά0 7
)
άά7 8
.
έέ 
Include
έέ 
(
έέ 
appointment
έέ  
=>
έέ! #
appointment
έέ$ /
.
έέ/ 0
Doctor
έέ0 6
)
έέ6 7
.
ήή 
Include
ήή 
(
ήή 
appointment
ήή  
=>
ήή! #
appointment
ήή$ /
.
ήή/ 0
HealthRecord
ήή0 <
)
ήή< =
;
ήή= >
}
ίί 
}ΰΰ ύ
^C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\IHealthRecordRepository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
;% &
public 
	interface #
IHealthRecordRepository (
:) *
IRepository+ 6
<6 7
HealthRecord7 C
>C D
{ 
Task 
< 	
PagedResult	 
< 
HealthRecord !
>! "
>" #,
 GetHealthRecordsByPatientIdAsync$ D
(D E
intE H
	patientIdI R
,R S
intT W

pageNumberX b
,b c
intd g
pageSizeh p
)p q
;q r
Task		 
<		 	
PagedResult			 
<		 
HealthRecord		 !
>		! "
>		" #7
+GetHealthRecordsByPatientIdAndDoctorIdAsync		$ O
(		O P
int

 
	patientId

 
,

 
int 
doctorId 
, 
int 

pageNumber 
, 
int 
pageSize 
) 
; 
Task 
< 	
HealthRecord	 
? 
> /
#GetHealthRecordByIdWithDetailsAsync ;
(; <
int< ?
id@ B
)B C
;C D
Task 
< 	
HealthRecord	 
? 
> /
#GetHealthRecordByAppointmentIdAsync ;
(; <
int< ?
appointmentId@ M
)M N
;N O
Task 
< 	
PagedResult	 
< 
HealthRecord !
>! "
>" #+
GetHealthRecordsByDoctorIdAsync$ C
(C D
int 
doctorId 
, 
int 

pageNumber 
, 
int 
pageSize 
) 
; 
} δ
XC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\IDoctorRepository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
;% &
public 
	interface 
IDoctorRepository "
:# $
IRepository% 0
<0 1
Doctor1 7
>7 8
{ 
Task 
< 	
PagedResult	 
< 
Doctor 
> 
> 
GetAllDoctorsAsync 0
(0 1
int		 

pageNumber		 
,		 
int

 
pageSize

 
,

 
string 
? 
search 
= 
null 
,  
DoctorSpecialisation 
? 
specialisation ,
=- .
null/ 3
,3 4
bool 
? 
isAvailable 
= 
null  
,  !
DoctorSortBy 
sortBy 
= 
DoctorSortBy *
.* +
Name+ /
,/ 0
SortDirection 
sortDirection #
=$ %
SortDirection& 3
.3 4
Asc4 7
)7 8
;8 9
Task 
< 	
List	 
< 
Doctor 
> 
> $
GetAvailableDoctorsAsync /
(/ 0 
DoctorSpecialisation0 D
?D E
specialisationF T
)T U
;U V
Task 
< 	
Doctor	 
? 
> 
GetDoctorByIdAsync $
($ %
int% (
id) +
)+ ,
;, -
Task 
< 	
PagedResult	 
< 
Doctor 
> 
> &
GetAllDoctorsWithUserAsync 8
(8 9
int 

pageNumber 
, 
int 
pageSize 
, 
string 
? 
search 
= 
null 
,  
DoctorSpecialisation 
? 
specialisation ,
=- .
null/ 3
)3 4
;4 5
Task 
< 	
Doctor	 
? 
> &
GetDoctorByIdWithUserAsync ,
(, -
int- 0
id1 3
)3 4
;4 5
Task 
< 	
Doctor	 
? 
> "
GetDoctorByUserIdAsync (
(( )
string) /
userId0 6
)6 7
;7 8
Task 
< 	
bool	 
? 
>  
GetAvailabilityAsync $
($ %
int% (
id) +
)+ ,
;, -
}   β+
]C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\IAppointmentRepository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
;% &
public 
	interface "
IAppointmentRepository '
:( )
IRepository* 5
<5 6
Appointment6 A
>A B
{ 
Task		 
<		 	
PagedResult			 
<		 
Appointment		  
>		  !
>		! "#
GetAllAppointmentsAsync		# :
(		: ;
int		; >

pageNumber		? I
,		I J
int		K N
pageSize		O W
)		W X
;		X Y
Task 
< 	
Appointment	 
? 
> .
"GetAppointmentByIdWithDetailsAsync 9
(9 :
int: =
appointmentId> K
)K L
;L M
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "+
GetAppointmentsByPatientIdAsync# B
(B C
int 
	patientId 
, 
AppointmentStatus 
? 
status !
,! "
int 

pageNumber 
, 
int 
pageSize 
) 
; 
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "*
GetAppointmentsByDoctorIdAsync# A
(A B
int 
doctorId 
, 
AppointmentStatus 
? 
status !
,! "
int 

pageNumber 
, 
int 
pageSize 
) 
; 
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "1
%GetAppointmentsByDoctorIdAndDateAsync# H
(H I
int 
doctorId 
, 
DateOnly 
date 
, 
int 

pageNumber 
, 
int 
pageSize 
) 
; 
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "/
#GetAppointmentsByDateAndStatusAsync# F
(F G
DateOnly   
date   
,   
AppointmentStatus!! 
?!! 
status!! !
,!!! "
int"" 

pageNumber"" 
,"" 
int## 
pageSize## 
)## 
;## 
Task%% 
<%% 	
List%%	 
<%% 
Appointment%% 
>%% 
>%% .
"GetExpiredPendingAppointmentsAsync%% >
(%%> ?
DateTime%%? G
cutoffDateTime%%H V
)%%V W
;%%W X
Task'' 
<'' 	
List''	 
<''  
AppointmentReportDto'' "
>''" #
>''# $&
GetAppointmentReportsAsync''% ?
(''? @
)''@ A
;''A B
Task)) 
<)) 	
bool))	 
>)) 3
'DoctorHasNonCancelledAppointmentAtAsync)) 6
())6 7
int))7 :
doctorId)); C
,))C D
DateOnly))E M
date))N R
,))R S
TimeOnly))T \
time))] a
)))a b
;))b c
Task++ 
<++ 	
List++	 
<++ 
Appointment++ 
>++ 
>++ =
1GetNonCancelledAppointmentsByDoctorIdAndDateAsync++ M
(++M N
int++N Q
doctorId++R Z
,++Z [
DateOnly++\ d
date++e i
)++i j
;++j k
Task-- 
<-- 	
List--	 
<-- 
Appointment-- 
>-- 
>-- 2
&GetNonCancelledAppointmentsByDateAsync-- B
(--B C
DateOnly--C K
date--L P
)--P Q
;--Q R
Task// 
<// 	
bool//	 
>// 4
(PatientHasNonCancelledAppointmentAtAsync// 7
(//7 8
int//8 ;
	patientId//< E
,//E F
DateOnly//G O
date//P T
,//T U
TimeOnly//V ^
time//_ c
)//c d
;//d e
Task11 
<11 	
bool11	 
>11 B
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsync11 E
(11E F
int11F I
	patientId11J S
,11S T
int11U X
doctorId11Y a
,11a b
DateOnly11c k
date11l p
)11p q
;11q r
Task33 
<33 	
bool33	 
>33 5
)DoctorHasConfirmedAppointmentsOnDateAsync33 8
(338 9
int339 <
doctorId33= E
,33E F
DateOnly33G O
date33P T
)33T U
;33U V
Task55 
<55 	
List55	 
<55 
Appointment55 
>55 
>55 C
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync55 S
(55S T
int55T W
doctorId55X `
,55` a
DateOnly55b j
date55k o
)55o p
;55p q
Task77 
<77 	
bool77	 
>77 9
-DoctorHasConfirmedAppointmentWithPatientAsync77 <
(77< =
int77= @
doctorId77A I
,77I J
int77K N
	patientId77O X
)77X Y
;77Y Z
}88 ϋ•
AC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Program.cs
Log 
. 
Logger 

= 
new 
LoggerConfiguration $
($ %
)% &
. 
MinimumLevel 
. 
Information 
( 
) 
. 
Enrich 
. 
FromLogContext 
( 
) 
. 
WriteTo 
. 
Console 
( 
) 
. !
CreateBootstrapLogger 
( 
) 
; 
try 
{ 
var 
builder 
= 
WebApplication  
.  !
CreateBuilder! .
(. /
args/ 3
)3 4
;4 5
const 	
string
 %
HealthAxisAdminCorsPolicy *
=+ ,
$str- H
;H I
var 
appName 
= 
builder 
. 
Configuration '
[' (
$str( =
]= >
??? A
$strB R
;R S
builder!! 
.!! 
Services!! 
.!! 

AddSerilog!! 
(!!  
(!!  !
services!!! )
,!!) *
loggerConfiguration!!+ >
)!!> ?
=>!!@ B
loggerConfiguration!!C V
."" 	
ReadFrom""	 
."" 
Configuration"" 
(""  
builder""  '
.""' (
Configuration""( 5
)""5 6
.## 	
ReadFrom##	 
.## 
Services## 
(## 
services## #
)### $
.$$ 	
Enrich$$	 
.$$ 
FromLogContext$$ 
($$ 
)$$  
.%% 	
Enrich%%	 
.%% 
WithProperty%% 
(%% 
$str%% *
,%%* +
appName%%, 3
)%%3 4
)%%4 5
;%%5 6
builder'' 
.'' 
Services'' 
.'' 
AddCors'' 
('' 
options'' $
=>''% '
{(( 
options)) 
.)) 
	AddPolicy)) 
()) %
HealthAxisAdminCorsPolicy)) 3
,))3 4
policy))5 ;
=>))< >
{** 	
policy++ 
.,, 
WithOrigins,, 
(,, 
$str-- ,
,--, -
$str.. +
,..+ ,
$str// +
,//+ ,
$str00 ,
)00, -
.11 
AllowAnyHeader11 
(11  
)11  !
.22 
AllowAnyMethod22 
(22  
)22  !
;22! "
}33 	
)33	 

;33
 
}44 
)44 
;44 
builder66 
.66 
Services66 
.66 
AddControllers66 #
(66# $
)66$ %
.77 	
AddJsonOptions77	 
(77 
options77 
=>77  "
{88 	
options99 
.99 !
JsonSerializerOptions99 )
.99) * 
PropertyNamingPolicy99* >
=99? @
JsonNamingPolicy99A Q
.99Q R
	CamelCase99R [
;99[ \
}:: 	
)::	 

;::
 
builder<< 
.<< 
Services<< 
.<< #
AddEndpointsApiExplorer<< ,
(<<, -
)<<- .
;<<. /
builder>> 
.>> 
Services>> 
.>> 
AddSwaggerGen>> "
(>>" #
options>># *
=>>>+ -
{?? 
options@@ 
.@@ 

SwaggerDoc@@ 
(@@ 
$str@@ 
,@@  
new@@! $
OpenApiInfo@@% 0
{AA 	
TitleBB 
=BB 
$strBB $
,BB$ %
VersionCC 
=CC 
$strCC 
}DD 	
)DD	 

;DD
 
optionsFF 
.FF !
AddSecurityDefinitionFF %
(FF% &
$strFF& .
,FF. /
newFF0 3!
OpenApiSecuritySchemeFF4 I
{GG 	
TypeHH 
=HH 
SecuritySchemeTypeHH %
.HH% &
HttpHH& *
,HH* +
SchemeII 
=II 
$strII 
,II 
BearerFormatJJ 
=JJ 
$strJJ  
,JJ  !
DescriptionKK 
=KK 
$strKK M
}LL 	
)LL	 

;LL
 
optionsNN 
.NN "
AddSecurityRequirementNN &
(NN& '
documentNN' /
=>NN0 2
newNN3 6&
OpenApiSecurityRequirementNN7 Q
{OO 	
[PP 
newPP *
OpenApiSecuritySchemeReferencePP /
(PP/ 0
$strPP0 8
,PP8 9
documentPP: B
)PPB C
]PPC D
=PPE F
[PPG H
]PPH I
}QQ 	
)QQ	 

;QQ
 
}RR 
)RR 
;RR 
builderTT 
.TT 
ServicesTT 
.TT 
AddExceptionHandlerTT (
<TT( )"
GlobalExceptionHandlerTT) ?
>TT? @
(TT@ A
)TTA B
;TTB C
builderUU 
.UU 
ServicesUU 
.UU 
AddProblemDetailsUU &
(UU& '
)UU' (
;UU( )
builderWW 
.WW 
ServicesWW 
.WW 
AddDbContextWW !
<WW! "
HealthAxisDbContextWW" 5
>WW5 6
(WW6 7
optionsWW7 >
=>WW? A
optionsXX 
.XX 
UseSqlServerXX 
(XX 
builderXX $
.XX$ %
ConfigurationXX% 2
.XX2 3
GetConnectionStringXX3 F
(XXF G
$strXXG U
)XXU V
)XXV W
)XXW X
;XXX Y
builderZZ 
.ZZ 
ServicesZZ 
.ZZ 
AddIdentityZZ  
<ZZ  !
IdentityUserZZ! -
,ZZ- .
IdentityRoleZZ/ ;
>ZZ; <
(ZZ< =
optionsZZ= D
=>ZZE G
{[[ 
options\\ 
.\\ 
User\\ 
.\\ 
RequireUniqueEmail\\ '
=\\( )
true\\* .
;\\. /
options^^ 
.^^ 
Password^^ 
.^^ 
RequireDigit^^ %
=^^& '
true^^( ,
;^^, -
options__ 
.__ 
Password__ 
.__ 
RequireUppercase__ )
=__* +
true__, 0
;__0 1
options`` 
.`` 
Password`` 
.`` 
RequireLowercase`` )
=``* +
true``, 0
;``0 1
optionsaa 
.aa 
Passwordaa 
.aa "
RequireNonAlphanumericaa /
=aa0 1
trueaa2 6
;aa6 7
optionsbb 
.bb 
Passwordbb 
.bb 
RequiredLengthbb '
=bb( )
$numbb* +
;bb+ ,
}cc 
)cc 
.dd $
AddEntityFrameworkStoresdd 
<dd 
HealthAxisDbContextdd 1
>dd1 2
(dd2 3
)dd3 4
.ee $
AddDefaultTokenProvidersee 
(ee 
)ee 
;ee  
vargg 
jwtSettingsgg 
=gg 
buildergg 
.gg 
Configurationgg +
.gg+ ,

GetSectiongg, 6
(gg6 7
$strgg7 <
)gg< =
;gg= >
builderii 
.ii 
Servicesii 
.ii 
AddAuthenticationii &
(ii& '
optionsii' .
=>ii/ 1
{jj 
optionskk 
.kk %
DefaultAuthenticateSchemekk )
=kk* +
JwtBearerDefaultskk, =
.kk= > 
AuthenticationSchemekk> R
;kkR S
optionsll 
.ll "
DefaultChallengeSchemell &
=ll' (
JwtBearerDefaultsll) :
.ll: ; 
AuthenticationSchemell; O
;llO P
}mm 
)mm 
.nn 
AddJwtBearernn 
(nn 
optionsnn 
=>nn 
{oo 
optionspp 
.pp %
TokenValidationParameterspp )
=pp* +
newpp, /%
TokenValidationParameterspp0 I
{qq 	
ValidateIssuerrr 
=rr 
truerr !
,rr! "
ValidIssuerss 
=ss 
jwtSettingsss %
[ss% &
$strss& .
]ss. /
,ss/ 0
ValidateAudienceuu 
=uu 
trueuu #
,uu# $
ValidAudiencevv 
=vv 
jwtSettingsvv '
[vv' (
$strvv( 2
]vv2 3
,vv3 4
ValidateLifetimexx 
=xx 
truexx #
,xx# $$
ValidateIssuerSigningKeyzz $
=zz% &
truezz' +
,zz+ ,
IssuerSigningKey{{ 
={{ 
new{{ " 
SymmetricSecurityKey{{# 7
({{7 8
Encoding|| 
.|| 
UTF8|| 
.|| 
GetBytes|| &
(||& '
jwtSettings||' 2
[||2 3
$str||3 8
]||8 9
!||9 :
)||: ;
)}} 
,}} 
	ClockSkew 
= 
TimeSpan  
.  !
Zero! %
}
€€ 	
;
€€	 

}
 
)
 
;
 
builder
ƒƒ 
.
ƒƒ 
Services
ƒƒ 
.
ƒƒ 
AddAuthorization
ƒƒ %
(
ƒƒ% &
)
ƒƒ& '
;
ƒƒ' (
builder
…… 
.
…… 
Services
…… 
.
…… 
	AddScoped
…… 
<
…… 
IDoctorRepository
…… 0
,
……0 1
DoctorRepository
……2 B
>
……B C
(
……C D
)
……D E
;
……E F
builder
†† 
.
†† 
Services
†† 
.
†† 
	AddScoped
†† 
<
††  
IPatientRepository
†† 1
,
††1 2
PatientRepository
††3 D
>
††D E
(
††E F
)
††F G
;
††G H
builder
‡‡ 
.
‡‡ 
Services
‡‡ 
.
‡‡ 
	AddScoped
‡‡ 
<
‡‡ $
IAppointmentRepository
‡‡ 5
,
‡‡5 6#
AppointmentRepository
‡‡7 L
>
‡‡L M
(
‡‡M N
)
‡‡N O
;
‡‡O P
builder
 
.
 
Services
 
.
 
	AddScoped
 
<
 %
IHealthRecordRepository
 6
,
6 7$
HealthRecordRepository
8 N
>
N O
(
O P
)
P Q
;
Q R
builder
 
.
 
Services
 
.
 
	AddScoped
 
<
 
IAuthService
 +
,
+ ,
AuthService
- 8
>
8 9
(
9 :
)
: ;
;
; <
builder
‹‹ 
.
‹‹ 
Services
‹‹ 
.
‹‹ 
	AddScoped
‹‹ 
<
‹‹ 
IDoctorService
‹‹ -
,
‹‹- .
DoctorService
‹‹/ <
>
‹‹< =
(
‹‹= >
)
‹‹> ?
;
‹‹? @
builder
 
.
 
Services
 
.
 
	AddScoped
 
<
 
IPatientService
 .
,
. /
PatientService
0 >
>
> ?
(
? @
)
@ A
;
A B
builder
 
.
 
Services
 
.
 
	AddScoped
 
<
 !
IAppointmentService
 2
,
2 3 
AppointmentService
4 F
>
F G
(
G H
)
H I
;
I J
builder
 
.
 
Services
 
.
 
	AddScoped
 
<
 "
IHealthRecordService
 3
,
3 4!
HealthRecordService
5 H
>
H I
(
I J
)
J K
;
K L
builder
 
.
 
Services
 
.
 
	AddScoped
 
<
 
IAdminService
 ,
,
, -
AdminService
. :
>
: ;
(
; <
)
< =
;
= >
builder
 
.
 
Services
 
.
 
AddMemoryCache
 #
(
# $
)
$ %
;
% &
builder
‘‘ 
.
‘‘ 
Services
‘‘ 
.
‘‘ 
	AddScoped
‘‘ 
<
‘‘ "
IAdminHandoffService
‘‘ 3
,
‘‘3 4!
AdminHandoffService
‘‘5 H
>
‘‘H I
(
‘‘I J
)
‘‘J K
;
‘‘K L
builder
““ 
.
““ 
Services
““ 
.
““ 
AddAutoMapper
““ "
(
““" #
cfg
““# &
=>
““' )
{
”” 
cfg
•• 
.
•• 

AddProfile
•• 
<
•• 
MappingProfile
•• %
>
••% &
(
••& '
)
••' (
;
••( )
}
–– 
)
–– 
;
–– 
var
 
app
 
=
 
builder
 
.
 
Build
 
(
 
)
 
;
 
app
 
.
 !
UseExceptionHandler
 
(
 
)
 
;
 
app
 
.
 &
UseSerilogRequestLogging
  
(
  !
options
! (
=>
) +
{
 
options
 
.
 
MessageTemplate
 
=
  !
$str
" t
;
t u
options
   
.
   %
EnrichDiagnosticContext
   '
=
  ( )
(
  * +
diagnosticContext
  + <
,
  < =
httpContext
  > I
)
  I J
=>
  K M
{
΅΅ 	
diagnosticContext
ΆΆ 
.
ΆΆ 
Set
ΆΆ !
(
ΆΆ! "
$str
ΆΆ" /
,
ΆΆ/ 0
httpContext
ΆΆ1 <
.
ΆΆ< =
Request
ΆΆ= D
.
ΆΆD E
Host
ΆΆE I
.
ΆΆI J
Value
ΆΆJ O
??
ΆΆP R
string
ΆΆS Y
.
ΆΆY Z
Empty
ΆΆZ _
)
ΆΆ_ `
;
ΆΆ` a
diagnosticContext
££ 
.
££ 
Set
££ !
(
££! "
$str
££" 1
,
££1 2
httpContext
££3 >
.
££> ?
Request
££? F
.
££F G
Scheme
££G M
)
££M N
;
££N O
diagnosticContext
¤¤ 
.
¤¤ 
Set
¤¤ !
(
¤¤! "
$str
¤¤" ,
,
¤¤, -
httpContext
¤¤. 9
.
¤¤9 :
User
¤¤: >
.
¤¤> ?
Identity
¤¤? G
?
¤¤G H
.
¤¤H I
Name
¤¤I M
??
¤¤N P
$str
¤¤Q \
)
¤¤\ ]
;
¤¤] ^
}
¥¥ 	
;
¥¥	 

}
¦¦ 
)
¦¦ 
;
¦¦ 
using
¨¨ 	
(
¨¨
 
var
¨¨ 
scope
¨¨ 
=
¨¨ 
app
¨¨ 
.
¨¨ 
Services
¨¨ #
.
¨¨# $
CreateScope
¨¨$ /
(
¨¨/ 0
)
¨¨0 1
)
¨¨1 2
{
©© 
var
ªª 
roleManager
ªª 
=
ªª 
scope
ªª 
.
ªª  
ServiceProvider
ªª  /
.
ªª/ 0 
GetRequiredService
ªª0 B
<
ªªB C
RoleManager
ªªC N
<
ªªN O
IdentityRole
ªªO [
>
ªª[ \
>
ªª\ ]
(
ªª] ^
)
ªª^ _
;
ªª_ `
var
«« 
userManager
«« 
=
«« 
scope
«« 
.
««  
ServiceProvider
««  /
.
««/ 0 
GetRequiredService
««0 B
<
««B C
UserManager
««C N
<
««N O
IdentityUser
««O [
>
««[ \
>
««\ ]
(
««] ^
)
««^ _
;
««_ `
var
¬¬ 
context
¬¬ 
=
¬¬ 
scope
¬¬ 
.
¬¬ 
ServiceProvider
¬¬ +
.
¬¬+ , 
GetRequiredService
¬¬, >
<
¬¬> ?!
HealthAxisDbContext
¬¬? R
>
¬¬R S
(
¬¬S T
)
¬¬T U
;
¬¬U V
var
®® 
seedDemoData
®® 
=
®® 
builder
®® "
.
®®" #
Configuration
®®# 0
.
®®0 1
GetValue
®®1 9
<
®®9 :
bool
®®: >
>
®®> ?
(
®®? @
$str
®®@ W
)
®®W X
;
®®X Y
await
°°  
IdentityDataSeeder
°°  
.
°°  !
	SeedAsync
°°! *
(
°°* +
roleManager
±± 
,
±± 
userManager
²² 
,
²² 
context
³³ 
,
³³ 
seedDemoData
΄΄ 
)
΄΄ 
;
΄΄ 
}
µµ 
if
·· 
(
·· 
app
·· 
.
·· 
Environment
·· 
.
·· 
IsDevelopment
·· %
(
··% &
)
··& '
)
··' (
{
ΈΈ 
app
ΉΉ 
.
ΉΉ 

UseSwagger
ΉΉ 
(
ΉΉ 
)
ΉΉ 
;
ΉΉ 
app
ΊΊ 
.
ΊΊ 
UseSwaggerUI
ΊΊ 
(
ΊΊ 
)
ΊΊ 
;
ΊΊ 
}
»» 
if
ΎΎ 
(
ΎΎ 
!
ΎΎ 	
app
ΎΎ	 
.
ΎΎ 
Environment
ΎΎ 
.
ΎΎ 
IsDevelopment
ΎΎ &
(
ΎΎ& '
)
ΎΎ' (
)
ΎΎ( )
{
ΏΏ 
app
ΐΐ 
.
ΐΐ !
UseHttpsRedirection
ΐΐ 
(
ΐΐ  
)
ΐΐ  !
;
ΐΐ! "
}
ΑΑ 
app
ΔΔ 
.
ΔΔ 
UseCors
ΔΔ 
(
ΔΔ '
HealthAxisAdminCorsPolicy
ΔΔ )
)
ΔΔ) *
;
ΔΔ* +
app
ΖΖ 
.
ΖΖ 
UseAuthentication
ΖΖ 
(
ΖΖ 
)
ΖΖ 
;
ΖΖ 
app
ΗΗ 
.
ΗΗ 
UseAuthorization
ΗΗ 
(
ΗΗ 
)
ΗΗ 
;
ΗΗ 
app
ΙΙ 
.
ΙΙ 
MapControllers
ΙΙ 
(
ΙΙ 
)
ΙΙ 
;
ΙΙ 
Log
ΛΛ 
.
ΛΛ 
Information
ΛΛ 
(
ΛΛ 
$str
ΛΛ 0
,
ΛΛ0 1
appName
ΛΛ2 9
)
ΛΛ9 :
;
ΛΛ: ;
await
ΝΝ 	
app
ΝΝ
 
.
ΝΝ 
RunAsync
ΝΝ 
(
ΝΝ 
)
ΝΝ 
;
ΝΝ 
}ΞΞ 
catchΟΟ 
(
ΟΟ 
	Exception
ΟΟ 
	exception
ΟΟ 
)
ΟΟ 
{ΠΠ 
Log
ΡΡ 
.
ΡΡ 
Fatal
ΡΡ 
(
ΡΡ 
	exception
ΡΡ 
,
ΡΡ 
$str
ΡΡ B
)
ΡΡB C
;
ΡΡC D
}ÒÒ 
finallyΣΣ 
{ΤΤ 
await
ΥΥ 	
Log
ΥΥ
 
.
ΥΥ  
CloseAndFlushAsync
ΥΥ  
(
ΥΥ  !
)
ΥΥ! "
;
ΥΥ" #
}ΦΦ °
HC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Models\Patient.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Models 
;  
public 
class 
Patient 
{ 
[		 
Key		 
]		 	
public

 

int

 
Id

 
{

 
get

 
;

 
set

 
;

 
}

 
[ 
Required 
] 
public 

string 
UserId 
{ 
get 
; 
set  #
;# $
}% &
=' (
string) /
./ 0
Empty0 5
;5 6
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
FullName 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
[ 
Required 
] 
public 

DateOnly 
DateOfBirth 
{  !
get" %
;% &
set' *
;* +
}, -
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
Gender 
{ 
get 
; 
set  #
;# $
}% &
=' (
string) /
./ 0
Empty0 5
;5 6
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
Address 
{ 
get 
;  
set! $
;$ %
}& '
=( )
string* 0
.0 1
Empty1 6
;6 7
[ 

ForeignKey 
( 
nameof 
( 
UserId 
) 
) 
]  
public 

IdentityUser 
? 
User 
{ 
get  #
;# $
set% (
;( )
}* +
public!! 

ICollection!! 
<!! 
Appointment!! "
>!!" #
Appointments!!$ 0
{!!1 2
get!!3 6
;!!6 7
set!!8 ;
;!!; <
}!!= >
=!!? @
new!!A D
List!!E I
<!!I J
Appointment!!J U
>!!U V
(!!V W
)!!W X
;!!X Y
}"" ή
MC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Models\HealthRecord.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Models 
;  
public 
class 
HealthRecord 
{ 
[ 
Key 
] 	
public		 

int		 
Id		 
{		 
get		 
;		 
set		 
;		 
}		 
[ 
Required 
] 
public 

int 
AppointmentId 
{ 
get "
;" #
set$ '
;' (
}) *
[ 
Required 
] 
public 

int 

PatientAge 
{ 
get 
;  
set! $
;$ %
}& '
[ 
Required 
] 
public 

DateOnly 
	VisitDate 
{ 
get  #
;# $
set% (
;( )
}* +
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
	Diagnosis 
{ 
get !
;! "
set# &
;& '
}( )
=* +
string, 2
.2 3
Empty3 8
;8 9
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
Prescription 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
string/ 5
.5 6
Empty6 ;
;; <
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
? 
Notes 
{ 
get 
; 
set  #
;# $
}% &
[ 

ForeignKey 
( 
nameof 
( 
AppointmentId $
)$ %
)% &
]& '
public   

Appointment   
?   
Appointment   #
{  $ %
get  & )
;  ) *
set  + .
;  . /
}  0 1
}!! ›!
GC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Models\Doctor.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Models 
;  
public

 
class

 
Doctor

 
{ 
[ 
Key 
] 	
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
[ 
Required 
] 
public 

string 
UserId 
{ 
get 
; 
set  #
;# $
}% &
=' (
string) /
./ 0
Empty0 5
;5 6
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
FullName 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
[ 
Required 
] 
public 
 
DoctorSpecialisation 
Specialisation  .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
[ 
Required 
] 
[ 
PracticeStartDate 
( 
$num 
) 
] 
public 

DateOnly 
PracticeStartDate %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
[ 
	Precision 
( 
$num 
, 
$num 
) 
] 
[ 
Range 

(
 
$num 
, 
$num 
) 
] 
public 

decimal 
ConsultationFee "
{# $
get% (
;( )
set* -
;- .
}/ 0
public!! 

bool!! 
IsAvailable!! 
{!! 
get!! !
;!!! "
set!!# &
;!!& '
}!!( )
=!!* +
true!!, 0
;!!0 1
[## 

ForeignKey## 
(## 
nameof## 
(## 
UserId## 
)## 
)## 
]##  
public$$ 

IdentityUser$$ 
?$$ 
User$$ 
{$$ 
get$$  #
;$$# $
set$$% (
;$$( )
}$$* +
public&& 

ICollection&& 
<&& 
Appointment&& "
>&&" #
Appointments&&$ 0
{&&1 2
get&&3 6
;&&6 7
set&&8 ;
;&&; <
}&&= >
=&&? @
new&&A D
List&&E I
<&&I J
Appointment&&J U
>&&U V
(&&V W
)&&W X
;&&X Y
[(( 
	NotMapped(( 
](( 
public)) 

int)) 
YearsOfExperience))  
=>))! #&
CalculateYearsOfExperience))$ >
())> ?
)))? @
;))@ A
public++ 

int++ &
CalculateYearsOfExperience++ )
(++) *
)++* +
{,, 
var-- 
today-- 
=-- 
DateOnly-- 
.-- 
FromDateTime-- )
(--) *
DateTime--* 2
.--2 3
Today--3 8
)--8 9
;--9 :
var.. 
years.. 
=.. 
today.. 
... 
Year.. 
-..  
PracticeStartDate..! 2
...2 3
Year..3 7
;..7 8
if00 

(00 
today00 
<00 
PracticeStartDate00 %
.00% &
AddYears00& .
(00. /
years00/ 4
)004 5
)005 6
{11 	
years22 
--22 
;22 
}33 	
return55 
years55 
<55 
$num55 
?55 
$num55 
:55 
years55 $
;55$ %
}66 
}77 µ
LC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Models\Appointment.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Models 
;  
public 
class 
Appointment 
{ 
[		 
Key		 
]		 	
public

 

int

 
Id

 
{

 
get

 
;

 
set

 
;

 
}

 
[ 
Required 
] 
public 

int 
	PatientId 
{ 
get 
; 
set  #
;# $
}% &
[ 
Required 
] 
public 

int 
DoctorId 
{ 
get 
; 
set "
;" #
}$ %
[ 
Required 
] 
public 

DateOnly 
AppointmentDate #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 
Required 
] 
public 

TimeOnly 
AppointmentTime #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

AppointmentStatus 
Status #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
AppointmentStatus4 E
.E F
PendingF M
;M N
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
? 
CancellationReason %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
[ 

ForeignKey 
( 
nameof 
( 
	PatientId  
)  !
)! "
]" #
public   

Patient   
?   
Patient   
{   
get   !
;  ! "
set  # &
;  & '
}  ( )
["" 

ForeignKey"" 
("" 
nameof"" 
("" 
DoctorId"" 
)""  
)""  !
]""! "
public## 

Doctor## 
?## 
Doctor## 
{## 
get## 
;##  
set##! $
;##$ %
}##& '
public%% 

HealthRecord%% 
?%% 
HealthRecord%% %
{%%& '
get%%( +
;%%+ ,
set%%- 0
;%%0 1
}%%2 3
}&& “
tC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Migrations\20260702113831_Added_PatientAge_toHealthRecords.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Migrations #
{ 
public 

partial 
class ,
 Added_PatientAge_toHealthRecords 9
:: ;
	Migration< E
{		 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
	AddColumn &
<& '
int' *
>* +
(+ ,
name 
: 
$str "
," #
table 
: 
$str &
,& '
type 
: 
$str 
, 
nullable 
: 
false 
,  
defaultValue 
: 
$num 
)  
;  !
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str "
," #
table 
: 
$str &
)& '
;' (
} 	
} 
} 
`C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Migrations\20260618045538_Improvements.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Migrations #
{ 
public 

partial 
class 
Improvements %
:& '
	Migration( 1
{		 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
} 	
} 
} ”Ϊ
qC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Migrations\20260617112732_Initial Migration but like fr.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Migrations #
{ 
public		 

partial		 
class		 %
InitialMigrationbutlikefr		 2
:		3 4
	Migration		5 >
{

 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str #
,# $
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
string& ,
>, -
(- .
type. 2
:2 3
$str4 C
,C D
nullableE M
:M N
falseO T
)T U
,U V
Name 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 E
,E F
	maxLengthG P
:P Q
$numR U
,U V
nullableW _
:_ `
truea e
)e f
,f g
NormalizedName "
=# $
table% *
.* +
Column+ 1
<1 2
string2 8
>8 9
(9 :
type: >
:> ?
$str@ O
,O P
	maxLengthQ Z
:Z [
$num\ _
,_ `
nullablea i
:i j
truek o
)o p
,p q
ConcurrencyStamp $
=% &
table' ,
., -
Column- 3
<3 4
string4 :
>: ;
(; <
type< @
:@ A
$strB Q
,Q R
nullableS [
:[ \
true] a
)a b
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 5
,5 6
x7 8
=>9 ;
x< =
.= >
Id> @
)@ A
;A B
} 
) 
; 
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str #
,# $
columns 
: 
table 
=> !
new" %
{ 
Id   
=   
table   
.   
Column   %
<  % &
string  & ,
>  , -
(  - .
type  . 2
:  2 3
$str  4 C
,  C D
nullable  E M
:  M N
false  O T
)  T U
,  U V
UserName!! 
=!! 
table!! $
.!!$ %
Column!!% +
<!!+ ,
string!!, 2
>!!2 3
(!!3 4
type!!4 8
:!!8 9
$str!!: I
,!!I J
	maxLength!!K T
:!!T U
$num!!V Y
,!!Y Z
nullable!![ c
:!!c d
true!!e i
)!!i j
,!!j k
NormalizedUserName"" &
=""' (
table"") .
."". /
Column""/ 5
<""5 6
string""6 <
>""< =
(""= >
type""> B
:""B C
$str""D S
,""S T
	maxLength""U ^
:""^ _
$num""` c
,""c d
nullable""e m
:""m n
true""o s
)""s t
,""t u
Email## 
=## 
table## !
.##! "
Column##" (
<##( )
string##) /
>##/ 0
(##0 1
type##1 5
:##5 6
$str##7 F
,##F G
	maxLength##H Q
:##Q R
$num##S V
,##V W
nullable##X `
:##` a
true##b f
)##f g
,##g h
NormalizedEmail$$ #
=$$$ %
table$$& +
.$$+ ,
Column$$, 2
<$$2 3
string$$3 9
>$$9 :
($$: ;
type$$; ?
:$$? @
$str$$A P
,$$P Q
	maxLength$$R [
:$$[ \
$num$$] `
,$$` a
nullable$$b j
:$$j k
true$$l p
)$$p q
,$$q r
EmailConfirmed%% "
=%%# $
table%%% *
.%%* +
Column%%+ 1
<%%1 2
bool%%2 6
>%%6 7
(%%7 8
type%%8 <
:%%< =
$str%%> C
,%%C D
nullable%%E M
:%%M N
false%%O T
)%%T U
,%%U V
PasswordHash&&  
=&&! "
table&&# (
.&&( )
Column&&) /
<&&/ 0
string&&0 6
>&&6 7
(&&7 8
type&&8 <
:&&< =
$str&&> M
,&&M N
nullable&&O W
:&&W X
true&&Y ]
)&&] ^
,&&^ _
SecurityStamp'' !
=''" #
table''$ )
.'') *
Column''* 0
<''0 1
string''1 7
>''7 8
(''8 9
type''9 =
:''= >
$str''? N
,''N O
nullable''P X
:''X Y
true''Z ^
)''^ _
,''_ `
ConcurrencyStamp(( $
=((% &
table((' ,
.((, -
Column((- 3
<((3 4
string((4 :
>((: ;
(((; <
type((< @
:((@ A
$str((B Q
,((Q R
nullable((S [
:(([ \
true((] a
)((a b
,((b c
PhoneNumber)) 
=))  !
table))" '
.))' (
Column))( .
<)). /
string))/ 5
>))5 6
())6 7
type))7 ;
:)); <
$str))= L
,))L M
nullable))N V
:))V W
true))X \
)))\ ]
,))] ^ 
PhoneNumberConfirmed** (
=**) *
table**+ 0
.**0 1
Column**1 7
<**7 8
bool**8 <
>**< =
(**= >
type**> B
:**B C
$str**D I
,**I J
nullable**K S
:**S T
false**U Z
)**Z [
,**[ \
TwoFactorEnabled++ $
=++% &
table++' ,
.++, -
Column++- 3
<++3 4
bool++4 8
>++8 9
(++9 :
type++: >
:++> ?
$str++@ E
,++E F
nullable++G O
:++O P
false++Q V
)++V W
,++W X

LockoutEnd,, 
=,,  
table,,! &
.,,& '
Column,,' -
<,,- .
DateTimeOffset,,. <
>,,< =
(,,= >
type,,> B
:,,B C
$str,,D T
,,,T U
nullable,,V ^
:,,^ _
true,,` d
),,d e
,,,e f
LockoutEnabled-- "
=--# $
table--% *
.--* +
Column--+ 1
<--1 2
bool--2 6
>--6 7
(--7 8
type--8 <
:--< =
$str--> C
,--C D
nullable--E M
:--M N
false--O T
)--T U
,--U V
AccessFailedCount.. %
=..& '
table..( -
...- .
Column... 4
<..4 5
int..5 8
>..8 9
(..9 :
type..: >
:..> ?
$str..@ E
,..E F
nullable..G O
:..O P
false..Q V
)..V W
}// 
,// 
constraints00 
:00 
table00 "
=>00# %
{11 
table22 
.22 

PrimaryKey22 $
(22$ %
$str22% 5
,225 6
x227 8
=>229 ;
x22< =
.22= >
Id22> @
)22@ A
;22A B
}33 
)33 
;33 
migrationBuilder55 
.55 
CreateTable55 (
(55( )
name66 
:66 
$str66 (
,66( )
columns77 
:77 
table77 
=>77 !
new77" %
{88 
Id99 
=99 
table99 
.99 
Column99 %
<99% &
int99& )
>99) *
(99* +
type99+ /
:99/ 0
$str991 6
,996 7
nullable998 @
:99@ A
false99B G
)99G H
.:: 

Annotation:: #
(::# $
$str::$ 8
,::8 9
$str::: @
)::@ A
,::A B
RoleId;; 
=;; 
table;; "
.;;" #
Column;;# )
<;;) *
string;;* 0
>;;0 1
(;;1 2
type;;2 6
:;;6 7
$str;;8 G
,;;G H
nullable;;I Q
:;;Q R
false;;S X
);;X Y
,;;Y Z
	ClaimType<< 
=<< 
table<<  %
.<<% &
Column<<& ,
<<<, -
string<<- 3
><<3 4
(<<4 5
type<<5 9
:<<9 :
$str<<; J
,<<J K
nullable<<L T
:<<T U
true<<V Z
)<<Z [
,<<[ \

ClaimValue== 
===  
table==! &
.==& '
Column==' -
<==- .
string==. 4
>==4 5
(==5 6
type==6 :
:==: ;
$str==< K
,==K L
nullable==M U
:==U V
true==W [
)==[ \
}>> 
,>> 
constraints?? 
:?? 
table?? "
=>??# %
{@@ 
tableAA 
.AA 

PrimaryKeyAA $
(AA$ %
$strAA% :
,AA: ;
xAA< =
=>AA> @
xAAA B
.AAB C
IdAAC E
)AAE F
;AAF G
tableBB 
.BB 

ForeignKeyBB $
(BB$ %
nameCC 
:CC 
$strCC F
,CCF G
columnDD 
:DD 
xDD  !
=>DD" $
xDD% &
.DD& '
RoleIdDD' -
,DD- .
principalTableEE &
:EE& '
$strEE( 5
,EE5 6
principalColumnFF '
:FF' (
$strFF) -
,FF- .
onDeleteGG  
:GG  !
ReferentialActionGG" 3
.GG3 4
CascadeGG4 ;
)GG; <
;GG< =
}HH 
)HH 
;HH 
migrationBuilderJJ 
.JJ 
CreateTableJJ (
(JJ( )
nameKK 
:KK 
$strKK (
,KK( )
columnsLL 
:LL 
tableLL 
=>LL !
newLL" %
{MM 
IdNN 
=NN 
tableNN 
.NN 
ColumnNN %
<NN% &
intNN& )
>NN) *
(NN* +
typeNN+ /
:NN/ 0
$strNN1 6
,NN6 7
nullableNN8 @
:NN@ A
falseNNB G
)NNG H
.OO 

AnnotationOO #
(OO# $
$strOO$ 8
,OO8 9
$strOO: @
)OO@ A
,OOA B
UserIdPP 
=PP 
tablePP "
.PP" #
ColumnPP# )
<PP) *
stringPP* 0
>PP0 1
(PP1 2
typePP2 6
:PP6 7
$strPP8 G
,PPG H
nullablePPI Q
:PPQ R
falsePPS X
)PPX Y
,PPY Z
	ClaimTypeQQ 
=QQ 
tableQQ  %
.QQ% &
ColumnQQ& ,
<QQ, -
stringQQ- 3
>QQ3 4
(QQ4 5
typeQQ5 9
:QQ9 :
$strQQ; J
,QQJ K
nullableQQL T
:QQT U
trueQQV Z
)QQZ [
,QQ[ \

ClaimValueRR 
=RR  
tableRR! &
.RR& '
ColumnRR' -
<RR- .
stringRR. 4
>RR4 5
(RR5 6
typeRR6 :
:RR: ;
$strRR< K
,RRK L
nullableRRM U
:RRU V
trueRRW [
)RR[ \
}SS 
,SS 
constraintsTT 
:TT 
tableTT "
=>TT# %
{UU 
tableVV 
.VV 

PrimaryKeyVV $
(VV$ %
$strVV% :
,VV: ;
xVV< =
=>VV> @
xVVA B
.VVB C
IdVVC E
)VVE F
;VVF G
tableWW 
.WW 

ForeignKeyWW $
(WW$ %
nameXX 
:XX 
$strXX F
,XXF G
columnYY 
:YY 
xYY  !
=>YY" $
xYY% &
.YY& '
UserIdYY' -
,YY- .
principalTableZZ &
:ZZ& '
$strZZ( 5
,ZZ5 6
principalColumn[[ '
:[[' (
$str[[) -
,[[- .
onDelete\\  
:\\  !
ReferentialAction\\" 3
.\\3 4
Cascade\\4 ;
)\\; <
;\\< =
}]] 
)]] 
;]] 
migrationBuilder__ 
.__ 
CreateTable__ (
(__( )
name`` 
:`` 
$str`` (
,``( )
columnsaa 
:aa 
tableaa 
=>aa !
newaa" %
{bb 
LoginProvidercc !
=cc" #
tablecc$ )
.cc) *
Columncc* 0
<cc0 1
stringcc1 7
>cc7 8
(cc8 9
typecc9 =
:cc= >
$strcc? N
,ccN O
nullableccP X
:ccX Y
falseccZ _
)cc_ `
,cc` a
ProviderKeydd 
=dd  !
tabledd" '
.dd' (
Columndd( .
<dd. /
stringdd/ 5
>dd5 6
(dd6 7
typedd7 ;
:dd; <
$strdd= L
,ddL M
nullableddN V
:ddV W
falseddX ]
)dd] ^
,dd^ _
ProviderDisplayNameee '
=ee( )
tableee* /
.ee/ 0
Columnee0 6
<ee6 7
stringee7 =
>ee= >
(ee> ?
typeee? C
:eeC D
$streeE T
,eeT U
nullableeeV ^
:ee^ _
trueee` d
)eed e
,eee f
UserIdff 
=ff 
tableff "
.ff" #
Columnff# )
<ff) *
stringff* 0
>ff0 1
(ff1 2
typeff2 6
:ff6 7
$strff8 G
,ffG H
nullableffI Q
:ffQ R
falseffS X
)ffX Y
}gg 
,gg 
constraintshh 
:hh 
tablehh "
=>hh# %
{ii 
tablejj 
.jj 

PrimaryKeyjj $
(jj$ %
$strjj% :
,jj: ;
xjj< =
=>jj> @
newjjA D
{jjE F
xjjG H
.jjH I
LoginProviderjjI V
,jjV W
xjjX Y
.jjY Z
ProviderKeyjjZ e
}jjf g
)jjg h
;jjh i
tablekk 
.kk 

ForeignKeykk $
(kk$ %
namell 
:ll 
$strll F
,llF G
columnmm 
:mm 
xmm  !
=>mm" $
xmm% &
.mm& '
UserIdmm' -
,mm- .
principalTablenn &
:nn& '
$strnn( 5
,nn5 6
principalColumnoo '
:oo' (
$stroo) -
,oo- .
onDeletepp  
:pp  !
ReferentialActionpp" 3
.pp3 4
Cascadepp4 ;
)pp; <
;pp< =
}qq 
)qq 
;qq 
migrationBuilderss 
.ss 
CreateTabless (
(ss( )
namett 
:tt 
$strtt '
,tt' (
columnsuu 
:uu 
tableuu 
=>uu !
newuu" %
{vv 
UserIdww 
=ww 
tableww "
.ww" #
Columnww# )
<ww) *
stringww* 0
>ww0 1
(ww1 2
typeww2 6
:ww6 7
$strww8 G
,wwG H
nullablewwI Q
:wwQ R
falsewwS X
)wwX Y
,wwY Z
RoleIdxx 
=xx 
tablexx "
.xx" #
Columnxx# )
<xx) *
stringxx* 0
>xx0 1
(xx1 2
typexx2 6
:xx6 7
$strxx8 G
,xxG H
nullablexxI Q
:xxQ R
falsexxS X
)xxX Y
}yy 
,yy 
constraintszz 
:zz 
tablezz "
=>zz# %
{{{ 
table|| 
.|| 

PrimaryKey|| $
(||$ %
$str||% 9
,||9 :
x||; <
=>||= ?
new||@ C
{||D E
x||F G
.||G H
UserId||H N
,||N O
x||P Q
.||Q R
RoleId||R X
}||Y Z
)||Z [
;||[ \
table}} 
.}} 

ForeignKey}} $
(}}$ %
name~~ 
:~~ 
$str~~ E
,~~E F
column 
: 
x  !
=>" $
x% &
.& '
RoleId' -
,- .
principalTable
€€ &
:
€€& '
$str
€€( 5
,
€€5 6
principalColumn
 '
:
' (
$str
) -
,
- .
onDelete
‚‚  
:
‚‚  !
ReferentialAction
‚‚" 3
.
‚‚3 4
Cascade
‚‚4 ;
)
‚‚; <
;
‚‚< =
table
ƒƒ 
.
ƒƒ 

ForeignKey
ƒƒ $
(
ƒƒ$ %
name
„„ 
:
„„ 
$str
„„ E
,
„„E F
column
…… 
:
…… 
x
……  !
=>
……" $
x
……% &
.
……& '
UserId
……' -
,
……- .
principalTable
†† &
:
††& '
$str
††( 5
,
††5 6
principalColumn
‡‡ '
:
‡‡' (
$str
‡‡) -
,
‡‡- .
onDelete
  
:
  !
ReferentialAction
" 3
.
3 4
Cascade
4 ;
)
; <
;
< =
}
‰‰ 
)
‰‰ 
;
‰‰ 
migrationBuilder
‹‹ 
.
‹‹ 
CreateTable
‹‹ (
(
‹‹( )
name
 
:
 
$str
 (
,
( )
columns
 
:
 
table
 
=>
 !
new
" %
{
 
UserId
 
=
 
table
 "
.
" #
Column
# )
<
) *
string
* 0
>
0 1
(
1 2
type
2 6
:
6 7
$str
8 G
,
G H
nullable
I Q
:
Q R
false
S X
)
X Y
,
Y Z
LoginProvider
 !
=
" #
table
$ )
.
) *
Column
* 0
<
0 1
string
1 7
>
7 8
(
8 9
type
9 =
:
= >
$str
? N
,
N O
nullable
P X
:
X Y
false
Z _
)
_ `
,
` a
Name
‘‘ 
=
‘‘ 
table
‘‘  
.
‘‘  !
Column
‘‘! '
<
‘‘' (
string
‘‘( .
>
‘‘. /
(
‘‘/ 0
type
‘‘0 4
:
‘‘4 5
$str
‘‘6 E
,
‘‘E F
nullable
‘‘G O
:
‘‘O P
false
‘‘Q V
)
‘‘V W
,
‘‘W X
Value
’’ 
=
’’ 
table
’’ !
.
’’! "
Column
’’" (
<
’’( )
string
’’) /
>
’’/ 0
(
’’0 1
type
’’1 5
:
’’5 6
$str
’’7 F
,
’’F G
nullable
’’H P
:
’’P Q
true
’’R V
)
’’V W
}
““ 
,
““ 
constraints
”” 
:
”” 
table
”” "
=>
””# %
{
•• 
table
–– 
.
–– 

PrimaryKey
–– $
(
––$ %
$str
––% :
,
––: ;
x
––< =
=>
––> @
new
––A D
{
––E F
x
––G H
.
––H I
UserId
––I O
,
––O P
x
––Q R
.
––R S
LoginProvider
––S `
,
––` a
x
––b c
.
––c d
Name
––d h
}
––i j
)
––j k
;
––k l
table
—— 
.
—— 

ForeignKey
—— $
(
——$ %
name
 
:
 
$str
 F
,
F G
column
™™ 
:
™™ 
x
™™  !
=>
™™" $
x
™™% &
.
™™& '
UserId
™™' -
,
™™- .
principalTable
 &
:
& '
$str
( 5
,
5 6
principalColumn
›› '
:
››' (
$str
››) -
,
››- .
onDelete
  
:
  !
ReferentialAction
" 3
.
3 4
Cascade
4 ;
)
; <
;
< =
}
 
)
 
;
 
migrationBuilder
 
.
 
CreateTable
 (
(
( )
name
   
:
   
$str
   
,
    
columns
΅΅ 
:
΅΅ 
table
΅΅ 
=>
΅΅ !
new
΅΅" %
{
ΆΆ 
Id
££ 
=
££ 
table
££ 
.
££ 
Column
££ %
<
££% &
int
££& )
>
££) *
(
££* +
type
££+ /
:
££/ 0
$str
££1 6
,
££6 7
nullable
££8 @
:
££@ A
false
££B G
)
££G H
.
¤¤ 

Annotation
¤¤ #
(
¤¤# $
$str
¤¤$ 8
,
¤¤8 9
$str
¤¤: @
)
¤¤@ A
,
¤¤A B
UserId
¥¥ 
=
¥¥ 
table
¥¥ "
.
¥¥" #
Column
¥¥# )
<
¥¥) *
string
¥¥* 0
>
¥¥0 1
(
¥¥1 2
type
¥¥2 6
:
¥¥6 7
$str
¥¥8 G
,
¥¥G H
nullable
¥¥I Q
:
¥¥Q R
false
¥¥S X
)
¥¥X Y
,
¥¥Y Z
FullName
¦¦ 
=
¦¦ 
table
¦¦ $
.
¦¦$ %
Column
¦¦% +
<
¦¦+ ,
string
¦¦, 2
>
¦¦2 3
(
¦¦3 4
type
¦¦4 8
:
¦¦8 9
$str
¦¦: I
,
¦¦I J
	maxLength
¦¦K T
:
¦¦T U
$num
¦¦V Y
,
¦¦Y Z
nullable
¦¦[ c
:
¦¦c d
false
¦¦e j
)
¦¦j k
,
¦¦k l
Specialisation
§§ "
=
§§# $
table
§§% *
.
§§* +
Column
§§+ 1
<
§§1 2
string
§§2 8
>
§§8 9
(
§§9 :
type
§§: >
:
§§> ?
$str
§§@ O
,
§§O P
	maxLength
§§Q Z
:
§§Z [
$num
§§\ _
,
§§_ `
nullable
§§a i
:
§§i j
false
§§k p
)
§§p q
,
§§q r
PracticeStartDate
¨¨ %
=
¨¨& '
table
¨¨( -
.
¨¨- .
Column
¨¨. 4
<
¨¨4 5
DateOnly
¨¨5 =
>
¨¨= >
(
¨¨> ?
type
¨¨? C
:
¨¨C D
$str
¨¨E K
,
¨¨K L
nullable
¨¨M U
:
¨¨U V
false
¨¨W \
)
¨¨\ ]
,
¨¨] ^
ConsultationFee
©© #
=
©©$ %
table
©©& +
.
©©+ ,
Column
©©, 2
<
©©2 3
decimal
©©3 :
>
©©: ;
(
©©; <
type
©©< @
:
©©@ A
$str
©©B Q
,
©©Q R
	precision
©©S \
:
©©\ ]
$num
©©^ `
,
©©` a
scale
©©b g
:
©©g h
$num
©©i j
,
©©j k
nullable
©©l t
:
©©t u
false
©©v {
)
©©{ |
,
©©| }
IsAvailable
ªª 
=
ªª  !
table
ªª" '
.
ªª' (
Column
ªª( .
<
ªª. /
bool
ªª/ 3
>
ªª3 4
(
ªª4 5
type
ªª5 9
:
ªª9 :
$str
ªª; @
,
ªª@ A
nullable
ªªB J
:
ªªJ K
false
ªªL Q
)
ªªQ R
}
«« 
,
«« 
constraints
¬¬ 
:
¬¬ 
table
¬¬ "
=>
¬¬# %
{
­­ 
table
®® 
.
®® 

PrimaryKey
®® $
(
®®$ %
$str
®®% 1
,
®®1 2
x
®®3 4
=>
®®5 7
x
®®8 9
.
®®9 :
Id
®®: <
)
®®< =
;
®®= >
table
―― 
.
―― 

ForeignKey
―― $
(
――$ %
name
°° 
:
°° 
$str
°° =
,
°°= >
column
±± 
:
±± 
x
±±  !
=>
±±" $
x
±±% &
.
±±& '
UserId
±±' -
,
±±- .
principalTable
²² &
:
²²& '
$str
²²( 5
,
²²5 6
principalColumn
³³ '
:
³³' (
$str
³³) -
,
³³- .
onDelete
΄΄  
:
΄΄  !
ReferentialAction
΄΄" 3
.
΄΄3 4
Restrict
΄΄4 <
)
΄΄< =
;
΄΄= >
}
µµ 
)
µµ 
;
µµ 
migrationBuilder
·· 
.
·· 
CreateTable
·· (
(
··( )
name
ΈΈ 
:
ΈΈ 
$str
ΈΈ  
,
ΈΈ  !
columns
ΉΉ 
:
ΉΉ 
table
ΉΉ 
=>
ΉΉ !
new
ΉΉ" %
{
ΊΊ 
Id
»» 
=
»» 
table
»» 
.
»» 
Column
»» %
<
»»% &
int
»»& )
>
»») *
(
»»* +
type
»»+ /
:
»»/ 0
$str
»»1 6
,
»»6 7
nullable
»»8 @
:
»»@ A
false
»»B G
)
»»G H
.
ΌΌ 

Annotation
ΌΌ #
(
ΌΌ# $
$str
ΌΌ$ 8
,
ΌΌ8 9
$str
ΌΌ: @
)
ΌΌ@ A
,
ΌΌA B
UserId
½½ 
=
½½ 
table
½½ "
.
½½" #
Column
½½# )
<
½½) *
string
½½* 0
>
½½0 1
(
½½1 2
type
½½2 6
:
½½6 7
$str
½½8 G
,
½½G H
nullable
½½I Q
:
½½Q R
false
½½S X
)
½½X Y
,
½½Y Z
FullName
ΎΎ 
=
ΎΎ 
table
ΎΎ $
.
ΎΎ$ %
Column
ΎΎ% +
<
ΎΎ+ ,
string
ΎΎ, 2
>
ΎΎ2 3
(
ΎΎ3 4
type
ΎΎ4 8
:
ΎΎ8 9
$str
ΎΎ: I
,
ΎΎI J
	maxLength
ΎΎK T
:
ΎΎT U
$num
ΎΎV Y
,
ΎΎY Z
nullable
ΎΎ[ c
:
ΎΎc d
false
ΎΎe j
)
ΎΎj k
,
ΎΎk l
DateOfBirth
ΏΏ 
=
ΏΏ  !
table
ΏΏ" '
.
ΏΏ' (
Column
ΏΏ( .
<
ΏΏ. /
DateOnly
ΏΏ/ 7
>
ΏΏ7 8
(
ΏΏ8 9
type
ΏΏ9 =
:
ΏΏ= >
$str
ΏΏ? E
,
ΏΏE F
nullable
ΏΏG O
:
ΏΏO P
false
ΏΏQ V
)
ΏΏV W
,
ΏΏW X
Gender
ΐΐ 
=
ΐΐ 
table
ΐΐ "
.
ΐΐ" #
Column
ΐΐ# )
<
ΐΐ) *
string
ΐΐ* 0
>
ΐΐ0 1
(
ΐΐ1 2
type
ΐΐ2 6
:
ΐΐ6 7
$str
ΐΐ8 F
,
ΐΐF G
	maxLength
ΐΐH Q
:
ΐΐQ R
$num
ΐΐS U
,
ΐΐU V
nullable
ΐΐW _
:
ΐΐ_ `
false
ΐΐa f
)
ΐΐf g
,
ΐΐg h
Address
ΑΑ 
=
ΑΑ 
table
ΑΑ #
.
ΑΑ# $
Column
ΑΑ$ *
<
ΑΑ* +
string
ΑΑ+ 1
>
ΑΑ1 2
(
ΑΑ2 3
type
ΑΑ3 7
:
ΑΑ7 8
$str
ΑΑ9 H
,
ΑΑH I
	maxLength
ΑΑJ S
:
ΑΑS T
$num
ΑΑU X
,
ΑΑX Y
nullable
ΑΑZ b
:
ΑΑb c
false
ΑΑd i
)
ΑΑi j
}
ΒΒ 
,
ΒΒ 
constraints
ΓΓ 
:
ΓΓ 
table
ΓΓ "
=>
ΓΓ# %
{
ΔΔ 
table
ΕΕ 
.
ΕΕ 

PrimaryKey
ΕΕ $
(
ΕΕ$ %
$str
ΕΕ% 2
,
ΕΕ2 3
x
ΕΕ4 5
=>
ΕΕ6 8
x
ΕΕ9 :
.
ΕΕ: ;
Id
ΕΕ; =
)
ΕΕ= >
;
ΕΕ> ?
table
ΖΖ 
.
ΖΖ 

ForeignKey
ΖΖ $
(
ΖΖ$ %
name
ΗΗ 
:
ΗΗ 
$str
ΗΗ >
,
ΗΗ> ?
column
ΘΘ 
:
ΘΘ 
x
ΘΘ  !
=>
ΘΘ" $
x
ΘΘ% &
.
ΘΘ& '
UserId
ΘΘ' -
,
ΘΘ- .
principalTable
ΙΙ &
:
ΙΙ& '
$str
ΙΙ( 5
,
ΙΙ5 6
principalColumn
ΚΚ '
:
ΚΚ' (
$str
ΚΚ) -
,
ΚΚ- .
onDelete
ΛΛ  
:
ΛΛ  !
ReferentialAction
ΛΛ" 3
.
ΛΛ3 4
Restrict
ΛΛ4 <
)
ΛΛ< =
;
ΛΛ= >
}
ΜΜ 
)
ΜΜ 
;
ΜΜ 
migrationBuilder
ΞΞ 
.
ΞΞ 
CreateTable
ΞΞ (
(
ΞΞ( )
name
ΟΟ 
:
ΟΟ 
$str
ΟΟ $
,
ΟΟ$ %
columns
ΠΠ 
:
ΠΠ 
table
ΠΠ 
=>
ΠΠ !
new
ΠΠ" %
{
ΡΡ 
Id
ÒÒ 
=
ÒÒ 
table
ÒÒ 
.
ÒÒ 
Column
ÒÒ %
<
ÒÒ% &
int
ÒÒ& )
>
ÒÒ) *
(
ÒÒ* +
type
ÒÒ+ /
:
ÒÒ/ 0
$str
ÒÒ1 6
,
ÒÒ6 7
nullable
ÒÒ8 @
:
ÒÒ@ A
false
ÒÒB G
)
ÒÒG H
.
ΣΣ 

Annotation
ΣΣ #
(
ΣΣ# $
$str
ΣΣ$ 8
,
ΣΣ8 9
$str
ΣΣ: @
)
ΣΣ@ A
,
ΣΣA B
	PatientId
ΤΤ 
=
ΤΤ 
table
ΤΤ  %
.
ΤΤ% &
Column
ΤΤ& ,
<
ΤΤ, -
int
ΤΤ- 0
>
ΤΤ0 1
(
ΤΤ1 2
type
ΤΤ2 6
:
ΤΤ6 7
$str
ΤΤ8 =
,
ΤΤ= >
nullable
ΤΤ? G
:
ΤΤG H
false
ΤΤI N
)
ΤΤN O
,
ΤΤO P
DoctorId
ΥΥ 
=
ΥΥ 
table
ΥΥ $
.
ΥΥ$ %
Column
ΥΥ% +
<
ΥΥ+ ,
int
ΥΥ, /
>
ΥΥ/ 0
(
ΥΥ0 1
type
ΥΥ1 5
:
ΥΥ5 6
$str
ΥΥ7 <
,
ΥΥ< =
nullable
ΥΥ> F
:
ΥΥF G
false
ΥΥH M
)
ΥΥM N
,
ΥΥN O
AppointmentDate
ΦΦ #
=
ΦΦ$ %
table
ΦΦ& +
.
ΦΦ+ ,
Column
ΦΦ, 2
<
ΦΦ2 3
DateOnly
ΦΦ3 ;
>
ΦΦ; <
(
ΦΦ< =
type
ΦΦ= A
:
ΦΦA B
$str
ΦΦC I
,
ΦΦI J
nullable
ΦΦK S
:
ΦΦS T
false
ΦΦU Z
)
ΦΦZ [
,
ΦΦ[ \
AppointmentTime
ΧΧ #
=
ΧΧ$ %
table
ΧΧ& +
.
ΧΧ+ ,
Column
ΧΧ, 2
<
ΧΧ2 3
TimeOnly
ΧΧ3 ;
>
ΧΧ; <
(
ΧΧ< =
type
ΧΧ= A
:
ΧΧA B
$str
ΧΧC I
,
ΧΧI J
nullable
ΧΧK S
:
ΧΧS T
false
ΧΧU Z
)
ΧΧZ [
,
ΧΧ[ \
Status
ΨΨ 
=
ΨΨ 
table
ΨΨ "
.
ΨΨ" #
Column
ΨΨ# )
<
ΨΨ) *
string
ΨΨ* 0
>
ΨΨ0 1
(
ΨΨ1 2
type
ΨΨ2 6
:
ΨΨ6 7
$str
ΨΨ8 F
,
ΨΨF G
	maxLength
ΨΨH Q
:
ΨΨQ R
$num
ΨΨS U
,
ΨΨU V
nullable
ΨΨW _
:
ΨΨ_ `
false
ΨΨa f
)
ΨΨf g
,
ΨΨg h 
CancellationReason
ΩΩ &
=
ΩΩ' (
table
ΩΩ) .
.
ΩΩ. /
Column
ΩΩ/ 5
<
ΩΩ5 6
string
ΩΩ6 <
>
ΩΩ< =
(
ΩΩ= >
type
ΩΩ> B
:
ΩΩB C
$str
ΩΩD S
,
ΩΩS T
	maxLength
ΩΩU ^
:
ΩΩ^ _
$num
ΩΩ` c
,
ΩΩc d
nullable
ΩΩe m
:
ΩΩm n
true
ΩΩo s
)
ΩΩs t
}
ΪΪ 
,
ΪΪ 
constraints
ΫΫ 
:
ΫΫ 
table
ΫΫ "
=>
ΫΫ# %
{
άά 
table
έέ 
.
έέ 

PrimaryKey
έέ $
(
έέ$ %
$str
έέ% 6
,
έέ6 7
x
έέ8 9
=>
έέ: <
x
έέ= >
.
έέ> ?
Id
έέ? A
)
έέA B
;
έέB C
table
ήή 
.
ήή 

ForeignKey
ήή $
(
ήή$ %
name
ίί 
:
ίί 
$str
ίί @
,
ίί@ A
column
ΰΰ 
:
ΰΰ 
x
ΰΰ  !
=>
ΰΰ" $
x
ΰΰ% &
.
ΰΰ& '
DoctorId
ΰΰ' /
,
ΰΰ/ 0
principalTable
αα &
:
αα& '
$str
αα( 1
,
αα1 2
principalColumn
ββ '
:
ββ' (
$str
ββ) -
,
ββ- .
onDelete
γγ  
:
γγ  !
ReferentialAction
γγ" 3
.
γγ3 4
Restrict
γγ4 <
)
γγ< =
;
γγ= >
table
δδ 
.
δδ 

ForeignKey
δδ $
(
δδ$ %
name
εε 
:
εε 
$str
εε B
,
εεB C
column
ζζ 
:
ζζ 
x
ζζ  !
=>
ζζ" $
x
ζζ% &
.
ζζ& '
	PatientId
ζζ' 0
,
ζζ0 1
principalTable
ηη &
:
ηη& '
$str
ηη( 2
,
ηη2 3
principalColumn
θθ '
:
θθ' (
$str
θθ) -
,
θθ- .
onDelete
ιι  
:
ιι  !
ReferentialAction
ιι" 3
.
ιι3 4
Restrict
ιι4 <
)
ιι< =
;
ιι= >
}
κκ 
)
κκ 
;
κκ 
migrationBuilder
μμ 
.
μμ 
CreateTable
μμ (
(
μμ( )
name
νν 
:
νν 
$str
νν %
,
νν% &
columns
ξξ 
:
ξξ 
table
ξξ 
=>
ξξ !
new
ξξ" %
{
οο 
Id
ππ 
=
ππ 
table
ππ 
.
ππ 
Column
ππ %
<
ππ% &
int
ππ& )
>
ππ) *
(
ππ* +
type
ππ+ /
:
ππ/ 0
$str
ππ1 6
,
ππ6 7
nullable
ππ8 @
:
ππ@ A
false
ππB G
)
ππG H
.
ρρ 

Annotation
ρρ #
(
ρρ# $
$str
ρρ$ 8
,
ρρ8 9
$str
ρρ: @
)
ρρ@ A
,
ρρA B
AppointmentId
ςς !
=
ςς" #
table
ςς$ )
.
ςς) *
Column
ςς* 0
<
ςς0 1
int
ςς1 4
>
ςς4 5
(
ςς5 6
type
ςς6 :
:
ςς: ;
$str
ςς< A
,
ςςA B
nullable
ςςC K
:
ςςK L
false
ςςM R
)
ςςR S
,
ςςS T
	VisitDate
σσ 
=
σσ 
table
σσ  %
.
σσ% &
Column
σσ& ,
<
σσ, -
DateOnly
σσ- 5
>
σσ5 6
(
σσ6 7
type
σσ7 ;
:
σσ; <
$str
σσ= C
,
σσC D
nullable
σσE M
:
σσM N
false
σσO T
)
σσT U
,
σσU V
	Diagnosis
ττ 
=
ττ 
table
ττ  %
.
ττ% &
Column
ττ& ,
<
ττ, -
string
ττ- 3
>
ττ3 4
(
ττ4 5
type
ττ5 9
:
ττ9 :
$str
ττ; J
,
ττJ K
	maxLength
ττL U
:
ττU V
$num
ττW Z
,
ττZ [
nullable
ττ\ d
:
ττd e
false
ττf k
)
ττk l
,
ττl m
Prescription
υυ  
=
υυ! "
table
υυ# (
.
υυ( )
Column
υυ) /
<
υυ/ 0
string
υυ0 6
>
υυ6 7
(
υυ7 8
type
υυ8 <
:
υυ< =
$str
υυ> M
,
υυM N
	maxLength
υυO X
:
υυX Y
$num
υυZ ]
,
υυ] ^
nullable
υυ_ g
:
υυg h
false
υυi n
)
υυn o
,
υυo p
Notes
φφ 
=
φφ 
table
φφ !
.
φφ! "
Column
φφ" (
<
φφ( )
string
φφ) /
>
φφ/ 0
(
φφ0 1
type
φφ1 5
:
φφ5 6
$str
φφ7 G
,
φφG H
	maxLength
φφI R
:
φφR S
$num
φφT X
,
φφX Y
nullable
φφZ b
:
φφb c
true
φφd h
)
φφh i
}
χχ 
,
χχ 
constraints
ψψ 
:
ψψ 
table
ψψ "
=>
ψψ# %
{
ωω 
table
ϊϊ 
.
ϊϊ 

PrimaryKey
ϊϊ $
(
ϊϊ$ %
$str
ϊϊ% 7
,
ϊϊ7 8
x
ϊϊ9 :
=>
ϊϊ; =
x
ϊϊ> ?
.
ϊϊ? @
Id
ϊϊ@ B
)
ϊϊB C
;
ϊϊC D
table
ϋϋ 
.
ϋϋ 

ForeignKey
ϋϋ $
(
ϋϋ$ %
name
όό 
:
όό 
$str
όό K
,
όόK L
column
ύύ 
:
ύύ 
x
ύύ  !
=>
ύύ" $
x
ύύ% &
.
ύύ& '
AppointmentId
ύύ' 4
,
ύύ4 5
principalTable
ώώ &
:
ώώ& '
$str
ώώ( 6
,
ώώ6 7
principalColumn
ÿÿ '
:
ÿÿ' (
$str
ÿÿ) -
,
ÿÿ- .
onDelete
€€  
:
€€  !
ReferentialAction
€€" 3
.
€€3 4
Restrict
€€4 <
)
€€< =
;
€€= >
}
 
)
 
;
 
migrationBuilder
ƒƒ 
.
ƒƒ 
CreateIndex
ƒƒ (
(
ƒƒ( )
name
„„ 
:
„„ 
$str
„„ 0
,
„„0 1
table
…… 
:
…… 
$str
…… %
,
……% &
column
†† 
:
†† 
$str
†† "
)
††" #
;
††# $
migrationBuilder
 
.
 
CreateIndex
 (
(
( )
name
‰‰ 
:
‰‰ 
$str
‰‰ 1
,
‰‰1 2
table
 
:
 
$str
 %
,
% &
column
‹‹ 
:
‹‹ 
$str
‹‹ #
)
‹‹# $
;
‹‹$ %
migrationBuilder
 
.
 
CreateIndex
 (
(
( )
name
 
:
 
$str
 2
,
2 3
table
 
:
 
$str
 )
,
) *
column
 
:
 
$str
  
)
  !
;
! "
migrationBuilder
’’ 
.
’’ 
CreateIndex
’’ (
(
’’( )
name
““ 
:
““ 
$str
““ %
,
““% &
table
”” 
:
”” 
$str
”” $
,
””$ %
column
•• 
:
•• 
$str
•• (
,
••( )
unique
–– 
:
–– 
true
–– 
,
–– 
filter
—— 
:
—— 
$str
—— 6
)
——6 7
;
——7 8
migrationBuilder
™™ 
.
™™ 
CreateIndex
™™ (
(
™™( )
name
 
:
 
$str
 2
,
2 3
table
›› 
:
›› 
$str
›› )
,
››) *
column
 
:
 
$str
  
)
  !
;
! "
migrationBuilder
 
.
 
CreateIndex
 (
(
( )
name
 
:
 
$str
 2
,
2 3
table
   
:
   
$str
   )
,
  ) *
column
΅΅ 
:
΅΅ 
$str
΅΅  
)
΅΅  !
;
΅΅! "
migrationBuilder
££ 
.
££ 
CreateIndex
££ (
(
££( )
name
¤¤ 
:
¤¤ 
$str
¤¤ 1
,
¤¤1 2
table
¥¥ 
:
¥¥ 
$str
¥¥ (
,
¥¥( )
column
¦¦ 
:
¦¦ 
$str
¦¦  
)
¦¦  !
;
¦¦! "
migrationBuilder
¨¨ 
.
¨¨ 
CreateIndex
¨¨ (
(
¨¨( )
name
©© 
:
©© 
$str
©© "
,
©©" #
table
ªª 
:
ªª 
$str
ªª $
,
ªª$ %
column
«« 
:
«« 
$str
«« )
)
««) *
;
««* +
migrationBuilder
­­ 
.
­­ 
CreateIndex
­­ (
(
­­( )
name
®® 
:
®® 
$str
®® %
,
®®% &
table
―― 
:
―― 
$str
―― $
,
――$ %
column
°° 
:
°° 
$str
°° ,
,
°°, -
unique
±± 
:
±± 
true
±± 
,
±± 
filter
²² 
:
²² 
$str
²² :
)
²²: ;
;
²²; <
migrationBuilder
΄΄ 
.
΄΄ 
CreateIndex
΄΄ (
(
΄΄( )
name
µµ 
:
µµ 
$str
µµ )
,
µµ) *
table
¶¶ 
:
¶¶ 
$str
¶¶  
,
¶¶  !
column
·· 
:
·· 
$str
··  
,
··  !
unique
ΈΈ 
:
ΈΈ 
true
ΈΈ 
)
ΈΈ 
;
ΈΈ 
migrationBuilder
ΊΊ 
.
ΊΊ 
CreateIndex
ΊΊ (
(
ΊΊ( )
name
»» 
:
»» 
$str
»» 6
,
»»6 7
table
ΌΌ 
:
ΌΌ 
$str
ΌΌ &
,
ΌΌ& '
column
½½ 
:
½½ 
$str
½½ '
,
½½' (
unique
ΎΎ 
:
ΎΎ 
true
ΎΎ 
)
ΎΎ 
;
ΎΎ 
migrationBuilder
ΐΐ 
.
ΐΐ 
CreateIndex
ΐΐ (
(
ΐΐ( )
name
ΑΑ 
:
ΑΑ 
$str
ΑΑ *
,
ΑΑ* +
table
ΒΒ 
:
ΒΒ 
$str
ΒΒ !
,
ΒΒ! "
column
ΓΓ 
:
ΓΓ 
$str
ΓΓ  
,
ΓΓ  !
unique
ΔΔ 
:
ΔΔ 
true
ΔΔ 
)
ΔΔ 
;
ΔΔ 
}
ΕΕ 	
	protected
ΘΘ 
override
ΘΘ 
void
ΘΘ 
Down
ΘΘ  $
(
ΘΘ$ %
MigrationBuilder
ΘΘ% 5
migrationBuilder
ΘΘ6 F
)
ΘΘF G
{
ΙΙ 	
migrationBuilder
ΚΚ 
.
ΚΚ 
	DropTable
ΚΚ &
(
ΚΚ& '
name
ΛΛ 
:
ΛΛ 
$str
ΛΛ (
)
ΛΛ( )
;
ΛΛ) *
migrationBuilder
ΝΝ 
.
ΝΝ 
	DropTable
ΝΝ &
(
ΝΝ& '
name
ΞΞ 
:
ΞΞ 
$str
ΞΞ (
)
ΞΞ( )
;
ΞΞ) *
migrationBuilder
ΠΠ 
.
ΠΠ 
	DropTable
ΠΠ &
(
ΠΠ& '
name
ΡΡ 
:
ΡΡ 
$str
ΡΡ (
)
ΡΡ( )
;
ΡΡ) *
migrationBuilder
ΣΣ 
.
ΣΣ 
	DropTable
ΣΣ &
(
ΣΣ& '
name
ΤΤ 
:
ΤΤ 
$str
ΤΤ '
)
ΤΤ' (
;
ΤΤ( )
migrationBuilder
ΦΦ 
.
ΦΦ 
	DropTable
ΦΦ &
(
ΦΦ& '
name
ΧΧ 
:
ΧΧ 
$str
ΧΧ (
)
ΧΧ( )
;
ΧΧ) *
migrationBuilder
ΩΩ 
.
ΩΩ 
	DropTable
ΩΩ &
(
ΩΩ& '
name
ΪΪ 
:
ΪΪ 
$str
ΪΪ %
)
ΪΪ% &
;
ΪΪ& '
migrationBuilder
άά 
.
άά 
	DropTable
άά &
(
άά& '
name
έέ 
:
έέ 
$str
έέ #
)
έέ# $
;
έέ$ %
migrationBuilder
ίί 
.
ίί 
	DropTable
ίί &
(
ίί& '
name
ΰΰ 
:
ΰΰ 
$str
ΰΰ $
)
ΰΰ$ %
;
ΰΰ% &
migrationBuilder
ββ 
.
ββ 
	DropTable
ββ &
(
ββ& '
name
γγ 
:
γγ 
$str
γγ 
)
γγ  
;
γγ  !
migrationBuilder
εε 
.
εε 
	DropTable
εε &
(
εε& '
name
ζζ 
:
ζζ 
$str
ζζ  
)
ζζ  !
;
ζζ! "
migrationBuilder
θθ 
.
θθ 
	DropTable
θθ &
(
θθ& '
name
ιι 
:
ιι 
$str
ιι #
)
ιι# $
;
ιι$ %
}
κκ 	
}
λλ 
}μμ © 
\C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Middlewares\GlobalExceptionHandler.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Middlewares $
;$ %
public 
class "
GlobalExceptionHandler #
(# $
ILogger$ +
<+ ,"
GlobalExceptionHandler, B
>B C
loggerD J
)J K
:L M
IExceptionHandlerN _
{ 
public		 

async		 
	ValueTask		 
<		 
bool		 
>		  
TryHandleAsync		! /
(		/ 0
HttpContext

 
httpContext

 
,

  
	Exception 
	exception 
, 
CancellationToken 
cancellationToken +
)+ ,
{ 
logger 
. 
LogError 
( 
	exception 
, 
$str 5
,5 6
	exception 
. 
Message 
) 	
;	 

var 
( 

statusCode 
, 
message  
)  !
=" #
	exception$ -
switch. 4
{ 	
AppException 
appException %
=>& (
() *
appException* 6
.6 7

StatusCode7 A
,A B
appExceptionC O
.O P
MessageP W
)W X
,X Y!
ArgumentNullException !
=>" $
(% &
StatusCodes& 1
.1 2
Status400BadRequest2 E
,E F
	exceptionG P
.P Q
MessageQ X
)X Y
,Y Z
ArgumentException 
=>  
(! "
StatusCodes" -
.- .
Status400BadRequest. A
,A B
	exceptionC L
.L M
MessageM T
)T U
,U V%
InvalidOperationException %
=>& (
() *
StatusCodes* 5
.5 6
Status400BadRequest6 I
,I J
	exceptionK T
.T U
MessageU \
)\ ]
,] ^ 
KeyNotFoundException  
=>! #
($ %
StatusCodes% 0
.0 1
Status404NotFound1 B
,B C
	exceptionD M
.M N
MessageN U
)U V
,V W'
UnauthorizedAccessException '
=>( *
(+ ,
StatusCodes, 7
.7 8
Status403Forbidden8 J
,J K
	exceptionL U
.U V
MessageV ]
)] ^
,^ _
_ 
=> 
( 
StatusCodes 
. (
Status500InternalServerError :
,: ;
$str< [
)[ \
} 	
;	 

var 
response 
= 
new 
ErrorResponseDto +
{   	

StatusCode!! 
=!! 

statusCode!! #
,!!# $
Message"" 
="" 
message"" 
,"" 
Details## 
=## 
	exception## 
.##  
GetType##  '
(##' (
)##( )
.##) *
Name##* .
,##. /
	Timestamp$$ 
=$$ 
DateTime$$  
.$$  !
UtcNow$$! '
,$$' (
Path%% 
=%% 
httpContext%% 
.%% 
Request%% &
.%%& '
Path%%' +
}&& 	
;&&	 

httpContext(( 
.(( 
Response(( 
.(( 

StatusCode(( '
=((( )

statusCode((* 4
;((4 5
await** 
httpContext** 
.** 
Response** "
.**" #
WriteAsJsonAsync**# 3
(**3 4
response**4 <
,**< =
cancellationToken**> O
)**O P
;**P Q
return,, 
true,, 
;,, 
}-- 
}.. θM
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Mappings\MappingProfile.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Mappings !
;! "
public

 
class

 
MappingProfile

 
:

 
Profile

 %
{ 
public 

MappingProfile 
( 
) 
{ 
	CreateMap 
< 
Doctor 
, 
PublicDoctorDto )
>) *
(* +
)+ ,
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
YearsOfExperience$ 5
,5 6
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src* -
.- .&
CalculateYearsOfExperience. H
(H I
)I J
)J K
)K L
;L M
	CreateMap 
< 
Doctor 
, 
	DoctorDto #
># $
($ %
)% &
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
YearsOfExperience$ 5
,5 6
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src* -
.- .&
CalculateYearsOfExperience. H
(H I
)I J
)J K
)K L
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
Email$ )
,) *
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src 
. 
User 
!= 
null  $
&&% '
src( +
.+ ,
User, 0
.0 1
Email1 6
!=7 9
null: >
? 
src 
. 
User "
." #
Email# (
: 
string  
.  !
Empty! &
)& '
)' (
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
PhoneNumber$ /
,/ 0
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src 
. 
User 
!= 
null  $
&&% '
src( +
.+ ,
User, 0
.0 1
PhoneNumber1 <
!== ?
null@ D
? 
src 
. 
User "
." #
PhoneNumber# .
: 
string  
.  !
Empty! &
)& '
)' (
;( )
	CreateMap   
<   
Patient   
,   

PatientDto   %
>  % &
(  & '
)  ' (
.!! 
	ForMember!! 
(!! 
dest!! 
=>!! 
dest!! #
.!!# $
Email!!$ )
,!!) *
opt"" 
=>"" 
opt"" 
."" 
MapFrom"" "
(""" #
src""# &
=>""' )
src## 
.## 
User## 
!=## 
null##  $
&&##% '
src##( +
.##+ ,
User##, 0
.##0 1
Email##1 6
!=##7 9
null##: >
?$$ 
src$$ 
.$$ 
User$$ "
.$$" #
Email$$# (
:%% 
string%%  
.%%  !
Empty%%! &
)%%& '
)%%' (
.&& 
	ForMember&& 
(&& 
dest&& 
=>&& 
dest&& #
.&&# $
PhoneNumber&&$ /
,&&/ 0
opt'' 
=>'' 
opt'' 
.'' 
MapFrom'' "
(''" #
src''# &
=>''' )
src(( 
.(( 
User(( 
!=(( 
null((  $
&&((% '
src((( +
.((+ ,
User((, 0
.((0 1
PhoneNumber((1 <
!=((= ?
null((@ D
?)) 
src)) 
.)) 
User)) "
.))" #
PhoneNumber))# .
:** 
string**  
.**  !
Empty**! &
)**& '
)**' (
;**( )
	CreateMap,, 
<,, 
Appointment,, 
,,, 
AppointmentDto,, -
>,,- .
(,,. /
),,/ 0
.-- 
	ForMember-- 
(-- 
dest-- 
=>-- 
dest-- #
.--# $
PatientName--$ /
,--/ 0
opt.. 
=>.. 
opt.. 
... 
MapFrom.. "
(.." #
src..# &
=>..' )
src// 
.// 
Patient// 
!=//  "
null//# '
?00 
src00 
.00 
Patient00 %
.00% &
FullName00& .
:11 
string11  
.11  !
Empty11! &
)11& '
)11' (
.22 
	ForMember22 
(22 
dest22 
=>22 
dest22 #
.22# $

DoctorName22$ .
,22. /
opt33 
=>33 
opt33 
.33 
MapFrom33 "
(33" #
src33# &
=>33' )
src44 
.44 
Doctor44 
!=44 !
null44" &
?55 
src55 
.55 
Doctor55 $
.55$ %
FullName55% -
:66 
string66  
.66  !
Empty66! &
)66& '
)66' (
.77 
	ForMember77 
(77 
dest77 
=>77 
dest77 #
.77# $
HealthRecordId77$ 2
,772 3
opt88 
=>88 
opt88 
.88 
MapFrom88 "
(88" #
src88# &
=>88' )
src99 
.99 
HealthRecord99 $
!=99% '
null99( ,
?:: 
src:: 
.:: 
HealthRecord:: *
.::* +
Id::+ -
:;; 
(;; 
int;; 
?;; 
);;  
null;;  $
);;$ %
);;% &
;;;& '
	CreateMap== 
<==  
CreateAppointmentDto== &
,==& '
Appointment==( 3
>==3 4
(==4 5
)==5 6
;==6 7
	CreateMap?? 
<?? 
HealthRecord?? 
,?? 
HealthRecordDto??  /
>??/ 0
(??0 1
)??1 2
.@@ 
	ForMember@@ 
(@@ 
dest@@ 
=>@@ 
dest@@ #
.@@# $
	PatientId@@$ -
,@@- .
optAA 
=>AA 
optAA 
.AA 
MapFromAA "
(AA" #
srcAA# &
=>AA' )
srcBB 
.BB 
AppointmentBB #
!=BB$ &
nullBB' +
?CC 
srcCC 
.CC 
AppointmentCC )
.CC) *
	PatientIdCC* 3
:DD 
$numDD 
)DD 
)DD 
.EE 
	ForMemberEE 
(EE 
destEE 
=>EE 
destEE #
.EE# $
DoctorIdEE$ ,
,EE, -
optFF 
=>FF 
optFF 
.FF 
MapFromFF "
(FF" #
srcFF# &
=>FF' )
srcGG 
.GG 
AppointmentGG #
!=GG$ &
nullGG' +
?HH 
srcHH 
.HH 
AppointmentHH )
.HH) *
DoctorIdHH* 2
:II 
$numII 
)II 
)II 
.JJ 
	ForMemberJJ 
(JJ 
destJJ 
=>JJ 
destJJ #
.JJ# $
PatientNameJJ$ /
,JJ/ 0
optKK 
=>KK 
optKK 
.KK 
MapFromKK "
(KK" #
srcKK# &
=>KK' )
srcLL 
.LL 
AppointmentLL #
!=LL$ &
nullLL' +
&&LL, .
srcLL/ 2
.LL2 3
AppointmentLL3 >
.LL> ?
PatientLL? F
!=LLG I
nullLLJ N
?MM 
srcMM 
.MM 
AppointmentMM )
.MM) *
PatientMM* 1
.MM1 2
FullNameMM2 :
:NN 
stringNN  
.NN  !
EmptyNN! &
)NN& '
)NN' (
.OO 
	ForMemberOO 
(OO 
destOO 
=>OO 
destOO #
.OO# $

PatientAgeOO$ .
,OO. /
optPP 
=>PP 
optPP 
.PP 
MapFromPP "
(PP" #
srcPP# &
=>PP' )
srcPP* -
.PP- .

PatientAgePP. 8
)PP8 9
)PP9 :
.QQ 
	ForMemberQQ 
(QQ 
destQQ 
=>QQ 
destQQ #
.QQ# $

DoctorNameQQ$ .
,QQ. /
optRR 
=>RR 
optRR 
.RR 
MapFromRR "
(RR" #
srcRR# &
=>RR' )
srcSS 
.SS 
AppointmentSS #
!=SS$ &
nullSS' +
&&SS, .
srcSS/ 2
.SS2 3
AppointmentSS3 >
.SS> ?
DoctorSS? E
!=SSF H
nullSSI M
?TT 
srcTT 
.TT 
AppointmentTT )
.TT) *
DoctorTT* 0
.TT0 1
FullNameTT1 9
:UU 
stringUU  
.UU  !
EmptyUU! &
)UU& '
)UU' (
;UU( )
}VV 
}WW Τ
^C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Extensions\ClaimsPrincipalExtensions.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Extensions #
;# $
public 
static 
class %
ClaimsPrincipalExtensions -
{ 
public 

static 
int 
? 
GetPatientId #
(# $
this$ (
ClaimsPrincipal) 8
user9 =
)= >
{		 
var

 

claimValue

 
=

 
user

 
.

 
FindFirstValue

 ,
(

, -
AppClaimTypes

- :
.

: ;
	PatientId

; D
)

D E
;

E F
return 
int 
. 
TryParse 
( 

claimValue &
,& '
out( +
var, /
	patientId0 9
)9 :
? 
	patientId 
: 
null 
; 
} 
public 

static 
int 
? 
GetDoctorId "
(" #
this# '
ClaimsPrincipal( 7
user8 <
)< =
{ 
var 

claimValue 
= 
user 
. 
FindFirstValue ,
(, -
AppClaimTypes- :
.: ;
DoctorId; C
)C D
;D E
return 
int 
. 
TryParse 
( 

claimValue &
,& '
out( +
var, /
doctorId0 8
)8 9
? 
doctorId 
: 
null 
; 
} 
public 

static 
string 
? 
GetCurrentRole (
(( )
this) -
ClaimsPrincipal. =
user> B
)B C
{ 
if 

( 
user 
. 
IsInRole 
( 
AppRoles "
." #
Admin# (
)( )
)) *
{ 	
return 
AppRoles 
. 
Admin !
;! "
} 	
if!! 

(!! 
user!! 
.!! 
IsInRole!! 
(!! 
AppRoles!! "
.!!" #
Doctor!!# )
)!!) *
)!!* +
{"" 	
return## 
AppRoles## 
.## 
Doctor## "
;##" #
}$$ 	
if&& 

(&& 
user&& 
.&& 
IsInRole&& 
(&& 
AppRoles&& "
.&&" #
Patient&&# *
)&&* +
)&&+ ,
{'' 	
return(( 
AppRoles(( 
.(( 
Patient(( #
;((# $
})) 	
return++ 
null++ 
;++ 
},, 
}-- ΄	
VC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Exceptions\NotFoundException.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Exceptions #
;# $
public 
class 
NotFoundException 
:  
AppException! -
{ 
public 

NotFoundException 
( 
string #
message$ +
)+ ,
: 	
base
 
( 
message 
, 
StatusCodes #
.# $
Status404NotFound$ 5
)5 6
{ 
} 
public

 

NotFoundException

 
(

 
string

 #
resourceName

$ 0
,

0 1
object

2 8
key

9 <
)

< =
: 	
base
 
( 
$" 
{ 
resourceName 
} 
$str )
{) *
key* -
}- .
$str. >
"> ?
,? @
StatusCodesA L
.L M
Status404NotFoundM ^
)^ _
{ 
} 
} Ι
WC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Exceptions\ForbiddenException.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Exceptions #
;# $
public 
class 
ForbiddenException 
:  !
AppException" .
{ 
public 

ForbiddenException 
( 
string $
message% ,
=- .
$str/ c
)c d
: 	
base
 
( 
message 
, 
StatusCodes #
.# $
Status403Forbidden$ 6
)6 7
{ 
} 
}		 ¤
VC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Exceptions\ConflictException.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Exceptions #
;# $
public 
class 
ConflictException 
:  
AppException! -
{ 
public 

ConflictException 
( 
string #
message$ +
)+ ,
: 	
base
 
( 
message 
, 
StatusCodes #
.# $
Status409Conflict$ 5
)5 6
{ 
} 
}		 ²
ZC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Exceptions\BusinessRuleException.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Exceptions #
;# $
public 
class !
BusinessRuleException "
:# $
AppException% 1
{ 
public 
!
BusinessRuleException  
(  !
string! '
message( /
)/ 0
: 	
base
 
( 
message 
, 
StatusCodes #
.# $
Status400BadRequest$ 7
)7 8
{ 
} 
}		 ¬
XC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Exceptions\BadRequestException.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Exceptions #
;# $
public 
class 
BadRequestException  
:! "
AppException# /
{ 
public 

BadRequestException 
( 
string %
message& -
)- .
: 	
base
 
( 
message 
, 
StatusCodes #
.# $
Status400BadRequest$ 7
)7 8
{ 
} 
}		 Φ
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Exceptions\AppException.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Exceptions #
;# $
public 
abstract 
class 
AppException "
:# $
	Exception% .
{ 
	protected 
AppException 
( 
string !
message" )
,) *
int+ .

statusCode/ 9
)9 :
: 	
base
 
( 
message 
) 
{ 

StatusCode 
= 

statusCode 
;  
}		 
public 

int 

StatusCode 
{ 
get 
;  
}! "
} η–
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Data\IdentityDataSeeder.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Data 
; 
public		 
static		 
class		 
IdentityDataSeeder		 &
{

 
private 
const 
string 
AdminPassword &
=' (
$str) 4
;4 5
private 
const 
string 
DoctorPassword '
=( )
$str* 6
;6 7
private 
const 
string 
PatientPassword (
=) *
$str+ 8
;8 9
private 
const 
string 
PrimaryAdminEmail *
=+ ,
$str- C
;C D
private 
const 
string 
PrimaryDoctorEmail +
=, -
$str. J
;J K
public 

static 
async 
Task 
	SeedAsync &
(& '
RoleManager 
< 
IdentityRole  
>  !
roleManager" -
,- .
UserManager 
< 
IdentityUser  
>  !
userManager" -
,- .
HealthAxisDbContext 
context #
,# $
bool 
seedDemoData 
= 
false !
)! "
{ 
await 
SeedRolesAsync 
( 
roleManager (
)( )
;) *
if 

( 
seedDemoData 
) 
{ 	
await (
ResetAllApplicationDataAsync .
(. /
context/ 6
,6 7
userManager8 C
)C D
;D E
} 	
await 
SeedAdminsAsync 
( 
userManager )
)) *
;* +
if!! 

(!! 
!!! 
seedDemoData!! 
)!! 
{"" 	
return## 
;## 
}$$ 	
var&& 
doctors&& 
=&& 
await&& 
SeedDoctorsAsync&& ,
(&&, -
userManager&&- 8
,&&8 9
context&&: A
)&&A B
;&&B C
var'' 
patients'' 
='' 
await'' 
SeedPatientsAsync'' .
(''. /
userManager''/ :
,'': ;
context''< C
)''C D
;''D E
await)) 1
%SeedAppointmentsAndHealthRecordsAsync)) 3
())3 4
context))4 ;
,)); <
doctors))= D
,))D E
patients))F N
)))N O
;))O P
}** 
private,, 
static,, 
async,, 
Task,, 
SeedRolesAsync,, ,
(,,, -
RoleManager,,- 8
<,,8 9
IdentityRole,,9 E
>,,E F
roleManager,,G R
),,R S
{-- 
string.. 
[.. 
].. 
roles.. 
=.. 
[.. 
AppRoles.. "
..." #
Admin..# (
,..( )
AppRoles..* 2
...2 3
Doctor..3 9
,..9 :
AppRoles..; C
...C D
Patient..D K
]..K L
;..L M
foreach00 
(00 
var00 
role00 
in00 
roles00 "
)00" #
{11 	
if22 
(22 
!22 
await22 
roleManager22 "
.22" #
RoleExistsAsync22# 2
(222 3
role223 7
)227 8
)228 9
{33 
var44 
result44 
=44 
await44 "
roleManager44# .
.44. /
CreateAsync44/ :
(44: ;
new44; >
IdentityRole44? K
{55 
Name66 
=66 
role66 
}77 
)77 
;77 
if99 
(99 
!99 
result99 
.99 
	Succeeded99 %
)99% &
{:: 
var;; 
errors;; 
=;;  
string;;! '
.;;' (
Join;;( ,
(;;, -
$str;;- 0
,;;0 1
result;;2 8
.;;8 9
Errors;;9 ?
.;;? @
Select;;@ F
(;;F G
error;;G L
=>;;M O
error;;P U
.;;U V
Description;;V a
);;a b
);;b c
;;;c d
throw<< 
new<< %
InvalidOperationException<< 7
(<<7 8
$"<<8 :
$str<<: N
{<<N O
role<<O S
}<<S T
$str<<T V
{<<V W
errors<<W ]
}<<] ^
"<<^ _
)<<_ `
;<<` a
}== 
}>> 
}?? 	
}@@ 
privateBB 
staticBB 
asyncBB 
TaskBB (
ResetAllApplicationDataAsyncBB :
(BB: ;
HealthAxisDbContextCC 
contextCC #
,CC# $
UserManagerDD 
<DD 
IdentityUserDD  
>DD  !
userManagerDD" -
)DD- .
{EE 
varFF 
healthRecordsFF 
=FF 
awaitFF !
contextFF" )
.FF) *
HealthRecordsFF* 7
.FF7 8
ToListAsyncFF8 C
(FFC D
)FFD E
;FFE F
contextGG 
.GG 
HealthRecordsGG 
.GG 
RemoveRangeGG )
(GG) *
healthRecordsGG* 7
)GG7 8
;GG8 9
varII 
appointmentsII 
=II 
awaitII  
contextII! (
.II( )
AppointmentsII) 5
.II5 6
ToListAsyncII6 A
(IIA B
)IIB C
;IIC D
contextJJ 
.JJ 
AppointmentsJJ 
.JJ 
RemoveRangeJJ (
(JJ( )
appointmentsJJ) 5
)JJ5 6
;JJ6 7
varLL 
doctorsLL 
=LL 
awaitLL 
contextLL #
.LL# $
DoctorsLL$ +
.LL+ ,
ToListAsyncLL, 7
(LL7 8
)LL8 9
;LL9 :
contextMM 
.MM 
DoctorsMM 
.MM 
RemoveRangeMM #
(MM# $
doctorsMM$ +
)MM+ ,
;MM, -
varOO 
patientsOO 
=OO 
awaitOO 
contextOO $
.OO$ %
PatientsOO% -
.OO- .
ToListAsyncOO. 9
(OO9 :
)OO: ;
;OO; <
contextPP 
.PP 
PatientsPP 
.PP 
RemoveRangePP $
(PP$ %
patientsPP% -
)PP- .
;PP. /
awaitRR 
contextRR 
.RR 
SaveChangesAsyncRR &
(RR& '
)RR' (
;RR( )
varTT 
usersTT 
=TT 
awaitTT 
userManagerTT %
.TT% &
UsersTT& +
.TT+ ,
ToListAsyncTT, 7
(TT7 8
)TT8 9
;TT9 :
foreachVV 
(VV 
varVV 
userVV 
inVV 
usersVV "
)VV" #
{WW 	
varXX 
resultXX 
=XX 
awaitXX 
userManagerXX *
.XX* +
DeleteAsyncXX+ 6
(XX6 7
userXX7 ;
)XX; <
;XX< =
ifZZ 
(ZZ 
!ZZ 
resultZZ 
.ZZ 
	SucceededZZ !
)ZZ! "
{[[ 
var\\ 
errors\\ 
=\\ 
string\\ #
.\\# $
Join\\$ (
(\\( )
$str\\) ,
,\\, -
result\\. 4
.\\4 5
Errors\\5 ;
.\\; <
Select\\< B
(\\B C
error\\C H
=>\\I K
error\\L Q
.\\Q R
Description\\R ]
)\\] ^
)\\^ _
;\\_ `
throw]] 
new]] %
InvalidOperationException]] 3
(]]3 4
$"]]4 6
$str]]6 S
{]]S T
user]]T X
.]]X Y
Email]]Y ^
}]]^ _
$str]]_ a
{]]a b
errors]]b h
}]]h i
"]]i j
)]]j k
;]]k l
}^^ 
}__ 	
}`` 
privatebb 
staticbb 
asyncbb 
Taskbb 
SeedAdminsAsyncbb -
(bb- .
UserManagerbb. 9
<bb9 :
IdentityUserbb: F
>bbF G
userManagerbbH S
)bbS T
{cc 
vardd 
adminsdd 
=dd 
newdd 
[dd 
]dd 
{ee 	
newff 
SeedUserff 
(ff 
PrimaryAdminEmailff *
,ff* +
$strff, 8
)ff8 9
,ff9 :
newgg 
SeedUsergg 
(gg 
$strgg :
,gg: ;
$strgg< H
)ggH I
,ggI J
newhh 
SeedUserhh 
(hh 
$strhh 7
,hh7 8
$strhh9 E
)hhE F
}ii 	
;ii	 

foreachkk 
(kk 
varkk 
adminkk 
inkk 
adminskk $
)kk$ %
{ll 	
awaitmm #
EnsureUserWithRoleAsyncmm )
(mm) *
userManagermm* 5
,mm5 6
adminmm7 <
.mm< =
Emailmm= B
,mmB C
adminmmD I
.mmI J
PhoneNumbermmJ U
,mmU V
AdminPasswordmmW d
,mmd e
AppRolesmmf n
.mmn o
Adminmmo t
,mmt u
resetPassword	mmv ƒ
:
mmƒ „
true
mm… ‰
)
mm‰ 
;
mm ‹
}nn 	
}oo 
privateqq 
staticqq 
asyncqq 
Taskqq 
<qq 
Listqq "
<qq" #
Doctorqq# )
>qq) *
>qq* +
SeedDoctorsAsyncqq, <
(qq< =
UserManagerrr 
<rr 
IdentityUserrr  
>rr  !
userManagerrr" -
,rr- .
HealthAxisDbContextss 
contextss #
)ss# $
{tt 
varuu 
todayuu 
=uu 
DateOnlyuu 
.uu 
FromDateTimeuu )
(uu) *
DateTimeuu* 2
.uu2 3
Todayuu3 8
)uu8 9
;uu9 :
varww 
doctorSeedsww 
=ww 
newww 
[ww 
]ww 
{xx 	
newyy 

SeedDoctoryy 
(yy 
$stryy )
,yy) *
PrimaryDoctorEmailyy+ =
,yy= >
$stryy? K
,yyK L 
DoctorSpecialisationyyM a
.yya b

Cardiologyyyb l
,yyl m
todayyyn s
.yys t
AddYearsyyt |
(yy| }
-yy} ~
$num	yy~ €
)
yy€ 
,
yy ‚
$num
yyƒ ‡
,
yy‡ 
true
yy‰ 
)
yy 
,
yy 
newzz 

SeedDoctorzz 
(zz 
$strzz (
,zz( )
$strzz* F
,zzF G
$strzzH T
,zzT U 
DoctorSpecialisationzzV j
.zzj k

Cardiologyzzk u
,zzu v
todayzzw |
.zz| }
AddYears	zz} …
(
zz… †
-
zz† ‡
$num
zz‡ 
)
zz ‰
,
zz‰ 
$num
zz‹ 
,
zz 
false
zz‘ –
)
zz– —
,
zz— 
new{{ 

SeedDoctor{{ 
({{ 
$str{{ '
,{{' (
$str{{) D
,{{D E
$str{{F R
,{{R S 
DoctorSpecialisation{{T h
.{{h i
Dermatology{{i t
,{{t u
today{{v {
.{{{ |
AddYears	{{| „
(
{{„ …
-
{{… †
$num
{{† ‡
)
{{‡ 
,
{{ ‰
$num
{{ 
,
{{ 
true
{{ ”
)
{{” •
,
{{• –
new|| 

SeedDoctor|| 
(|| 
$str|| )
,||) *
$str||+ H
,||H I
$str||J V
,||V W 
DoctorSpecialisation||X l
.||l m
Dermatology||m x
,||x y
today||z 
.	|| €
AddYears
||€ 
(
|| ‰
-
||‰ 
$num
|| ‹
)
||‹ 
,
|| 
$num
|| ’
,
||’ “
true
||” 
)
|| ™
,
||™ 
new}} 

SeedDoctor}} 
(}} 
$str}} (
,}}( )
$str}}* F
,}}F G
$str}}H T
,}}T U 
DoctorSpecialisation}}V j
.}}j k
	Neurology}}k t
,}}t u
today}}v {
.}}{ |
AddYears	}}| „
(
}}„ …
-
}}… †
$num
}}† 
)
}} ‰
,
}}‰ 
$num
}}‹ 
,
}} 
true
}}‘ •
)
}}• –
,
}}– —
new~~ 

SeedDoctor~~ 
(~~ 
$str~~ '
,~~' (
$str~~) D
,~~D E
$str~~F R
,~~R S 
DoctorSpecialisation~~T h
.~~h i
	Neurology~~i r
,~~r s
today~~t y
.~~y z
AddYears	~~z ‚
(
~~‚ ƒ
-
~~ƒ „
$num
~~„ †
)
~~† ‡
,
~~‡ 
$num
~~‰ 
,
~~ 
false
~~ ”
)
~~” •
,
~~• –
new 

SeedDoctor 
( 
$str )
,) *
$str+ H
,H I
$strJ V
,V W 
DoctorSpecialisationX l
.l m
Orthopaedicsm y
,y z
today	{ €
.
€ 
AddYears
 ‰
(
‰ 
-
 ‹
$num
‹ 
)
 
,
 
$num
 ”
,
” •
true
– 
)
 ›
,
› 
new
€€ 

SeedDoctor
€€ 
(
€€ 
$str
€€ )
,
€€) *
$str
€€+ H
,
€€H I
$str
€€J V
,
€€V W"
DoctorSpecialisation
€€X l
.
€€l m
Orthopaedics
€€m y
,
€€y z
today€€{ €
.€€€ 
AddYears€€ ‰
(€€‰ 
-€€ ‹
$num€€‹ 
)€€ 
,€€ 
$num€€ ”
,€€” •
true€€– 
)€€ ›
,€€› 
new
 

SeedDoctor
 
(
 
$str
 *
,
* +
$str
, J
,
J K
$str
L X
,
X Y"
DoctorSpecialisation
Z n
.
n o

Pediatrics
o y
,
y z
today{ €
.€ 
AddYears ‰
(‰ 
- ‹
$num‹ 
) 
, 
$num “
,“ ”
true• ™
)™ 
, ›
new
‚‚ 

SeedDoctor
‚‚ 
(
‚‚ 
$str
‚‚ )
,
‚‚) *
$str
‚‚+ H
,
‚‚H I
$str
‚‚J V
,
‚‚V W"
DoctorSpecialisation
‚‚X l
.
‚‚l m

Pediatrics
‚‚m w
,
‚‚w x
today
‚‚y ~
.
‚‚~ 
AddYears‚‚ ‡
(‚‚‡ 
-‚‚ ‰
$num‚‚‰ ‹
)‚‚‹ 
,‚‚ 
$num‚‚ ’
,‚‚’ “
true‚‚” 
)‚‚ ™
,‚‚™ 
new
ƒƒ 

SeedDoctor
ƒƒ 
(
ƒƒ 
$str
ƒƒ *
,
ƒƒ* +
$str
ƒƒ, J
,
ƒƒJ K
$str
ƒƒL X
,
ƒƒX Y"
DoctorSpecialisation
ƒƒZ n
.
ƒƒn o
GeneralMedicine
ƒƒo ~
,
ƒƒ~ 
todayƒƒ€ …
.ƒƒ… †
AddYearsƒƒ† 
(ƒƒ 
-ƒƒ 
$numƒƒ ’
)ƒƒ’ “
,ƒƒ“ ”
$numƒƒ• ™
,ƒƒ™ 
trueƒƒ› 
)ƒƒ  
,ƒƒ  ΅
new
„„ 

SeedDoctor
„„ 
(
„„ 
$str
„„ )
,
„„) *
$str
„„+ H
,
„„H I
$str
„„J V
,
„„V W"
DoctorSpecialisation
„„X l
.
„„l m
GeneralMedicine
„„m |
,
„„| }
today„„~ ƒ
.„„ƒ „
AddYears„„„ 
(„„ 
-„„ 
$num„„ 
)„„ ‘
,„„‘ ’
$num„„“ —
,„„— 
true„„™ 
)„„ 
,„„ 
new
…… 

SeedDoctor
…… 
(
…… 
$str
…… )
,
……) *
$str
……+ H
,
……H I
$str
……J V
,
……V W"
DoctorSpecialisation
……X l
.
……l m

Psychiatry
……m w
,
……w x
today
……y ~
.
……~ 
AddYears…… ‡
(……‡ 
-…… ‰
$num……‰ 
)…… ‹
,……‹ 
$num…… ‘
,……‘ ’
true……“ —
)……— 
,…… ™
new
†† 

SeedDoctor
†† 
(
†† 
$str
†† )
,
††) *
$str
††+ H
,
††H I
$str
††J V
,
††V W"
DoctorSpecialisation
††X l
.
††l m

Psychiatry
††m w
,
††w x
today
††y ~
.
††~ 
AddYears†† ‡
(††‡ 
-†† ‰
$num††‰ 
)†† ‹
,††‹ 
$num†† ‘
,††‘ ’
true††“ —
)††— 
,†† ™
new
‡‡ 

SeedDoctor
‡‡ 
(
‡‡ 
$str
‡‡ (
,
‡‡( )
$str
‡‡* F
,
‡‡F G
$str
‡‡H T
,
‡‡T U"
DoctorSpecialisation
‡‡V j
.
‡‡j k
	Radiology
‡‡k t
,
‡‡t u
today
‡‡v {
.
‡‡{ |
AddYears‡‡| „
(‡‡„ …
-‡‡… †
$num‡‡† ‡
)‡‡‡ 
,‡‡ ‰
$num‡‡ 
,‡‡ 
true‡‡ ”
)‡‡” •
,‡‡• –
new
 

SeedDoctor
 
(
 
$str
 )
,
) *
$str
+ H
,
H I
$str
J V
,
V W"
DoctorSpecialisation
X l
.
l m
	Radiology
m v
,
v w
today
x }
.
} ~
AddYears~ †
(† ‡
-‡ 
$num 
) ‹
,‹ 
$num ‘
,‘ ’
false“ 
) ™
,™ 
new
‰‰ 

SeedDoctor
‰‰ 
(
‰‰ 
$str
‰‰ *
,
‰‰* +
$str
‰‰, Q
,
‰‰Q R
$str
‰‰S _
,
‰‰_ `"
DoctorSpecialisation
‰‰a u
.
‰‰u v

Gynecology‰‰v €
,‰‰€ 
today‰‰‚ ‡
.‰‰‡ 
AddYears‰‰ 
(‰‰ ‘
-‰‰‘ ’
$num‰‰’ ”
)‰‰” •
,‰‰• –
$num‰‰— ›
,‰‰› 
true‰‰ ΅
)‰‰΅ Ά
,‰‰Ά £
new
 

SeedDoctor
 
(
 
$str
 (
,
( )
$str
* M
,
M N
$str
O [
,
[ \"
DoctorSpecialisation
] q
.
q r

Gynecology
r |
,
| }
today~ ƒ
.ƒ „
AddYears„ 
( 
- 
$num 
) 
, ‘
$num’ –
,– —
true 
) 
, 
new
‹‹ 

SeedDoctor
‹‹ 
(
‹‹ 
$str
‹‹ &
,
‹‹& '
$str
‹‹( I
,
‹‹I J
$str
‹‹K W
,
‹‹W X"
DoctorSpecialisation
‹‹Y m
.
‹‹m n
ENT
‹‹n q
,
‹‹q r
today
‹‹s x
.
‹‹x y
AddYears‹‹y 
(‹‹ ‚
-‹‹‚ ƒ
$num‹‹ƒ …
)‹‹… †
,‹‹† ‡
$num‹‹ 
,‹‹ 
true‹‹ ’
)‹‹’ “
,‹‹“ ”
new
 

SeedDoctor
 
(
 
$str
 )
,
) *
$str
+ O
,
O P
$str
Q ]
,
] ^"
DoctorSpecialisation
_ s
.
s t
ENT
t w
,
w x
today
y ~
.
~ 
AddYears ‡
(‡ 
- ‰
$num‰ ‹
)‹ 
, 
$num ’
,’ “
true” 
) ™
}
 	
;
	 

foreach
 
(
 
var
 
seed
 
in
 
doctorSeeds
 (
)
( )
{
 	
var
‘‘ 
user
‘‘ 
=
‘‘ 
await
‘‘ %
EnsureUserWithRoleAsync
‘‘ 4
(
‘‘4 5
userManager
‘‘5 @
,
‘‘@ A
seed
‘‘B F
.
‘‘F G
Email
‘‘G L
,
‘‘L M
seed
‘‘N R
.
‘‘R S
PhoneNumber
‘‘S ^
,
‘‘^ _
DoctorPassword
‘‘` n
,
‘‘n o
AppRoles
‘‘p x
.
‘‘x y
Doctor
‘‘y 
,‘‘ €
resetPassword‘‘ 
:‘‘ 
true‘‘ ”
)‘‘” •
;‘‘• –
var
““ 
doctor
““ 
=
““ 
new
““ 
Doctor
““ #
{
”” 
UserId
•• 
=
•• 
user
•• 
.
•• 
Id
••  
,
••  !
FullName
–– 
=
–– 
RemoveDoctorTitle
–– ,
(
––, -
seed
––- 1
.
––1 2
FullName
––2 :
)
––: ;
,
––; <
Specialisation
—— 
=
——  
seed
——! %
.
——% &
Specialisation
——& 4
,
——4 5
PracticeStartDate
 !
=
" #
seed
$ (
.
( )
PracticeStartDate
) :
,
: ;
ConsultationFee
™™ 
=
™™  !
seed
™™" &
.
™™& '
ConsultationFee
™™' 6
,
™™6 7
IsAvailable
 
=
 
seed
 "
.
" #
IsAvailable
# .
}
›› 
;
›› 
await
 
context
 
.
 
Doctors
 !
.
! "
AddAsync
" *
(
* +
doctor
+ 1
)
1 2
;
2 3
}
 	
await
   
context
   
.
   
SaveChangesAsync
   &
(
  & '
)
  ' (
;
  ( )
return
ΆΆ 
await
ΆΆ 
context
ΆΆ 
.
ΆΆ 
Doctors
ΆΆ $
.
££ 
Include
££ 
(
££ 
doctor
££ 
=>
££ 
doctor
££ %
.
££% &
User
££& *
)
££* +
.
¤¤ 
OrderBy
¤¤ 
(
¤¤ 
doctor
¤¤ 
=>
¤¤ 
doctor
¤¤ %
.
¤¤% &
Id
¤¤& (
)
¤¤( )
.
¥¥ 
ToListAsync
¥¥ 
(
¥¥ 
)
¥¥ 
;
¥¥ 
}
¦¦ 
private
¨¨ 
static
¨¨ 
async
¨¨ 
Task
¨¨ 
<
¨¨ 
List
¨¨ "
<
¨¨" #
Patient
¨¨# *
>
¨¨* +
>
¨¨+ ,
SeedPatientsAsync
¨¨- >
(
¨¨> ?
UserManager
©© 
<
©© 
IdentityUser
©©  
>
©©  !
userManager
©©" -
,
©©- .!
HealthAxisDbContext
ªª 
context
ªª #
)
ªª# $
{
«« 
var
¬¬ 
today
¬¬ 
=
¬¬ 
DateOnly
¬¬ 
.
¬¬ 
FromDateTime
¬¬ )
(
¬¬) *
DateTime
¬¬* 2
.
¬¬2 3
Today
¬¬3 8
)
¬¬8 9
;
¬¬9 :
var
®® 
patientSeeds
®® 
=
®® 
new
®® 
[
®® 
]
®®  
{
―― 	
new
°° 
SeedPatient
°° 
(
°° 
$str
°° )
,
°°) *
$str
°°+ D
,
°°D E
$str
°°F R
,
°°R S
today
°°T Y
.
°°Y Z
AddYears
°°Z b
(
°°b c
-
°°c d
$num
°°d f
)
°°f g
.
°°g h
	AddMonths
°°h q
(
°°q r
-
°°r s
$num
°°s t
)
°°t u
,
°°u v
$str
°°w }
,
°°} ~
$str°° “
)°°“ ”
,°°” •
new
±± 
SeedPatient
±± 
(
±± 
$str
±± )
,
±±) *
$str
±±+ D
,
±±D E
$str
±±F R
,
±±R S
today
±±T Y
.
±±Y Z
AddYears
±±Z b
(
±±b c
-
±±c d
$num
±±d f
)
±±f g
.
±±g h
	AddMonths
±±h q
(
±±q r
-
±±r s
$num
±±s t
)
±±t u
,
±±u v
$str
±±w 
,±± €
$str±± 
)±± ‘
,±±‘ ’
new
²² 
SeedPatient
²² 
(
²² 
$str
²² (
,
²²( )
$str
²²* B
,
²²B C
$str
²²D P
,
²²P Q
today
²²R W
.
²²W X
AddYears
²²X `
(
²²` a
-
²²a b
$num
²²b d
)
²²d e
.
²²e f
	AddMonths
²²f o
(
²²o p
-
²²p q
$num
²²q r
)
²²r s
,
²²s t
$str
²²u {
,
²²{ |
$str²²} 
)²² 
,²² 
new
³³ 
SeedPatient
³³ 
(
³³ 
$str
³³ (
,
³³( )
$str
³³* B
,
³³B C
$str
³³D P
,
³³P Q
today
³³R W
.
³³W X
AddYears
³³X `
(
³³` a
-
³³a b
$num
³³b d
)
³³d e
.
³³e f
	AddMonths
³³f o
(
³³o p
-
³³p q
$num
³³q r
)
³³r s
,
³³s t
$str
³³u }
,
³³} ~
$str³³ ‘
)³³‘ ’
,³³’ “
new
΄΄ 
SeedPatient
΄΄ 
(
΄΄ 
$str
΄΄ *
,
΄΄* +
$str
΄΄, F
,
΄΄F G
$str
΄΄H T
,
΄΄T U
today
΄΄V [
.
΄΄[ \
AddYears
΄΄\ d
(
΄΄d e
-
΄΄e f
$num
΄΄f h
)
΄΄h i
.
΄΄i j
	AddMonths
΄΄j s
(
΄΄s t
-
΄΄t u
$num
΄΄u v
)
΄΄v w
,
΄΄w x
$str
΄΄y 
,΄΄ €
$str΄΄ “
)΄΄“ ”
,΄΄” •
new
µµ 
SeedPatient
µµ 
(
µµ 
$str
µµ (
,
µµ( )
$str
µµ* B
,
µµB C
$str
µµD P
,
µµP Q
today
µµR W
.
µµW X
AddYears
µµX `
(
µµ` a
-
µµa b
$num
µµb d
)
µµd e
.
µµe f
	AddMonths
µµf o
(
µµo p
-
µµp q
$num
µµq r
)
µµr s
,
µµs t
$str
µµu }
,
µµ} ~
$strµµ ’
)µµ’ “
,µµ“ ”
new
¶¶ 
SeedPatient
¶¶ 
(
¶¶ 
$str
¶¶ +
,
¶¶+ ,
$str
¶¶- H
,
¶¶H I
$str
¶¶J V
,
¶¶V W
today
¶¶X ]
.
¶¶] ^
AddYears
¶¶^ f
(
¶¶f g
-
¶¶g h
$num
¶¶h j
)
¶¶j k
.
¶¶k l
	AddMonths
¶¶l u
(
¶¶u v
-
¶¶v w
$num
¶¶w x
)
¶¶x y
,
¶¶y z
$str¶¶{ ƒ
,¶¶ƒ „
$str¶¶… —
)¶¶— 
,¶¶ ™
new
·· 
SeedPatient
·· 
(
·· 
$str
·· )
,
··) *
$str
··+ D
,
··D E
$str
··F R
,
··R S
today
··T Y
.
··Y Z
AddYears
··Z b
(
··b c
-
··c d
$num
··d f
)
··f g
.
··g h
	AddMonths
··h q
(
··q r
-
··r s
$num
··s t
)
··t u
,
··u v
$str
··w }
,
··} ~
$str·· 
)·· 
,·· ‘
new
ΈΈ 
SeedPatient
ΈΈ 
(
ΈΈ 
$str
ΈΈ '
,
ΈΈ' (
$str
ΈΈ) @
,
ΈΈ@ A
$str
ΈΈB N
,
ΈΈN O
today
ΈΈP U
.
ΈΈU V
AddYears
ΈΈV ^
(
ΈΈ^ _
-
ΈΈ_ `
$num
ΈΈ` b
)
ΈΈb c
.
ΈΈc d
	AddMonths
ΈΈd m
(
ΈΈm n
-
ΈΈn o
$num
ΈΈo p
)
ΈΈp q
,
ΈΈq r
$str
ΈΈs {
,
ΈΈ{ |
$strΈΈ} 
)ΈΈ 
,ΈΈ 
new
ΉΉ 
SeedPatient
ΉΉ 
(
ΉΉ 
$str
ΉΉ '
,
ΉΉ' (
$str
ΉΉ) @
,
ΉΉ@ A
$str
ΉΉB N
,
ΉΉN O
today
ΉΉP U
.
ΉΉU V
AddYears
ΉΉV ^
(
ΉΉ^ _
-
ΉΉ_ `
$num
ΉΉ` b
)
ΉΉb c
.
ΉΉc d
	AddMonths
ΉΉd m
(
ΉΉm n
-
ΉΉn o
$num
ΉΉo p
)
ΉΉp q
,
ΉΉq r
$str
ΉΉs y
,
ΉΉy z
$strΉΉ{ 
)ΉΉ 
,ΉΉ ‘
new
ΊΊ 
SeedPatient
ΊΊ 
(
ΊΊ 
$str
ΊΊ )
,
ΊΊ) *
$str
ΊΊ+ D
,
ΊΊD E
$str
ΊΊF R
,
ΊΊR S
today
ΊΊT Y
.
ΊΊY Z
AddYears
ΊΊZ b
(
ΊΊb c
-
ΊΊc d
$num
ΊΊd f
)
ΊΊf g
.
ΊΊg h
	AddMonths
ΊΊh q
(
ΊΊq r
-
ΊΊr s
$num
ΊΊs t
)
ΊΊt u
,
ΊΊu v
$str
ΊΊw 
,ΊΊ €
$strΊΊ ™
)ΊΊ™ 
,ΊΊ ›
new
»» 
SeedPatient
»» 
(
»» 
$str
»» )
,
»») *
$str
»»+ D
,
»»D E
$str
»»F R
,
»»R S
today
»»T Y
.
»»Y Z
AddYears
»»Z b
(
»»b c
-
»»c d
$num
»»d f
)
»»f g
.
»»g h
	AddMonths
»»h q
(
»»q r
-
»»r s
$num
»»s t
)
»»t u
,
»»u v
$str
»»w }
,
»»} ~
$str»» 
)»» 
,»» ‘
new
ΌΌ 
SeedPatient
ΌΌ 
(
ΌΌ 
$str
ΌΌ .
,
ΌΌ. /
$str
ΌΌ0 N
,
ΌΌN O
$str
ΌΌP \
,
ΌΌ\ ]
today
ΌΌ^ c
.
ΌΌc d
AddYears
ΌΌd l
(
ΌΌl m
-
ΌΌm n
$num
ΌΌn p
)
ΌΌp q
.
ΌΌq r
	AddMonths
ΌΌr {
(
ΌΌ{ |
-
ΌΌ| }
$num
ΌΌ} ~
)
ΌΌ~ 
,ΌΌ €
$strΌΌ ‰
,ΌΌ‰ 
$strΌΌ‹ 
)ΌΌ 
,ΌΌ 
new
½½ 
SeedPatient
½½ 
(
½½ 
$str
½½ ,
,
½½, -
$str
½½. J
,
½½J K
$str
½½L X
,
½½X Y
today
½½Z _
.
½½_ `
AddYears
½½` h
(
½½h i
-
½½i j
$num
½½j l
)
½½l m
.
½½m n
	AddMonths
½½n w
(
½½w x
-
½½x y
$num
½½y z
)
½½z {
,
½½{ |
$str½½} ƒ
,½½ƒ „
$str½½… —
)½½— 
,½½ ™
new
ΎΎ 
SeedPatient
ΎΎ 
(
ΎΎ 
$str
ΎΎ )
,
ΎΎ) *
$str
ΎΎ+ D
,
ΎΎD E
$str
ΎΎF R
,
ΎΎR S
today
ΎΎT Y
.
ΎΎY Z
AddYears
ΎΎZ b
(
ΎΎb c
-
ΎΎc d
$num
ΎΎd f
)
ΎΎf g
.
ΎΎg h
	AddMonths
ΎΎh q
(
ΎΎq r
-
ΎΎr s
$num
ΎΎs t
)
ΎΎt u
,
ΎΎu v
$str
ΎΎw 
,ΎΎ €
$strΎΎ ”
)ΎΎ” •
,ΎΎ• –
new
ΏΏ 
SeedPatient
ΏΏ 
(
ΏΏ 
$str
ΏΏ *
,
ΏΏ* +
$str
ΏΏ, F
,
ΏΏF G
$str
ΏΏH T
,
ΏΏT U
today
ΏΏV [
.
ΏΏ[ \
AddYears
ΏΏ\ d
(
ΏΏd e
-
ΏΏe f
$num
ΏΏf h
)
ΏΏh i
.
ΏΏi j
	AddMonths
ΏΏj s
(
ΏΏs t
-
ΏΏt u
$num
ΏΏu v
)
ΏΏv w
,
ΏΏw x
$str
ΏΏy 
,ΏΏ €
$strΏΏ •
)ΏΏ• –
,ΏΏ– —
new
ΐΐ 
SeedPatient
ΐΐ 
(
ΐΐ 
$str
ΐΐ &
,
ΐΐ& '
$str
ΐΐ( >
,
ΐΐ> ?
$str
ΐΐ@ L
,
ΐΐL M
today
ΐΐN S
.
ΐΐS T
AddYears
ΐΐT \
(
ΐΐ\ ]
-
ΐΐ] ^
$num
ΐΐ^ `
)
ΐΐ` a
.
ΐΐa b
	AddMonths
ΐΐb k
(
ΐΐk l
-
ΐΐl m
$num
ΐΐm n
)
ΐΐn o
,
ΐΐo p
$str
ΐΐq y
,
ΐΐy z
$strΐΐ{ ‘
)ΐΐ‘ ’
,ΐΐ’ “
new
ΑΑ 
SeedPatient
ΑΑ 
(
ΑΑ 
$str
ΑΑ .
,
ΑΑ. /
$str
ΑΑ0 N
,
ΑΑN O
$str
ΑΑP \
,
ΑΑ\ ]
today
ΑΑ^ c
.
ΑΑc d
AddYears
ΑΑd l
(
ΑΑl m
-
ΑΑm n
$num
ΑΑn p
)
ΑΑp q
.
ΑΑq r
	AddMonths
ΑΑr {
(
ΑΑ{ |
-
ΑΑ| }
$num
ΑΑ} ~
)
ΑΑ~ 
,ΑΑ €
$strΑΑ ‡
,ΑΑ‡ 
$strΑΑ‰ ›
)ΑΑ› 
}
ΒΒ 	
;
ΒΒ	 

foreach
ΔΔ 
(
ΔΔ 
var
ΔΔ 
seed
ΔΔ 
in
ΔΔ 
patientSeeds
ΔΔ )
)
ΔΔ) *
{
ΕΕ 	
var
ΖΖ 
user
ΖΖ 
=
ΖΖ 
await
ΖΖ %
EnsureUserWithRoleAsync
ΖΖ 4
(
ΖΖ4 5
userManager
ΖΖ5 @
,
ΖΖ@ A
seed
ΖΖB F
.
ΖΖF G
Email
ΖΖG L
,
ΖΖL M
seed
ΖΖN R
.
ΖΖR S
PhoneNumber
ΖΖS ^
,
ΖΖ^ _
PatientPassword
ΖΖ` o
,
ΖΖo p
AppRoles
ΖΖq y
.
ΖΖy z
PatientΖΖz 
,ΖΖ ‚
resetPasswordΖΖƒ 
:ΖΖ ‘
trueΖΖ’ –
)ΖΖ– —
;ΖΖ— 
var
ΘΘ 
patient
ΘΘ 
=
ΘΘ 
new
ΘΘ 
Patient
ΘΘ %
{
ΙΙ 
UserId
ΚΚ 
=
ΚΚ 
user
ΚΚ 
.
ΚΚ 
Id
ΚΚ  
,
ΚΚ  !
FullName
ΛΛ 
=
ΛΛ 
seed
ΛΛ 
.
ΛΛ  
FullName
ΛΛ  (
,
ΛΛ( )
DateOfBirth
ΜΜ 
=
ΜΜ 
seed
ΜΜ "
.
ΜΜ" #
DateOfBirth
ΜΜ# .
,
ΜΜ. /
Gender
ΝΝ 
=
ΝΝ 
seed
ΝΝ 
.
ΝΝ 
Gender
ΝΝ $
,
ΝΝ$ %
Address
ΞΞ 
=
ΞΞ 
seed
ΞΞ 
.
ΞΞ 
Address
ΞΞ &
}
ΟΟ 
;
ΟΟ 
await
ΡΡ 
context
ΡΡ 
.
ΡΡ 
Patients
ΡΡ "
.
ΡΡ" #
AddAsync
ΡΡ# +
(
ΡΡ+ ,
patient
ΡΡ, 3
)
ΡΡ3 4
;
ΡΡ4 5
}
ÒÒ 	
await
ΤΤ 
context
ΤΤ 
.
ΤΤ 
SaveChangesAsync
ΤΤ &
(
ΤΤ& '
)
ΤΤ' (
;
ΤΤ( )
return
ΦΦ 
await
ΦΦ 
context
ΦΦ 
.
ΦΦ 
Patients
ΦΦ %
.
ΧΧ 
Include
ΧΧ 
(
ΧΧ 
patient
ΧΧ 
=>
ΧΧ 
patient
ΧΧ  '
.
ΧΧ' (
User
ΧΧ( ,
)
ΧΧ, -
.
ΨΨ 
OrderBy
ΨΨ 
(
ΨΨ 
patient
ΨΨ 
=>
ΨΨ 
patient
ΨΨ  '
.
ΨΨ' (
Id
ΨΨ( *
)
ΨΨ* +
.
ΩΩ 
ToListAsync
ΩΩ 
(
ΩΩ 
)
ΩΩ 
;
ΩΩ 
}
ΪΪ 
private
άά 
static
άά 
async
άά 
Task
άά 3
%SeedAppointmentsAndHealthRecordsAsync
άά C
(
άάC D!
HealthAxisDbContext
έέ 
context
έέ #
,
έέ# $
IReadOnlyList
ήή 
<
ήή 
Doctor
ήή 
>
ήή 
doctors
ήή %
,
ήή% &
IReadOnlyList
ίί 
<
ίί 
Patient
ίί 
>
ίί 
patients
ίί '
)
ίί' (
{
ΰΰ 
if
αα 

(
αα 
doctors
αα 
.
αα 
Count
αα 
==
αα 
$num
αα 
||
αα !
patients
αα" *
.
αα* +
Count
αα+ 0
==
αα1 3
$num
αα4 5
)
αα5 6
{
ββ 	
return
γγ 
;
γγ 
}
δδ 	
var
ζζ 
today
ζζ 
=
ζζ 
DateOnly
ζζ 
.
ζζ 
FromDateTime
ζζ )
(
ζζ) *
DateTime
ζζ* 2
.
ζζ2 3
Today
ζζ3 8
)
ζζ8 9
;
ζζ9 :
var
ηη 
doctorByEmail
ηη 
=
ηη 
doctors
ηη #
.
θθ 
Where
θθ 
(
θθ 
doctor
θθ 
=>
θθ 
doctor
θθ #
.
θθ# $
User
θθ$ (
?
θθ( )
.
θθ) *
Email
θθ* /
is
θθ0 2
not
θθ3 6
null
θθ7 ;
)
θθ; <
.
ιι 
ToDictionary
ιι 
(
ιι 
doctor
ιι  
=>
ιι! #
doctor
ιι$ *
.
ιι* +
User
ιι+ /
!
ιι/ 0
.
ιι0 1
Email
ιι1 6
!
ιι6 7
,
ιι7 8
StringComparer
ιι9 G
.
ιιG H
OrdinalIgnoreCase
ιιH Y
)
ιιY Z
;
ιιZ [
var
λλ $
doctorBySpecialisation
λλ "
=
λλ# $
doctors
λλ% ,
.
μμ 
GroupBy
μμ 
(
μμ 
doctor
μμ 
=>
μμ 
doctor
μμ %
.
μμ% &
Specialisation
μμ& 4
)
μμ4 5
.
νν 
ToDictionary
νν 
(
νν 
group
νν 
=>
νν  "
group
νν# (
.
νν( )
Key
νν) ,
,
νν, -
group
νν. 3
=>
νν4 6
group
νν7 <
.
νν< =
First
νν= B
(
ννB C
)
ννC D
)
ννD E
;
ννE F
var
οο 
appointmentSeeds
οο 
=
οο #
BuildAppointmentSeeds
οο 4
(
οο4 5
today
οο5 :
,
οο: ;
doctorByEmail
οο< I
,
οοI J$
doctorBySpecialisation
οοK a
,
οοa b
patients
οοc k
)
οοk l
;
οοl m
var
ππ .
 completedAppointmentsWithRecords
ππ ,
=
ππ- .
new
ππ/ 2
List
ππ3 7
<
ππ7 8
(
ππ8 9
Appointment
ππ9 D
Appointment
ππE P
,
ππP Q
SeedAppointment
ππR a
Seed
ππb f
)
ππf g
>
ππg h
(
ππh i
)
ππi j
;
ππj k
foreach
ςς 
(
ςς 
var
ςς 
seed
ςς 
in
ςς 
appointmentSeeds
ςς -
)
ςς- .
{
σσ 	
var
ττ 
appointment
ττ 
=
ττ 
new
ττ !
Appointment
ττ" -
{
υυ 
	PatientId
φφ 
=
φφ 
seed
φφ  
.
φφ  !
Patient
φφ! (
.
φφ( )
Id
φφ) +
,
φφ+ ,
DoctorId
χχ 
=
χχ 
seed
χχ 
.
χχ  
Doctor
χχ  &
.
χχ& '
Id
χχ' )
,
χχ) *
AppointmentDate
ψψ 
=
ψψ  !
seed
ψψ" &
.
ψψ& '
Date
ψψ' +
,
ψψ+ ,
AppointmentTime
ωω 
=
ωω  !
seed
ωω" &
.
ωω& '
Time
ωω' +
,
ωω+ ,
Status
ϊϊ 
=
ϊϊ 
seed
ϊϊ 
.
ϊϊ 
Status
ϊϊ $
,
ϊϊ$ % 
CancellationReason
ϋϋ "
=
ϋϋ# $
seed
ϋϋ% )
.
ϋϋ) * 
CancellationReason
ϋϋ* <
}
όό 
;
όό 
await
ώώ 
context
ώώ 
.
ώώ 
Appointments
ώώ &
.
ώώ& '
AddAsync
ώώ' /
(
ώώ/ 0
appointment
ώώ0 ;
)
ώώ; <
;
ώώ< =
if
€€ 
(
€€ 
seed
€€ 
.
€€ 
HealthRecord
€€ !
!=
€€" $
null
€€% )
&&
€€* ,
seed
€€- 1
.
€€1 2
Status
€€2 8
==
€€9 ;
AppointmentStatus
€€< M
.
€€M N
	Completed
€€N W
)
€€W X
{
 .
 completedAppointmentsWithRecords
‚‚ 0
.
‚‚0 1
Add
‚‚1 4
(
‚‚4 5
(
‚‚5 6
appointment
‚‚6 A
,
‚‚A B
seed
‚‚C G
)
‚‚G H
)
‚‚H I
;
‚‚I J
}
ƒƒ 
}
„„ 	
await
†† 
context
†† 
.
†† 
SaveChangesAsync
†† &
(
††& '
)
††' (
;
††( )
foreach
 
(
 
var
 
(
 
appointment
 !
,
! "
seed
# '
)
' (
in
) +.
 completedAppointmentsWithRecords
, L
)
L M
{
‰‰ 	
var
 

seedRecord
 
=
 
seed
 !
.
! "
HealthRecord
" .
!
. /
;
/ 0
await
 
context
 
.
 
HealthRecords
 '
.
' (
AddAsync
( 0
(
0 1
new
1 4
HealthRecord
5 A
{
 
AppointmentId
 
=
 
appointment
  +
.
+ ,
Id
, .
,
. /

PatientAge
 
=
 
CalculateAge
 )
(
) *
seed
* .
.
. /
Patient
/ 6
.
6 7
DateOfBirth
7 B
,
B C
appointment
D O
.
O P
AppointmentDate
P _
)
_ `
,
` a
	VisitDate
 
=
 

seedRecord
 &
.
& '
	VisitDate
' 0
,
0 1
	Diagnosis
‘‘ 
=
‘‘ 

seedRecord
‘‘ &
.
‘‘& '
	Diagnosis
‘‘' 0
,
‘‘0 1
Prescription
’’ 
=
’’ 

seedRecord
’’ )
.
’’) *
Prescription
’’* 6
,
’’6 7
Notes
““ 
=
““ 

seedRecord
““ "
.
““" #
Notes
““# (
}
”” 
)
”” 
;
”” 
}
•• 	
await
—— 
context
—— 
.
—— 
SaveChangesAsync
—— &
(
——& '
)
——' (
;
——( )
}
 
private
 
static
 
IReadOnlyList
  
<
  !
SeedAppointment
! 0
>
0 1#
BuildAppointmentSeeds
2 G
(
G H
DateOnly
›› 
today
›› 
,
›› !
IReadOnlyDictionary
 
<
 
string
 "
,
" #
Doctor
$ *
>
* +
doctorByEmail
, 9
,
9 :!
IReadOnlyDictionary
 
<
 "
DoctorSpecialisation
 0
,
0 1
Doctor
2 8
>
8 9$
doctorBySpecialisation
: P
,
P Q
IReadOnlyList
 
<
 
Patient
 
>
 
patients
 '
)
' (
{
 
Doctor
   
Anjali
   
(
   
)
   
=>
   
doctorByEmail
   (
[
  ( ) 
PrimaryDoctorEmail
  ) ;
]
  ; <
;
  < =
Doctor
΅΅ 
Doctor
΅΅ 
(
΅΅ "
DoctorSpecialisation
΅΅ *
specialisation
΅΅+ 9
)
΅΅9 :
=>
΅΅; =$
doctorBySpecialisation
΅΅> T
[
΅΅T U
specialisation
΅΅U c
]
΅΅c d
;
΅΅d e
Patient
ΆΆ 
Patient
ΆΆ 
(
ΆΆ 
int
ΆΆ 
index
ΆΆ !
)
ΆΆ! "
=>
ΆΆ# %
patients
ΆΆ& .
[
ΆΆ. /
index
ΆΆ/ 4
%
ΆΆ5 6
patients
ΆΆ7 ?
.
ΆΆ? @
Count
ΆΆ@ E
]
ΆΆE F
;
ΆΆF G
return
¤¤ 
[
¥¥ 	
new
§§ 
(
§§ 
Patient
§§ 
(
§§ 
$num
§§ 
)
§§ 
,
§§ 
Anjali
§§ "
(
§§" #
)
§§# $
,
§§$ %
today
§§& +
.
§§+ ,
AddDays
§§, 3
(
§§3 4
-
§§4 5
$num
§§5 8
)
§§8 9
,
§§9 :
new
§§; >
TimeOnly
§§? G
(
§§G H
$num
§§H I
,
§§I J
$num
§§K L
)
§§L M
,
§§M N
AppointmentStatus
§§O `
.
§§` a
	Completed
§§a j
,
§§j k
null
§§l p
,
§§p q
new
¨¨ 
SeedHealthRecord
¨¨ $
(
¨¨$ %
today
¨¨% *
.
¨¨* +
AddDays
¨¨+ 2
(
¨¨2 3
-
¨¨3 4
$num
¨¨4 7
)
¨¨7 8
,
¨¨8 9
$str
¨¨: \
,
¨¨\ ]
$str¨¨^ 
,¨¨ ›
$str¨¨ Κ
)¨¨Κ Λ
)¨¨Λ Μ
,¨¨Μ Ν
new
©© 
(
©© 
Patient
©© 
(
©© 
$num
©© 
)
©© 
,
©© 
Anjali
©© "
(
©©" #
)
©©# $
,
©©$ %
today
©©& +
.
©©+ ,
AddDays
©©, 3
(
©©3 4
-
©©4 5
$num
©©5 8
)
©©8 9
,
©©9 :
new
©©; >
TimeOnly
©©? G
(
©©G H
$num
©©H I
,
©©I J
$num
©©K M
)
©©M N
,
©©N O
AppointmentStatus
©©P a
.
©©a b
	Completed
©©b k
,
©©k l
null
©©m q
,
©©q r
new
ªª 
SeedHealthRecord
ªª $
(
ªª$ %
today
ªª% *
.
ªª* +
AddDays
ªª+ 2
(
ªª2 3
-
ªª3 4
$num
ªª4 7
)
ªª7 8
,
ªª8 9
$str
ªª: Q
,
ªªQ R
$strªªS ‡
,ªª‡ 
$strªª‰ Β
)ªªΒ Γ
)ªªΓ Δ
,ªªΔ Ε
new
«« 
(
«« 
Patient
«« 
(
«« 
$num
«« 
)
«« 
,
«« 
Anjali
«« "
(
««" #
)
««# $
,
««$ %
today
««& +
.
««+ ,
AddDays
««, 3
(
««3 4
-
««4 5
$num
««5 7
)
««7 8
,
««8 9
new
««: =
TimeOnly
««> F
(
««F G
$num
««G I
,
««I J
$num
««K L
)
««L M
,
««M N
AppointmentStatus
««O `
.
««` a
	Completed
««a j
,
««j k
null
««l p
,
««p q
new
¬¬ 
SeedHealthRecord
¬¬ $
(
¬¬$ %
today
¬¬% *
.
¬¬* +
AddDays
¬¬+ 2
(
¬¬2 3
-
¬¬3 4
$num
¬¬4 6
)
¬¬6 7
,
¬¬7 8
$str
¬¬9 Z
,
¬¬Z [
$str¬¬\ 
,¬¬ 
$str¬¬  η
)¬¬η θ
)¬¬θ ι
,¬¬ι κ
new
­­ 
(
­­ 
Patient
­­ 
(
­­ 
$num
­­ 
)
­­ 
,
­­ 
Anjali
­­ "
(
­­" #
)
­­# $
,
­­$ %
today
­­& +
.
­­+ ,
AddDays
­­, 3
(
­­3 4
-
­­4 5
$num
­­5 7
)
­­7 8
,
­­8 9
new
­­: =
TimeOnly
­­> F
(
­­F G
$num
­­G H
,
­­H I
$num
­­J L
)
­­L M
,
­­M N
AppointmentStatus
­­O `
.
­­` a
	Completed
­­a j
,
­­j k
null
­­l p
,
­­p q
new
®® 
SeedHealthRecord
®® $
(
®®$ %
today
®®% *
.
®®* +
AddDays
®®+ 2
(
®®2 3
-
®®3 4
$num
®®4 6
)
®®6 7
,
®®7 8
$str
®®9 Q
,
®®Q R
$str®®S „
,®®„ …
$str®®† Ν
)®®Ν Ξ
)®®Ξ Ο
,®®Ο Π
new
―― 
(
―― 
Patient
―― 
(
―― 
$num
―― 
)
―― 
,
―― 
Anjali
―― "
(
――" #
)
――# $
,
――$ %
today
――& +
.
――+ ,
AddDays
――, 3
(
――3 4
-
――4 5
$num
――5 7
)
――7 8
,
――8 9
new
――: =
TimeOnly
――> F
(
――F G
$num
――G I
,
――I J
$num
――K L
)
――L M
,
――M N
AppointmentStatus
――O `
.
――` a
	Completed
――a j
,
――j k
null
――l p
,
――p q
new
°° 
SeedHealthRecord
°° $
(
°°$ %
today
°°% *
.
°°* +
AddDays
°°+ 2
(
°°2 3
-
°°3 4
$num
°°4 6
)
°°6 7
,
°°7 8
$str
°°9 R
,
°°R S
$str°°T ‡
,°°‡ 
$str°°‰ Π
)°°Π Ρ
)°°Ρ Ò
,°°Ò Σ
new
²² 
(
²² 
Patient
²² 
(
²² 
$num
²² 
)
²² 
,
²² 
Anjali
²² "
(
²²" #
)
²²# $
,
²²$ %
today
²²& +
.
²²+ ,
AddDays
²², 3
(
²²3 4
-
²²4 5
$num
²²5 8
)
²²8 9
,
²²9 :
new
²²; >
TimeOnly
²²? G
(
²²G H
$num
²²H J
,
²²J K
$num
²²L M
)
²²M N
,
²²N O
AppointmentStatus
²²P a
.
²²a b
	Completed
²²b k
,
²²k l
null
²²m q
,
²²q r
new
³³ 
SeedHealthRecord
³³ $
(
³³$ %
today
³³% *
.
³³* +
AddDays
³³+ 2
(
³³2 3
-
³³3 4
$num
³³4 7
)
³³7 8
,
³³8 9
$str
³³: ]
,
³³] ^
$str³³_ 
,³³ 
$str³³ Λ
)³³Λ Μ
)³³Μ Ν
,³³Ν Ξ
new
΄΄ 
(
΄΄ 
Patient
΄΄ 
(
΄΄ 
$num
΄΄ 
)
΄΄ 
,
΄΄ 
Anjali
΄΄ "
(
΄΄" #
)
΄΄# $
,
΄΄$ %
today
΄΄& +
.
΄΄+ ,
AddDays
΄΄, 3
(
΄΄3 4
-
΄΄4 5
$num
΄΄5 7
)
΄΄7 8
,
΄΄8 9
new
΄΄: =
TimeOnly
΄΄> F
(
΄΄F G
$num
΄΄G I
,
΄΄I J
$num
΄΄K M
)
΄΄M N
,
΄΄N O
AppointmentStatus
΄΄P a
.
΄΄a b
	Completed
΄΄b k
,
΄΄k l
null
΄΄m q
,
΄΄q r
new
µµ 
SeedHealthRecord
µµ $
(
µµ$ %
today
µµ% *
.
µµ* +
AddDays
µµ+ 2
(
µµ2 3
-
µµ3 4
$num
µµ4 6
)
µµ6 7
,
µµ7 8
$str
µµ9 R
,
µµR S
$strµµT 
,µµ ‚
$strµµƒ ½
)µµ½ Ύ
)µµΎ Ώ
,µµΏ ΐ
new
¶¶ 
(
¶¶ 
Patient
¶¶ 
(
¶¶ 
$num
¶¶ 
)
¶¶ 
,
¶¶ 
Anjali
¶¶ "
(
¶¶" #
)
¶¶# $
,
¶¶$ %
today
¶¶& +
.
¶¶+ ,
AddDays
¶¶, 3
(
¶¶3 4
-
¶¶4 5
$num
¶¶5 7
)
¶¶7 8
,
¶¶8 9
new
¶¶: =
TimeOnly
¶¶> F
(
¶¶F G
$num
¶¶G I
,
¶¶I J
$num
¶¶K L
)
¶¶L M
,
¶¶M N
AppointmentStatus
¶¶O `
.
¶¶` a
	Completed
¶¶a j
,
¶¶j k
null
¶¶l p
,
¶¶p q
new
·· 
SeedHealthRecord
·· $
(
··$ %
today
··% *
.
··* +
AddDays
··+ 2
(
··2 3
-
··3 4
$num
··4 6
)
··6 7
,
··7 8
$str
··9 Q
,
··Q R
$str··S ‹
,··‹ 
$str·· Μ
)··Μ Ν
)··Ν Ξ
,··Ξ Ο
new
ΉΉ 
(
ΉΉ 
Patient
ΉΉ 
(
ΉΉ 
$num
ΉΉ 
)
ΉΉ 
,
ΉΉ 
Anjali
ΉΉ "
(
ΉΉ" #
)
ΉΉ# $
,
ΉΉ$ %
today
ΉΉ& +
.
ΉΉ+ ,
AddDays
ΉΉ, 3
(
ΉΉ3 4
-
ΉΉ4 5
$num
ΉΉ5 8
)
ΉΉ8 9
,
ΉΉ9 :
new
ΉΉ; >
TimeOnly
ΉΉ? G
(
ΉΉG H
$num
ΉΉH J
,
ΉΉJ K
$num
ΉΉL M
)
ΉΉM N
,
ΉΉN O
AppointmentStatus
ΉΉP a
.
ΉΉa b
	Completed
ΉΉb k
,
ΉΉk l
null
ΉΉm q
,
ΉΉq r
new
ΊΊ 
SeedHealthRecord
ΊΊ $
(
ΊΊ$ %
today
ΊΊ% *
.
ΊΊ* +
AddDays
ΊΊ+ 2
(
ΊΊ2 3
-
ΊΊ3 4
$num
ΊΊ4 7
)
ΊΊ7 8
,
ΊΊ8 9
$str
ΊΊ: T
,
ΊΊT U
$strΊΊV 
,ΊΊ ‘
$strΊΊ’ Ό
)ΊΊΌ ½
)ΊΊ½ Ύ
,ΊΊΎ Ώ
new
»» 
(
»» 
Patient
»» 
(
»» 
$num
»» 
)
»» 
,
»» 
Anjali
»» "
(
»»" #
)
»»# $
,
»»$ %
today
»»& +
.
»»+ ,
AddDays
»», 3
(
»»3 4
-
»»4 5
$num
»»5 7
)
»»7 8
,
»»8 9
new
»»: =
TimeOnly
»»> F
(
»»F G
$num
»»G I
,
»»I J
$num
»»K M
)
»»M N
,
»»N O
AppointmentStatus
»»P a
.
»»a b
	Completed
»»b k
,
»»k l
null
»»m q
,
»»q r
new
ΌΌ 
SeedHealthRecord
ΌΌ $
(
ΌΌ$ %
today
ΌΌ% *
.
ΌΌ* +
AddDays
ΌΌ+ 2
(
ΌΌ2 3
-
ΌΌ3 4
$num
ΌΌ4 6
)
ΌΌ6 7
,
ΌΌ7 8
$str
ΌΌ9 O
,
ΌΌO P
$str
ΌΌQ z
,
ΌΌz {
$strΌΌ| ­
)ΌΌ­ ®
)ΌΌ® ―
,ΌΌ― °
new
½½ 
(
½½ 
Patient
½½ 
(
½½ 
$num
½½ 
)
½½ 
,
½½ 
Anjali
½½ "
(
½½" #
)
½½# $
,
½½$ %
today
½½& +
.
½½+ ,
AddDays
½½, 3
(
½½3 4
-
½½4 5
$num
½½5 7
)
½½7 8
,
½½8 9
new
½½: =
TimeOnly
½½> F
(
½½F G
$num
½½G I
,
½½I J
$num
½½K L
)
½½L M
,
½½M N
AppointmentStatus
½½O `
.
½½` a
	Completed
½½a j
,
½½j k
null
½½l p
,
½½p q
new
ΎΎ 
SeedHealthRecord
ΎΎ $
(
ΎΎ$ %
today
ΎΎ% *
.
ΎΎ* +
AddDays
ΎΎ+ 2
(
ΎΎ2 3
-
ΎΎ3 4
$num
ΎΎ4 6
)
ΎΎ6 7
,
ΎΎ7 8
$str
ΎΎ9 W
,
ΎΎW X
$strΎΎY ‰
,ΎΎ‰ 
$strΎΎ‹ °
)ΎΎ° ±
)ΎΎ± ²
,ΎΎ² ³
new
ΐΐ 
(
ΐΐ 
Patient
ΐΐ 
(
ΐΐ 
$num
ΐΐ 
)
ΐΐ 
,
ΐΐ 
Anjali
ΐΐ "
(
ΐΐ" #
)
ΐΐ# $
,
ΐΐ$ %
today
ΐΐ& +
.
ΐΐ+ ,
AddDays
ΐΐ, 3
(
ΐΐ3 4
-
ΐΐ4 5
$num
ΐΐ5 8
)
ΐΐ8 9
,
ΐΐ9 :
new
ΐΐ; >
TimeOnly
ΐΐ? G
(
ΐΐG H
$num
ΐΐH J
,
ΐΐJ K
$num
ΐΐL M
)
ΐΐM N
,
ΐΐN O
AppointmentStatus
ΐΐP a
.
ΐΐa b
	Completed
ΐΐb k
,
ΐΐk l
null
ΐΐm q
,
ΐΐq r
new
ΑΑ 
SeedHealthRecord
ΑΑ $
(
ΑΑ$ %
today
ΑΑ% *
.
ΑΑ* +
AddDays
ΑΑ+ 2
(
ΑΑ2 3
-
ΑΑ3 4
$num
ΑΑ4 7
)
ΑΑ7 8
,
ΑΑ8 9
$str
ΑΑ: ]
,
ΑΑ] ^
$strΑΑ_ ‰
,ΑΑ‰ 
$strΑΑ‹ ·
)ΑΑ· Έ
)ΑΑΈ Ή
,ΑΑΉ Ί
new
ΒΒ 
(
ΒΒ 
Patient
ΒΒ 
(
ΒΒ 
$num
ΒΒ 
)
ΒΒ 
,
ΒΒ 
Anjali
ΒΒ "
(
ΒΒ" #
)
ΒΒ# $
,
ΒΒ$ %
today
ΒΒ& +
.
ΒΒ+ ,
AddDays
ΒΒ, 3
(
ΒΒ3 4
-
ΒΒ4 5
$num
ΒΒ5 7
)
ΒΒ7 8
,
ΒΒ8 9
new
ΒΒ: =
TimeOnly
ΒΒ> F
(
ΒΒF G
$num
ΒΒG I
,
ΒΒI J
$num
ΒΒK M
)
ΒΒM N
,
ΒΒN O
AppointmentStatus
ΒΒP a
.
ΒΒa b
	Completed
ΒΒb k
,
ΒΒk l
null
ΒΒm q
,
ΒΒq r
new
ΓΓ 
SeedHealthRecord
ΓΓ $
(
ΓΓ$ %
today
ΓΓ% *
.
ΓΓ* +
AddDays
ΓΓ+ 2
(
ΓΓ2 3
-
ΓΓ3 4
$num
ΓΓ4 6
)
ΓΓ6 7
,
ΓΓ7 8
$str
ΓΓ9 _
,
ΓΓ_ `
$strΓΓa ”
,ΓΓ” •
$strΓΓ– ³
)ΓΓ³ ΄
)ΓΓ΄ µ
,ΓΓµ ¶
new
ΔΔ 
(
ΔΔ 
Patient
ΔΔ 
(
ΔΔ 
$num
ΔΔ 
)
ΔΔ 
,
ΔΔ 
Anjali
ΔΔ "
(
ΔΔ" #
)
ΔΔ# $
,
ΔΔ$ %
today
ΔΔ& +
.
ΔΔ+ ,
AddDays
ΔΔ, 3
(
ΔΔ3 4
-
ΔΔ4 5
$num
ΔΔ5 7
)
ΔΔ7 8
,
ΔΔ8 9
new
ΔΔ: =
TimeOnly
ΔΔ> F
(
ΔΔF G
$num
ΔΔG I
,
ΔΔI J
$num
ΔΔK L
)
ΔΔL M
,
ΔΔM N
AppointmentStatus
ΔΔO `
.
ΔΔ` a
	Completed
ΔΔa j
,
ΔΔj k
null
ΔΔl p
,
ΔΔp q
new
ΕΕ 
SeedHealthRecord
ΕΕ $
(
ΕΕ$ %
today
ΕΕ% *
.
ΕΕ* +
AddDays
ΕΕ+ 2
(
ΕΕ2 3
-
ΕΕ3 4
$num
ΕΕ4 6
)
ΕΕ6 7
,
ΕΕ7 8
$str
ΕΕ9 ^
,
ΕΕ^ _
$str
ΕΕ` ~
,
ΕΕ~ 
$strΕΕ€ Ή
)ΕΕΉ Ί
)ΕΕΊ »
,ΕΕ» Ό
new
ΖΖ 
(
ΖΖ 
Patient
ΖΖ 
(
ΖΖ 
$num
ΖΖ 
)
ΖΖ 
,
ΖΖ 
Anjali
ΖΖ "
(
ΖΖ" #
)
ΖΖ# $
,
ΖΖ$ %
today
ΖΖ& +
.
ΖΖ+ ,
AddDays
ΖΖ, 3
(
ΖΖ3 4
-
ΖΖ4 5
$num
ΖΖ5 6
)
ΖΖ6 7
,
ΖΖ7 8
new
ΖΖ9 <
TimeOnly
ΖΖ= E
(
ΖΖE F
$num
ΖΖF H
,
ΖΖH I
$num
ΖΖJ L
)
ΖΖL M
,
ΖΖM N
AppointmentStatus
ΖΖO `
.
ΖΖ` a
	Completed
ΖΖa j
,
ΖΖj k
null
ΖΖl p
,
ΖΖp q
new
ΗΗ 
SeedHealthRecord
ΗΗ $
(
ΗΗ$ %
today
ΗΗ% *
.
ΗΗ* +
AddDays
ΗΗ+ 2
(
ΗΗ2 3
-
ΗΗ3 4
$num
ΗΗ4 5
)
ΗΗ5 6
,
ΗΗ6 7
$str
ΗΗ8 X
,
ΗΗX Y
$strΗΗZ 
,ΗΗ 
$strΗΗ Ή
)ΗΗΉ Ί
)ΗΗΊ »
,ΗΗ» Ό
new
ΙΙ 
(
ΙΙ 
Patient
ΙΙ 
(
ΙΙ 
$num
ΙΙ 
)
ΙΙ 
,
ΙΙ 
Anjali
ΙΙ "
(
ΙΙ" #
)
ΙΙ# $
,
ΙΙ$ %
today
ΙΙ& +
,
ΙΙ+ ,
new
ΙΙ- 0
TimeOnly
ΙΙ1 9
(
ΙΙ9 :
$num
ΙΙ: ;
,
ΙΙ; <
$num
ΙΙ= >
)
ΙΙ> ?
,
ΙΙ? @
AppointmentStatus
ΙΙA R
.
ΙΙR S
	Confirmed
ΙΙS \
,
ΙΙ\ ]
null
ΙΙ^ b
,
ΙΙb c
null
ΙΙd h
)
ΙΙh i
,
ΙΙi j
new
ΚΚ 
(
ΚΚ 
Patient
ΚΚ 
(
ΚΚ 
$num
ΚΚ 
)
ΚΚ 
,
ΚΚ 
Anjali
ΚΚ "
(
ΚΚ" #
)
ΚΚ# $
,
ΚΚ$ %
today
ΚΚ& +
,
ΚΚ+ ,
new
ΚΚ- 0
TimeOnly
ΚΚ1 9
(
ΚΚ9 :
$num
ΚΚ: <
,
ΚΚ< =
$num
ΚΚ> ?
)
ΚΚ? @
,
ΚΚ@ A
AppointmentStatus
ΚΚB S
.
ΚΚS T
Pending
ΚΚT [
,
ΚΚ[ \
null
ΚΚ] a
,
ΚΚa b
null
ΚΚc g
)
ΚΚg h
,
ΚΚh i
new
ΛΛ 
(
ΛΛ 
Patient
ΛΛ 
(
ΛΛ 
$num
ΛΛ 
)
ΛΛ 
,
ΛΛ 
Anjali
ΛΛ "
(
ΛΛ" #
)
ΛΛ# $
,
ΛΛ$ %
today
ΛΛ& +
,
ΛΛ+ ,
new
ΛΛ- 0
TimeOnly
ΛΛ1 9
(
ΛΛ9 :
$num
ΛΛ: <
,
ΛΛ< =
$num
ΛΛ> ?
)
ΛΛ? @
,
ΛΛ@ A
AppointmentStatus
ΛΛB S
.
ΛΛS T
	Confirmed
ΛΛT ]
,
ΛΛ] ^
null
ΛΛ_ c
,
ΛΛc d
null
ΛΛe i
)
ΛΛi j
,
ΛΛj k
new
ΜΜ 
(
ΜΜ 
Patient
ΜΜ 
(
ΜΜ 
$num
ΜΜ 
)
ΜΜ 
,
ΜΜ 
Anjali
ΜΜ "
(
ΜΜ" #
)
ΜΜ# $
,
ΜΜ$ %
today
ΜΜ& +
,
ΜΜ+ ,
new
ΜΜ- 0
TimeOnly
ΜΜ1 9
(
ΜΜ9 :
$num
ΜΜ: <
,
ΜΜ< =
$num
ΜΜ> ?
)
ΜΜ? @
,
ΜΜ@ A
AppointmentStatus
ΜΜB S
.
ΜΜS T
Pending
ΜΜT [
,
ΜΜ[ \
null
ΜΜ] a
,
ΜΜa b
null
ΜΜc g
)
ΜΜg h
,
ΜΜh i
new
ΝΝ 
(
ΝΝ 
Patient
ΝΝ 
(
ΝΝ 
$num
ΝΝ 
)
ΝΝ 
,
ΝΝ 
Anjali
ΝΝ "
(
ΝΝ" #
)
ΝΝ# $
,
ΝΝ$ %
today
ΝΝ& +
,
ΝΝ+ ,
new
ΝΝ- 0
TimeOnly
ΝΝ1 9
(
ΝΝ9 :
$num
ΝΝ: <
,
ΝΝ< =
$num
ΝΝ> ?
)
ΝΝ? @
,
ΝΝ@ A
AppointmentStatus
ΝΝB S
.
ΝΝS T
	Cancelled
ΝΝT ]
,
ΝΝ] ^
$strΝΝ_ •
,ΝΝ• –
nullΝΝ— ›
)ΝΝ› 
,ΝΝ 
new
ΟΟ 
(
ΟΟ 
Patient
ΟΟ 
(
ΟΟ 
$num
ΟΟ 
)
ΟΟ 
,
ΟΟ 
Anjali
ΟΟ "
(
ΟΟ" #
)
ΟΟ# $
,
ΟΟ$ %
today
ΟΟ& +
.
ΟΟ+ ,
AddDays
ΟΟ, 3
(
ΟΟ3 4
$num
ΟΟ4 5
)
ΟΟ5 6
,
ΟΟ6 7
new
ΟΟ8 ;
TimeOnly
ΟΟ< D
(
ΟΟD E
$num
ΟΟE F
,
ΟΟF G
$num
ΟΟH I
)
ΟΟI J
,
ΟΟJ K
AppointmentStatus
ΟΟL ]
.
ΟΟ] ^
Pending
ΟΟ^ e
,
ΟΟe f
null
ΟΟg k
,
ΟΟk l
null
ΟΟm q
)
ΟΟq r
,
ΟΟr s
new
ΠΠ 
(
ΠΠ 
Patient
ΠΠ 
(
ΠΠ 
$num
ΠΠ 
)
ΠΠ 
,
ΠΠ 
Anjali
ΠΠ "
(
ΠΠ" #
)
ΠΠ# $
,
ΠΠ$ %
today
ΠΠ& +
.
ΠΠ+ ,
AddDays
ΠΠ, 3
(
ΠΠ3 4
$num
ΠΠ4 5
)
ΠΠ5 6
,
ΠΠ6 7
new
ΠΠ8 ;
TimeOnly
ΠΠ< D
(
ΠΠD E
$num
ΠΠE G
,
ΠΠG H
$num
ΠΠI J
)
ΠΠJ K
,
ΠΠK L
AppointmentStatus
ΠΠM ^
.
ΠΠ^ _
	Confirmed
ΠΠ_ h
,
ΠΠh i
null
ΠΠj n
,
ΠΠn o
null
ΠΠp t
)
ΠΠt u
,
ΠΠu v
new
ΡΡ 
(
ΡΡ 
Patient
ΡΡ 
(
ΡΡ 
$num
ΡΡ 
)
ΡΡ 
,
ΡΡ 
Anjali
ΡΡ "
(
ΡΡ" #
)
ΡΡ# $
,
ΡΡ$ %
today
ΡΡ& +
.
ΡΡ+ ,
AddDays
ΡΡ, 3
(
ΡΡ3 4
$num
ΡΡ4 5
)
ΡΡ5 6
,
ΡΡ6 7
new
ΡΡ8 ;
TimeOnly
ΡΡ< D
(
ΡΡD E
$num
ΡΡE G
,
ΡΡG H
$num
ΡΡI J
)
ΡΡJ K
,
ΡΡK L
AppointmentStatus
ΡΡM ^
.
ΡΡ^ _
Pending
ΡΡ_ f
,
ΡΡf g
null
ΡΡh l
,
ΡΡl m
null
ΡΡn r
)
ΡΡr s
,
ΡΡs t
new
ÒÒ 
(
ÒÒ 
Patient
ÒÒ 
(
ÒÒ 
$num
ÒÒ 
)
ÒÒ 
,
ÒÒ 
Anjali
ÒÒ "
(
ÒÒ" #
)
ÒÒ# $
,
ÒÒ$ %
today
ÒÒ& +
.
ÒÒ+ ,
AddDays
ÒÒ, 3
(
ÒÒ3 4
$num
ÒÒ4 5
)
ÒÒ5 6
,
ÒÒ6 7
new
ÒÒ8 ;
TimeOnly
ÒÒ< D
(
ÒÒD E
$num
ÒÒE G
,
ÒÒG H
$num
ÒÒI J
)
ÒÒJ K
,
ÒÒK L
AppointmentStatus
ÒÒM ^
.
ÒÒ^ _
	Confirmed
ÒÒ_ h
,
ÒÒh i
null
ÒÒj n
,
ÒÒn o
null
ÒÒp t
)
ÒÒt u
,
ÒÒu v
new
ΣΣ 
(
ΣΣ 
Patient
ΣΣ 
(
ΣΣ 
$num
ΣΣ 
)
ΣΣ 
,
ΣΣ 
Anjali
ΣΣ "
(
ΣΣ" #
)
ΣΣ# $
,
ΣΣ$ %
today
ΣΣ& +
.
ΣΣ+ ,
AddDays
ΣΣ, 3
(
ΣΣ3 4
$num
ΣΣ4 5
)
ΣΣ5 6
,
ΣΣ6 7
new
ΣΣ8 ;
TimeOnly
ΣΣ< D
(
ΣΣD E
$num
ΣΣE G
,
ΣΣG H
$num
ΣΣI J
)
ΣΣJ K
,
ΣΣK L
AppointmentStatus
ΣΣM ^
.
ΣΣ^ _
Pending
ΣΣ_ f
,
ΣΣf g
null
ΣΣh l
,
ΣΣl m
null
ΣΣn r
)
ΣΣr s
,
ΣΣs t
new
ΤΤ 
(
ΤΤ 
Patient
ΤΤ 
(
ΤΤ 
$num
ΤΤ 
)
ΤΤ 
,
ΤΤ 
Anjali
ΤΤ #
(
ΤΤ# $
)
ΤΤ$ %
,
ΤΤ% &
today
ΤΤ' ,
.
ΤΤ, -
AddDays
ΤΤ- 4
(
ΤΤ4 5
$num
ΤΤ5 7
)
ΤΤ7 8
,
ΤΤ8 9
new
ΤΤ: =
TimeOnly
ΤΤ> F
(
ΤΤF G
$num
ΤΤG H
,
ΤΤH I
$num
ΤΤJ L
)
ΤΤL M
,
ΤΤM N
AppointmentStatus
ΤΤO `
.
ΤΤ` a
	Confirmed
ΤΤa j
,
ΤΤj k
null
ΤΤl p
,
ΤΤp q
null
ΤΤr v
)
ΤΤv w
,
ΤΤw x
new
ΥΥ 
(
ΥΥ 
Patient
ΥΥ 
(
ΥΥ 
$num
ΥΥ 
)
ΥΥ 
,
ΥΥ 
Anjali
ΥΥ #
(
ΥΥ# $
)
ΥΥ$ %
,
ΥΥ% &
today
ΥΥ' ,
.
ΥΥ, -
AddDays
ΥΥ- 4
(
ΥΥ4 5
$num
ΥΥ5 7
)
ΥΥ7 8
,
ΥΥ8 9
new
ΥΥ: =
TimeOnly
ΥΥ> F
(
ΥΥF G
$num
ΥΥG I
,
ΥΥI J
$num
ΥΥK M
)
ΥΥM N
,
ΥΥN O
AppointmentStatus
ΥΥP a
.
ΥΥa b
Pending
ΥΥb i
,
ΥΥi j
null
ΥΥk o
,
ΥΥo p
null
ΥΥq u
)
ΥΥu v
,
ΥΥv w
new
ΦΦ 
(
ΦΦ 
Patient
ΦΦ 
(
ΦΦ 
$num
ΦΦ 
)
ΦΦ 
,
ΦΦ 
Anjali
ΦΦ #
(
ΦΦ# $
)
ΦΦ$ %
,
ΦΦ% &
today
ΦΦ' ,
.
ΦΦ, -
AddDays
ΦΦ- 4
(
ΦΦ4 5
$num
ΦΦ5 7
)
ΦΦ7 8
,
ΦΦ8 9
new
ΦΦ: =
TimeOnly
ΦΦ> F
(
ΦΦF G
$num
ΦΦG I
,
ΦΦI J
$num
ΦΦK M
)
ΦΦM N
,
ΦΦN O
AppointmentStatus
ΦΦP a
.
ΦΦa b
	Confirmed
ΦΦb k
,
ΦΦk l
null
ΦΦm q
,
ΦΦq r
null
ΦΦs w
)
ΦΦw x
,
ΦΦx y
new
ΩΩ 
(
ΩΩ 
Patient
ΩΩ 
(
ΩΩ 
$num
ΩΩ 
)
ΩΩ 
,
ΩΩ 
Doctor
ΩΩ "
(
ΩΩ" #"
DoctorSpecialisation
ΩΩ# 7
.
ΩΩ7 8
Dermatology
ΩΩ8 C
)
ΩΩC D
,
ΩΩD E
today
ΩΩF K
.
ΩΩK L
AddDays
ΩΩL S
(
ΩΩS T
-
ΩΩT U
$num
ΩΩU V
)
ΩΩV W
,
ΩΩW X
new
ΩΩY \
TimeOnly
ΩΩ] e
(
ΩΩe f
$num
ΩΩf g
,
ΩΩg h
$num
ΩΩi j
)
ΩΩj k
,
ΩΩk l
AppointmentStatus
ΩΩm ~
.
ΩΩ~ 
	CompletedΩΩ 
,ΩΩ ‰
nullΩΩ 
,ΩΩ 
new
ΪΪ 
SeedHealthRecord
ΪΪ $
(
ΪΪ$ %
today
ΪΪ% *
.
ΪΪ* +
AddDays
ΪΪ+ 2
(
ΪΪ2 3
-
ΪΪ3 4
$num
ΪΪ4 5
)
ΪΪ5 6
,
ΪΪ6 7
$str
ΪΪ8 Q
,
ΪΪQ R
$strΪΪS ‰
,ΪΪ‰ 
$strΪΪ‹ ©
)ΪΪ© ª
)ΪΪª «
,ΪΪ« ¬
new
ΫΫ 
(
ΫΫ 
Patient
ΫΫ 
(
ΫΫ 
$num
ΫΫ 
)
ΫΫ 
,
ΫΫ 
Doctor
ΫΫ "
(
ΫΫ" #"
DoctorSpecialisation
ΫΫ# 7
.
ΫΫ7 8
	Neurology
ΫΫ8 A
)
ΫΫA B
,
ΫΫB C
today
ΫΫD I
.
ΫΫI J
AddDays
ΫΫJ Q
(
ΫΫQ R
-
ΫΫR S
$num
ΫΫS T
)
ΫΫT U
,
ΫΫU V
new
ΫΫW Z
TimeOnly
ΫΫ[ c
(
ΫΫc d
$num
ΫΫd f
,
ΫΫf g
$num
ΫΫh i
)
ΫΫi j
,
ΫΫj k
AppointmentStatus
ΫΫl }
.
ΫΫ} ~
	CompletedΫΫ~ ‡
,ΫΫ‡ 
nullΫΫ‰ 
,ΫΫ 
new
άά 
SeedHealthRecord
άά $
(
άά$ %
today
άά% *
.
άά* +
AddDays
άά+ 2
(
άά2 3
-
άά3 4
$num
άά4 5
)
άά5 6
,
άά6 7
$str
άά8 I
,
άάI J
$str
άάK n
,
άάn o
$strάάp ‰
)άά‰ 
)άά ‹
,άά‹ 
new
έέ 
(
έέ 
Patient
έέ 
(
έέ 
$num
έέ 
)
έέ 
,
έέ 
Doctor
έέ "
(
έέ" #"
DoctorSpecialisation
έέ# 7
.
έέ7 8
Orthopaedics
έέ8 D
)
έέD E
,
έέE F
today
έέG L
.
έέL M
AddDays
έέM T
(
έέT U
-
έέU V
$num
έέV W
)
έέW X
,
έέX Y
new
έέZ ]
TimeOnly
έέ^ f
(
έέf g
$num
έέg i
,
έέi j
$num
έέk l
)
έέl m
,
έέm n 
AppointmentStatusέέo €
.έέ€ 
	Completedέέ 
,έέ ‹
nullέέ 
,έέ ‘
new
ήή 
SeedHealthRecord
ήή $
(
ήή$ %
today
ήή% *
.
ήή* +
AddDays
ήή+ 2
(
ήή2 3
-
ήή3 4
$num
ήή4 5
)
ήή5 6
,
ήή6 7
$str
ήή8 K
,
ήήK L
$str
ήήM y
,
ήήy z
$strήή{ ¤
)ήή¤ ¥
)ήή¥ ¦
,ήή¦ §
new
ίί 
(
ίί 
Patient
ίί 
(
ίί 
$num
ίί 
)
ίί 
,
ίί 
Doctor
ίί "
(
ίί" #"
DoctorSpecialisation
ίί# 7
.
ίί7 8

Pediatrics
ίί8 B
)
ίίB C
,
ίίC D
today
ίίE J
.
ίίJ K
AddDays
ίίK R
(
ίίR S
-
ίίS T
$num
ίίT U
)
ίίU V
,
ίίV W
new
ίίX [
TimeOnly
ίί\ d
(
ίίd e
$num
ίίe g
,
ίίg h
$num
ίίi j
)
ίίj k
,
ίίk l
AppointmentStatus
ίίm ~
.
ίί~ 
	Completedίί 
,ίί ‰
nullίί 
,ίί 
new
ΰΰ 
SeedHealthRecord
ΰΰ $
(
ΰΰ$ %
today
ΰΰ% *
.
ΰΰ* +
AddDays
ΰΰ+ 2
(
ΰΰ2 3
-
ΰΰ3 4
$num
ΰΰ4 5
)
ΰΰ5 6
,
ΰΰ6 7
$str
ΰΰ8 [
,
ΰΰ[ \
$str
ΰΰ] |
,
ΰΰ| }
$strΰΰ~ ©
)ΰΰ© ª
)ΰΰª «
,ΰΰ« ¬
new
αα 
(
αα 
Patient
αα 
(
αα 
$num
αα 
)
αα 
,
αα 
Doctor
αα #
(
αα# $"
DoctorSpecialisation
αα$ 8
.
αα8 9
GeneralMedicine
αα9 H
)
ααH I
,
ααI J
today
ααK P
.
ααP Q
AddDays
ααQ X
(
ααX Y
-
ααY Z
$num
ααZ \
)
αα\ ]
,
αα] ^
new
αα_ b
TimeOnly
ααc k
(
ααk l
$num
ααl n
,
ααn o
$num
ααp q
)
ααq r
,
ααr s 
AppointmentStatusααt …
.αα… †
	Completedαα† 
,αα 
nullαα‘ •
,αα• –
new
ββ 
SeedHealthRecord
ββ $
(
ββ$ %
today
ββ% *
.
ββ* +
AddDays
ββ+ 2
(
ββ2 3
-
ββ3 4
$num
ββ4 6
)
ββ6 7
,
ββ7 8
$str
ββ9 R
,
ββR S
$strββT 
,ββ ‚
$strββƒ 
)ββ 
)ββ 
,ββ 
new
γγ 
(
γγ 
Patient
γγ 
(
γγ 
$num
γγ 
)
γγ 
,
γγ 
Doctor
γγ #
(
γγ# $"
DoctorSpecialisation
γγ$ 8
.
γγ8 9

Psychiatry
γγ9 C
)
γγC D
,
γγD E
today
γγF K
.
γγK L
AddDays
γγL S
(
γγS T
-
γγT U
$num
γγU W
)
γγW X
,
γγX Y
new
γγZ ]
TimeOnly
γγ^ f
(
γγf g
$num
γγg i
,
γγi j
$num
γγk l
)
γγl m
,
γγm n 
AppointmentStatusγγo €
.γγ€ 
	Completedγγ 
,γγ ‹
nullγγ 
,γγ ‘
new
δδ 
SeedHealthRecord
δδ $
(
δδ$ %
today
δδ% *
.
δδ* +
AddDays
δδ+ 2
(
δδ2 3
-
δδ3 4
$num
δδ4 6
)
δδ6 7
,
δδ7 8
$str
δδ9 K
,
δδK L
$str
δδM x
,
δδx y
$strδδz ¤
)δδ¤ ¥
)δδ¥ ¦
,δδ¦ §
new
εε 
(
εε 
Patient
εε 
(
εε 
$num
εε 
)
εε 
,
εε 
Doctor
εε #
(
εε# $"
DoctorSpecialisation
εε$ 8
.
εε8 9
	Radiology
εε9 B
)
εεB C
,
εεC D
today
εεE J
.
εεJ K
AddDays
εεK R
(
εεR S
-
εεS T
$num
εεT V
)
εεV W
,
εεW X
new
εεY \
TimeOnly
εε] e
(
εεe f
$num
εεf g
,
εεg h
$num
εεi k
)
εεk l
,
εεl m
AppointmentStatus
εεn 
.εε €
	Completedεε€ ‰
,εε‰ 
nullεε‹ 
,εε 
new
ζζ 
SeedHealthRecord
ζζ $
(
ζζ$ %
today
ζζ% *
.
ζζ* +
AddDays
ζζ+ 2
(
ζζ2 3
-
ζζ3 4
$num
ζζ4 6
)
ζζ6 7
,
ζζ7 8
$str
ζζ9 V
,
ζζV W
$str
ζζX s
,
ζζs t
$strζζu —
)ζζ— 
)ζζ ™
,ζζ™ 
new
ηη 
(
ηη 
Patient
ηη 
(
ηη 
$num
ηη 
)
ηη 
,
ηη 
Doctor
ηη #
(
ηη# $"
DoctorSpecialisation
ηη$ 8
.
ηη8 9

Gynecology
ηη9 C
)
ηηC D
,
ηηD E
today
ηηF K
.
ηηK L
AddDays
ηηL S
(
ηηS T
-
ηηT U
$num
ηηU W
)
ηηW X
,
ηηX Y
new
ηηZ ]
TimeOnly
ηη^ f
(
ηηf g
$num
ηηg i
,
ηηi j
$num
ηηk m
)
ηηm n
,
ηηn o 
AppointmentStatusηηp 
.ηη ‚
	Completedηη‚ ‹
,ηη‹ 
nullηη ‘
,ηη‘ ’
new
θθ 
SeedHealthRecord
θθ $
(
θθ$ %
today
θθ% *
.
θθ* +
AddDays
θθ+ 2
(
θθ2 3
-
θθ3 4
$num
θθ4 6
)
θθ6 7
,
θθ7 8
$str
θθ9 U
,
θθU V
$str
θθW ~
,
θθ~ 
$strθθ€ °
)θθ° ±
)θθ± ²
,θθ² ³
new
ιι 
(
ιι 
Patient
ιι 
(
ιι 
$num
ιι 
)
ιι 
,
ιι 
Doctor
ιι #
(
ιι# $"
DoctorSpecialisation
ιι$ 8
.
ιι8 9
ENT
ιι9 <
)
ιι< =
,
ιι= >
today
ιι? D
.
ιιD E
AddDays
ιιE L
(
ιιL M
-
ιιM N
$num
ιιN P
)
ιιP Q
,
ιιQ R
new
ιιS V
TimeOnly
ιιW _
(
ιι_ `
$num
ιι` b
,
ιιb c
$num
ιιd f
)
ιιf g
,
ιιg h
AppointmentStatus
ιιi z
.
ιιz {
	Completedιι{ „
,ιι„ …
nullιι† 
,ιι ‹
new
κκ 
SeedHealthRecord
κκ $
(
κκ$ %
today
κκ% *
.
κκ* +
AddDays
κκ+ 2
(
κκ2 3
-
κκ3 4
$num
κκ4 6
)
κκ6 7
,
κκ7 8
$str
κκ9 I
,
κκI J
$str
κκK j
,
κκj k
$strκκl 
)κκ 
)κκ 
,κκ 
new
λλ 
(
λλ 
Patient
λλ 
(
λλ 
$num
λλ 
)
λλ 
,
λλ 
Doctor
λλ #
(
λλ# $"
DoctorSpecialisation
λλ$ 8
.
λλ8 9
GeneralMedicine
λλ9 H
)
λλH I
,
λλI J
today
λλK P
.
λλP Q
AddDays
λλQ X
(
λλX Y
-
λλY Z
$num
λλZ \
)
λλ\ ]
,
λλ] ^
new
λλ_ b
TimeOnly
λλc k
(
λλk l
$num
λλl m
,
λλm n
$num
λλo q
)
λλq r
,
λλr s 
AppointmentStatusλλt …
.λλ… †
	Completedλλ† 
,λλ 
nullλλ‘ •
,λλ• –
new
μμ 
SeedHealthRecord
μμ $
(
μμ$ %
today
μμ% *
.
μμ* +
AddDays
μμ+ 2
(
μμ2 3
-
μμ3 4
$num
μμ4 6
)
μμ6 7
,
μμ7 8
$str
μμ9 Q
,
μμQ R
$strμμS 
,μμ ‰
$strμμ Έ
)μμΈ Ή
)μμΉ Ί
,μμΊ »
new
νν 
(
νν 
Patient
νν 
(
νν 
$num
νν 
)
νν 
,
νν 
Doctor
νν #
(
νν# $"
DoctorSpecialisation
νν$ 8
.
νν8 9

Psychiatry
νν9 C
)
ννC D
,
ννD E
today
ννF K
.
ννK L
AddDays
ννL S
(
ννS T
-
ννT U
$num
ννU W
)
ννW X
,
ννX Y
new
ννZ ]
TimeOnly
νν^ f
(
ννf g
$num
ννg i
,
ννi j
$num
ννk m
)
ννm n
,
ννn o 
AppointmentStatusννp 
.νν ‚
	Completedνν‚ ‹
,νν‹ 
nullνν ‘
,νν‘ ’
new
ξξ 
SeedHealthRecord
ξξ $
(
ξξ$ %
today
ξξ% *
.
ξξ* +
AddDays
ξξ+ 2
(
ξξ2 3
-
ξξ3 4
$num
ξξ4 6
)
ξξ6 7
,
ξξ7 8
$str
ξξ9 S
,
ξξS T
$strξξU ‹
,ξξ‹ 
$strξξ ³
)ξξ³ ΄
)ξξ΄ µ
,ξξµ ¶
new
οο 
(
οο 
Patient
οο 
(
οο 
$num
οο 
)
οο 
,
οο 
Doctor
οο #
(
οο# $"
DoctorSpecialisation
οο$ 8
.
οο8 9
ENT
οο9 <
)
οο< =
,
οο= >
today
οο? D
.
οοD E
AddDays
οοE L
(
οοL M
-
οοM N
$num
οοN P
)
οοP Q
,
οοQ R
new
οοS V
TimeOnly
οοW _
(
οο_ `
$num
οο` b
,
οοb c
$num
οοd f
)
οοf g
,
οοg h
AppointmentStatus
οοi z
.
οοz {
	Completedοο{ „
,οο„ …
nullοο† 
,οο ‹
new
ππ 
SeedHealthRecord
ππ $
(
ππ$ %
today
ππ% *
.
ππ* +
AddDays
ππ+ 2
(
ππ2 3
-
ππ3 4
$num
ππ4 6
)
ππ6 7
,
ππ7 8
$str
ππ9 U
,
ππU V
$strππW ‚
,ππ‚ ƒ
$strππ„ Έ
)ππΈ Ή
)ππΉ Ί
,ππΊ »
new
ςς 
(
ςς 
Patient
ςς 
(
ςς 
$num
ςς 
)
ςς 
,
ςς 
Doctor
ςς #
(
ςς# $"
DoctorSpecialisation
ςς$ 8
.
ςς8 9
Dermatology
ςς9 D
)
ςςD E
,
ςςE F
today
ςςG L
,
ςςL M
new
ςςN Q
TimeOnly
ςςR Z
(
ςςZ [
$num
ςς[ \
,
ςς\ ]
$num
ςς^ `
)
ςς` a
,
ςςa b
AppointmentStatus
ςςc t
.
ςςt u
	Confirmed
ςςu ~
,
ςς~ 
nullςς€ „
,ςς„ …
nullςς† 
)ςς ‹
,ςς‹ 
new
σσ 
(
σσ 
Patient
σσ 
(
σσ 
$num
σσ 
)
σσ 
,
σσ 
Doctor
σσ #
(
σσ# $"
DoctorSpecialisation
σσ$ 8
.
σσ8 9
GeneralMedicine
σσ9 H
)
σσH I
,
σσI J
today
σσK P
,
σσP Q
new
σσR U
TimeOnly
σσV ^
(
σσ^ _
$num
σσ_ a
,
σσa b
$num
σσc e
)
σσe f
,
σσf g
AppointmentStatus
σσh y
.
σσy z
Pendingσσz 
,σσ ‚
nullσσƒ ‡
,σσ‡ 
nullσσ‰ 
)σσ 
,σσ 
new
ττ 
(
ττ 
Patient
ττ 
(
ττ 
$num
ττ 
)
ττ 
,
ττ 
Doctor
ττ #
(
ττ# $"
DoctorSpecialisation
ττ$ 8
.
ττ8 9
ENT
ττ9 <
)
ττ< =
,
ττ= >
today
ττ? D
,
ττD E
new
ττF I
TimeOnly
ττJ R
(
ττR S
$num
ττS U
,
ττU V
$num
ττW Y
)
ττY Z
,
ττZ [
AppointmentStatus
ττ\ m
.
ττm n
	Cancelled
ττn w
,
ττw x
$strττy £
,ττ£ ¤
nullττ¥ ©
)ττ© ª
,ττª «
new
φφ 
(
φφ 
Patient
φφ 
(
φφ 
$num
φφ 
)
φφ 
,
φφ 
Doctor
φφ #
(
φφ# $"
DoctorSpecialisation
φφ$ 8
.
φφ8 9
	Neurology
φφ9 B
)
φφB C
,
φφC D
today
φφE J
.
φφJ K
AddDays
φφK R
(
φφR S
$num
φφS T
)
φφT U
,
φφU V
new
φφW Z
TimeOnly
φφ[ c
(
φφc d
$num
φφd e
,
φφe f
$num
φφg i
)
φφi j
,
φφj k
AppointmentStatus
φφl }
.
φφ} ~
Pendingφφ~ …
,φφ… †
nullφφ‡ ‹
,φφ‹ 
nullφφ ‘
)φφ‘ ’
,φφ’ “
new
χχ 
(
χχ 
Patient
χχ 
(
χχ 
$num
χχ 
)
χχ 
,
χχ 
Doctor
χχ #
(
χχ# $"
DoctorSpecialisation
χχ$ 8
.
χχ8 9
Orthopaedics
χχ9 E
)
χχE F
,
χχF G
today
χχH M
.
χχM N
AddDays
χχN U
(
χχU V
$num
χχV W
)
χχW X
,
χχX Y
new
χχZ ]
TimeOnly
χχ^ f
(
χχf g
$num
χχg i
,
χχi j
$num
χχk m
)
χχm n
,
χχn o 
AppointmentStatusχχp 
.χχ ‚
	Confirmedχχ‚ ‹
,χχ‹ 
nullχχ ‘
,χχ‘ ’
nullχχ“ —
)χχ— 
,χχ ™
new
ψψ 
(
ψψ 
Patient
ψψ 
(
ψψ 
$num
ψψ 
)
ψψ 
,
ψψ 
Doctor
ψψ #
(
ψψ# $"
DoctorSpecialisation
ψψ$ 8
.
ψψ8 9

Pediatrics
ψψ9 C
)
ψψC D
,
ψψD E
today
ψψF K
.
ψψK L
AddDays
ψψL S
(
ψψS T
$num
ψψT U
)
ψψU V
,
ψψV W
new
ψψX [
TimeOnly
ψψ\ d
(
ψψd e
$num
ψψe g
,
ψψg h
$num
ψψi k
)
ψψk l
,
ψψl m
AppointmentStatus
ψψn 
.ψψ €
Pendingψψ€ ‡
,ψψ‡ 
nullψψ‰ 
,ψψ 
nullψψ “
)ψψ“ ”
,ψψ” •
new
ωω 
(
ωω 
Patient
ωω 
(
ωω 
$num
ωω 
)
ωω 
,
ωω 
Doctor
ωω #
(
ωω# $"
DoctorSpecialisation
ωω$ 8
.
ωω8 9

Psychiatry
ωω9 C
)
ωωC D
,
ωωD E
today
ωωF K
.
ωωK L
AddDays
ωωL S
(
ωωS T
$num
ωωT U
)
ωωU V
,
ωωV W
new
ωωX [
TimeOnly
ωω\ d
(
ωωd e
$num
ωωe g
,
ωωg h
$num
ωωi k
)
ωωk l
,
ωωl m
AppointmentStatus
ωωn 
.ωω €
	Confirmedωω€ ‰
,ωω‰ 
nullωω‹ 
,ωω 
nullωω‘ •
)ωω• –
,ωω– —
new
ϊϊ 
(
ϊϊ 
Patient
ϊϊ 
(
ϊϊ 
$num
ϊϊ 
)
ϊϊ 
,
ϊϊ 
Doctor
ϊϊ #
(
ϊϊ# $"
DoctorSpecialisation
ϊϊ$ 8
.
ϊϊ8 9

Gynecology
ϊϊ9 C
)
ϊϊC D
,
ϊϊD E
today
ϊϊF K
.
ϊϊK L
AddDays
ϊϊL S
(
ϊϊS T
$num
ϊϊT U
)
ϊϊU V
,
ϊϊV W
new
ϊϊX [
TimeOnly
ϊϊ\ d
(
ϊϊd e
$num
ϊϊe g
,
ϊϊg h
$num
ϊϊi k
)
ϊϊk l
,
ϊϊl m
AppointmentStatus
ϊϊn 
.ϊϊ €
Pendingϊϊ€ ‡
,ϊϊ‡ 
nullϊϊ‰ 
,ϊϊ 
nullϊϊ “
)ϊϊ“ ”
,ϊϊ” •
new
ϋϋ 
(
ϋϋ 
Patient
ϋϋ 
(
ϋϋ 
$num
ϋϋ 
)
ϋϋ 
,
ϋϋ 
Doctor
ϋϋ "
(
ϋϋ" #"
DoctorSpecialisation
ϋϋ# 7
.
ϋϋ7 8
	Radiology
ϋϋ8 A
)
ϋϋA B
,
ϋϋB C
today
ϋϋD I
.
ϋϋI J
AddDays
ϋϋJ Q
(
ϋϋQ R
$num
ϋϋR T
)
ϋϋT U
,
ϋϋU V
new
ϋϋW Z
TimeOnly
ϋϋ[ c
(
ϋϋc d
$num
ϋϋd f
,
ϋϋf g
$num
ϋϋh i
)
ϋϋi j
,
ϋϋj k
AppointmentStatus
ϋϋl }
.
ϋϋ} ~
	Confirmedϋϋ~ ‡
,ϋϋ‡ 
nullϋϋ‰ 
,ϋϋ 
nullϋϋ “
)ϋϋ“ ”
,ϋϋ” •
new
ύύ 
(
ύύ 
Patient
ύύ 
(
ύύ 
$num
ύύ 
)
ύύ 
,
ύύ 
Doctor
ύύ #
(
ύύ# $"
DoctorSpecialisation
ύύ$ 8
.
ύύ8 9

Cardiology
ύύ9 C
)
ύύC D
,
ύύD E
today
ύύF K
.
ύύK L
AddDays
ύύL S
(
ύύS T
-
ύύT U
$num
ύύU W
)
ύύW X
,
ύύX Y
new
ύύZ ]
TimeOnly
ύύ^ f
(
ύύf g
$num
ύύg h
,
ύύh i
$num
ύύj k
)
ύύk l
,
ύύl m
AppointmentStatus
ύύn 
.ύύ €
	Cancelledύύ€ ‰
,ύύ‰ 
$strύύ‹ Δ
,ύύΔ Ε
nullύύΖ Κ
)ύύΚ Λ
,ύύΛ Μ
new
ώώ 
(
ώώ 
Patient
ώώ 
(
ώώ 
$num
ώώ 
)
ώώ 
,
ώώ 
Doctor
ώώ #
(
ώώ# $"
DoctorSpecialisation
ώώ$ 8
.
ώώ8 9
Dermatology
ώώ9 D
)
ώώD E
,
ώώE F
today
ώώG L
.
ώώL M
AddDays
ώώM T
(
ώώT U
-
ώώU V
$num
ώώV X
)
ώώX Y
,
ώώY Z
new
ώώ[ ^
TimeOnly
ώώ_ g
(
ώώg h
$num
ώώh j
,
ώώj k
$num
ώώl m
)
ώώm n
,
ώώn o 
AppointmentStatusώώp 
.ώώ ‚
	Cancelledώώ‚ ‹
,ώώ‹ 
$strώώ µ
,ώώµ ¶
nullώώ· »
)ώώ» Ό
]
ÿÿ 	
;
ÿÿ	 

}
€€ 
private
‚‚ 
static
‚‚ 
async
‚‚ 
Task
‚‚ 
<
‚‚ 
IdentityUser
‚‚ *
>
‚‚* +%
EnsureUserWithRoleAsync
‚‚, C
(
‚‚C D
UserManager
ƒƒ 
<
ƒƒ 
IdentityUser
ƒƒ  
>
ƒƒ  !
userManager
ƒƒ" -
,
ƒƒ- .
string
„„ 
email
„„ 
,
„„ 
string
…… 
phoneNumber
…… 
,
…… 
string
†† 
password
†† 
,
†† 
string
‡‡ 
role
‡‡ 
,
‡‡ 
bool
 
resetPassword
 
=
 
false
 "
)
" #
{
‰‰ 
var
 
existingUser
 
=
 
await
  
userManager
! ,
.
, -
FindByEmailAsync
- =
(
= >
email
> C
)
C D
;
D E
if
 

(
 
existingUser
 
==
 
null
  
)
  !
{
 	
existingUser
 
=
 
new
 
IdentityUser
 +
{
 
UserName
 
=
 
email
  
,
  !
Email
‘‘ 
=
‘‘ 
email
‘‘ 
,
‘‘ 
PhoneNumber
’’ 
=
’’ 
phoneNumber
’’ )
,
’’) *
EmailConfirmed
““ 
=
““  
true
““! %
}
”” 
;
”” 
var
–– 
result
–– 
=
–– 
await
–– 
userManager
–– *
.
––* +
CreateAsync
––+ 6
(
––6 7
existingUser
––7 C
,
––C D
password
––E M
)
––M N
;
––N O
if
 
(
 
!
 
result
 
.
 
	Succeeded
 !
)
! "
{
™™ 
var
 
errors
 
=
 
string
 #
.
# $
Join
$ (
(
( )
$str
) ,
,
, -
result
. 4
.
4 5
Errors
5 ;
.
; <
Select
< B
(
B C
error
C H
=>
I K
error
L Q
.
Q R
Description
R ]
)
] ^
)
^ _
;
_ `
throw
›› 
new
›› '
InvalidOperationException
›› 3
(
››3 4
$"
››4 6
$str
››6 J
{
››J K
email
››K P
}
››P Q
$str
››Q S
{
››S T
errors
››T Z
}
››Z [
"
››[ \
)
››\ ]
;
››] ^
}
 
}
 	
else
 
{
 	
existingUser
   
.
   
UserName
   !
=
  " #
email
  $ )
;
  ) *
existingUser
΅΅ 
.
΅΅ 
Email
΅΅ 
=
΅΅  
email
΅΅! &
;
΅΅& '
existingUser
ΆΆ 
.
ΆΆ 
PhoneNumber
ΆΆ $
=
ΆΆ% &
phoneNumber
ΆΆ' 2
;
ΆΆ2 3
existingUser
££ 
.
££ 
EmailConfirmed
££ '
=
££( )
true
££* .
;
££. /
var
¥¥ 
updateResult
¥¥ 
=
¥¥ 
await
¥¥ $
userManager
¥¥% 0
.
¥¥0 1
UpdateAsync
¥¥1 <
(
¥¥< =
existingUser
¥¥= I
)
¥¥I J
;
¥¥J K
if
§§ 
(
§§ 
!
§§ 
updateResult
§§ 
.
§§ 
	Succeeded
§§ '
)
§§' (
{
¨¨ 
var
©© 
errors
©© 
=
©© 
string
©© #
.
©©# $
Join
©©$ (
(
©©( )
$str
©©) ,
,
©©, -
updateResult
©©. :
.
©©: ;
Errors
©©; A
.
©©A B
Select
©©B H
(
©©H I
error
©©I N
=>
©©O Q
error
©©R W
.
©©W X
Description
©©X c
)
©©c d
)
©©d e
;
©©e f
throw
ªª 
new
ªª '
InvalidOperationException
ªª 3
(
ªª3 4
$"
ªª4 6
$str
ªª6 S
{
ªªS T
email
ªªT Y
}
ªªY Z
$str
ªªZ \
{
ªª\ ]
errors
ªª] c
}
ªªc d
"
ªªd e
)
ªªe f
;
ªªf g
}
«« 
if
­­ 
(
­­ 
resetPassword
­­ 
)
­­ 
{
®® 
var
―― 
token
―― 
=
―― 
await
―― !
userManager
――" -
.
――- .-
GeneratePasswordResetTokenAsync
――. M
(
――M N
existingUser
――N Z
)
――Z [
;
――[ \
var
°° 
passwordResult
°° "
=
°°# $
await
°°% *
userManager
°°+ 6
.
°°6 7 
ResetPasswordAsync
°°7 I
(
°°I J
existingUser
°°J V
,
°°V W
token
°°X ]
,
°°] ^
password
°°_ g
)
°°g h
;
°°h i
if
²² 
(
²² 
!
²² 
passwordResult
²² #
.
²²# $
	Succeeded
²²$ -
)
²²- .
{
³³ 
var
΄΄ 
errors
΄΄ 
=
΄΄  
string
΄΄! '
.
΄΄' (
Join
΄΄( ,
(
΄΄, -
$str
΄΄- 0
,
΄΄0 1
passwordResult
΄΄2 @
.
΄΄@ A
Errors
΄΄A G
.
΄΄G H
Select
΄΄H N
(
΄΄N O
error
΄΄O T
=>
΄΄U W
error
΄΄X ]
.
΄΄] ^
Description
΄΄^ i
)
΄΄i j
)
΄΄j k
;
΄΄k l
throw
µµ 
new
µµ '
InvalidOperationException
µµ 7
(
µµ7 8
$"
µµ8 :
$str
µµ: c
{
µµc d
email
µµd i
}
µµi j
$str
µµj l
{
µµl m
errors
µµm s
}
µµs t
"
µµt u
)
µµu v
;
µµv w
}
¶¶ 
}
·· 
}
ΈΈ 	
if
ΊΊ 

(
ΊΊ 
!
ΊΊ 
await
ΊΊ 
userManager
ΊΊ 
.
ΊΊ 
IsInRoleAsync
ΊΊ ,
(
ΊΊ, -
existingUser
ΊΊ- 9
,
ΊΊ9 :
role
ΊΊ; ?
)
ΊΊ? @
)
ΊΊ@ A
{
»» 	
var
ΌΌ 

roleResult
ΌΌ 
=
ΌΌ 
await
ΌΌ "
userManager
ΌΌ# .
.
ΌΌ. /
AddToRoleAsync
ΌΌ/ =
(
ΌΌ= >
existingUser
ΌΌ> J
,
ΌΌJ K
role
ΌΌL P
)
ΌΌP Q
;
ΌΌQ R
if
ΎΎ 
(
ΎΎ 
!
ΎΎ 

roleResult
ΎΎ 
.
ΎΎ 
	Succeeded
ΎΎ %
)
ΎΎ% &
{
ΏΏ 
var
ΐΐ 
errors
ΐΐ 
=
ΐΐ 
string
ΐΐ #
.
ΐΐ# $
Join
ΐΐ$ (
(
ΐΐ( )
$str
ΐΐ) ,
,
ΐΐ, -

roleResult
ΐΐ. 8
.
ΐΐ8 9
Errors
ΐΐ9 ?
.
ΐΐ? @
Select
ΐΐ@ F
(
ΐΐF G
error
ΐΐG L
=>
ΐΐM O
error
ΐΐP U
.
ΐΐU V
Description
ΐΐV a
)
ΐΐa b
)
ΐΐb c
;
ΐΐc d
throw
ΑΑ 
new
ΑΑ '
InvalidOperationException
ΑΑ 3
(
ΑΑ3 4
$"
ΑΑ4 6
$str
ΑΑ6 L
{
ΑΑL M
role
ΑΑM Q
}
ΑΑQ R
$str
ΑΑR V
{
ΑΑV W
email
ΑΑW \
}
ΑΑ\ ]
$str
ΑΑ] _
{
ΑΑ_ `
errors
ΑΑ` f
}
ΑΑf g
"
ΑΑg h
)
ΑΑh i
;
ΑΑi j
}
ΒΒ 
}
ΓΓ 	
return
ΕΕ 
existingUser
ΕΕ 
;
ΕΕ 
}
ΖΖ 
private
ΘΘ 
static
ΘΘ 
int
ΘΘ 
CalculateAge
ΘΘ #
(
ΘΘ# $
DateOnly
ΘΘ$ ,
dateOfBirth
ΘΘ- 8
,
ΘΘ8 9
DateOnly
ΘΘ: B
referenceDate
ΘΘC P
)
ΘΘP Q
{
ΙΙ 
var
ΚΚ 
age
ΚΚ 
=
ΚΚ 
referenceDate
ΚΚ 
.
ΚΚ  
Year
ΚΚ  $
-
ΚΚ% &
dateOfBirth
ΚΚ' 2
.
ΚΚ2 3
Year
ΚΚ3 7
;
ΚΚ7 8
if
ΜΜ 

(
ΜΜ 
referenceDate
ΜΜ 
<
ΜΜ 
dateOfBirth
ΜΜ '
.
ΜΜ' (
AddYears
ΜΜ( 0
(
ΜΜ0 1
age
ΜΜ1 4
)
ΜΜ4 5
)
ΜΜ5 6
{
ΝΝ 	
age
ΞΞ 
--
ΞΞ 
;
ΞΞ 
}
ΟΟ 	
return
ΡΡ 
age
ΡΡ 
;
ΡΡ 
}
ÒÒ 
private
ΤΤ 
static
ΤΤ 
string
ΤΤ 
RemoveDoctorTitle
ΤΤ +
(
ΤΤ+ ,
string
ΤΤ, 2
fullName
ΤΤ3 ;
)
ΤΤ; <
{
ΥΥ 
return
ΦΦ 
fullName
ΦΦ 
.
ΦΦ 

StartsWith
ΦΦ "
(
ΦΦ" #
$str
ΦΦ# )
,
ΦΦ) *
StringComparison
ΦΦ+ ;
.
ΦΦ; <
OrdinalIgnoreCase
ΦΦ< M
)
ΦΦM N
?
ΧΧ 
fullName
ΧΧ 
[
ΧΧ 
$num
ΧΧ 
..
ΧΧ 
]
ΧΧ 
:
ΨΨ 
fullName
ΨΨ 
;
ΨΨ 
}
ΩΩ 
private
ΫΫ 
sealed
ΫΫ 
record
ΫΫ 
SeedUser
ΫΫ "
(
ΫΫ" #
string
ΫΫ# )
Email
ΫΫ* /
,
ΫΫ/ 0
string
ΫΫ1 7
PhoneNumber
ΫΫ8 C
)
ΫΫC D
;
ΫΫD E
private
έέ 
sealed
έέ 
record
έέ 

SeedDoctor
έέ $
(
έέ$ %
string
ήή 
FullName
ήή 
,
ήή 
string
ίί 
Email
ίί 
,
ίί 
string
ΰΰ 
PhoneNumber
ΰΰ 
,
ΰΰ "
DoctorSpecialisation
αα 
Specialisation
αα +
,
αα+ ,
DateOnly
ββ 
PracticeStartDate
ββ "
,
ββ" #
decimal
γγ 
ConsultationFee
γγ 
,
γγ  
bool
δδ 
IsAvailable
δδ 
)
δδ 
;
δδ 
private
ζζ 
sealed
ζζ 
record
ζζ 
SeedPatient
ζζ %
(
ζζ% &
string
ηη 
FullName
ηη 
,
ηη 
string
θθ 
Email
θθ 
,
θθ 
string
ιι 
PhoneNumber
ιι 
,
ιι 
DateOnly
κκ 
DateOfBirth
κκ 
,
κκ 
string
λλ 
Gender
λλ 
,
λλ 
string
μμ 
Address
μμ 
)
μμ 
;
μμ 
private
ξξ 
sealed
ξξ 
record
ξξ 
SeedAppointment
ξξ )
(
ξξ) *
Patient
οο 
Patient
οο 
,
οο 
Doctor
ππ 
Doctor
ππ 
,
ππ 
DateOnly
ρρ 
Date
ρρ 
,
ρρ 
TimeOnly
ςς 
Time
ςς 
,
ςς 
AppointmentStatus
σσ 
Status
σσ  
,
σσ  !
string
ττ 
?
ττ  
CancellationReason
ττ "
,
ττ" #
SeedHealthRecord
υυ 
?
υυ 
HealthRecord
υυ &
)
υυ& '
;
υυ' (
private
χχ 
sealed
χχ 
record
χχ 
SeedHealthRecord
χχ *
(
χχ* +
DateOnly
ψψ 
	VisitDate
ψψ 
,
ψψ 
string
ωω 
	Diagnosis
ωω 
,
ωω 
string
ϊϊ 
Prescription
ϊϊ 
,
ϊϊ 
string
ϋϋ 
?
ϋϋ 
Notes
ϋϋ 
)
ϋϋ 
;
ϋϋ 
}όό ³9
RC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Data\HealthAxisDbContext.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Data 
; 
public 
class 
HealthAxisDbContext  
(  !
DbContextOptions! 1
<1 2
HealthAxisDbContext2 E
>E F
optionsG N
)N O
:P Q
IdentityDbContextR c
<c d
IdentityUserd p
>p q
(q r
optionsr y
)y z
{		 
public 

DbSet 
< 
Doctor 
> 
Doctors  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

DbSet 
< 
Patient 
> 
Patients "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

DbSet 
< 
Appointment 
> 
Appointments *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
public 

DbSet 
< 
HealthRecord 
> 
HealthRecords ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
	protected 
override 
void 
OnModelCreating +
(+ ,
ModelBuilder, 8
builder9 @
)@ A
{ 
base 
. 
OnModelCreating 
( 
builder $
)$ %
;% &
builder 
. 
Entity 
< 
IdentityUser #
># $
($ %
)% &
. 
HasOne 
< 
Doctor 
> 
( 
) 
. 
WithOne 
( 
doctor 
=> 
doctor %
.% &
User& *
)* +
. 
HasForeignKey 
< 
Doctor !
>! "
(" #
doctor# )
=>* ,
doctor- 3
.3 4
UserId4 :
): ;
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Restrict% -
)- .
;. /
builder 
. 
Entity 
< 
IdentityUser #
># $
($ %
)% &
. 
HasOne 
< 
Patient 
> 
( 
) 
. 
WithOne 
( 
patient 
=> 
patient  '
.' (
User( ,
), -
.   
HasForeignKey   
<   
Patient   "
>  " #
(  # $
patient  $ +
=>  , .
patient  / 6
.  6 7
UserId  7 =
)  = >
.!! 
OnDelete!! 
(!! 
DeleteBehavior!! $
.!!$ %
Restrict!!% -
)!!- .
;!!. /
builder## 
.## 
Entity## 
<## 
Appointment## "
>##" #
(### $
)##$ %
.$$ 
HasOne$$ 
($$ 
appointment$$ 
=>$$  "
appointment$$# .
.$$. /
Patient$$/ 6
)$$6 7
.%% 
WithMany%% 
(%% 
patient%% 
=>%%  
patient%%! (
.%%( )
Appointments%%) 5
)%%5 6
.&& 
HasForeignKey&& 
(&& 
appointment&& &
=>&&' )
appointment&&* 5
.&&5 6
	PatientId&&6 ?
)&&? @
.'' 
OnDelete'' 
('' 
DeleteBehavior'' $
.''$ %
Restrict''% -
)''- .
;''. /
builder)) 
.)) 
Entity)) 
<)) 
Appointment)) "
>))" #
())# $
)))$ %
.** 
HasOne** 
(** 
appointment** 
=>**  "
appointment**# .
.**. /
Doctor**/ 5
)**5 6
.++ 
WithMany++ 
(++ 
doctor++ 
=>++ 
doctor++  &
.++& '
Appointments++' 3
)++3 4
.,, 
HasForeignKey,, 
(,, 
appointment,, &
=>,,' )
appointment,,* 5
.,,5 6
DoctorId,,6 >
),,> ?
.-- 
OnDelete-- 
(-- 
DeleteBehavior-- $
.--$ %
Restrict--% -
)--- .
;--. /
builder// 
.// 
Entity// 
<// 
Appointment// "
>//" #
(//# $
)//$ %
.00 
Property00 
(00 
appointment00 !
=>00" $
appointment00% 0
.000 1
Status001 7
)007 8
.11 
HasConversion11 
<11 
string11 !
>11! "
(11" #
)11# $
.22 
HasMaxLength22 
(22 
$num22 
)22 
.33 

IsRequired33 
(33 
)33 
;33 
builder55 
.55 
Entity55 
<55 
Appointment55 "
>55" #
(55# $
)55$ %
.66 
HasOne66 
(66 
appointment66 
=>66  "
appointment66# .
.66. /
HealthRecord66/ ;
)66; <
.77 
WithOne77 
(77 
record77 
=>77 
record77 %
.77% &
Appointment77& 1
)771 2
.88 
HasForeignKey88 
<88 
HealthRecord88 '
>88' (
(88( )
record88) /
=>880 2
record883 9
.889 :
AppointmentId88: G
)88G H
.99 
OnDelete99 
(99 
DeleteBehavior99 $
.99$ %
Restrict99% -
)99- .
;99. /
builder;; 
.;; 
Entity;; 
<;; 
HealthRecord;; #
>;;# $
(;;$ %
);;% &
.<< 
HasIndex<< 
(<< 
record<< 
=><< 
record<<  &
.<<& '
AppointmentId<<' 4
)<<4 5
.== 
IsUnique== 
(== 
)== 
;== 
builder?? 
.?? 
Entity?? 
<?? 
Doctor?? 
>?? 
(?? 
)??  
.@@ 
Property@@ 
(@@ 
doctor@@ 
=>@@ 
doctor@@  &
.@@& '
Specialisation@@' 5
)@@5 6
.AA 
HasConversionAA 
<AA 
stringAA !
>AA! "
(AA" #
)AA# $
.BB 
HasMaxLengthBB 
(BB 
$numBB 
)BB 
.CC 

IsRequiredCC 
(CC 
)CC 
;CC 
}DD 
}EE ‡5
XC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\PatientsController.cs
	namespace		 	

HealthAxis		
 
.		 
API		 
.		 
Controllers		 $
;		$ %
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
[ 
	Authorize 

(
 !
AuthenticationSchemes  
=! "
JwtBearerDefaults# 4
.4 5 
AuthenticationScheme5 I
)I J
]J K
public 
class 
PatientsController 
(  
IPatientService  /
patientService0 >
)> ?
:@ A
ControllerBaseB P
{ 
[ 
HttpGet 
( 
$str 
) 
] 
[ 
	Authorize 
( !
AuthenticationSchemes $
=% &
JwtBearerDefaults' 8
.8 9 
AuthenticationScheme9 M
,M N
RolesO T
=U V
AppRolesW _
._ `
Patient` g
)g h
]h i
public 

async 
Task 
< 
IActionResult #
># $
GetCurrentPatient% 6
(6 7
)7 8
{ 
var 
	patientId 
= 
User 
. 
GetPatientId )
() *
)* +
;+ ,
if 

( 
	patientId 
== 
null 
) 
{ 	
return 
Forbid 
( 
) 
; 
} 	
var 
patient 
= 
await 
patientService *
.* +
GetPatientByIdAsync+ >
(> ?
	patientId? H
.H I
ValueI N
)N O
;O P
return 
Ok 
( 
patient 
) 
; 
} 
[   
HttpPut   
(   
$str   
)   
]   
[!! 
	Authorize!! 
(!! !
AuthenticationSchemes!! $
=!!% &
JwtBearerDefaults!!' 8
.!!8 9 
AuthenticationScheme!!9 M
,!!M N
Roles!!O T
=!!U V
AppRoles!!W _
.!!_ `
Patient!!` g
)!!g h
]!!h i
public"" 

async"" 
Task"" 
<"" 
IActionResult"" #
>""# $ 
UpdateCurrentPatient""% 9
(""9 :
UpdatePatientDto"": J
request""K R
)""R S
{## 
var$$ 
	patientId$$ 
=$$ 
User$$ 
.$$ 
GetPatientId$$ )
($$) *
)$$* +
;$$+ ,
if&& 

(&& 
	patientId&& 
==&& 
null&& 
)&& 
{'' 	
return(( 
Forbid(( 
((( 
)(( 
;(( 
})) 	
var++ 
patient++ 
=++ 
await++ 
patientService++ *
.++* +
UpdatePatientAsync+++ =
(++= >
	patientId++> G
.++G H
Value++H M
,++M N
request++O V
)++V W
;++W X
return-- 
Ok-- 
(-- 
patient-- 
)-- 
;-- 
}.. 
[00 
HttpGet00 
(00 
$str00 
)00 
]00 
[11 
	Authorize11 
(11 !
AuthenticationSchemes11 $
=11% &
JwtBearerDefaults11' 8
.118 9 
AuthenticationScheme119 M
,11M N
Roles11O T
=11U V
AppRoles11W _
.11_ `
PatientAdmin11` l
)11l m
]11m n
public22 

async22 
Task22 
<22 
IActionResult22 #
>22# $
GetPatientById22% 3
(223 4
int224 7
id228 :
)22: ;
{33 
if44 

(44 
User44 
.44 
IsInRole44 
(44 
AppRoles44 "
.44" #
Patient44# *
)44* +
&&44, .
!44/ 0
IsOwnPatientId440 >
(44> ?
id44? A
)44A B
)44B C
{55 	
return66 
Forbid66 
(66 
)66 
;66 
}77 	
var99 
patient99 
=99 
await99 
patientService99 *
.99* +
GetPatientByIdAsync99+ >
(99> ?
id99? A
)99A B
;99B C
return;; 
Ok;; 
(;; 
patient;; 
);; 
;;; 
}<< 
[>> 
HttpPut>> 
(>> 
$str>> 
)>> 
]>> 
[?? 
	Authorize?? 
(?? !
AuthenticationSchemes?? $
=??% &
JwtBearerDefaults??' 8
.??8 9 
AuthenticationScheme??9 M
,??M N
Roles??O T
=??U V
AppRoles??W _
.??_ `
PatientAdmin??` l
)??l m
]??m n
public@@ 

async@@ 
Task@@ 
<@@ 
IActionResult@@ #
>@@# $
UpdatePatient@@% 2
(@@2 3
int@@3 6
id@@7 9
,@@9 :
UpdatePatientDto@@; K
request@@L S
)@@S T
{AA 
ifBB 

(BB 
UserBB 
.BB 
IsInRoleBB 
(BB 
AppRolesBB "
.BB" #
PatientBB# *
)BB* +
&&BB, .
!BB/ 0
IsOwnPatientIdBB0 >
(BB> ?
idBB? A
)BBA B
)BBB C
{CC 	
returnDD 
ForbidDD 
(DD 
)DD 
;DD 
}EE 	
varGG 
patientGG 
=GG 
awaitGG 
patientServiceGG *
.GG* +
UpdatePatientAsyncGG+ =
(GG= >
idGG> @
,GG@ A
requestGGB I
)GGI J
;GGJ K
returnII 
OkII 
(II 
patientII 
)II 
;II 
}JJ 
privateLL 
boolLL 
IsOwnPatientIdLL 
(LL  
intLL  #
	patientIdLL$ -
)LL- .
{MM 
returnNN 
UserNN 
.NN 
GetPatientIdNN  
(NN  !
)NN! "
==NN# %
	patientIdNN& /
;NN/ 0
}OO 
}PP όL
]C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\HealthRecordsController.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Controllers $
;$ %
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
[ 
	Authorize 

(
 !
AuthenticationSchemes  
=! "
JwtBearerDefaults# 4
.4 5 
AuthenticationScheme5 I
,I J
RolesK P
=Q R
AppRolesS [
.[ \
PatientDoctor\ i
)i j
]j k
public 
class #
HealthRecordsController $
($ % 
IHealthRecordService% 9
healthRecordService: M
)M N
:O P
ControllerBaseQ _
{ 
[ 
HttpGet 
( 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $'
GetCurrentUserHealthRecords% @
(@ A
[ 
	FromQuery 
] 
PaginationQueryDto "

pagination# -
)- .
{ 
if 

( 
User 
. 
IsInRole 
( 
AppRoles "
." #
Patient# *
)* +
)+ ,
{ 	
var 
	patientId 
= 
User  
.  !
GetPatientId! -
(- .
). /
;/ 0
if 
( 
	patientId 
== 
null !
)! "
{ 
return 
Forbid 
( 
) 
;  
} 
var 
records 
= 
await 
healthRecordService  3
.3 4,
 GetHealthRecordsByPatientIdAsync4 T
(T U
	patientId   
.   
Value   
,    

pagination!! 
)!! 
;!! 
return## 
Ok## 
(## 
records## 
)## 
;## 
}$$ 	
if&& 

(&& 
User&& 
.&& 
IsInRole&& 
(&& 
AppRoles&& "
.&&" #
Doctor&&# )
)&&) *
)&&* +
{'' 	
var(( 
doctorId(( 
=(( 
User(( 
.((  
GetDoctorId((  +
(((+ ,
)((, -
;((- .
if** 
(** 
doctorId** 
==** 
null**  
)**  !
{++ 
return,, 
Forbid,, 
(,, 
),, 
;,,  
}-- 
var// 
records// 
=// 
await// 
healthRecordService//  3
.//3 4+
GetHealthRecordsByDoctorIdAsync//4 S
(//S T
doctorId00 
.00 
Value00 
,00 

pagination11 
)11 
;11 
return33 
Ok33 
(33 
records33 
)33 
;33 
}44 	
return66 
Forbid66 
(66 
)66 
;66 
}77 
[99 
HttpGet99 
(99 
$str99 &
)99& '
]99' (
public:: 

async:: 
Task:: 
<:: 
IActionResult:: #
>::# $'
GetHealthRecordsByPatientId::% @
(::@ A
int;; 
	patientId;; 
,;; 
[<< 	
	FromQuery<<	 
]<< 
PaginationQueryDto<< &

pagination<<' 1
)<<1 2
{== 
if>> 

(>> 
User>> 
.>> 
IsInRole>> 
(>> 
AppRoles>> "
.>>" #
Patient>># *
)>>* +
)>>+ ,
{?? 	
if@@ 
(@@ 
!@@ 
IsOwnPatientId@@ 
(@@  
	patientId@@  )
)@@) *
)@@* +
{AA 
returnBB 
ForbidBB 
(BB 
)BB 
;BB  
}CC 
varEE 
patientRecordsEE 
=EE  
awaitEE! &
healthRecordServiceEE' :
.EE: ;,
 GetHealthRecordsByPatientIdAsyncEE; [
(EE[ \
	patientIdEE\ e
,EEe f

paginationEEg q
)EEq r
;EEr s
returnFF 
OkFF 
(FF 
patientRecordsFF $
)FF$ %
;FF% &
}GG 	
ifII 

(II 
UserII 
.II 
IsInRoleII 
(II 
AppRolesII "
.II" #
DoctorII# )
)II) *
)II* +
{JJ 	
varKK 
doctorIdKK 
=KK 
UserKK 
.KK  
GetDoctorIdKK  +
(KK+ ,
)KK, -
;KK- .
ifMM 
(MM 
doctorIdMM 
==MM 
nullMM  
)MM  !
{NN 
returnOO 
ForbidOO 
(OO 
)OO 
;OO  
}PP 
varRR 
doctorRecordsRR 
=RR 
awaitRR  %
healthRecordServiceRR& 9
.RR9 :5
)GetHealthRecordsForDoctorPatientViewAsyncRR: c
(RRc d
	patientIdSS 
,SS 
doctorIdTT 
.TT 
ValueTT 
,TT 

paginationUU 
)UU 
;UU 
returnWW 
OkWW 
(WW 
doctorRecordsWW #
)WW# $
;WW$ %
}XX 	
returnZZ 
ForbidZZ 
(ZZ 
)ZZ 
;ZZ 
}[[ 
[]] 
HttpGet]] 
(]] 
$str]] 
)]] 
]]] 
public^^ 

async^^ 
Task^^ 
<^^ 
IActionResult^^ #
>^^# $
GetHealthRecordById^^% 8
(^^8 9
int^^9 <
id^^= ?
)^^? @
{__ 
var`` 
record`` 
=`` 
await`` 
healthRecordService`` .
.``. /$
GetHealthRecordByIdAsync``/ G
(``G H
id``H J
)``J K
;``K L
ifbb 

(bb 
Userbb 
.bb 
IsInRolebb 
(bb 
AppRolesbb "
.bb" #
Patientbb# *
)bb* +
&&bb, .
!bb/ 0
IsOwnPatientIdbb0 >
(bb> ?
recordbb? E
.bbE F
	PatientIdbbF O
)bbO P
)bbP Q
{cc 	
returndd 
Forbiddd 
(dd 
)dd 
;dd 
}ee 	
ifgg 

(gg 
Usergg 
.gg 
IsInRolegg 
(gg 
AppRolesgg "
.gg" #
Doctorgg# )
)gg) *
)gg* +
{hh 	
varii 
doctorIdii 
=ii 
Userii 
.ii  
GetDoctorIdii  +
(ii+ ,
)ii, -
;ii- .
ifkk 
(kk 
doctorIdkk 
==kk 
nullkk  
||kk! #
doctorIdkk$ ,
.kk, -
Valuekk- 2
!=kk3 5
recordkk6 <
.kk< =
DoctorIdkk= E
)kkE F
{ll 
returnmm 
Forbidmm 
(mm 
)mm 
;mm  
}nn 
}oo 	
returnqq 
Okqq 
(qq 
recordqq 
)qq 
;qq 
}rr 
[tt 
HttpPosttt 
]tt 
[uu 
	Authorizeuu 
(uu !
AuthenticationSchemesuu $
=uu% &
JwtBearerDefaultsuu' 8
.uu8 9 
AuthenticationSchemeuu9 M
,uuM N
RolesuuO T
=uuU V
AppRolesuuW _
.uu_ `
Doctoruu` f
)uuf g
]uug h
publicvv 

asyncvv 
Taskvv 
<vv 
IActionResultvv #
>vv# $
CreateHealthRecordvv% 7
(vv7 8!
CreateHealthRecordDtovv8 M
requestvvN U
)vvU V
{ww 
varxx 
doctorIdxx 
=xx 
Userxx 
.xx 
GetDoctorIdxx '
(xx' (
)xx( )
;xx) *
ifzz 

(zz 
doctorIdzz 
==zz 
nullzz 
)zz 
{{{ 	
return|| 
Forbid|| 
(|| 
)|| 
;|| 
}}} 	
var 
record 
= 
await 
healthRecordService .
.. /#
CreateHealthRecordAsync/ F
(F G
requestG N
,N O
doctorIdP X
.X Y
ValueY ^
)^ _
;_ `
return
 
CreatedAtAction
 
(
 
nameof
 %
(
% &!
GetHealthRecordById
& 9
)
9 :
,
: ;
new
< ?
{
@ A
id
B D
=
E F
record
G M
.
M N
Id
N P
}
Q R
,
R S
record
T Z
)
Z [
;
[ \
}
‚‚ 
private
„„ 
bool
„„ 
IsOwnPatientId
„„ 
(
„„  
int
„„  #
	patientId
„„$ -
)
„„- .
{
…… 
return
†† 
User
†† 
.
†† 
GetPatientId
††  
(
††  !
)
††! "
==
††# %
	patientId
††& /
;
††/ 0
}
‡‡ 
}‰‰ ©P
WC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\DoctorsController.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Controllers $
;$ %
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public 
class 
DoctorsController 
( 
IDoctorService -
doctorService. ;
); <
:= >
ControllerBase? M
{ 
[ 
HttpGet 
] 
[ 
AllowAnonymous 
] 
public 

async 
Task 
< 
IActionResult #
># $

GetDoctors% /
(/ 0
[0 1
	FromQuery1 :
]: ; 
DoctorSearchQueryDto< P
queryQ V
)V W
{ 
var 
doctors 
= 
await 
doctorService )
.) *
GetAllDoctorsAsync* <
(< =
query= B
)B C
;C D
return 
Ok 
( 
doctors 
) 
; 
} 
[ 
HttpGet 
( 
$str 
) 
]  
[ 
AllowAnonymous 
] 
public 

async 
Task 
< 
IActionResult #
># $
GetAvailableSlots% 6
(6 7
[   	
	FromQuery  	 
]   
DateOnly   
date   !
,  ! "
[!! 	
	FromQuery!!	 
]!!  
DoctorSpecialisation!! (
?!!( )
specialisation!!* 8
,!!8 9
["" 	
	FromQuery""	 
]"" 
PaginationQueryDto"" &

pagination""' 1
)""1 2
{## 
var$$ 
doctors$$ 
=$$ 
await$$ 
doctorService$$ )
.$$) *"
GetAvailableSlotsAsync$$* @
($$@ A
date$$A E
,$$E F
specialisation$$G U
,$$U V

pagination$$W a
)$$a b
;$$b c
return&& 
Ok&& 
(&& 
doctors&& 
)&& 
;&& 
}'' 
[(( 
HttpGet(( 
((( 
$str(( 
)(( 
](( 
[)) 
	Authorize)) 
()) !
AuthenticationSchemes)) $
=))% &
JwtBearerDefaults))' 8
.))8 9 
AuthenticationScheme))9 M
,))M N
Roles))O T
=))U V
AppRoles))W _
.))_ `
Doctor))` f
)))f g
]))g h
public** 

async** 
Task** 
<** 
IActionResult** #
>**# $
GetCurrentDoctor**% 5
(**5 6
)**6 7
{++ 
var,, 
doctorId,, 
=,, 
User,, 
.,, 
GetDoctorId,, '
(,,' (
),,( )
;,,) *
if.. 

(.. 
doctorId.. 
==.. 
null.. 
).. 
{// 	
return00 
Forbid00 
(00 
)00 
;00 
}11 	
var33 
doctor33 
=33 
await33 
doctorService33 (
.33( )%
GetDoctorProfileByIdAsync33) B
(33B C
doctorId33C K
.33K L
Value33L Q
)33Q R
;33R S
if55 

(55 
doctor55 
==55 
null55 
)55 
{66 	
throw77 
new77 
NotFoundException77 '
(77' (
ErrorMessages77( 5
.775 6
DoctorNotFound776 D
)77D E
;77E F
}88 	
return:: 
Ok:: 
(:: 
doctor:: 
):: 
;:: 
};; 
[== 
HttpPut== 
(== 
$str== 
)== 
]==  
[>> 
	Authorize>> 
(>> !
AuthenticationSchemes>> $
=>>% &
JwtBearerDefaults>>' 8
.>>8 9 
AuthenticationScheme>>9 M
,>>M N
Roles>>O T
=>>U V
AppRoles>>W _
.>>_ `
Doctor>>` f
)>>f g
]>>g h
public?? 

async?? 
Task?? 
<?? 
IActionResult?? #
>??# $+
UpdateCurrentDoctorAvailability??% D
(??D E'
UpdateDoctorAvailabilityDto??E `
request??a h
)??h i
{@@ 
varAA 
doctorIdAA 
=AA 
UserAA 
.AA 
GetDoctorIdAA '
(AA' (
)AA( )
;AA) *
ifCC 

(CC 
doctorIdCC 
==CC 
nullCC 
)CC 
{DD 	
returnEE 
ForbidEE 
(EE 
)EE 
;EE 
}FF 	
varHH 
availabilityHH 
=HH 
awaitHH  
doctorServiceHH! .
.HH. /#
UpdateAvailabilityAsyncHH/ F
(HHF G
doctorIdII 
.II 
ValueII 
,II 
requestJJ 
,JJ 
AppRolesKK 
.KK 
DoctorKK 
,KK 
doctorIdLL 
.LL 
ValueLL 
)LL 
;LL 
returnNN 
OkNN 
(NN 
availabilityNN 
)NN 
;NN  
}OO 
[QQ 
HttpGetQQ 
(QQ 
$strQQ 
)QQ 
]QQ 
[RR 
AllowAnonymousRR 
]RR 
publicSS 

asyncSS 
TaskSS 
<SS 
IActionResultSS #
>SS# $
GetDoctorByIdSS% 2
(SS2 3
intSS3 6
idSS7 9
)SS9 :
{TT 
varUU 
doctorUU 
=UU 
awaitUU 
doctorServiceUU (
.UU( )
GetDoctorByIdAsyncUU) ;
(UU; <
idUU< >
)UU> ?
;UU? @
ifWW 

(WW 
doctorWW 
==WW 
nullWW 
)WW 
{XX 	
throwYY 
newYY 
NotFoundExceptionYY '
(YY' (
ErrorMessagesYY( 5
.YY5 6
DoctorNotFoundYY6 D
)YYD E
;YYE F
}ZZ 	
return\\ 
Ok\\ 
(\\ 
doctor\\ 
)\\ 
;\\ 
}]] 
[__ 
HttpGet__ 
(__ 
$str__ $
)__$ %
]__% &
[`` 
AllowAnonymous`` 
]`` 
publicaa 

asyncaa 
Taskaa 
<aa 
IActionResultaa #
>aa# $
GetAvailabilityaa% 4
(aa4 5
intaa5 8
idaa9 ;
)aa; <
{bb 
varcc 
availabilitycc 
=cc 
awaitcc  
doctorServicecc! .
.cc. / 
GetAvailabilityAsynccc/ C
(ccC D
idccD F
)ccF G
;ccG H
ifee 

(ee 
availabilityee 
==ee 
nullee  
)ee  !
{ff 	
throwgg 
newgg 
NotFoundExceptiongg '
(gg' (
ErrorMessagesgg( 5
.gg5 6
DoctorNotFoundgg6 D
)ggD E
;ggE F
}hh 	
returnjj 
Okjj 
(jj 
availabilityjj 
)jj 
;jj  
}kk 
[mm 
HttpGetmm 
(mm 
$strmm 
)mm 
]mm 
[nn 
AllowAnonymousnn 
]nn 
publicoo 

asyncoo 
Taskoo 
<oo 
IActionResultoo #
>oo# $
GetDoctorSlotsoo% 3
(oo3 4
intoo4 7
idoo8 :
,oo: ;
[oo< =
	FromQueryoo= F
]ooF G
DateOnlyooH P
dateooQ U
)ooU V
{pp 
varqq 
slotsqq 
=qq 
awaitqq 
doctorServiceqq '
.qq' (
GetDoctorSlotsAsyncqq( ;
(qq; <
idqq< >
,qq> ?
dateqq@ D
)qqD E
;qqE F
returnss 
Okss 
(ss 
slotsss 
)ss 
;ss 
}tt 
[vv 
HttpPutvv 
(vv 
$strvv $
)vv$ %
]vv% &
[ww 
	Authorizeww 
(ww !
AuthenticationSchemesww $
=ww% &
JwtBearerDefaultsww' 8
.ww8 9 
AuthenticationSchemeww9 M
,wwM N
RoleswwO T
=wwU V
AppRoleswwW _
.ww_ `
DoctorAdminww` k
)wwk l
]wwl m
publicxx 

asyncxx 
Taskxx 
<xx 
IActionResultxx #
>xx# $
UpdateAvailabilityxx% 7
(xx7 8
intxx8 ;
idxx< >
,xx> ?'
UpdateDoctorAvailabilityDtoxx@ [
requestxx\ c
)xxc d
{yy 
varzz 
currentRolezz 
=zz 
Userzz 
.zz 
GetCurrentRolezz -
(zz- .
)zz. /
;zz/ 0
if|| 

(|| 
currentRole|| 
==|| 
null|| 
)||  
{}} 	
return~~ 
Forbid~~ 
(~~ 
)~~ 
;~~ 
} 	
var
 
availability
 
=
 
await
  
doctorService
! .
.
. /%
UpdateAvailabilityAsync
/ F
(
F G
id
‚‚ 
,
‚‚ 
request
ƒƒ 
,
ƒƒ 
currentRole
„„ 
,
„„ 
User
…… 
.
…… 
GetDoctorId
…… 
(
…… 
)
…… 
)
…… 
;
……  
return
‡‡ 
Ok
‡‡ 
(
‡‡ 
availability
‡‡ 
)
‡‡ 
;
‡‡  
}
 
}‰‰ ω
TC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\AuthController.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Controllers $
;$ %
[ 
ApiController 
] 
[		 
Route		 
(		 
$str		 
)		 
]		 
public

 
class

 
AuthController

 
(

 
IAuthService

 (
authService

) 4
)

4 5
:

6 7
ControllerBase

8 F
{ 
[ 
HttpPost 
( 
$str 
) 
] 
[  
ProducesResponseType 
( 
StatusCodes %
.% &
Status201Created& 6
)6 7
]7 8
[  
ProducesResponseType 
( 
StatusCodes %
.% &
Status400BadRequest& 9
)9 :
]: ;
public 

async 
Task 
< 
IActionResult #
># $
Register% -
(- .
RegisterDto. 9
request: A
)A B
{ 
var 
result 
= 
await 
authService &
.& '
RegisterAsync' 4
(4 5
request5 <
)< =
;= >
if 

( 
! 
result 
. 
Success 
) 
{ 	
return 

BadRequest 
( 
new !
{" #
message$ +
=, -
result. 4
.4 5
Message5 <
}= >
)> ?
;? @
} 	
return 
Created 
( 
string 
. 
Empty #
,# $
new% (
{ 	
message 
= 
result 
. 
Message $
,$ %
userId 
= 
result 
. 
UserId "
} 	
)	 

;
 
} 
[ 
HttpPost 
( 
$str 
) 
] 
[    
ProducesResponseType   
(   
typeof    
(    !
AuthResponseDto  ! 0
)  0 1
,  1 2
StatusCodes  3 >
.  > ?
Status200OK  ? J
)  J K
]  K L
[!!  
ProducesResponseType!! 
(!! 
StatusCodes!! %
.!!% &!
Status401Unauthorized!!& ;
)!!; <
]!!< =
public"" 

async"" 
Task"" 
<"" 
IActionResult"" #
>""# $
Login""% *
(""* +
LoginDto""+ 3
request""4 ;
)""; <
{## 
var$$ 
result$$ 
=$$ 
await$$ 
authService$$ &
.$$& '

LoginAsync$$' 1
($$1 2
request$$2 9
)$$9 :
;$$: ;
if&& 

(&& 
!&& 
result&& 
.&& 
Success&& 
||&& 
result&& %
.&&% &
Response&&& .
==&&/ 1
null&&2 6
)&&6 7
{'' 	
return(( 
Unauthorized(( 
(((  
new((  #
{(($ %
message((& -
=((. /
ErrorMessages((0 =
.((= >
InvalidCredentials((> P
}((Q R
)((R S
;((S T
})) 	
return++ 
Ok++ 
(++ 
result++ 
.++ 
Response++ !
)++! "
;++" #
},, 
}-- ƒm
\C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\AppointmentsController.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Controllers $
;$ %
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
[ 
	Authorize 

(
 !
AuthenticationSchemes  
=! "
JwtBearerDefaults# 4
.4 5 
AuthenticationScheme5 I
,I J
RolesK P
=Q R
AppRolesS [
.[ \
PatientDoctorAdmin\ n
)n o
]o p
public 
class "
AppointmentsController #
(# $
IAppointmentService$ 7
appointmentService8 J
)J K
:L M
ControllerBaseN \
{ 
[ 
HttpGet 
( 
$str 
) 
] 
[ 
	Authorize 
( !
AuthenticationSchemes $
=% &
JwtBearerDefaults' 8
.8 9 
AuthenticationScheme9 M
,M N
RolesO T
=U V
AppRolesW _
._ `
PatientDoctor` m
)m n
]n o
public 

async 
Task 
< 
IActionResult #
># $&
GetCurrentUserAppointments% ?
(? @
[ 
	FromQuery 
] 
DateOnly 
? 
date 
, 
[ 
	FromQuery 
] 
PaginationQueryDto "

pagination# -
)- .
{ 
if 

( 
User 
. 
IsInRole 
( 
AppRoles "
." #
Patient# *
)* +
)+ ,
{ 	
var 
	patientId 
= 
User  
.  !
GetPatientId! -
(- .
). /
;/ 0
if 
( 
	patientId 
== 
null !
)! "
{ 
return 
Forbid 
( 
) 
;  
}   
var"" 
appointments"" 
="" 
await"" $
appointmentService""% 7
.""7 8+
GetAppointmentsByPatientIdAsync""8 W
(""W X
	patientId## 
.## 
Value## 
,##  
null$$ 
,$$ 

pagination%% 
)%% 
;%% 
return'' 
Ok'' 
('' 
appointments'' "
)''" #
;''# $
}(( 	
if** 

(** 
User** 
.** 
IsInRole** 
(** 
AppRoles** "
.**" #
Doctor**# )
)**) *
)*** +
{++ 	
var,, 
doctorId,, 
=,, 
User,, 
.,,  
GetDoctorId,,  +
(,,+ ,
),,, -
;,,- .
if.. 
(.. 
doctorId.. 
==.. 
null..  
)..  !
{// 
return00 
Forbid00 
(00 
)00 
;00  
}11 
var33 
appointments33 
=33 
date33 #
.33# $
HasValue33$ ,
?44 
await44 
appointmentService44 *
.44* +1
%GetAppointmentsByDoctorIdAndDateAsync44+ P
(44P Q
doctorId44Q Y
.44Y Z
Value44Z _
,44_ `
date44a e
.44e f
Value44f k
,44k l

pagination44m w
)44w x
:55 
await55 
appointmentService55 *
.55* +*
GetAppointmentsByDoctorIdAsync55+ I
(55I J
doctorId55J R
.55R S
Value55S X
,55X Y
null55Z ^
,55^ _

pagination55` j
)55j k
;55k l
return77 
Ok77 
(77 
appointments77 "
)77" #
;77# $
}88 	
return:: 
Forbid:: 
(:: 
):: 
;:: 
};; 
[== 
HttpGet== 
]== 
public>> 

async>> 
Task>> 
<>> 
IActionResult>> #
>>># $
GetAppointments>>% 4
(>>4 5
[?? 	
	FromQuery??	 
]?? 
DateOnly?? 
??? 
date?? "
,??" #
[@@ 	
	FromQuery@@	 
]@@ 
PaginationQueryDto@@ &

pagination@@' 1
)@@1 2
{AA 
ifBB 

(BB 
UserBB 
.BB 
IsInRoleBB 
(BB 
AppRolesBB "
.BB" #
AdminBB# (
)BB( )
)BB) *
{CC 	
varDD 
appointmentsDD 
=DD 
awaitDD $
appointmentServiceDD% 7
.DD7 8#
GetAllAppointmentsAsyncDD8 O
(DDO P

paginationDDP Z
)DDZ [
;DD[ \
returnEE 
OkEE 
(EE 
appointmentsEE "
)EE" #
;EE# $
}FF 	
ifHH 

(HH 
UserHH 
.HH 
IsInRoleHH 
(HH 
AppRolesHH "
.HH" #
PatientHH# *
)HH* +
)HH+ ,
{II 	
varJJ 
	patientIdJJ 
=JJ 
UserJJ  
.JJ  !
GetPatientIdJJ! -
(JJ- .
)JJ. /
;JJ/ 0
ifLL 
(LL 
	patientIdLL 
==LL 
nullLL !
)LL! "
{MM 
returnNN 
ForbidNN 
(NN 
)NN 
;NN  
}OO 
varQQ 
appointmentsQQ 
=QQ 
awaitQQ $
appointmentServiceQQ% 7
.QQ7 8+
GetAppointmentsByPatientIdAsyncQQ8 W
(QQW X
	patientIdQQX a
.QQa b
ValueQQb g
,QQg h
nullQQi m
,QQm n

paginationQQo y
)QQy z
;QQz {
returnRR 
OkRR 
(RR 
appointmentsRR "
)RR" #
;RR# $
}SS 	
ifUU 

(UU 
UserUU 
.UU 
IsInRoleUU 
(UU 
AppRolesUU "
.UU" #
DoctorUU# )
)UU) *
)UU* +
{VV 	
varWW 
doctorIdWW 
=WW 
UserWW 
.WW  
GetDoctorIdWW  +
(WW+ ,
)WW, -
;WW- .
ifYY 
(YY 
doctorIdYY 
==YY 
nullYY  
)YY  !
{ZZ 
return[[ 
Forbid[[ 
([[ 
)[[ 
;[[  
}\\ 
var^^ 
appointments^^ 
=^^ 
date^^ #
.^^# $
HasValue^^$ ,
?__ 
await__ 
appointmentService__ *
.__* +1
%GetAppointmentsByDoctorIdAndDateAsync__+ P
(__P Q
doctorId__Q Y
.__Y Z
Value__Z _
,___ `
date__a e
.__e f
Value__f k
,__k l

pagination__m w
)__w x
:`` 
await`` 
appointmentService`` *
.``* +*
GetAppointmentsByDoctorIdAsync``+ I
(``I J
doctorId``J R
.``R S
Value``S X
,``X Y
null``Z ^
,``^ _

pagination``` j
)``j k
;``k l
returnbb 
Okbb 
(bb 
appointmentsbb "
)bb" #
;bb# $
}cc 	
returnee 
Forbidee 
(ee 
)ee 
;ee 
}ff 
[hh 
HttpGethh 
(hh 
$strhh 
)hh 
]hh 
publicii 

asyncii 
Taskii 
<ii 
IActionResultii #
>ii# $
GetAppointmentByIdii% 7
(ii7 8
intii8 ;
idii< >
)ii> ?
{jj 
varkk 
appointmentkk 
=kk 
awaitkk 
appointmentServicekk  2
.kk2 3#
GetAppointmentByIdAsynckk3 J
(kkJ K
idkkK M
)kkM N
;kkN O
ifmm 

(mm 
Usermm 
.mm 
IsInRolemm 
(mm 
AppRolesmm "
.mm" #
Patientmm# *
)mm* +
&&mm, .
Usermm/ 3
.mm3 4
GetPatientIdmm4 @
(mm@ A
)mmA B
!=mmC E
appointmentmmF Q
.mmQ R
	PatientIdmmR [
)mm[ \
{nn 	
returnoo 
Forbidoo 
(oo 
)oo 
;oo 
}pp 	
ifrr 

(rr 
Userrr 
.rr 
IsInRolerr 
(rr 
AppRolesrr "
.rr" #
Doctorrr# )
)rr) *
&&rr+ -
Userrr. 2
.rr2 3
GetDoctorIdrr3 >
(rr> ?
)rr? @
!=rrA C
appointmentrrD O
.rrO P
DoctorIdrrP X
)rrX Y
{ss 	
returntt 
Forbidtt 
(tt 
)tt 
;tt 
}uu 	
returnww 
Okww 
(ww 
appointmentww 
)ww 
;ww 
}xx 
[zz 
HttpPostzz 
]zz 
[{{ 
	Authorize{{ 
({{ !
AuthenticationSchemes{{ $
={{% &
JwtBearerDefaults{{' 8
.{{8 9 
AuthenticationScheme{{9 M
,{{M N
Roles{{O T
={{U V
AppRoles{{W _
.{{_ `
PatientAdmin{{` l
){{l m
]{{m n
public|| 

async|| 
Task|| 
<|| 
IActionResult|| #
>||# $
CreateAppointment||% 6
(||6 7 
CreateAppointmentDto||7 K
request||L S
)||S T
{}} 
if~~ 

(~~ 
User~~ 
.~~ 
IsInRole~~ 
(~~ 
AppRoles~~ "
.~~" #
Patient~~# *
)~~* +
)~~+ ,
{ 	
var
€€ 
	patientId
€€ 
=
€€ 
User
€€  
.
€€  !
GetPatientId
€€! -
(
€€- .
)
€€. /
;
€€/ 0
if
‚‚ 
(
‚‚ 
	patientId
‚‚ 
==
‚‚ 
null
‚‚ !
||
‚‚" $
	patientId
‚‚% .
.
‚‚. /
Value
‚‚/ 4
!=
‚‚5 7
request
‚‚8 ?
.
‚‚? @
	PatientId
‚‚@ I
)
‚‚I J
{
ƒƒ 
return
„„ 
Forbid
„„ 
(
„„ 
)
„„ 
;
„„  
}
…… 
}
†† 	
var
 
appointment
 
=
 
await
  
appointmentService
  2
.
2 3$
CreateAppointmentAsync
3 I
(
I J
request
J Q
)
Q R
;
R S
return
 
appointment
 
==
 
null
 "
?
‹‹ 
throw
‹‹ 
new
‹‹ '
InvalidOperationException
‹‹ 1
(
‹‹1 2
ErrorMessages
‹‹2 ?
.
‹‹? @'
UnableToCreateAppointment
‹‹@ Y
)
‹‹Y Z
:
 
CreatedAtAction
 
(
 
nameof
 $
(
$ % 
GetAppointmentById
% 7
)
7 8
,
8 9
new
: =
{
> ?
id
@ B
=
C D
appointment
E P
.
P Q
Id
Q S
}
T U
,
U V
appointment
W b
)
b c
;
c d
}
 
[
 
HttpPut
 
(
 
$str
 
)
 
]
  
[
 
	Authorize
 
(
 #
AuthenticationSchemes
 $
=
% &
JwtBearerDefaults
' 8
.
8 9"
AuthenticationScheme
9 M
,
M N
Roles
O T
=
U V
AppRoles
W _
.
_ ` 
PatientDoctorAdmin
` r
)
r s
]
s t
public
‘‘ 

async
‘‘ 
Task
‘‘ 
<
‘‘ 
IActionResult
‘‘ #
>
‘‘# $%
UpdateAppointmentStatus
‘‘% <
(
‘‘< =
int
‘‘= @
id
‘‘A C
,
‘‘C D(
UpdateAppointmentStatusDto
‘‘E _
request
‘‘` g
)
‘‘g h
{
’’ 
var
““ 
currentRole
““ 
=
““ 
User
““ 
.
““ 
GetCurrentRole
““ -
(
““- .
)
““. /
;
““/ 0
if
•• 

(
•• 
currentRole
•• 
==
•• 
null
•• 
)
••  
{
–– 	
return
—— 
Forbid
—— 
(
—— 
)
—— 
;
—— 
}
 	
var
 
appointment
 
=
 
await
  
appointmentService
  2
.
2 3*
UpdateAppointmentStatusAsync
3 O
(
O P
id
›› 
,
›› 
request
 
,
 
currentRole
 
,
 
User
 
.
 
GetPatientId
 
(
 
)
 
,
  
User
 
.
 
GetDoctorId
 
(
 
)
 
)
 
;
  
return
΅΅ 
Ok
΅΅ 
(
΅΅ 
appointment
΅΅ 
)
΅΅ 
;
΅΅ 
}
ΆΆ 
}¤¤ ΄-
\C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\AdminHandoffController.cs
	namespace		 	

HealthAxis		
 
.		 
API		 
.		 
Controllers		 $
;		$ %
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public 
class "
AdminHandoffController #
(# $
IAuthService 
authService 
,  
IAdminHandoffService 
adminHandoffService ,
), -
:. /
ControllerBase0 >
{ 
[ 
HttpPost 
( 
$str 
) 
] 
[ 
	Authorize 
( !
AuthenticationSchemes $
=% &
JwtBearerDefaults' 8
.8 9 
AuthenticationScheme9 M
,M N
RolesO T
=U V
AppRolesW _
._ `
Admin` e
)e f
]f g
[  
ProducesResponseType 
( 
typeof  
(  !'
AdminHandoffCodeResponseDto! <
)< =
,= >
StatusCodes? J
.J K
Status200OKK V
)V W
]W X
[  
ProducesResponseType 
( 
StatusCodes %
.% &!
Status401Unauthorized& ;
); <
]< =
[  
ProducesResponseType 
( 
StatusCodes %
.% &
Status403Forbidden& 8
)8 9
]9 :
public 

IActionResult "
CreateAdminHandoffCode /
(/ 0
)0 1
{ 
var 
userId 
= 
User 
. 
FindFirstValue (
(( )

ClaimTypes) 3
.3 4
NameIdentifier4 B
)B C
;C D
if 

( 
string 
. 
IsNullOrWhiteSpace %
(% &
userId& ,
), -
)- .
{ 	
return 
Forbid 
( 
) 
; 
} 	
var 
code 
= 
adminHandoffService &
.& '

CreateCode' 1
(1 2
userId2 8
)8 9
;9 :
return!! 
Ok!! 
(!! 
new!! '
AdminHandoffCodeResponseDto!! 1
{"" 	
Code## 
=## 
code## 
,## 
ExpiresInSeconds$$ 
=$$ 
$num$$ !
}%% 	
)%%	 

;%%
 
}&& 
[(( 
HttpPost(( 
((( 
$str(( 
)(( 
](( 
[)) 
AllowAnonymous)) 
])) 
[**  
ProducesResponseType** 
(** 
typeof**  
(**  !
AuthResponseDto**! 0
)**0 1
,**1 2
StatusCodes**3 >
.**> ?
Status200OK**? J
)**J K
]**K L
[++  
ProducesResponseType++ 
(++ 
StatusCodes++ %
.++% &!
Status401Unauthorized++& ;
)++; <
]++< =
[,,  
ProducesResponseType,, 
(,, 
StatusCodes,, %
.,,% &
Status403Forbidden,,& 8
),,8 9
],,9 :
public-- 

async-- 
Task-- 
<-- 
IActionResult-- #
>--# $$
ExchangeAdminHandoffCode--% =
(--= >#
AdminHandoffExchangeDto--> U
request--V ]
)--] ^
{.. 
var// 
userId// 
=// 
adminHandoffService// (
.//( )
ConsumeCode//) 4
(//4 5
request//5 <
.//< =
Code//= A
)//A B
;//B C
if11 

(11 
string11 
.11 
IsNullOrWhiteSpace11 %
(11% &
userId11& ,
)11, -
)11- .
{22 	
return33 
Unauthorized33 
(33  
new33  #
{33$ %
message33& -
=33. /
$str330 X
}33Y Z
)33Z [
;33[ \
}44 	
var66 
result66 
=66 
await66 
authService66 &
.66& ',
 CreateAuthResponseForUserIdAsync66' G
(66G H
userId66H N
)66N O
;66O P
if88 

(88 
!88 
result88 
.88 
Success88 
||88 
result88 %
.88% &
Response88& .
==88/ 1
null882 6
)886 7
{99 	
return:: 
Unauthorized:: 
(::  
new::  #
{::$ %
message::& -
=::. /
result::0 6
.::6 7
Message::7 >
}::? @
)::@ A
;::A B
};; 	
if== 

(== 
!== 
string== 
.== 
Equals== 
(== 
result== !
.==! "
Response==" *
.==* +
Role==+ /
,==/ 0
AppRoles==1 9
.==9 :
Admin==: ?
,==? @
StringComparison==A Q
.==Q R
OrdinalIgnoreCase==R c
)==c d
)==d e
{>> 	
return?? 
Forbid?? 
(?? 
)?? 
;?? 
}@@ 	
returnBB 
OkBB 
(BB 
resultBB 
.BB 
ResponseBB !
)BB! "
;BB" #
}CC 
}DD µY
UC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\AdminController.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Controllers $
;$ %
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
[ 
	Authorize 

(
 !
AuthenticationSchemes  
=! "
JwtBearerDefaults# 4
.4 5 
AuthenticationScheme5 I
,I J
RolesK P
=Q R
AppRolesS [
.[ \
Admin\ a
)a b
]b c
public 
class 
AdminController 
( 
IAdminService *
adminService+ 7
)7 8
:9 :
ControllerBase; I
{ 
[ 
HttpGet 
( 
$str  
)  !
]! "
public 

async 
Task 
< 
IActionResult #
># $
GetDashboardSummary% 8
(8 9
)9 :
{ 
var 
summary 
= 
await 
adminService (
.( )$
GetDashboardSummaryAsync) A
(A B
)B C
;C D
return 
Ok 
( 
summary 
) 
; 
} 
[ 
HttpGet 
( 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $

GetDoctors% /
(/ 0
[ 	
	FromQuery	 
] 
string 
? 
search "
," #
[ 	
	FromQuery	 
]  
DoctorSpecialisation (
?( )
specialisation* 8
,8 9
[   	
	FromQuery  	 
]   
PaginationQueryDto   &

pagination  ' 1
)  1 2
{!! 
var"" 
doctors"" 
="" 
await"" 
adminService"" (
.""( )
GetDoctorsAsync"") 8
(""8 9

pagination""9 C
,""C D
search""E K
,""K L
specialisation""M [
)""[ \
;""\ ]
return$$ 
Ok$$ 
($$ 
doctors$$ 
)$$ 
;$$ 
}%% 
['' 
HttpPost'' 
('' 
$str'' 
)'' 
]'' 
public(( 

async(( 
Task(( 
<(( 
IActionResult(( #
>((# $
CreateDoctor((% 1
(((1 2
CreateDoctorDto((2 A
request((B I
)((I J
{)) 
var** 
doctor** 
=** 
await** 
adminService** '
.**' (
CreateDoctorAsync**( 9
(**9 :
request**: A
)**A B
;**B C
return,, 
doctor,, 
==,, 
null,, 
?-- 
throw-- 
new-- %
InvalidOperationException-- 1
(--1 2
ErrorMessages--2 ?
.--? @ 
UnableToCreateDoctor--@ T
)--T U
:.. 
Created.. 
(.. 
$".. 
$str.. +
{..+ ,
doctor.., 2
...2 3
Id..3 5
}..5 6
"..6 7
,..7 8
doctor..9 ?
)..? @
;..@ A
}// 
[11 
HttpPut11 
(11 
$str11 
)11  
]11  !
public22 

async22 
Task22 
<22 
IActionResult22 #
>22# $
UpdateDoctor22% 1
(221 2
int222 5
id226 8
,228 9
UpdateDoctorDto22: I
request22J Q
)22Q R
{33 
var44 
doctor44 
=44 
await44 
adminService44 '
.44' (
UpdateDoctorAsync44( 9
(449 :
id44: <
,44< =
request44> E
)44E F
;44F G
return66 
Ok66 
(66 
doctor66 
)66 
;66 
}77 
[99 
HttpPut99 
(99 
$str99 (
)99( )
]99) *
public:: 

async:: 
Task:: 
<:: 
IActionResult:: #
>::# $
ResetDoctorPassword::% 8
(::8 9
int::9 <
id::= ?
,::? @!
AdminResetPasswordDto::A V
request::W ^
)::^ _
{;; 
await<< 
adminService<< 
.<< $
ResetDoctorPasswordAsync<< 3
(<<3 4
id<<4 6
,<<6 7
request<<8 ?
)<<? @
;<<@ A
return>> 
Ok>> 
(>> 
new>> 
{>> 
message>> 
=>>  !
$str>>" G
}>>H I
)>>I J
;>>J K
}?? 
[AA 
HttpGetAA 
(AA 
$strAA ,
)AA, -
]AA- .
publicBB 

asyncBB 
TaskBB 
<BB 
IActionResultBB #
>BB# $!
GetDoctorAppointmentsBB% :
(BB: ;
intCC 
idCC 

,CC
 
[DD 
	FromQueryDD 
]DD 
AppointmentStatusDD !
?DD! "
statusDD# )
,DD) *
[EE 
	FromQueryEE 
]EE 
PaginationQueryDtoEE "

paginationEE# -
)EE- .
{FF 
varGG 
appointmentsGG 
=GG 
awaitGG  
adminServiceGG! -
.GG- .&
GetDoctorAppointmentsAsyncGG. H
(GGH I
idGGI K
,GGK L
statusGGM S
,GGS T

paginationGGU _
)GG_ `
;GG` a
returnII 
OkII 
(II 
appointmentsII 
)II 
;II  
}KK 
[MM 
HttpGetMM 
(MM 
$strMM 
)MM 
]MM 
publicNN 

asyncNN 
TaskNN 
<NN 
IActionResultNN #
>NN# $
GetPatientsNN% 0
(NN0 1
[OO 	
	FromQueryOO	 
]OO 
stringOO 
?OO 
searchOO "
,OO" #
[PP 	
	FromQueryPP	 
]PP 
PaginationQueryDtoPP &

paginationPP' 1
)PP1 2
{QQ 
varRR 
patientsRR 
=RR 
awaitRR 
adminServiceRR )
.RR) *
GetPatientsAsyncRR* :
(RR: ;

paginationRR; E
,RRE F
searchRRG M
)RRM N
;RRN O
returnTT 
OkTT 
(TT 
patientsTT 
)TT 
;TT 
}UU 
[WW 
HttpPutWW 
(WW 
$strWW  
)WW  !
]WW! "
publicXX 

asyncXX 
TaskXX 
<XX 
IActionResultXX #
>XX# $
UpdatePatientXX% 2
(XX2 3
intXX3 6
idXX7 9
,XX9 :
UpdatePatientDtoXX; K
requestXXL S
)XXS T
{YY 
varZZ 
patientZZ 
=ZZ 
awaitZZ 
adminServiceZZ (
.ZZ( )
UpdatePatientAsyncZZ) ;
(ZZ; <
idZZ< >
,ZZ> ?
requestZZ@ G
)ZZG H
;ZZH I
return\\ 
Ok\\ 
(\\ 
patient\\ 
)\\ 
;\\ 
}]] 
[__ 
HttpPut__ 
(__ 
$str__ )
)__) *
]__* +
public`` 

async`` 
Task`` 
<`` 
IActionResult`` #
>``# $ 
ResetPatientPassword``% 9
(``9 :
int``: =
id``> @
,``@ A!
AdminResetPasswordDto``B W
request``X _
)``_ `
{aa 
awaitbb 
adminServicebb 
.bb %
ResetPatientPasswordAsyncbb 4
(bb4 5
idbb5 7
,bb7 8
requestbb9 @
)bb@ A
;bbA B
returndd 
Okdd 
(dd 
newdd 
{dd 
messagedd 
=dd  !
$strdd" H
}ddI J
)ddJ K
;ddK L
}ee 
[gg 
HttpGetgg 
(gg 
$strgg -
)gg- .
]gg. /
publichh 

asynchh 
Taskhh 
<hh 
IActionResulthh #
>hh# $"
GetPatientAppointmentshh% ;
(hh; <
intii 
idii 
,ii 
[jj 	
	FromQueryjj	 
]jj 
AppointmentStatusjj %
?jj% &
statusjj' -
,jj- .
[kk 	
	FromQuerykk	 
]kk 
PaginationQueryDtokk &

paginationkk' 1
)kk1 2
{ll 
varmm 
appointmentsmm 
=mm 
awaitmm  
adminServicemm! -
.mm- .'
GetPatientAppointmentsAsyncmm. I
(mmI J
idmmJ L
,mmL M
statusmmN T
,mmT U

paginationmmV `
)mm` a
;mma b
returnoo 
Okoo 
(oo 
appointmentsoo 
)oo 
;oo  
}pp 
[rr 
HttpGetrr 
(rr 
$strrr #
)rr# $
]rr$ %
publicss 

asyncss 
Taskss 
<ss 
IActionResultss #
>ss# $!
GetAppointmentReportsss% :
(ss: ;
[ss; <
	FromQueryss< E
]ssE F
PaginationQueryDtossG Y

paginationssZ d
)ssd e
{tt 
varuu 
reportsuu 
=uu 
awaituu 
adminServiceuu (
.uu( )&
GetAppointmentReportsAsyncuu) C
(uuC D

paginationuuD N
)uuN O
;uuO P
returnww 
Okww 
(ww 
reportsww 
)ww 
;ww 
}xx 
[zz 
HttpGetzz 
(zz 
$strzz +
)zz+ ,
]zz, -
public{{ 

async{{ 
Task{{ 
<{{ 
IActionResult{{ #
>{{# $'
GetAppointmentReportDetails{{% @
({{@ A
[|| 	
	FromQuery||	 
]|| 
DateOnly|| 
date|| !
,||! "
[}} 	
	FromQuery}}	 
]}} 
AppointmentStatus}} %
?}}% &
status}}' -
,}}- .
[~~ 	
	FromQuery~~	 
]~~ 
PaginationQueryDto~~ &

pagination~~' 1
)~~1 2
{ 
var
€€ 
appointments
€€ 
=
€€ 
await
€€  
adminService
€€! -
.
€€- ..
 GetAppointmentReportDetailsAsync
€€. N
(
€€N O
date
 
,
 
status
‚‚ 
,
‚‚ 

pagination
ƒƒ 
)
ƒƒ 
;
ƒƒ 
return
…… 
Ok
…… 
(
…… 
appointments
…… 
)
…… 
;
……  
}
†† 
}‡‡ ΰ#
WC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\AccountController.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Controllers $
;$ %
[

 
ApiController

 
]

 
[ 
Route 
( 
$str 
) 
] 
[ 
	Authorize 

(
 !
AuthenticationSchemes  
=! "
JwtBearerDefaults# 4
.4 5 
AuthenticationScheme5 I
)I J
]J K
public 
class 
AccountController 
( 
UserManager *
<* +
IdentityUser+ 7
>7 8
userManager9 D
)D E
:F G
ControllerBaseH V
{ 
[ 
HttpPut 
( 
$str 
) 
]  
[  
ProducesResponseType 
( 
StatusCodes %
.% &
Status200OK& 1
)1 2
]2 3
[  
ProducesResponseType 
( 
StatusCodes %
.% &
Status400BadRequest& 9
)9 :
]: ;
[  
ProducesResponseType 
( 
StatusCodes %
.% &
Status403Forbidden& 8
)8 9
]9 :
[  
ProducesResponseType 
( 
StatusCodes %
.% &
Status404NotFound& 7
)7 8
]8 9
public 

async 
Task 
< 
IActionResult #
># $
ChangePassword% 3
(3 4
ChangePasswordDto4 E
requestF M
)M N
{ 
if 

( 
request 
. 
CurrentPassword #
==$ &
request' .
.. /
NewPassword/ :
): ;
{ 	
return 

BadRequest 
( 
new !
{" #
message$ +
=, -
$str. i
}j k
)k l
;l m
} 	
var 
userId 
= 
User 
. 
FindFirstValue (
(( )

ClaimTypes) 3
.3 4
NameIdentifier4 B
)B C
;C D
if 

( 
string 
. 
IsNullOrWhiteSpace %
(% &
userId& ,
), -
)- .
{ 	
return 
Forbid 
( 
) 
; 
}   	
var"" 
user"" 
="" 
await"" 
userManager"" $
.""$ %
FindByIdAsync""% 2
(""2 3
userId""3 9
)""9 :
;"": ;
if$$ 

($$ 
user$$ 
==$$ 
null$$ 
)$$ 
{%% 	
return&& 
NotFound&& 
(&& 
new&& 
{&&  !
message&&" )
=&&* +
$str&&, E
}&&F G
)&&G H
;&&H I
}'' 	
var)) 
result)) 
=)) 
await)) 
userManager)) &
.))& '
ChangePasswordAsync))' :
()): ;
user** 
,** 
request++ 
.++ 
CurrentPassword++ #
,++# $
request,, 
.,, 
NewPassword,, 
),,  
;,,  !
if.. 

(.. 
!.. 
result.. 
... 
	Succeeded.. 
).. 
{// 	
var00 
errors00 
=00 
string00 
.00  
Join00  $
(00$ %
$str00% (
,00( )
result00* 0
.000 1
Errors001 7
.007 8
Select008 >
(00> ?
error00? D
=>00E G
error00H M
.00M N
Description00N Y
)00Y Z
)00Z [
;00[ \
return11 

BadRequest11 
(11 
new11 !
{11" #
message11$ +
=11, -
errors11. 4
}115 6
)116 7
;117 8
}22 	
return44 
Ok44 
(44 
new44 
{44 
message44 
=44  !
$str44" B
}44C D
)44D E
;44E F
}55 
}66 ­@
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Constants\ErrorMessages.cs
	namespace 	

HealthAxis
 
. 
API 
. 
	Constants "
;" #
public 
static 
class 
ErrorMessages !
{ 
public 

const 
string 
InvalidCredentials *
=+ ,
$str- C
;C D
public 

const 
string 
InvalidRefreshToken +
=, -
$str. F
;F G
public		 

const		 
string		 
RefreshTokenExpired		 +
=		, -
$str		. J
;		J K
public 

const 
string 
PasswordsDoNotMatch +
=, -
$str. G
;G H
public 

const 
string "
EmailAlreadyRegistered .
=/ 0
$str1 O
;O P
public 

const 
string 
EmailAlreadyExists *
=+ ,
$str- U
;U V
public 

const 
string 
PatientNotFound '
=( )
$str* >
;> ?
public 

const 
string "
PatientAccountNotFound .
=/ 0
$str1 M
;M N
public 

const 
string "
PatientProfileNotFound .
=/ 0
$str1 _
;_ `
public 

const 
string 
DoctorNotFound &
=' (
$str) <
;< =
public 

const 
string '
DoctorNotFoundAfterCreation 3
=4 5
$str6 X
;X Y
public 

const 
string !
DoctorProfileNotFound -
=. /
$str0 ]
;] ^
public 

const 
string 
DoctorUnavailable )
=* +
$str, W
;W X
public 

const 
string "
DoctorAvailableMessage .
=/ 0
$str1 G
;G H
public!! 

const!! 
string!! $
DoctorUnavailableMessage!! 0
=!!1 2
$str!!3 M
;!!M N
public## 

const## 
string## @
4DoctorCannotDeactivateWithConfirmedAppointmentsToday## L
=##M N
$str	##O Ò
;
##Ò Σ
public%% 

const%% 
string%% /
#DoctorsCanUpdateOnlyOwnAvailability%% ;
=%%< =
$str%%> o
;%%o p
public'' 

const'' 
string'' -
!DoctorEmergencyCancellationReason'' 9
='': ;
$str''< 
;	'' €
public)) 

const)) 
string)) 
AppointmentNotFound)) +
=)), -
$str)). F
;))F G
public++ 

const++ 
string++ ,
 AppointmentNotFoundAfterCreation++ 8
=++9 :
$str++; b
;++b c
public-- 

const-- 
string-- )
AppointmentDateCannotBeInPast-- 5
=--6 7
$str--8 a
;--a b
public// 

const// 
string// 6
*AppointmentMustBeBookedAtLeast48HoursAhead// B
=//C D
$str	//E 
;
// 
public11 

const11 
string11 ;
/AppointmentCannotBeBookedMoreThanSixMonthsAhead11 G
=11H I
$str	11J 
;
11 ‰
public33 

const33 
string33 #
DoctorSlotAlreadyBooked33 /
=330 1
$str332 t
;33t u
public55 

const55 
string55 $
PatientSlotAlreadyBooked55 0
=551 2
$str553 v
;55v w
public77 

const77 
string77 8
,PatientAlreadyHasAppointmentWithDoctorOnDate77 D
=77E F
$str	77G ’
;
77’ “
public99 

const99 
string99 1
%OnlyPendingAppointmentsCanBeConfirmed99 =
=99> ?
$str99@ m
;99m n
public;; 

const;; 
string;; /
#DoctorsCanManageOnlyOwnAppointments;; ;
=;;< =
$str;;> o
;;;o p
public== 

const== 
string== 0
$PatientsCanManageOnlyOwnAppointments== <
==== >
$str==? q
;==q r
public?? 

const?? 
string?? &
CancellationReasonRequired?? 2
=??3 4
$str??5 W
;??W X
publicAA 

constAA 
stringAA 2
&CompletedAppointmentsCannotBeCancelledAA >
=AA? @
$strAAA n
;AAn o
publicCC 

constCC 
stringCC 7
+CancelledAppointmentsCannotBeCancelledAgainCC C
=CCD E
$strCCF t
;CCt u
publicEE 

constEE 
stringEE 5
)AppointmentCannotBeCancelledWithin24HoursEE A
=EEB C
$str	EED 
;
EE 
publicGG 

constGG 
stringGG 7
+AppointmentCompletedOnlyThroughHealthRecordGG C
=GGD E
$str	GGF ‡
;
GG‡ 
publicII 

constII 
stringII 2
&UnsupportedAppointmentStatusTransitionII >
=II? @
$strIIA m
;IIm n
publicKK 

constKK 
stringKK 1
%PendingAppointmentAutoCancelledReasonKK =
=KK> ?
$str	KK@ °
;
KK° ±
publicMM 

constMM 
stringMM $
CancelledByPatientSuffixMM 0
=MM1 2
$strMM3 L
;MML M
publicOO 

constOO 
stringOO #
CancelledByDoctorSuffixOO /
=OO0 1
$strOO2 J
;OOJ K
publicQQ 

constQQ 
stringQQ "
CancelledByAdminSuffixQQ .
=QQ/ 0
$strQQ1 H
;QQH I
publicSS 

constSS 
stringSS ?
3AppointmentCannotBeDeletedBecauseHealthRecordExistsSS K
=SSL M
$str	SSN Ά
;
SSΆ £
publicUU 

constUU 
stringUU  
HealthRecordNotFoundUU ,
=UU- .
$strUU/ I
;UUI J
publicWW 

constWW 
stringWW -
!HealthRecordNotFoundAfterCreationWW 9
=WW: ;
$strWW< e
;WWe f
publicYY 

constYY 
stringYY <
0DoctorCanCreateHealthRecordOnlyForOwnAppointmentYY H
=YYI J
$str	YYK 
;
YY 
public[[ 

const[[ 
string[[ 3
'OnlyConfirmedAppointmentsCanBeCompleted[[ ?
=[[@ A
$str[[B q
;[[q r
public]] 

const]] 
string]] 9
-HealthRecordCanBeCreatedOnlyOnAppointmentDate]] E
=]]F G
$str	]]H …
;
]]… †
public__ 

const__ 
string__ -
!VisitDateMustMatchAppointmentDate__ 9
=__: ;
$str__< i
;__i j
publicaa 

constaa 
stringaa 3
'HealthRecordAlreadyExistsForAppointmentaa ?
=aa@ A
$straaB x
;aax y
publiccc 

constcc 
stringcc  
UnableToCreateDoctorcc ,
=cc- .
$strcc/ I
;ccI J
publicee 

constee 
stringee %
UnableToCreateAppointmentee 1
=ee2 3
$stree4 S
;eeS T
publicgg 

constgg 
stringgg &
UnableToCreateHealthRecordgg 2
=gg3 4
$strgg5 V
;ggV W
publicii 

constii 
stringii 4
(PatientsCanCancelOnlyPendingAppointmentsii @
=iiA B
$strjj 4
;jj4 5
publicll 

constll 
stringll >
2DoctorsCanCancelOnlyPendingOrConfirmedAppointmentsll J
=llK L
$strmm @
;mm@ A
}nn 