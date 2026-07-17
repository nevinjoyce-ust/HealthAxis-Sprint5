¢
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
} ïG
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
}gg õx
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
ÄÄ 
;
ÄÄ 
var
ÇÇ 
createdRecord
ÇÇ 
=
ÇÇ 
await
ÇÇ  %$
healthRecordRepository
ÇÇ& <
.
ÇÇ< =
AddAsync
ÇÇ= E
(
ÇÇE F
healthRecord
ÇÇF R
)
ÇÇR S
;
ÇÇS T
appointment
ÑÑ 
.
ÑÑ 
Status
ÑÑ 
=
ÑÑ  
AppointmentStatus
ÑÑ! 2
.
ÑÑ2 3
	Completed
ÑÑ3 <
;
ÑÑ< =
await
ÖÖ #
appointmentRepository
ÖÖ '
.
ÖÖ' (
UpdateAsync
ÖÖ( 3
(
ÖÖ3 4
appointment
ÖÖ4 ?
)
ÖÖ? @
;
ÖÖ@ A
await
áá 
transaction
áá 
.
áá 
CommitAsync
áá )
(
áá) *
)
áá* +
;
áá+ ,
var
ââ 
recordWithDetails
ââ !
=
ââ" #
await
ââ$ )$
healthRecordRepository
ââ* @
.
ââ@ A1
#GetHealthRecordByIdWithDetailsAsync
ââA d
(
ââd e
createdRecord
ââe r
.
ââr s
Id
ââs u
)
ââu v
;
ââv w
return
ãã 
recordWithDetails
ãã $
==
ãã% '
null
ãã( ,
?
åå 
throw
åå 
new
åå 
NotFoundException
åå -
(
åå- .
ErrorMessages
åå. ;
.
åå; </
!HealthRecordNotFoundAfterCreation
åå< ]
)
åå] ^
:
çç 
mapper
çç 
.
çç 
Map
çç 
<
çç 
HealthRecordDto
çç ,
>
çç, -
(
çç- .
recordWithDetails
çç. ?
)
çç? @
;
çç@ A
}
éé 	
catch
èè 
{
êê 	
await
ëë 
transaction
ëë 
.
ëë 
RollbackAsync
ëë +
(
ëë+ ,
)
ëë, -
;
ëë- .
throw
íí 
;
íí 
}
ìì 	
}
îî 
public
ññ 

async
ññ 
Task
ññ 
<
ññ 
PagedResultDto
ññ $
<
ññ$ %
HealthRecordDto
ññ% 4
>
ññ4 5
>
ññ5 6-
GetHealthRecordsByDoctorIdAsync
ññ7 V
(
ññV W
int
óó 
doctorId
óó 
,
óó  
PaginationQueryDto
òò 

pagination
òò %
)
òò% &
{
ôô 
var
öö 
records
öö 
=
öö 
await
öö $
healthRecordRepository
öö 2
.
öö2 3-
GetHealthRecordsByDoctorIdAsync
öö3 R
(
ööR S
doctorId
õõ 
,
õõ 

pagination
úú 
.
úú 

PageNumber
úú !
,
úú! "

pagination
ùù 
.
ùù 
PageSize
ùù 
)
ùù  
;
ùù  !
return
üü 
MapPagedResult
üü 
<
üü 
HealthRecord
üü *
,
üü* +
HealthRecordDto
üü, ;
>
üü; <
(
üü< =
records
üü= D
)
üüD E
;
üüE F
}
†† 
private
¢¢ 
static
¢¢ 
int
¢¢ 
CalculateAge
¢¢ #
(
¢¢# $
DateOnly
¢¢$ ,
dateOfBirth
¢¢- 8
,
¢¢8 9
DateOnly
¢¢: B
referenceDate
¢¢C P
)
¢¢P Q
{
££ 
var
§§ 
age
§§ 
=
§§ 
referenceDate
§§ 
.
§§  
Year
§§  $
-
§§% &
dateOfBirth
§§' 2
.
§§2 3
Year
§§3 7
;
§§7 8
if
¶¶ 

(
¶¶ 
referenceDate
¶¶ 
<
¶¶ 
dateOfBirth
¶¶ '
.
¶¶' (
AddYears
¶¶( 0
(
¶¶0 1
age
¶¶1 4
)
¶¶4 5
)
¶¶5 6
{
ßß 	
age
®® 
--
®® 
;
®® 
}
©© 	
return
´´ 
age
´´ 
;
´´ 
}
¨¨ 
private
ÆÆ 
PagedResultDto
ÆÆ 
<
ÆÆ 
TDestination
ÆÆ '
>
ÆÆ' (
MapPagedResult
ÆÆ) 7
<
ÆÆ7 8
TSource
ÆÆ8 ?
,
ÆÆ? @
TDestination
ÆÆA M
>
ÆÆM N
(
ÆÆN O
PagedResult
ÆÆO Z
<
ÆÆZ [
TSource
ÆÆ[ b
>
ÆÆb c
pagedResult
ÆÆd o
)
ÆÆo p
{
ØØ 
return
∞∞ 
new
∞∞ 
PagedResultDto
∞∞ !
<
∞∞! "
TDestination
∞∞" .
>
∞∞. /
{
±± 	
Items
≤≤ 
=
≤≤ 
mapper
≤≤ 
.
≤≤ 
Map
≤≤ 
<
≤≤ 
List
≤≤ #
<
≤≤# $
TDestination
≤≤$ 0
>
≤≤0 1
>
≤≤1 2
(
≤≤2 3
pagedResult
≤≤3 >
.
≤≤> ?
Items
≤≤? D
)
≤≤D E
,
≤≤E F

PageNumber
≥≥ 
=
≥≥ 
pagedResult
≥≥ $
.
≥≥$ %

PageNumber
≥≥% /
,
≥≥/ 0
PageSize
¥¥ 
=
¥¥ 
pagedResult
¥¥ "
.
¥¥" #
PageSize
¥¥# +
,
¥¥+ ,

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
∂∂ 
=
∂∂ 
pagedResult
∂∂ $
.
∂∂$ %

TotalPages
∂∂% /
}
∑∑ 	
;
∑∑	 

}
∏∏ 
}ππ ÅÛ
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
,0 1+
IDoctorAvailabilityCacheService #$
availabilityCacheService$ <
)< =
:> ?
IDoctorService@ N
{ 
private 
static 
readonly 
TimeOnly $
WorkDayStart% 1
=2 3
new4 7
(7 8
$num8 9
,9 :
$num; <
)< =
;= >
private 
static 
readonly 
TimeOnly $

LunchStart% /
=0 1
new2 5
(5 6
$num6 8
,8 9
$num: ;
); <
;< =
private 
static 
readonly 
TimeOnly $
LunchEnd% -
=. /
new0 3
(3 4
$num4 6
,6 7
$num8 9
)9 :
;: ;
private 
static 
readonly 
TimeOnly $

WorkDayEnd% /
=0 1
new2 5
(5 6
$num6 8
,8 9
$num: ;
); <
;< =
private 
static 
readonly 
TimeSpan $
SlotDuration% 1
=2 3
TimeSpan4 <
.< =
FromMinutes= H
(H I
$numI K
)K L
;L M
private 
const 
int 0
$MinimumBookingHoursBeforeAppointment :
=; <
$num= ?
;? @
private 
const 
int 4
(AvailabilityCacheInvalidationMonthsAhead >
=? @
$numA B
;B C
public 

async 
Task 
< 
PagedResultDto $
<$ %
PublicDoctorDto% 4
>4 5
>5 6
GetAllDoctorsAsync7 I
(I J 
DoctorSearchQueryDtoJ ^
query_ d
)d e
{ 
var 
doctors 
= 
await 
doctorRepository ,
., -
GetAllDoctorsAsync- ?
(? @
query 
. 

PageNumber 
, 
query   
.   
PageSize   
,   
query!! 
.!! 
Search!! 
,!! 
query"" 
."" 
Specialisation""  
,""  !
query## 
.## 
IsAvailable## 
,## 
query$$ 
.$$ 
SortBy$$ 
,$$ 
query%% 
.%% 
SortDirection%% 
)%%  
;%%  !
return'' 
MapPagedResult'' 
<'' 
Doctor'' $
,''$ %
PublicDoctorDto''& 5
>''5 6
(''6 7
doctors''7 >
)''> ?
;''? @
}(( 
public** 

async** 
Task** 
<** 
PublicDoctorDto** %
?**% &
>**& '
GetDoctorByIdAsync**( :
(**: ;
int**; >
id**? A
)**A B
{++ 
var,, 
doctor,, 
=,, 
await,, 
doctorRepository,, +
.,,+ ,
GetDoctorByIdAsync,,, >
(,,> ?
id,,? A
),,A B
;,,B C
if.. 

(.. 
doctor.. 
==.. 
null.. 
).. 
{// 	
return00 
null00 
;00 
}11 	
return33 
mapper33 
.33 
Map33 
<33 
PublicDoctorDto33 )
>33) *
(33* +
doctor33+ 1
)331 2
;332 3
}44 
public66 

async66 
Task66 
<66 
PublicDoctorDto66 %
?66% &
>66& '"
GetDoctorByUserIdAsync66( >
(66> ?
string66? E
userId66F L
)66L M
{77 
var88 
doctor88 
=88 
await88 
doctorRepository88 +
.88+ ,"
GetDoctorByUserIdAsync88, B
(88B C
userId88C I
)88I J
;88J K
if:: 

(:: 
doctor:: 
==:: 
null:: 
):: 
{;; 	
return<< 
null<< 
;<< 
}== 	
return?? 
mapper?? 
.?? 
Map?? 
<?? 
PublicDoctorDto?? )
>??) *
(??* +
doctor??+ 1
)??1 2
;??2 3
}@@ 
publicBB 

asyncBB 
TaskBB 
<BB !
DoctorAvailabilityDtoBB +
?BB+ ,
>BB, - 
GetAvailabilityAsyncBB. B
(BBB C
intBBC F
idBBG I
)BBI J
{CC 
varDD 
availabilityDD 
=DD 
awaitDD  
doctorRepositoryDD! 1
.DD1 2 
GetAvailabilityAsyncDD2 F
(DDF G
idDDG I
)DDI J
;DDJ K
ifFF 

(FF 
availabilityFF 
==FF 
nullFF  
)FF  !
{GG 	
returnHH 
nullHH 
;HH 
}II 	
returnKK 
newKK !
DoctorAvailabilityDtoKK (
{LL 	
DoctorIdMM 
=MM 
idMM 
,MM 
IsAvailableNN 
=NN 
availabilityNN &
.NN& '
ValueNN' ,
,NN, -
MessageOO 
=OO 
availabilityOO "
.OO" #
ValueOO# (
?PP 
ErrorMessagesPP 
.PP  "
DoctorAvailableMessagePP  6
:QQ 
ErrorMessagesQQ 
.QQ  $
DoctorUnavailableMessageQQ  8
}RR 	
;RR	 

}SS 
publicUU 

asyncUU 
TaskUU 
<UU #
DoctorAvailableSlotsDtoUU -
>UU- .
GetDoctorSlotsAsyncUU/ B
(UUB C
intUUC F
idUUG I
,UUI J
DateOnlyUUK S
dateUUT X
)UUX Y
{VV 
varWW 
cachedSlotsWW 
=WW 
awaitWW $
availabilityCacheServiceWW  8
.WW8 9
GetDoctorSlotsAsyncWW9 L
(WWL M
idWWM O
,WWO P
dateWWQ U
)WWU V
;WWV W
ifYY 

(YY 
cachedSlotsYY 
!=YY 
nullYY 
)YY  
{ZZ 	
return[[ 
cachedSlots[[ 
;[[ 
}\\ 	
var^^ 
doctor^^ 
=^^ 
await^^ 
doctorRepository^^ +
.^^+ ,
GetDoctorByIdAsync^^, >
(^^> ?
id^^? A
)^^A B
;^^B C
if`` 

(`` 
doctor`` 
==`` 
null`` 
)`` 
{aa 	
throwbb 
newbb 
NotFoundExceptionbb '
(bb' (
ErrorMessagesbb( 5
.bb5 6
DoctorNotFoundbb6 D
)bbD E
;bbE F
}cc 	
returnee 
awaitee )
BuildAndCacheDoctorSlotsAsyncee 2
(ee2 3
doctoree3 9
,ee9 :
dateee; ?
)ee? @
;ee@ A
}ff 
publichh 

asynchh 
Taskhh 
<hh 
PagedResultDtohh $
<hh$ %#
DoctorAvailableSlotsDtohh% <
>hh< =
>hh= >"
GetAvailableSlotsAsynchh? U
(hhU V
DateOnlyii 
dateii 
,ii  
DoctorSpecialisationjj 
?jj 
specialisationjj ,
,jj, -
PaginationQueryDtokk 

paginationkk %
)kk% &
{ll 
varmm 
doctorsmm 
=mm 
awaitmm 
doctorRepositorymm ,
.mm, -$
GetAvailableDoctorsAsyncmm- E
(mmE F
specialisationmmF T
)mmT U
;mmU V
varnn %
doctorsWithAvailableSlotsnn %
=nn& '
newnn( +
Listnn, 0
<nn0 1#
DoctorAvailableSlotsDtonn1 H
>nnH I
(nnI J
)nnJ K
;nnK L
foreachpp 
(pp 
varpp 
doctorpp 
inpp 
doctorspp &
)pp& '
{qq 	
varrr 
doctorSlotsrr 
=rr 
awaitrr #,
 GetCachedOrBuildDoctorSlotsAsyncrr$ D
(rrD E
doctorrrE K
,rrK L
daterrM Q
)rrQ R
;rrR S
iftt 
(tt 
doctorSlotstt 
.tt 
AvailableSlotstt *
.tt* +
Counttt+ 0
>tt1 2
$numtt3 4
)tt4 5
{uu %
doctorsWithAvailableSlotsvv )
.vv) *
Addvv* -
(vv- .
doctorSlotsvv. 9
)vv9 :
;vv: ;
}ww 
}xx 	
varzz 

totalCountzz 
=zz %
doctorsWithAvailableSlotszz 2
.zz2 3
Countzz3 8
;zz8 9
var{{ 

totalPages{{ 
={{ 

totalCount{{ #
=={{$ &
$num{{' (
?|| 
$num|| 
:}} 
(}} 
int}} 
)}} 
Math}} 
.}} 
Ceiling}} 
(}}  

totalCount}}  *
/}}+ ,
(}}- .
double}}. 4
)}}4 5

pagination}}5 ?
.}}? @
PageSize}}@ H
)}}H I
;}}I J
var 

pagedItems 
= %
doctorsWithAvailableSlots 2
.
ÄÄ 
Skip
ÄÄ 
(
ÄÄ 
(
ÄÄ 

pagination
ÄÄ 
.
ÄÄ 

PageNumber
ÄÄ (
-
ÄÄ) *
$num
ÄÄ+ ,
)
ÄÄ, -
*
ÄÄ. /

pagination
ÄÄ0 :
.
ÄÄ: ;
PageSize
ÄÄ; C
)
ÄÄC D
.
ÅÅ 
Take
ÅÅ 
(
ÅÅ 

pagination
ÅÅ 
.
ÅÅ 
PageSize
ÅÅ %
)
ÅÅ% &
.
ÇÇ 
ToList
ÇÇ 
(
ÇÇ 
)
ÇÇ 
;
ÇÇ 
return
ÑÑ 
new
ÑÑ 
PagedResultDto
ÑÑ !
<
ÑÑ! "%
DoctorAvailableSlotsDto
ÑÑ" 9
>
ÑÑ9 :
{
ÖÖ 	
Items
ÜÜ 
=
ÜÜ 

pagedItems
ÜÜ 
,
ÜÜ 

PageNumber
áá 
=
áá 

pagination
áá #
.
áá# $

PageNumber
áá$ .
,
áá. /
PageSize
àà 
=
àà 

pagination
àà !
.
àà! "
PageSize
àà" *
,
àà* +

TotalCount
ââ 
=
ââ 

totalCount
ââ #
,
ââ# $

TotalPages
ää 
=
ää 

totalPages
ää #
}
ãã 	
;
ãã	 

}
åå 
public
éé 

async
éé 
Task
éé 
<
éé #
DoctorAvailabilityDto
éé +
>
éé+ ,%
UpdateAvailabilityAsync
éé- D
(
ééD E
int
èè 
id
èè 
,
èè )
UpdateDoctorAvailabilityDto
êê #
dto
êê$ '
,
êê' (
string
ëë 
currentRole
ëë 
,
ëë 
int
íí 
?
íí 
currentDoctorId
íí 
)
íí 
{
ìì 
var
îî 
doctor
îî 
=
îî 
await
îî 
doctorRepository
îî +
.
îî+ , 
GetDoctorByIdAsync
îî, >
(
îî> ?
id
îî? A
)
îîA B
;
îîB C
if
ññ 

(
ññ 
doctor
ññ 
==
ññ 
null
ññ 
)
ññ 
{
óó 	
throw
òò 
new
òò 
NotFoundException
òò '
(
òò' (
ErrorMessages
òò( 5
.
òò5 6
DoctorNotFound
òò6 D
)
òòD E
;
òòE F
}
ôô 	2
$ValidateAvailabilityUpdatePermission
õõ ,
(
õõ, -
id
õõ- /
,
õõ/ 0
currentRole
õõ1 <
,
õõ< =
currentDoctorId
õõ> M
)
õõM N
;
õõN O
var
ùù 
isDeactivation
ùù 
=
ùù 
doctor
ùù #
.
ùù# $
IsAvailable
ùù$ /
&&
ùù0 2
!
ùù3 4
dto
ùù4 7
.
ùù7 8
IsAvailable
ùù8 C
;
ùùC D
if
üü 

(
üü 
isDeactivation
üü 
)
üü 
{
†† 	
await
°° %
HandleDeactivationAsync
°° )
(
°°) *
id
°°* ,
,
°°, -
currentRole
°°. 9
)
°°9 :
;
°°: ;
}
¢¢ 	
doctor
§§ 
.
§§ 
IsAvailable
§§ 
=
§§ 
dto
§§  
.
§§  !
IsAvailable
§§! ,
;
§§, -
var
¶¶ 
updatedDoctor
¶¶ 
=
¶¶ 
await
¶¶ !
doctorRepository
¶¶" 2
.
¶¶2 3
UpdateAsync
¶¶3 >
(
¶¶> ?
doctor
¶¶? E
)
¶¶E F
;
¶¶F G
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
©© 	
throw
™™ 
new
™™ 
NotFoundException
™™ '
(
™™' (
ErrorMessages
™™( 5
.
™™5 6
DoctorNotFound
™™6 D
)
™™D E
;
™™E F
}
´´ 	
await
≠≠ &
availabilityCacheService
≠≠ &
.
≠≠& '0
"RemoveDoctorAvailabilityRangeAsync
≠≠' I
(
≠≠I J
updatedDoctor
ÆÆ 
.
ÆÆ 
Id
ÆÆ 
,
ÆÆ 6
(AvailabilityCacheInvalidationMonthsAhead
ØØ 4
)
ØØ4 5
;
ØØ5 6
return
±± #
CreateAvailabilityDto
±± $
(
±±$ %
updatedDoctor
±±% 2
.
±±2 3
Id
±±3 5
,
±±5 6
updatedDoctor
±±7 D
.
±±D E
IsAvailable
±±E P
)
±±P Q
;
±±Q R
}
≤≤ 
public
¥¥ 

async
¥¥ 
Task
¥¥ 
<
¥¥ 
	DoctorDto
¥¥ 
?
¥¥  
>
¥¥  !'
GetDoctorProfileByIdAsync
¥¥" ;
(
¥¥; <
int
¥¥< ?
id
¥¥@ B
)
¥¥B C
{
µµ 
var
∂∂ 
doctor
∂∂ 
=
∂∂ 
await
∂∂ 
doctorRepository
∂∂ +
.
∂∂+ ,(
GetDoctorByIdWithUserAsync
∂∂, F
(
∂∂F G
id
∂∂G I
)
∂∂I J
;
∂∂J K
if
∏∏ 

(
∏∏ 
doctor
∏∏ 
==
∏∏ 
null
∏∏ 
)
∏∏ 
{
ππ 	
return
∫∫ 
null
∫∫ 
;
∫∫ 
}
ªª 	
return
ΩΩ 
mapper
ΩΩ 
.
ΩΩ 
Map
ΩΩ 
<
ΩΩ 
	DoctorDto
ΩΩ #
>
ΩΩ# $
(
ΩΩ$ %
doctor
ΩΩ% +
)
ΩΩ+ ,
;
ΩΩ, -
}
ææ 
private
¿¿ 
async
¿¿ 
Task
¿¿ 
<
¿¿ %
DoctorAvailableSlotsDto
¿¿ .
>
¿¿. /.
 GetCachedOrBuildDoctorSlotsAsync
¿¿0 P
(
¿¿P Q
Doctor
¿¿Q W
doctor
¿¿X ^
,
¿¿^ _
DateOnly
¿¿` h
date
¿¿i m
)
¿¿m n
{
¡¡ 
var
¬¬ 
cachedSlots
¬¬ 
=
¬¬ 
await
¬¬ &
availabilityCacheService
¬¬  8
.
¬¬8 9!
GetDoctorSlotsAsync
¬¬9 L
(
¬¬L M
doctor
¬¬M S
.
¬¬S T
Id
¬¬T V
,
¬¬V W
date
¬¬X \
)
¬¬\ ]
;
¬¬] ^
if
ƒƒ 

(
ƒƒ 
cachedSlots
ƒƒ 
!=
ƒƒ 
null
ƒƒ 
)
ƒƒ  
{
≈≈ 	
return
∆∆ 
cachedSlots
∆∆ 
;
∆∆ 
}
«« 	
return
…… 
await
…… +
BuildAndCacheDoctorSlotsAsync
…… 2
(
……2 3
doctor
……3 9
,
……9 :
date
……; ?
)
……? @
;
……@ A
}
   
private
ÃÃ 
async
ÃÃ 
Task
ÃÃ 
<
ÃÃ %
DoctorAvailableSlotsDto
ÃÃ .
>
ÃÃ. /+
BuildAndCacheDoctorSlotsAsync
ÃÃ0 M
(
ÃÃM N
Doctor
ÃÃN T
doctor
ÃÃU [
,
ÃÃ[ \
DateOnly
ÃÃ] e
date
ÃÃf j
)
ÃÃj k
{
ÕÕ 
var
ŒŒ 
bookedTimes
ŒŒ 
=
ŒŒ 
await
ŒŒ !
GetBookedTimesAsync
ŒŒ  3
(
ŒŒ3 4
doctor
ŒŒ4 :
.
ŒŒ: ;
Id
ŒŒ; =
,
ŒŒ= >
date
ŒŒ? C
)
ŒŒC D
;
ŒŒD E
var
œœ 
slots
œœ 
=
œœ +
CreateDoctorAvailableSlotsDto
œœ 1
(
œœ1 2
doctor
œœ2 8
,
œœ8 9
date
œœ: >
,
œœ> ?
bookedTimes
œœ@ K
)
œœK L
;
œœL M
await
—— &
availabilityCacheService
—— &
.
——& '!
SetDoctorSlotsAsync
——' :
(
——: ;
doctor
——; A
.
——A B
Id
——B D
,
——D E
date
——F J
,
——J K
slots
——L Q
)
——Q R
;
——R S
return
”” 
slots
”” 
;
”” 
}
‘‘ 
private
÷÷ 
static
÷÷ %
DoctorAvailableSlotsDto
÷÷ *+
CreateDoctorAvailableSlotsDto
÷÷+ H
(
÷÷H I
Doctor
◊◊ 
doctor
◊◊ 
,
◊◊ 
DateOnly
ÿÿ 
date
ÿÿ 
,
ÿÿ 
HashSet
ŸŸ 
<
ŸŸ 
TimeOnly
ŸŸ 
>
ŸŸ 
bookedTimes
ŸŸ %
)
ŸŸ% &
{
⁄⁄ 
return
€€ 
new
€€ %
DoctorAvailableSlotsDto
€€ *
{
‹‹ 	
DoctorId
›› 
=
›› 
doctor
›› 
.
›› 
Id
››  
,
››  !

DoctorName
ﬁﬁ 
=
ﬁﬁ 
doctor
ﬁﬁ 
.
ﬁﬁ  
FullName
ﬁﬁ  (
,
ﬁﬁ( )
Specialisation
ﬂﬂ 
=
ﬂﬂ 
doctor
ﬂﬂ #
.
ﬂﬂ# $
Specialisation
ﬂﬂ$ 2
,
ﬂﬂ2 3
YearsOfExperience
‡‡ 
=
‡‡ 
doctor
‡‡  &
.
‡‡& '(
CalculateYearsOfExperience
‡‡' A
(
‡‡A B
)
‡‡B C
,
‡‡C D
ConsultationFee
·· 
=
·· 
doctor
·· $
.
··$ %
ConsultationFee
··% 4
,
··4 5
IsAvailable
‚‚ 
=
‚‚ 
doctor
‚‚  
.
‚‚  !
IsAvailable
‚‚! ,
,
‚‚, -
AvailableSlots
„„ 
=
„„ $
GenerateAvailableSlots
„„ 3
(
„„3 4
date
„„4 8
,
„„8 9
doctor
„„: @
.
„„@ A
IsAvailable
„„A L
,
„„L M
bookedTimes
„„N Y
)
„„Y Z
}
‰‰ 	
;
‰‰	 

}
ÂÂ 
private
ÁÁ 
async
ÁÁ 
Task
ÁÁ 
<
ÁÁ 
HashSet
ÁÁ 
<
ÁÁ 
TimeOnly
ÁÁ '
>
ÁÁ' (
>
ÁÁ( )!
GetBookedTimesAsync
ÁÁ* =
(
ÁÁ= >
int
ËË 
doctorId
ËË 
,
ËË 
DateOnly
ÈÈ 
date
ÈÈ 
)
ÈÈ 
{
ÍÍ 
var
ÎÎ 
appointments
ÎÎ 
=
ÎÎ 
await
ÎÎ  #
appointmentRepository
ÎÎ! 6
.
ÎÎ6 7?
1GetNonCancelledAppointmentsByDoctorIdAndDateAsync
ÎÎ7 h
(
ÎÎh i
doctorId
ÏÏ 
,
ÏÏ 
date
ÌÌ 
)
ÌÌ 
;
ÌÌ 
return
ÔÔ 
appointments
ÔÔ 
.
 
Select
 
(
 
appointment
 
=>
  "
appointment
# .
.
. /
AppointmentTime
/ >
)
> ?
.
ÒÒ 
	ToHashSet
ÒÒ 
(
ÒÒ 
)
ÒÒ 
;
ÒÒ 
}
ÚÚ 
private
ÙÙ 
static
ÙÙ 
List
ÙÙ 
<
ÙÙ 
TimeOnly
ÙÙ  
>
ÙÙ  !$
GenerateAvailableSlots
ÙÙ" 8
(
ÙÙ8 9
DateOnly
ıı 
date
ıı 
,
ıı 
bool
ˆˆ 
doctorIsAvailable
ˆˆ 
,
ˆˆ 
HashSet
˜˜ 
<
˜˜ 
TimeOnly
˜˜ 
>
˜˜ 
bookedTimes
˜˜ %
)
˜˜% &
{
¯¯ 
var
˘˘ 
slots
˘˘ 
=
˘˘ 
new
˘˘ 
List
˘˘ 
<
˘˘ 
TimeOnly
˘˘ %
>
˘˘% &
(
˘˘& '
)
˘˘' (
;
˘˘( )
if
˚˚ 

(
˚˚ 
!
˚˚ 
doctorIsAvailable
˚˚ 
)
˚˚ 
{
¸¸ 	
return
˝˝ 
slots
˝˝ 
;
˝˝ 
}
˛˛ 	
for
ÄÄ 
(
ÄÄ 
var
ÄÄ 
current
ÄÄ 
=
ÄÄ 
WorkDayStart
ÄÄ '
;
ÄÄ' (
current
ÄÄ) 0
<
ÄÄ1 2

WorkDayEnd
ÄÄ3 =
;
ÄÄ= >
current
ÄÄ? F
=
ÄÄG H
current
ÄÄI P
.
ÄÄP Q
Add
ÄÄQ T
(
ÄÄT U
SlotDuration
ÄÄU a
)
ÄÄa b
)
ÄÄb c
{
ÅÅ 	
if
ÇÇ 
(
ÇÇ 
current
ÇÇ 
>=
ÇÇ 

LunchStart
ÇÇ %
&&
ÇÇ& (
current
ÇÇ) 0
<
ÇÇ1 2
LunchEnd
ÇÇ3 ;
)
ÇÇ; <
{
ÉÉ 
continue
ÑÑ 
;
ÑÑ 
}
ÖÖ 
if
áá 
(
áá 
!
áá !
IsAtLeastHoursAhead
áá $
(
áá$ %
date
áá% )
,
áá) *
current
áá+ 2
,
áá2 32
$MinimumBookingHoursBeforeAppointment
áá4 X
)
ááX Y
)
ááY Z
{
àà 
continue
ââ 
;
ââ 
}
ää 
if
åå 
(
åå 
bookedTimes
åå 
.
åå 
Contains
åå $
(
åå$ %
current
åå% ,
)
åå, -
)
åå- .
{
çç 
continue
éé 
;
éé 
}
èè 
slots
ëë 
.
ëë 
Add
ëë 
(
ëë 
current
ëë 
)
ëë 
;
ëë 
}
íí 	
return
îî 
slots
îî 
;
îî 
}
ïï 
private
óó 
static
óó 
bool
óó !
IsAtLeastHoursAhead
óó +
(
óó+ ,
DateOnly
óó, 4
date
óó5 9
,
óó9 :
TimeOnly
óó; C
time
óóD H
,
óóH I
int
óóJ M
minimumHours
óóN Z
)
óóZ [
{
òò 
var
ôô 
scheduledAt
ôô 
=
ôô 
date
ôô 
.
ôô 

ToDateTime
ôô )
(
ôô) *
time
ôô* .
)
ôô. /
;
ôô/ 0
return
õõ 
scheduledAt
õõ 
>=
õõ 
DateTime
õõ &
.
õõ& '
Now
õõ' *
.
õõ* +
AddHours
õõ+ 3
(
õõ3 4
minimumHours
õõ4 @
)
õõ@ A
;
õõA B
}
úú 
private
ûû 
PagedResultDto
ûû 
<
ûû 
TDestination
ûû '
>
ûû' (
MapPagedResult
ûû) 7
<
ûû7 8
TSource
ûû8 ?
,
ûû? @
TDestination
ûûA M
>
ûûM N
(
ûûN O
PagedResult
üü 
<
üü 
TSource
üü 
>
üü 
pagedResult
üü (
)
üü( )
{
†† 
return
°° 
new
°° 
PagedResultDto
°° !
<
°°! "
TDestination
°°" .
>
°°. /
{
¢¢ 	
Items
££ 
=
££ 
mapper
££ 
.
££ 
Map
££ 
<
££ 
List
££ #
<
££# $
TDestination
££$ 0
>
££0 1
>
££1 2
(
££2 3
pagedResult
££3 >
.
££> ?
Items
££? D
)
££D E
,
££E F

PageNumber
§§ 
=
§§ 
pagedResult
§§ $
.
§§$ %

PageNumber
§§% /
,
§§/ 0
PageSize
•• 
=
•• 
pagedResult
•• "
.
••" #
PageSize
••# +
,
••+ ,

TotalCount
¶¶ 
=
¶¶ 
pagedResult
¶¶ $
.
¶¶$ %

TotalCount
¶¶% /
,
¶¶/ 0

TotalPages
ßß 
=
ßß 
pagedResult
ßß $
.
ßß$ %

TotalPages
ßß% /
}
®® 	
;
®®	 

}
©© 
private
´´ 
static
´´ 
void
´´ 2
$ValidateAvailabilityUpdatePermission
´´ <
(
´´< =
int
¨¨ 
doctorId
¨¨ 
,
¨¨ 
string
≠≠ 
currentRole
≠≠ 
,
≠≠ 
int
ÆÆ 
?
ÆÆ 
currentDoctorId
ÆÆ 
)
ÆÆ 
{
ØØ 
if
∞∞ 

(
∞∞ 
currentRole
∞∞ 
==
∞∞ 
AppRoles
∞∞ #
.
∞∞# $
Doctor
∞∞$ *
&&
∞∞+ -
currentDoctorId
∞∞. =
!=
∞∞> @
doctorId
∞∞A I
)
∞∞I J
{
±± 	
throw
≤≤ 
new
≤≤  
ForbiddenException
≤≤ (
(
≤≤( )
ErrorMessages
≤≤) 6
.
≤≤6 71
#DoctorsCanUpdateOnlyOwnAvailability
≤≤7 Z
)
≤≤Z [
;
≤≤[ \
}
≥≥ 	
if
µµ 

(
µµ 
currentRole
µµ 
!=
µµ 
AppRoles
µµ #
.
µµ# $
Doctor
µµ$ *
&&
µµ+ -
currentRole
µµ. 9
!=
µµ: <
AppRoles
µµ= E
.
µµE F
Admin
µµF K
)
µµK L
{
∂∂ 	
throw
∑∑ 
new
∑∑  
ForbiddenException
∑∑ (
(
∑∑( )
ErrorMessages
∑∑) 6
.
∑∑6 74
&UnsupportedAppointmentStatusTransition
∑∑7 ]
)
∑∑] ^
;
∑∑^ _
}
∏∏ 	
}
ππ 
private
ªª 
static
ªª #
DoctorAvailabilityDto
ªª (#
CreateAvailabilityDto
ªª) >
(
ªª> ?
int
ªª? B
doctorId
ªªC K
,
ªªK L
bool
ªªM Q
isAvailable
ªªR ]
)
ªª] ^
{
ºº 
return
ΩΩ 
new
ΩΩ #
DoctorAvailabilityDto
ΩΩ (
{
ææ 	
DoctorId
øø 
=
øø 
doctorId
øø 
,
øø  
IsAvailable
¿¿ 
=
¿¿ 
isAvailable
¿¿ %
,
¿¿% &
Message
¡¡ 
=
¡¡ 
isAvailable
¡¡ !
?
¬¬ 
ErrorMessages
¬¬ 
.
¬¬  $
DoctorAvailableMessage
¬¬  6
:
√√ 
ErrorMessages
√√ 
.
√√  &
DoctorUnavailableMessage
√√  8
}
ƒƒ 	
;
ƒƒ	 

}
≈≈ 
private
«« 
async
«« 
Task
«« %
HandleDeactivationAsync
«« .
(
««. /
int
»» 
doctorId
»» 
,
»» 
string
…… 
currentRole
…… 
)
…… 
{
   
var
ÀÀ 
today
ÀÀ 
=
ÀÀ 
DateOnly
ÀÀ 
.
ÀÀ 
FromDateTime
ÀÀ )
(
ÀÀ) *
DateTime
ÀÀ* 2
.
ÀÀ2 3
Today
ÀÀ3 8
)
ÀÀ8 9
;
ÀÀ9 :
if
ÕÕ 

(
ÕÕ 
currentRole
ÕÕ 
==
ÕÕ 
AppRoles
ÕÕ #
.
ÕÕ# $
Doctor
ÕÕ$ *
)
ÕÕ* +
{
ŒŒ 	
await
œœ 0
"EnsureDoctorCanDeactivateSelfAsync
œœ 4
(
œœ4 5
doctorId
œœ5 =
,
œœ= >
today
œœ? D
)
œœD E
;
œœE F
return
–– 
;
–– 
}
—— 	
if
”” 

(
”” 
currentRole
”” 
==
”” 
AppRoles
”” #
.
””# $
Admin
””$ )
)
””) *
{
‘‘ 	
await
’’ ?
1CancelTodaysAppointmentsForAdminDeactivationAsync
’’ C
(
’’C D
doctorId
’’D L
,
’’L M
today
’’N S
)
’’S T
;
’’T U
}
÷÷ 	
}
◊◊ 
private
ŸŸ 
async
ŸŸ 
Task
ŸŸ 0
"EnsureDoctorCanDeactivateSelfAsync
ŸŸ 9
(
ŸŸ9 :
int
⁄⁄ 
doctorId
⁄⁄ 
,
⁄⁄ 
DateOnly
€€ 
today
€€ 
)
€€ 
{
‹‹ 
var
›› +
hasConfirmedAppointmentsToday
›› )
=
››* +
await
››, 1#
appointmentRepository
››2 G
.
ﬁﬁ 7
)DoctorHasConfirmedAppointmentsOnDateAsync
ﬁﬁ 6
(
ﬁﬁ6 7
doctorId
ﬁﬁ7 ?
,
ﬁﬁ? @
today
ﬁﬁA F
)
ﬁﬁF G
;
ﬁﬁG H
if
‡‡ 

(
‡‡ +
hasConfirmedAppointmentsToday
‡‡ )
)
‡‡) *
{
·· 	
throw
‚‚ 
new
‚‚ #
BusinessRuleException
‚‚ +
(
‚‚+ ,
ErrorMessages
‚‚, 9
.
‚‚9 :B
4DoctorCannotDeactivateWithConfirmedAppointmentsToday
‚‚: n
)
‚‚n o
;
‚‚o p
}
„„ 	
}
‰‰ 
private
ÊÊ 
async
ÊÊ 
Task
ÊÊ ?
1CancelTodaysAppointmentsForAdminDeactivationAsync
ÊÊ H
(
ÊÊH I
int
ÁÁ 
doctorId
ÁÁ 
,
ÁÁ 
DateOnly
ËË 
today
ËË 
)
ËË 
{
ÈÈ 
var
ÍÍ "
appointmentsToCancel
ÍÍ  
=
ÍÍ! "
await
ÍÍ# (#
appointmentRepository
ÍÍ) >
.
ÎÎ E
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync
ÎÎ D
(
ÎÎD E
doctorId
ÎÎE M
,
ÎÎM N
today
ÎÎO T
)
ÎÎT U
;
ÎÎU V
foreach
ÌÌ 
(
ÌÌ 
var
ÌÌ 
appointment
ÌÌ  
in
ÌÌ! #"
appointmentsToCancel
ÌÌ$ 8
)
ÌÌ8 9
{
ÓÓ 	
appointment
ÔÔ 
.
ÔÔ 
Status
ÔÔ 
=
ÔÔ  
AppointmentStatus
ÔÔ! 2
.
ÔÔ2 3
	Cancelled
ÔÔ3 <
;
ÔÔ< =
appointment
 
.
  
CancellationReason
 *
=
+ ,
ErrorMessages
- :
.
: ;/
!DoctorEmergencyCancellationReason
; \
;
\ ]
await
ÚÚ #
appointmentRepository
ÚÚ '
.
ÚÚ' (
UpdateAsync
ÚÚ( 3
(
ÚÚ3 4
appointment
ÚÚ4 ?
)
ÚÚ? @
;
ÚÚ@ A
}
ÛÛ 	
}
ÙÙ 
}ıı ˇ>
fC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\DoctorAvailabilityCacheService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
.! "
Impl" &
;& '
public 
class *
DoctorAvailabilityCacheService +
(+ ,
IDistributedCache 
cache 
, 
ILogger		 
<		 *
DoctorAvailabilityCacheService		 *
>		* +
logger		, 2
)		2 3
:

 +
IDoctorAvailabilityCacheService

 %
{ 
private 
const 
int 
CacheTtlMinutes %
=& '
$num( )
;) *
private 
static 
readonly (
DistributedCacheEntryOptions 8
CacheOptions9 E
=F G
newH K
(K L
)L M
{ +
AbsoluteExpirationRelativeToNow '
=( )
TimeSpan* 2
.2 3
FromMinutes3 >
(> ?
CacheTtlMinutes? N
)N O
} 
; 
private 
static 
readonly !
JsonSerializerOptions 1
JsonOptions2 =
=> ?
new 
( "
JsonSerializerDefaults "
." #
Web# &
)& '
;' (
public 

async 
Task 
< #
DoctorAvailableSlotsDto -
?- .
>. /
GetDoctorSlotsAsync0 C
(C D
int 
doctorId 
, 
DateOnly 
date 
) 
{ 
var 
cacheKey 
= 
BuildCacheKey $
($ %
doctorId% -
,- .
date/ 3
)3 4
;4 5
var 
cachedValue 
= 
await 
cache  %
.% &
GetStringAsync& 4
(4 5
cacheKey5 =
)= >
;> ?
if 

( 
string 
. 
IsNullOrWhiteSpace %
(% &
cachedValue& 1
)1 2
)2 3
{ 	
if 
( 
logger 
. 
	IsEnabled  
(  !
LogLevel! )
.) *
Information* 5
)5 6
)6 7
{   
logger!! 
.!! 
LogInformation!! %
(!!% &
$str"" V
,""V W
doctorId## 
,## 
date$$ 
)$$ 
;$$ 
}%% 
return'' 
null'' 
;'' 
}(( 	
if** 

(** 
logger** 
.** 
	IsEnabled** 
(** 
LogLevel** %
.**% &
Information**& 1
)**1 2
)**2 3
{++ 	
logger,, 
.,, 
LogInformation,, !
(,,! "
$str-- Q
,--Q R
doctorId.. 
,.. 
date// 
)// 
;// 
}00 	
return22 
JsonSerializer22 
.22 
Deserialize22 )
<22) *#
DoctorAvailableSlotsDto22* A
>22A B
(22B C
cachedValue33 
,33 
JsonOptions44 
)44 
;44 
}55 
public77 

async77 
Task77 
SetDoctorSlotsAsync77 )
(77) *
int88 
doctorId88 
,88 
DateOnly99 
date99 
,99 #
DoctorAvailableSlotsDto:: 
slots::  %
)::% &
{;; 
var<< 
cacheKey<< 
=<< 
BuildCacheKey<< $
(<<$ %
doctorId<<% -
,<<- .
date<</ 3
)<<3 4
;<<4 5
var== 
serializedValue== 
=== 
JsonSerializer== ,
.==, -
	Serialize==- 6
(==6 7
slots==7 <
,==< =
JsonOptions==> I
)==I J
;==J K
await?? 
cache?? 
.?? 
SetStringAsync?? "
(??" #
cacheKey??# +
,??+ ,
serializedValue??- <
,??< =
CacheOptions??> J
)??J K
;??K L
ifAA 

(AA 
loggerAA 
.AA 
	IsEnabledAA 
(AA 
LogLevelAA %
.AA% &
DebugAA& +
)AA+ ,
)AA, -
{BB 	
loggerCC 
.CC 
LogDebugCC 
(CC 
$strDD g
,DDg h
doctorIdEE 
,EE 
dateFF 
,FF 
CacheTtlMinutesGG 
)GG  
;GG  !
}HH 	
}II 
publicKK 

asyncKK 
TaskKK "
RemoveDoctorSlotsAsyncKK ,
(KK, -
intKK- 0
doctorIdKK1 9
,KK9 :
DateOnlyKK; C
dateKKD H
)KKH I
{LL 
awaitMM 
cacheMM 
.MM 
RemoveAsyncMM 
(MM  
BuildCacheKeyMM  -
(MM- .
doctorIdMM. 6
,MM6 7
dateMM8 <
)MM< =
)MM= >
;MM> ?
ifOO 

(OO 
loggerOO 
.OO 
	IsEnabledOO 
(OO 
LogLevelOO %
.OO% &
InformationOO& 1
)OO1 2
)OO2 3
{PP 	
loggerQQ 
.QQ 
LogInformationQQ !
(QQ! "
$strRR Y
,RRY Z
doctorIdSS 
,SS 
dateTT 
)TT 
;TT 
}UU 	
}VV 
publicXX 

asyncXX 
TaskXX .
"RemoveDoctorAvailabilityRangeAsyncXX 8
(XX8 9
intYY 
doctorIdYY 
,YY 
intZZ 
monthsAheadZZ 
)ZZ 
{[[ 
var\\ 
	startDate\\ 
=\\ 
DateOnly\\  
.\\  !
FromDateTime\\! -
(\\- .
DateTime\\. 6
.\\6 7
Today\\7 <
)\\< =
;\\= >
var]] 
endDate]] 
=]] 
	startDate]] 
.]]  
	AddMonths]]  )
(]]) *
monthsAhead]]* 5
)]]5 6
;]]6 7
for__ 
(__ 
var__ 
date__ 
=__ 
	startDate__ !
;__! "
date__# '
<=__( *
endDate__+ 2
;__2 3
date__4 8
=__9 :
date__; ?
.__? @
AddDays__@ G
(__G H
$num__H I
)__I J
)__J K
{`` 	
awaitaa 
cacheaa 
.aa 
RemoveAsyncaa #
(aa# $
BuildCacheKeyaa$ 1
(aa1 2
doctorIdaa2 :
,aa: ;
dateaa< @
)aa@ A
)aaA B
;aaB C
}bb 	
ifdd 

(dd 
loggerdd 
.dd 
	IsEnableddd 
(dd 
LogLeveldd %
.dd% &
Informationdd& 1
)dd1 2
)dd2 3
{ee 	
loggerff 
.ff 
LogInformationff !
(ff! "
$strgg |
,gg| }
doctorIdhh 
,hh 
	startDateii 
,ii 
endDatejj 
)jj 
;jj 
}kk 	
}ll 
privatenn 
staticnn 
stringnn 
BuildCacheKeynn '
(nn' (
intnn( +
doctorIdnn, 4
,nn4 5
DateOnlynn6 >
datenn? C
)nnC D
{oo 
returnpp 
$"pp 
$strpp 
{pp 
doctorIdpp "
}pp" #
$strpp# 1
{pp1 2
datepp2 6
:pp6 7
$strpp7 A
}ppA B
"ppB C
;ppC D
}qq 
}rr »¿
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
public 

async 
Task 
< 
( 
bool 
Success #
,# $
string% +
Message, 3
,3 4
string5 ;
UserId< B
)B C
>C D
RegisterAsyncE R
(R S
RegisterDto 
request 
) 
{ 
if 

( 
request 
. 
Password 
!= 
request  '
.' (
ConfirmPassword( 7
)7 8
{ 	
return 
( 
false 
, 
ErrorMessages (
.( )
PasswordsDoNotMatch) <
,< =
string> D
.D E
EmptyE J
)J K
;K L
} 	
var 
existingUser 
= 
await  
userManager! ,
., -
FindByEmailAsync- =
(= >
request> E
.E F
EmailF K
)K L
;L M
if   

(   
existingUser   
!=   
null    
)    !
{!! 	
return"" 
("" 
false"" 
,"" 
ErrorMessages"" (
.""( )"
EmailAlreadyRegistered"") ?
,""? @
string""A G
.""G H
Empty""H M
)""M N
;""N O
}## 	
await%% 
using%% 
var%% 
transaction%% #
=%%$ %
await%%& +
context%%, 3
.%%3 4
Database%%4 <
.%%< =!
BeginTransactionAsync%%= R
(%%R S
)%%S T
;%%T U
try'' 
{(( 	
var)) 
user)) 
=)) 
new)) 
IdentityUser)) '
{** 
UserName++ 
=++ 
request++ "
.++" #
Email++# (
,++( )
Email,, 
=,, 
request,, 
.,,  
Email,,  %
,,,% &
EmailConfirmed-- 
=--  
true--! %
,--% &
PhoneNumber.. 
=.. 
request.. %
...% &
PhoneNumber..& 1
}// 
;// 
var11 
createResult11 
=11 
await11 $
userManager11% 0
.110 1
CreateAsync111 <
(11< =
user11= A
,11A B
request11C J
.11J K
Password11K S
)11S T
;11T U
if33 
(33 
!33 
createResult33 
.33 
	Succeeded33 '
)33' (
{44 
var55 
errors55 
=55 
string55 #
.55# $
Join55$ (
(55( )
$str66 
,66 
createResult77  
.77  !
Errors77! '
.77' (
Select77( .
(77. /
error77/ 4
=>775 7
error778 =
.77= >
Description77> I
)77I J
)77J K
;77K L
await99 
transaction99 !
.99! "
RollbackAsync99" /
(99/ 0
)990 1
;991 2
return:: 
(:: 
false:: 
,:: 
errors:: %
,::% &
string::' -
.::- .
Empty::. 3
)::3 4
;::4 5
};; 
var== 

roleResult== 
=== 
await== "
userManager==# .
.==. /
AddToRoleAsync==/ =
(=== >
user==> B
,==B C
AppRoles==D L
.==L M
Patient==M T
)==T U
;==U V
if?? 
(?? 
!?? 

roleResult?? 
.?? 
	Succeeded?? %
)??% &
{@@ 
varAA 
errorsAA 
=AA 
stringAA #
.AA# $
JoinAA$ (
(AA( )
$strBB 
,BB 

roleResultCC 
.CC 
ErrorsCC %
.CC% &
SelectCC& ,
(CC, -
errorCC- 2
=>CC3 5
errorCC6 ;
.CC; <
DescriptionCC< G
)CCG H
)CCH I
;CCI J
awaitEE 
transactionEE !
.EE! "
RollbackAsyncEE" /
(EE/ 0
)EE0 1
;EE1 2
returnFF 
(FF 
falseFF 
,FF 
errorsFF %
,FF% &
stringFF' -
.FF- .
EmptyFF. 3
)FF3 4
;FF4 5
}GG 
varII 
patientII 
=II 
newII 
PatientII %
{JJ 
UserIdKK 
=KK 
userKK 
.KK 
IdKK  
,KK  !
FullNameLL 
=LL 
requestLL "
.LL" #
FullNameLL# +
,LL+ ,
DateOfBirthMM 
=MM 
requestMM %
.MM% &
DateOfBirthMM& 1
,MM1 2
GenderNN 
=NN 
requestNN  
.NN  !
GenderNN! '
,NN' (
AddressOO 
=OO 
requestOO !
.OO! "
AddressOO" )
}PP 
;PP 
awaitRR 
contextRR 
.RR 
PatientsRR "
.RR" #
AddAsyncRR# +
(RR+ ,
patientRR, 3
)RR3 4
;RR4 5
awaitSS 
contextSS 
.SS 
SaveChangesAsyncSS *
(SS* +
)SS+ ,
;SS, -
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

LoginAsync`` 
(`` 
LoginDto`` 
request`` #
)``# $
{aa 
varbb 
userbb 
=bb 
awaitbb 
userManagerbb $
.bb$ %
FindByEmailAsyncbb% 5
(bb5 6
requestbb6 =
.bb= >
Emailbb> C
)bbC D
;bbD E
ifdd 

(dd 
userdd 
==dd 
nulldd 
)dd 
{ee 	
returnff 
(ff 
falseff 
,ff 
ErrorMessagesff (
.ff( )
InvalidCredentialsff) ;
,ff; <
nullff= A
)ffA B
;ffB C
}gg 	
varii 
isPasswordValidii 
=ii 
awaitii #
userManagerii$ /
.ii/ 0
CheckPasswordAsyncii0 B
(iiB C
userjj 
,jj 
requestkk 
.kk 
Passwordkk 
)kk 
;kk 
ifmm 

(mm 
!mm 
isPasswordValidmm 
)mm 
{nn 	
returnoo 
(oo 
falseoo 
,oo 
ErrorMessagesoo (
.oo( )
InvalidCredentialsoo) ;
,oo; <
nulloo= A
)ooA B
;ooB C
}pp 	
varrr 
profileResultrr 
=rr 
awaitrr !!
BuildUserProfileAsyncrr" 7
(rr7 8
userrr8 <
)rr< =
;rr= >
iftt 

(tt 
!tt 
profileResulttt 
.tt 
Successtt "
)tt" #
{uu 	
returnvv 
(vv 
falsevv 
,vv 
profileResultvv (
.vv( )
Messagevv) 0
,vv0 1
nullvv2 6
)vv6 7
;vv7 8
}ww 	
varyy 
responseyy 
=yy  
GenerateAuthResponseyy +
(yy+ ,
userzz 
,zz 
profileResult{{ 
.{{ 
Roles{{ 
,{{  
profileResult|| 
.|| 
Role|| 
,|| 
profileResult}} 
.}} 
	PatientId}} #
,}}# $
profileResult~~ 
.~~ 
DoctorId~~ "
,~~" #
$str *
)* +
;+ ,
return
ÅÅ 
(
ÅÅ 
true
ÅÅ 
,
ÅÅ 
response
ÅÅ 
.
ÅÅ 
Message
ÅÅ &
,
ÅÅ& '
response
ÅÅ( 0
)
ÅÅ0 1
;
ÅÅ1 2
}
ÇÇ 
private
ÑÑ 
async
ÑÑ 
Task
ÑÑ 
<
ÑÑ 
(
ÑÑ 
bool
ÖÖ 
Success
ÖÖ 
,
ÖÖ 
string
ÜÜ 
Message
ÜÜ 
,
ÜÜ 
IList
áá 
<
áá 
string
áá 
>
áá 
Roles
áá 
,
áá 
string
àà 
Role
àà 
,
àà 
int
ââ 
?
ââ 
	PatientId
ââ 
,
ââ 
int
ää 
?
ää 
DoctorId
ää 
)
ää 
>
ää #
BuildUserProfileAsync
ää -
(
ää- .
IdentityUser
ää. :
user
ää; ?
)
ää? @
{
ãã 
var
åå 
roles
åå 
=
åå 
await
åå 
userManager
åå %
.
åå% &
GetRolesAsync
åå& 3
(
åå3 4
user
åå4 8
)
åå8 9
;
åå9 :
var
çç 
role
çç 
=
çç 
roles
çç 
.
çç 
FirstOrDefault
çç '
(
çç' (
)
çç( )
??
çç* ,
string
çç- 3
.
çç3 4
Empty
çç4 9
;
çç9 :
int
èè 
?
èè 
	patientId
èè 
=
èè 
null
èè 
;
èè 
int
êê 
?
êê 
doctorId
êê 
=
êê 
null
êê 
;
êê 
if
íí 

(
íí 
string
íí 
.
íí 
Equals
íí 
(
íí 
role
íí 
,
íí 
AppRoles
íí  (
.
íí( )
Patient
íí) 0
,
íí0 1
StringComparison
íí2 B
.
ííB C
OrdinalIgnoreCase
ííC T
)
ííT U
)
ííU V
{
ìì 	
var
îî 
patient
îî 
=
îî 
await
îî 
patientRepository
îî  1
.
îî1 2%
GetPatientByUserIdAsync
îî2 I
(
îîI J
user
îîJ N
.
îîN O
Id
îîO Q
)
îîQ R
;
îîR S
if
ññ 
(
ññ 
patient
ññ 
==
ññ 
null
ññ 
)
ññ  
{
óó 
return
òò 
(
òò 
false
ôô 
,
ôô 
ErrorMessages
öö !
.
öö! "$
PatientProfileNotFound
öö" 8
,
öö8 9
roles
õõ 
,
õõ 
role
úú 
,
úú 
null
ùù 
,
ùù 
null
ûû 
)
ûû 
;
ûû 
}
üü 
	patientId
°° 
=
°° 
patient
°° 
.
°°  
Id
°°  "
;
°°" #
}
¢¢ 	
if
§§ 

(
§§ 
string
§§ 
.
§§ 
Equals
§§ 
(
§§ 
role
§§ 
,
§§ 
AppRoles
§§  (
.
§§( )
Doctor
§§) /
,
§§/ 0
StringComparison
§§1 A
.
§§A B
OrdinalIgnoreCase
§§B S
)
§§S T
)
§§T U
{
•• 	
var
¶¶ 
doctor
¶¶ 
=
¶¶ 
await
¶¶ 
doctorRepository
¶¶ /
.
¶¶/ 0$
GetDoctorByUserIdAsync
¶¶0 F
(
¶¶F G
user
¶¶G K
.
¶¶K L
Id
¶¶L N
)
¶¶N O
;
¶¶O P
if
®® 
(
®® 
doctor
®® 
==
®® 
null
®® 
)
®® 
{
©© 
return
™™ 
(
™™ 
false
´´ 
,
´´ 
ErrorMessages
¨¨ !
.
¨¨! "#
DoctorProfileNotFound
¨¨" 7
,
¨¨7 8
roles
≠≠ 
,
≠≠ 
role
ÆÆ 
,
ÆÆ 
null
ØØ 
,
ØØ 
null
∞∞ 
)
∞∞ 
;
∞∞ 
}
±± 
doctorId
≥≥ 
=
≥≥ 
doctor
≥≥ 
.
≥≥ 
Id
≥≥  
;
≥≥  !
}
¥¥ 	
return
∂∂ 
(
∂∂ 
true
∂∂ 
,
∂∂ 
string
∂∂ 
.
∂∂ 
Empty
∂∂ "
,
∂∂" #
roles
∂∂$ )
,
∂∂) *
role
∂∂+ /
,
∂∂/ 0
	patientId
∂∂1 :
,
∂∂: ;
doctorId
∂∂< D
)
∂∂D E
;
∂∂E F
}
∑∑ 
private
ππ 
AuthResponseDto
ππ "
GenerateAuthResponse
ππ 0
(
ππ0 1
IdentityUser
∫∫ 
user
∫∫ 
,
∫∫ 
IList
ªª 
<
ªª 
string
ªª 
>
ªª 
roles
ªª 
,
ªª 
string
ºº 
role
ºº 
,
ºº 
int
ΩΩ 
?
ΩΩ 
	patientId
ΩΩ 
,
ΩΩ 
int
ææ 
?
ææ 
doctorId
ææ 
,
ææ 
string
øø 
message
øø 
)
øø 
{
¿¿ 
var
¡¡ 
	expiresIn
¡¡ 
=
¡¡ 
int
¡¡ 
.
¡¡ 
Parse
¡¡ !
(
¡¡! "
configuration
¬¬ 
.
¬¬ 

GetSection
¬¬ $
(
¬¬$ %
$str
¬¬% *
)
¬¬* +
[
¬¬+ ,
$str
¬¬, J
]
¬¬J K
!
¬¬K L
)
¬¬L M
;
¬¬M N
var
ƒƒ 
token
ƒƒ 
=
ƒƒ 
GenerateToken
ƒƒ !
(
ƒƒ! "
user
≈≈ 
,
≈≈ 
roles
∆∆ 
,
∆∆ 
	expiresIn
«« 
,
«« 
	patientId
»» 
,
»» 
doctorId
…… 
)
…… 
;
…… 
return
ÀÀ 
new
ÀÀ 
AuthResponseDto
ÀÀ "
{
ÃÃ 	
AccessToken
ÕÕ 
=
ÕÕ 
token
ÕÕ 
,
ÕÕ  
Message
ŒŒ 
=
ŒŒ 
message
ŒŒ 
,
ŒŒ 
	ExpiresIn
œœ 
=
œœ 
	expiresIn
œœ !
,
œœ! "
UserId
–– 
=
–– 
user
–– 
.
–– 
Id
–– 
,
–– 
	PatientId
—— 
=
—— 
	patientId
—— !
,
——! "
DoctorId
““ 
=
““ 
doctorId
““ 
,
““  
Email
”” 
=
”” 
user
”” 
.
”” 
Email
”” 
??
”” !
string
””" (
.
””( )
Empty
””) .
,
””. /
Role
‘‘ 
=
‘‘ 
role
‘‘ 
}
’’ 	
;
’’	 

}
÷÷ 
private
ÿÿ 
string
ÿÿ 
GenerateToken
ÿÿ  
(
ÿÿ  !
IdentityUser
ŸŸ 
user
ŸŸ 
,
ŸŸ 
IList
⁄⁄ 
<
⁄⁄ 
string
⁄⁄ 
>
⁄⁄ 
roles
⁄⁄ 
,
⁄⁄ 
int
€€ 
	expiresIn
€€ 
,
€€ 
int
‹‹ 
?
‹‹ 
	patientId
‹‹ 
,
‹‹ 
int
›› 
?
›› 
doctorId
›› 
)
›› 
{
ﬁﬁ 
var
ﬂﬂ 
jwtSettings
ﬂﬂ 
=
ﬂﬂ 
configuration
ﬂﬂ '
.
ﬂﬂ' (

GetSection
ﬂﬂ( 2
(
ﬂﬂ2 3
$str
ﬂﬂ3 8
)
ﬂﬂ8 9
;
ﬂﬂ9 :
var
·· 
key
·· 
=
·· 
new
·· "
SymmetricSecurityKey
·· *
(
··* +
Encoding
‚‚ 
.
‚‚ 
UTF8
‚‚ 
.
‚‚ 
GetBytes
‚‚ "
(
‚‚" #
jwtSettings
‚‚# .
[
‚‚. /
$str
‚‚/ 4
]
‚‚4 5
!
‚‚5 6
)
‚‚6 7
)
‚‚7 8
;
‚‚8 9
var
‰‰ 
credentials
‰‰ 
=
‰‰ 
new
‰‰  
SigningCredentials
‰‰ 0
(
‰‰0 1
key
ÂÂ 
,
ÂÂ  
SecurityAlgorithms
ÊÊ 
.
ÊÊ 

HmacSha256
ÊÊ )
)
ÊÊ) *
;
ÊÊ* +
var
ËË 
claims
ËË 
=
ËË 
new
ËË 
List
ËË 
<
ËË 
Claim
ËË #
>
ËË# $
{
ÈÈ 	
new
ÍÍ 
(
ÍÍ 
AppClaimTypes
ÍÍ 
.
ÍÍ 
UserId
ÍÍ $
,
ÍÍ$ %
user
ÍÍ& *
.
ÍÍ* +
Id
ÍÍ+ -
)
ÍÍ- .
,
ÍÍ. /
new
ÎÎ 
(
ÎÎ %
JwtRegisteredClaimNames
ÎÎ '
.
ÎÎ' (
Sub
ÎÎ( +
,
ÎÎ+ ,
user
ÎÎ- 1
.
ÎÎ1 2
Id
ÎÎ2 4
)
ÎÎ4 5
,
ÎÎ5 6
new
ÏÏ 
(
ÏÏ %
JwtRegisteredClaimNames
ÏÏ '
.
ÏÏ' (
Email
ÏÏ( -
,
ÏÏ- .
user
ÏÏ/ 3
.
ÏÏ3 4
Email
ÏÏ4 9
??
ÏÏ: <
string
ÏÏ= C
.
ÏÏC D
Empty
ÏÏD I
)
ÏÏI J
,
ÏÏJ K
new
ÌÌ 
(
ÌÌ 

ClaimTypes
ÌÌ 
.
ÌÌ 
NameIdentifier
ÌÌ )
,
ÌÌ) *
user
ÌÌ+ /
.
ÌÌ/ 0
Id
ÌÌ0 2
)
ÌÌ2 3
,
ÌÌ3 4
new
ÓÓ 
(
ÓÓ 

ClaimTypes
ÓÓ 
.
ÓÓ 
Email
ÓÓ  
,
ÓÓ  !
user
ÓÓ" &
.
ÓÓ& '
Email
ÓÓ' ,
??
ÓÓ- /
string
ÓÓ0 6
.
ÓÓ6 7
Empty
ÓÓ7 <
)
ÓÓ< =
,
ÓÓ= >
new
ÔÔ 
(
ÔÔ %
JwtRegisteredClaimNames
ÔÔ '
.
ÔÔ' (
Jti
ÔÔ( +
,
ÔÔ+ ,
Guid
ÔÔ- 1
.
ÔÔ1 2
NewGuid
ÔÔ2 9
(
ÔÔ9 :
)
ÔÔ: ;
.
ÔÔ; <
ToString
ÔÔ< D
(
ÔÔD E
)
ÔÔE F
)
ÔÔF G
}
 	
;
	 

foreach
ÚÚ 
(
ÚÚ 
var
ÚÚ 
userRole
ÚÚ 
in
ÚÚ  
roles
ÚÚ! &
)
ÚÚ& '
{
ÛÛ 	
claims
ÙÙ 
.
ÙÙ 
Add
ÙÙ 
(
ÙÙ 
new
ÙÙ 
Claim
ÙÙ  
(
ÙÙ  !
AppClaimTypes
ÙÙ! .
.
ÙÙ. /
Role
ÙÙ/ 3
,
ÙÙ3 4
userRole
ÙÙ5 =
)
ÙÙ= >
)
ÙÙ> ?
;
ÙÙ? @
claims
ıı 
.
ıı 
Add
ıı 
(
ıı 
new
ıı 
Claim
ıı  
(
ıı  !

ClaimTypes
ıı! +
.
ıı+ ,
Role
ıı, 0
,
ıı0 1
userRole
ıı2 :
)
ıı: ;
)
ıı; <
;
ıı< =
}
ˆˆ 	
if
¯¯ 

(
¯¯ 
	patientId
¯¯ 
.
¯¯ 
HasValue
¯¯ 
)
¯¯ 
{
˘˘ 	
claims
˙˙ 
.
˙˙ 
Add
˙˙ 
(
˙˙ 
new
˙˙ 
Claim
˙˙  
(
˙˙  !
AppClaimTypes
˚˚ 
.
˚˚ 
	PatientId
˚˚ '
,
˚˚' (
	patientId
¸¸ 
.
¸¸ 
Value
¸¸ 
.
¸¸  
ToString
¸¸  (
(
¸¸( )
)
¸¸) *
)
¸¸* +
)
¸¸+ ,
;
¸¸, -
}
˝˝ 	
if
ˇˇ 

(
ˇˇ 
doctorId
ˇˇ 
.
ˇˇ 
HasValue
ˇˇ 
)
ˇˇ 
{
ÄÄ 	
claims
ÅÅ 
.
ÅÅ 
Add
ÅÅ 
(
ÅÅ 
new
ÅÅ 
Claim
ÅÅ  
(
ÅÅ  !
AppClaimTypes
ÇÇ 
.
ÇÇ 
DoctorId
ÇÇ &
,
ÇÇ& '
doctorId
ÉÉ 
.
ÉÉ 
Value
ÉÉ 
.
ÉÉ 
ToString
ÉÉ '
(
ÉÉ' (
)
ÉÉ( )
)
ÉÉ) *
)
ÉÉ* +
;
ÉÉ+ ,
}
ÑÑ 	
var
ÜÜ 
token
ÜÜ 
=
ÜÜ 
new
ÜÜ 
JwtSecurityToken
ÜÜ (
(
ÜÜ( )
issuer
áá 
:
áá 
jwtSettings
áá 
[
áá  
$str
áá  (
]
áá( )
,
áá) *
audience
àà 
:
àà 
jwtSettings
àà !
[
àà! "
$str
àà" ,
]
àà, -
,
àà- .
claims
ââ 
:
ââ 
claims
ââ 
,
ââ 
expires
ää 
:
ää 
DateTime
ää 
.
ää 
UtcNow
ää $
.
ää$ %

AddMinutes
ää% /
(
ää/ 0
	expiresIn
ää0 9
)
ää9 :
,
ää: ; 
signingCredentials
ãã 
:
ãã 
credentials
ãã  +
)
ãã+ ,
;
ãã, -
return
çç 
new
çç %
JwtSecurityTokenHandler
çç *
(
çç* +
)
çç+ ,
.
çç, -

WriteToken
çç- 7
(
çç7 8
token
çç8 =
)
çç= >
;
çç> ?
}
éé 
public
êê 

async
êê 
Task
êê 
<
êê 
(
êê 
bool
êê 
Success
êê #
,
êê# $
string
êê% +
Message
êê, 3
,
êê3 4
AuthResponseDto
êê5 D
?
êêD E
Response
êêF N
)
êêN O
>
êêO P.
 CreateAuthResponseForUserIdAsync
ëë (
(
ëë( )
string
ëë) /
userId
ëë0 6
)
ëë6 7
{
íí 
var
ìì 
user
ìì 
=
ìì 
await
ìì 
userManager
ìì $
.
ìì$ %
FindByIdAsync
ìì% 2
(
ìì2 3
userId
ìì3 9
)
ìì9 :
;
ìì: ;
if
ïï 

(
ïï 
user
ïï 
==
ïï 
null
ïï 
)
ïï 
{
ññ 	
return
óó 
(
óó 
false
óó 
,
óó 
$str
óó 4
,
óó4 5
null
óó6 :
)
óó: ;
;
óó; <
}
òò 	
var
öö 
profileResult
öö 
=
öö 
await
öö !#
BuildUserProfileAsync
öö" 7
(
öö7 8
user
öö8 <
)
öö< =
;
öö= >
if
úú 

(
úú 
!
úú 
profileResult
úú 
.
úú 
Success
úú "
)
úú" #
{
ùù 	
return
ûû 
(
ûû 
false
ûû 
,
ûû 
profileResult
ûû (
.
ûû( )
Message
ûû) 0
,
ûû0 1
null
ûû2 6
)
ûû6 7
;
ûû7 8
}
üü 	
var
°° 
response
°° 
=
°° "
GenerateAuthResponse
°° +
(
°°+ ,
user
¢¢ 
,
¢¢ 
profileResult
££ 
.
££ 
Roles
££ 
,
££  
profileResult
§§ 
.
§§ 
Role
§§ 
,
§§ 
profileResult
•• 
.
•• 
	PatientId
•• #
,
••# $
profileResult
¶¶ 
.
¶¶ 
DoctorId
¶¶ "
,
¶¶" #
$str
ßß .
)
ßß. /
;
ßß/ 0
return
©© 
(
©© 
true
©© 
,
©© 
response
©© 
.
©© 
Message
©© &
,
©©& '
response
©©( 0
)
©©0 1
;
©©1 2
}
™™ 
}´´ ©˙
ZC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\AppointmentService.cs
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
class 
AppointmentService 
(  "
IAppointmentRepository !
appointmentRepository 0
,0 1
IPatientRepository 
patientRepository (
,( )
IDoctorRepository 
doctorRepository &
,& '
IMapper 
mapper 
, 
IPublishEndpoint 
	publisher 
, +
IDoctorAvailabilityCacheService #$
availabilityCacheService$ <
)< =
:> ?
IAppointmentService@ S
{ 
private 
const 
int 0
$MinimumBookingHoursBeforeAppointment :
=; <
$num= ?
;? @
private 
const 
int 5
)MinimumCancellationHoursBeforeAppointment ?
=@ A
$numB D
;D E
private 
const 
int %
MaximumBookingMonthsAhead /
=0 1
$num2 3
;3 4
public 

async 
Task 
< 
PagedResultDto $
<$ %
AppointmentDto% 3
>3 4
>4 5#
GetAllAppointmentsAsync6 M
(M N
PaginationQueryDtoN `

paginationa k
)k l
{ 
var 
appointments 
= 
await  !
appointmentRepository! 6
.6 7#
GetAllAppointmentsAsync7 N
(N O

paginationO Y
.Y Z

PageNumberZ d
,d e

paginationf p
.p q
PageSizeq y
)y z
;z {
return 
MapPagedResult 
< 
Appointment )
,) *
AppointmentDto+ 9
>9 :
(: ;
appointments; G
)G H
;H I
} 
public!! 

async!! 
Task!! 
<!! 
AppointmentDto!! $
>!!$ %#
GetAppointmentByIdAsync!!& =
(!!= >
int!!> A
id!!B D
)!!D E
{"" 
var## 
appointment## 
=## 
await## !
appointmentRepository##  5
.##5 6.
"GetAppointmentByIdWithDetailsAsync##6 X
(##X Y
id##Y [
)##[ \
??$$ 
throw$$ 
new$$ 
NotFoundException$$ *
($$* +
ErrorMessages$$+ 8
.$$8 9
AppointmentNotFound$$9 L
)$$L M
;$$M N
return%% 
mapper%% 
.%% 
Map%% 
<%% 
AppointmentDto%% (
>%%( )
(%%) *
appointment%%* 5
)%%5 6
;%%6 7
}&& 
public(( 

async(( 
Task(( 
<(( 
AppointmentDto(( $
?(($ %
>((% &"
CreateAppointmentAsync((' =
(((= > 
CreateAppointmentDto((> R
dto((S V
)((V W
{)) 
await** 0
$ValidateAppointmentCanBeCreatedAsync** 2
(**2 3
dto**3 6
)**6 7
;**7 8
var++ 
appointment++ 
=++ 
new++ 
Appointment++ )
{,, 	
	PatientId-- 
=-- 
dto-- 
.-- 
	PatientId-- %
,--% &
DoctorId.. 
=.. 
dto.. 
... 
DoctorId.. #
,..# $
AppointmentDate// 
=// 
dto// !
.//! "
AppointmentDate//" 1
,//1 2
AppointmentTime00 
=00 
dto00 !
.00! "
AppointmentTime00" 1
,001 2
Status11 
=11 
AppointmentStatus11 &
.11& '
Pending11' .
}22 	
;22	 

var44 
createdAppointment44 
=44  
await44! &!
appointmentRepository44' <
.44< =
AddAsync44= E
(44E F
appointment44F Q
)44Q R
;44R S
var55 "
appointmentWithDetails55 "
=55# $
await55% *!
appointmentRepository55+ @
.55@ A.
"GetAppointmentByIdWithDetailsAsync55A c
(55c d
createdAppointment55d v
.55v w
Id55w y
)55y z
??66 
throw66 
new66 
NotFoundException66 *
(66* +
ErrorMessages66+ 8
.668 9,
 AppointmentNotFoundAfterCreation669 Y
)66Y Z
;66Z [
await88 $
availabilityCacheService88 &
.88& '"
RemoveDoctorSlotsAsync88' =
(88= >"
appointmentWithDetails88> T
.88T U
DoctorId88U ]
,88] ^"
appointmentWithDetails88_ u
.88u v
AppointmentDate	88v Ö
)
88Ö Ü
;
88Ü á
await:: 
	publisher:: 
.:: 
Publish:: 
(::  
new::  #"
AppointmentBookedEvent::$ :
{;; 	
AppointmentId<< 
=<< "
appointmentWithDetails<< 2
.<<2 3
Id<<3 5
,<<5 6
	PatientId== 
=== "
appointmentWithDetails== .
.==. /
	PatientId==/ 8
,==8 9
DoctorId>> 
=>> "
appointmentWithDetails>> -
.>>- .
DoctorId>>. 6
,>>6 7
ScheduledDate?? 
=?? "
appointmentWithDetails?? 2
.??2 3
AppointmentDate??3 B
,??B C
TimeSlot@@ 
=@@ "
appointmentWithDetails@@ -
.@@- .
AppointmentTime@@. =
,@@= >

OccurredAtAA 
=AA 
DateTimeAA !
.AA! "
UtcNowAA" (
}BB 	
)BB	 

;BB
 
returnDD 
mapperDD 
.DD 
MapDD 
<DD 
AppointmentDtoDD (
>DD( )
(DD) *"
appointmentWithDetailsDD* @
)DD@ A
;DDA B
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
intGGU X
doctorIdGGY a
,GGa b
AppointmentStatusGGc t
?GGt u
statusGGv |
,GG| }
PaginationQueryDto	GG~ ê

pagination
GGë õ
)
GGõ ú
{HH 
varII 
appointmentsII 
=II 
awaitII  !
appointmentRepositoryII! 6
.II6 7*
GetAppointmentsByDoctorIdAsyncII7 U
(IIU V
doctorIdIIV ^
,II^ _
statusII` f
,IIf g

paginationIIh r
.IIr s

PageNumberIIs }
,II} ~

pagination	II â
.
IIâ ä
PageSize
IIä í
)
IIí ì
;
IIì î
returnJJ 
MapPagedResultJJ 
<JJ 
AppointmentJJ )
,JJ) *
AppointmentDtoJJ+ 9
>JJ9 :
(JJ: ;
appointmentsJJ; G
)JJG H
;JJH I
}KK 
publicMM 

asyncMM 
TaskMM 
<MM 
PagedResultDtoMM $
<MM$ %
AppointmentDtoMM% 3
>MM3 4
>MM4 5+
GetAppointmentsByPatientIdAsyncMM6 U
(MMU V
intMMV Y
	patientIdMMZ c
,MMc d
AppointmentStatusMMe v
?MMv w
statusMMx ~
,MM~  
PaginationQueryDto
MMÄ í

pagination
MMì ù
)
MMù û
{NN 
varOO 
appointmentsOO 
=OO 
awaitOO  !
appointmentRepositoryOO! 6
.OO6 7+
GetAppointmentsByPatientIdAsyncOO7 V
(OOV W
	patientIdOOW `
,OO` a
statusOOb h
,OOh i

paginationOOj t
.OOt u

PageNumberOOu 
,	OO Ä

pagination
OOÅ ã
.
OOã å
PageSize
OOå î
)
OOî ï
;
OOï ñ
returnPP 
MapPagedResultPP 
<PP 
AppointmentPP )
,PP) *
AppointmentDtoPP+ 9
>PP9 :
(PP: ;
appointmentsPP; G
)PPG H
;PPH I
}QQ 
publicSS 

asyncSS 
TaskSS 
<SS 
PagedResultDtoSS $
<SS$ %
AppointmentDtoSS% 3
>SS3 4
>SS4 51
%GetAppointmentsByDoctorIdAndDateAsyncSS6 [
(SS[ \
intSS\ _
doctorIdSS` h
,SSh i
DateOnlySSj r
dateSSs w
,SSw x
PaginationQueryDto	SSy ã

pagination
SSå ñ
)
SSñ ó
{TT 
varUU 
appointmentsUU 
=UU 
awaitUU  !
appointmentRepositoryUU! 6
.UU6 71
%GetAppointmentsByDoctorIdAndDateAsyncUU7 \
(UU\ ]
doctorIdUU] e
,UUe f
dateUUg k
,UUk l

paginationUUm w
.UUw x

PageNumber	UUx Ç
,
UUÇ É

pagination
UUÑ é
.
UUé è
PageSize
UUè ó
)
UUó ò
;
UUò ô
returnVV 
MapPagedResultVV 
<VV 
AppointmentVV )
,VV) *
AppointmentDtoVV+ 9
>VV9 :
(VV: ;
appointmentsVV; G
)VVG H
;VVH I
}WW 
publicYY 

asyncYY 
TaskYY 
<YY 
PagedResultDtoYY $
<YY$ %
AppointmentDtoYY% 3
>YY3 4
>YY4 5/
#GetAppointmentsByDateAndStatusAsyncYY6 Y
(YYY Z
DateOnlyYYZ b
dateYYc g
,YYg h
AppointmentStatusYYi z
?YYz {
status	YY| Ç
,
YYÇ É 
PaginationQueryDto
YYÑ ñ

pagination
YYó °
)
YY° ¢
{ZZ 
var[[ 
appointments[[ 
=[[ 
await[[  !
appointmentRepository[[! 6
.[[6 7/
#GetAppointmentsByDateAndStatusAsync[[7 Z
([[Z [
date[[[ _
,[[_ `
status[[a g
,[[g h

pagination[[i s
.[[s t

PageNumber[[t ~
,[[~ 

pagination
[[Ä ä
.
[[ä ã
PageSize
[[ã ì
)
[[ì î
;
[[î ï
return\\ 
MapPagedResult\\ 
<\\ 
Appointment\\ )
,\\) *
AppointmentDto\\+ 9
>\\9 :
(\\: ;
appointments\\; G
)\\G H
;\\H I
}]] 
public__ 

async__ 
Task__ 
<__ 
AppointmentDto__ $
?__$ %
>__% &(
UpdateAppointmentStatusAsync__' C
(__C D
int__D G
id__H J
,__J K&
UpdateAppointmentStatusDto__L f
dto__g j
,__j k
string__l r
currentRole__s ~
,__~ 
int
__Ä É
?
__É Ñ
currentPatientId
__Ö ï
,
__ï ñ
int
__ó ö
?
__ö õ
currentDoctorId
__ú ´
)
__´ ¨
{`` 
varaa 
appointmentaa 
=aa 
awaitaa !
appointmentRepositoryaa  5
.aa5 6.
"GetAppointmentByIdWithDetailsAsyncaa6 X
(aaX Y
idaaY [
)aa[ \
??bb 
throwbb 
newbb 
NotFoundExceptionbb *
(bb* +
ErrorMessagesbb+ 8
.bb8 9
AppointmentNotFoundbb9 L
)bbL M
;bbM N
switchdd 
(dd 
dtodd 
.dd 
Statusdd 
)dd 
{ee 	
caseff 
AppointmentStatusff "
.ff" #
	Confirmedff# ,
:ff, -
ConfirmAppointmentgg "
(gg" #
appointmentgg# .
,gg. /
currentRolegg0 ;
,gg; <
currentDoctorIdgg= L
)ggL M
;ggM N
breakhh 
;hh 
caseii 
AppointmentStatusii "
.ii" #
	Cancelledii# ,
:ii, -
CancelAppointmentjj !
(jj! "
appointmentjj" -
,jj- .
dtojj/ 2
,jj2 3
currentRolejj4 ?
,jj? @
currentPatientIdjjA Q
,jjQ R
currentDoctorIdjjS b
)jjb c
;jjc d
breakkk 
;kk 
casell 
AppointmentStatusll "
.ll" #
	Completedll# ,
:ll, -
throwmm 
newmm !
BusinessRuleExceptionmm /
(mm/ 0
ErrorMessagesmm0 =
.mm= >7
+AppointmentCompletedOnlyThroughHealthRecordmm> i
)mmi j
;mmj k
defaultnn 
:nn 
throwoo 
newoo !
BusinessRuleExceptionoo /
(oo/ 0
ErrorMessagesoo0 =
.oo= >2
&UnsupportedAppointmentStatusTransitionoo> d
)ood e
;ooe f
}pp 	
awaitrr !
appointmentRepositoryrr #
.rr# $
UpdateAsyncrr$ /
(rr/ 0
appointmentrr0 ;
)rr; <
;rr< =
iftt 

(tt 
dtott 
.tt 
Statustt 
==tt 
AppointmentStatustt +
.tt+ ,
	Cancelledtt, 5
)tt5 6
{uu 	
awaitvv $
availabilityCacheServicevv *
.vv* +"
RemoveDoctorSlotsAsyncvv+ A
(vvA B
appointmentvvB M
.vvM N
DoctorIdvvN V
,vvV W
appointmentvvX c
.vvc d
AppointmentDatevvd s
)vvs t
;vvt u
}ww 	
varyy "
appointmentWithDetailsyy "
=yy# $
awaityy% *!
appointmentRepositoryyy+ @
.yy@ A.
"GetAppointmentByIdWithDetailsAsyncyyA c
(yyc d
idyyd f
)yyf g
;yyg h
returnzz "
appointmentWithDetailszz %
==zz& (
nullzz) -
?{{ 
throw{{ 
new{{ 
NotFoundException{{ )
({{) *
ErrorMessages{{* 7
.{{7 8
AppointmentNotFound{{8 K
){{K L
:|| 
mapper|| 
.|| 
Map|| 
<|| 
AppointmentDto|| '
>||' (
(||( )"
appointmentWithDetails||) ?
)||? @
;||@ A
}}} 
public 

Task 
< 
List 
<  
AppointmentReportDto )
>) *
>* +&
GetAppointmentReportsAsync, F
(F G
)G H
=>I K!
appointmentRepositoryL a
.a b&
GetAppointmentReportsAsyncb |
(| }
)} ~
;~ 
private
ÅÅ 
async
ÅÅ 
Task
ÅÅ 2
$ValidateAppointmentCanBeCreatedAsync
ÅÅ ;
(
ÅÅ; <"
CreateAppointmentDto
ÅÅ< P
dto
ÅÅQ T
)
ÅÅT U
{
ÇÇ 
if
ÉÉ 

(
ÉÉ 
await
ÉÉ 
patientRepository
ÉÉ #
.
ÉÉ# $
GetByIdAsync
ÉÉ$ 0
(
ÉÉ0 1
dto
ÉÉ1 4
.
ÉÉ4 5
	PatientId
ÉÉ5 >
)
ÉÉ> ?
==
ÉÉ@ B
null
ÉÉC G
)
ÉÉG H
throw
ÉÉI N
new
ÉÉO R
NotFoundException
ÉÉS d
(
ÉÉd e
ErrorMessages
ÉÉe r
.
ÉÉr s
PatientNotFoundÉÉs Ç
)ÉÉÇ É
;ÉÉÉ Ñ
var
ÑÑ 
doctor
ÑÑ 
=
ÑÑ 
await
ÑÑ 
doctorRepository
ÑÑ +
.
ÑÑ+ , 
GetDoctorByIdAsync
ÑÑ, >
(
ÑÑ> ?
dto
ÑÑ? B
.
ÑÑB C
DoctorId
ÑÑC K
)
ÑÑK L
??
ÑÑM O
throw
ÑÑP U
new
ÑÑV Y
NotFoundException
ÑÑZ k
(
ÑÑk l
ErrorMessages
ÑÑl y
.
ÑÑy z
DoctorNotFoundÑÑz à
)ÑÑà â
;ÑÑâ ä
if
ÖÖ 

(
ÖÖ 
!
ÖÖ 
doctor
ÖÖ 
.
ÖÖ 
IsAvailable
ÖÖ 
)
ÖÖ  
throw
ÖÖ! &
new
ÖÖ' *#
BusinessRuleException
ÖÖ+ @
(
ÖÖ@ A
ErrorMessages
ÖÖA N
.
ÖÖN O
DoctorUnavailable
ÖÖO `
)
ÖÖ` a
;
ÖÖa b
if
ÜÜ 

(
ÜÜ 
!
ÜÜ !
IsAtLeastHoursAhead
ÜÜ  
(
ÜÜ  !
dto
ÜÜ! $
.
ÜÜ$ %
AppointmentDate
ÜÜ% 4
,
ÜÜ4 5
dto
ÜÜ6 9
.
ÜÜ9 :
AppointmentTime
ÜÜ: I
,
ÜÜI J2
$MinimumBookingHoursBeforeAppointment
ÜÜK o
)
ÜÜo p
)
ÜÜp q
throw
ÜÜr w
new
ÜÜx {$
BusinessRuleExceptionÜÜ| ë
(ÜÜë í
ErrorMessagesÜÜí ü
.ÜÜü †:
*AppointmentMustBeBookedAtLeast48HoursAheadÜÜ†  
)ÜÜ  À
;ÜÜÀ Ã
if
áá 

(
áá #
IsMoreThanMonthsAhead
áá !
(
áá! "
dto
áá" %
.
áá% &
AppointmentDate
áá& 5
,
áá5 6'
MaximumBookingMonthsAhead
áá7 P
)
ááP Q
)
ááQ R
throw
ááS X
new
ááY \#
BusinessRuleException
áá] r
(
áár s
ErrorMessagesáás Ä
.ááÄ Å?
/AppointmentCannotBeBookedMoreThanSixMonthsAheadááÅ ∞
)áá∞ ±
;áá± ≤
if
àà 

(
àà 
await
àà #
appointmentRepository
àà '
.
àà' (5
'DoctorHasNonCancelledAppointmentAtAsync
àà( O
(
ààO P
dto
ààP S
.
ààS T
DoctorId
ààT \
,
àà\ ]
dto
àà^ a
.
ààa b
AppointmentDate
ààb q
,
ààq r
dto
ààs v
.
ààv w
AppointmentTimeààw Ü
)ààÜ á
)ààá à
throwààâ é
newààè í!
ConflictExceptionààì §
(àà§ •
ErrorMessagesàà• ≤
.àà≤ ≥'
DoctorSlotAlreadyBookedàà≥  
)àà  À
;ààÀ Ã
if
ââ 

(
ââ 
await
ââ #
appointmentRepository
ââ '
.
ââ' (6
(PatientHasNonCancelledAppointmentAtAsync
ââ( P
(
ââP Q
dto
ââQ T
.
ââT U
	PatientId
ââU ^
,
ââ^ _
dto
ââ` c
.
ââc d
AppointmentDate
ââd s
,
ââs t
dto
ââu x
.
ââx y
AppointmentTimeâây à
)ââà â
)âââ ä
throwââã ê
newââë î!
ConflictExceptionââï ¶
(ââ¶ ß
ErrorMessagesââß ¥
.ââ¥ µ(
PatientSlotAlreadyBookedââµ Õ
)ââÕ Œ
;ââŒ œ
if
ää 

(
ää 
await
ää #
appointmentRepository
ää '
.
ää' (D
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsync
ää( ^
(
ää^ _
dto
ää_ b
.
ääb c
	PatientId
ääc l
,
ääl m
dto
ään q
.
ääq r
DoctorId
äär z
,
ääz {
dto
ää| 
.ää Ä
AppointmentDateääÄ è
)ääè ê
)ääê ë
throwääí ó
newääò õ!
ConflictExceptionääú ≠
(ää≠ Æ
ErrorMessagesääÆ ª
.ääª º<
,PatientAlreadyHasAppointmentWithDoctorOnDateääº Ë
)ääË È
;ääÈ Í
}
ãã 
private
çç 
static
çç 
void
çç  
ConfirmAppointment
çç *
(
çç* +
Appointment
çç+ 6
appointment
çç7 B
,
ççB C
string
ççD J
currentRole
ççK V
,
ççV W
int
ççX [
?
çç[ \
currentDoctorId
çç] l
)
ççl m
{
éé 
if
èè 

(
èè 
appointment
èè 
.
èè 
Status
èè 
!=
èè !
AppointmentStatus
èè" 3
.
èè3 4
Pending
èè4 ;
)
èè; <
throw
èè= B
new
èèC F#
BusinessRuleException
èèG \
(
èè\ ]
ErrorMessages
èè] j
.
èèj k4
%OnlyPendingAppointmentsCanBeConfirmedèèk ê
)èèê ë
;èèë í
if
êê 

(
êê 
currentRole
êê 
==
êê 
AppRoles
êê #
.
êê# $
Patient
êê$ +
)
êê+ ,
throw
êê- 2
new
êê3 6 
ForbiddenException
êê7 I
(
êêI J
ErrorMessages
êêJ W
.
êêW X4
&UnsupportedAppointmentStatusTransition
êêX ~
)
êê~ 
;êê Ä
if
ëë 

(
ëë 
currentRole
ëë 
==
ëë 
AppRoles
ëë #
.
ëë# $
Doctor
ëë$ *
&&
ëë+ -
currentDoctorId
ëë. =
!=
ëë> @
appointment
ëëA L
.
ëëL M
DoctorId
ëëM U
)
ëëU V
throw
ëëW \
new
ëë] ` 
ForbiddenException
ëëa s
(
ëës t
ErrorMessagesëët Å
.ëëÅ Ç3
#DoctorsCanManageOnlyOwnAppointmentsëëÇ •
)ëë• ¶
;ëë¶ ß
appointment
íí 
.
íí 
Status
íí 
=
íí 
AppointmentStatus
íí .
.
íí. /
	Confirmed
íí/ 8
;
íí8 9
appointment
ìì 
.
ìì  
CancellationReason
ìì &
=
ìì' (
null
ìì) -
;
ìì- .
}
îî 
private
ññ 
static
ññ 
void
ññ 
CancelAppointment
ññ )
(
ññ) *
Appointment
ññ* 5
appointment
ññ6 A
,
ññA B(
UpdateAppointmentStatusDto
ññC ]
dto
ññ^ a
,
ñña b
string
ññc i
currentRole
ññj u
,
ññu v
int
ññw z
?
ññz {
currentPatientIdññ| å
,ññå ç
intññé ë
?ññë í
currentDoctorIdññì ¢
)ññ¢ £
{
óó -
EnsureAppointmentCanBeCancelled
òò '
(
òò' (
appointment
òò( 3
,
òò3 4
dto
òò5 8
)
òò8 9
;
òò9 :
var
ôô 
reason
ôô 
=
ôô 
dto
ôô 
.
ôô  
CancellationReason
ôô +
!
ôô+ ,
.
ôô, -
Trim
ôô- 1
(
ôô1 2
)
ôô2 3
;
ôô3 4
appointment
öö 
.
öö  
CancellationReason
öö &
=
öö' (
currentRole
öö) 4
switch
öö5 ;
{
õõ 	
AppRoles
úú 
.
úú 
Patient
úú 
=>
úú ,
BuildPatientCancellationReason
úú  >
(
úú> ?
appointment
úú? J
,
úúJ K
reason
úúL R
,
úúR S
currentPatientId
úúT d
)
úúd e
,
úúe f
AppRoles
ùù 
.
ùù 
Doctor
ùù 
=>
ùù +
BuildDoctorCancellationReason
ùù <
(
ùù< =
appointment
ùù= H
,
ùùH I
reason
ùùJ P
,
ùùP Q
currentDoctorId
ùùR a
)
ùùa b
,
ùùb c
AppRoles
ûû 
.
ûû 
Admin
ûû 
=>
ûû 
reason
ûû $
+
ûû% &
ErrorMessages
ûû' 4
.
ûû4 5$
CancelledByAdminSuffix
ûû5 K
,
ûûK L
_
üü 
=>
üü 
throw
üü 
new
üü  
ForbiddenException
üü -
(
üü- .
ErrorMessages
üü. ;
.
üü; <4
&UnsupportedAppointmentStatusTransition
üü< b
)
üüb c
}
†† 	
;
††	 

appointment
°° 
.
°° 
Status
°° 
=
°° 
AppointmentStatus
°° .
.
°°. /
	Cancelled
°°/ 8
;
°°8 9
}
¢¢ 
private
§§ 
static
§§ 
void
§§ -
EnsureAppointmentCanBeCancelled
§§ 7
(
§§7 8
Appointment
§§8 C
appointment
§§D O
,
§§O P(
UpdateAppointmentStatusDto
§§Q k
dto
§§l o
)
§§o p
{
•• 
if
¶¶ 

(
¶¶ 
string
¶¶ 
.
¶¶  
IsNullOrWhiteSpace
¶¶ %
(
¶¶% &
dto
¶¶& )
.
¶¶) * 
CancellationReason
¶¶* <
)
¶¶< =
)
¶¶= >
throw
¶¶? D
new
¶¶E H#
BusinessRuleException
¶¶I ^
(
¶¶^ _
ErrorMessages
¶¶_ l
.
¶¶l m)
CancellationReasonRequired¶¶m á
)¶¶á à
;¶¶à â
if
ßß 

(
ßß 
appointment
ßß 
.
ßß 
Status
ßß 
==
ßß !
AppointmentStatus
ßß" 3
.
ßß3 4
	Completed
ßß4 =
)
ßß= >
throw
ßß? D
new
ßßE H#
BusinessRuleException
ßßI ^
(
ßß^ _
ErrorMessages
ßß_ l
.
ßßl m5
&CompletedAppointmentsCannotBeCancelledßßm ì
)ßßì î
;ßßî ï
if
®® 

(
®® 
appointment
®® 
.
®® 
Status
®® 
==
®® !
AppointmentStatus
®®" 3
.
®®3 4
	Cancelled
®®4 =
)
®®= >
throw
®®? D
new
®®E H#
BusinessRuleException
®®I ^
(
®®^ _
ErrorMessages
®®_ l
.
®®l m:
+CancelledAppointmentsCannotBeCancelledAgain®®m ò
)®®ò ô
;®®ô ö
}
©© 
private
´´ 
static
´´ 
string
´´ ,
BuildPatientCancellationReason
´´ 8
(
´´8 9
Appointment
´´9 D
appointment
´´E P
,
´´P Q
string
´´R X
reason
´´Y _
,
´´_ `
int
´´a d
?
´´d e
currentPatientId
´´f v
)
´´v w
{
¨¨ 
if
≠≠ 

(
≠≠ 
currentPatientId
≠≠ 
!=
≠≠ 
appointment
≠≠  +
.
≠≠+ ,
	PatientId
≠≠, 5
)
≠≠5 6
throw
≠≠7 <
new
≠≠= @ 
ForbiddenException
≠≠A S
(
≠≠S T
ErrorMessages
≠≠T a
.
≠≠a b3
$PatientsCanManageOnlyOwnAppointments≠≠b Ü
)≠≠Ü á
;≠≠á à
if
ÆÆ 

(
ÆÆ 
appointment
ÆÆ 
.
ÆÆ 
Status
ÆÆ 
!=
ÆÆ !
AppointmentStatus
ÆÆ" 3
.
ÆÆ3 4
Pending
ÆÆ4 ;
)
ÆÆ; <
throw
ÆÆ= B
new
ÆÆC F#
BusinessRuleException
ÆÆG \
(
ÆÆ\ ]
ErrorMessages
ÆÆ] j
.
ÆÆj k7
(PatientsCanCancelOnlyPendingAppointmentsÆÆk ì
)ÆÆì î
;ÆÆî ï
return
ØØ 
reason
ØØ 
+
ØØ 
ErrorMessages
ØØ %
.
ØØ% &&
CancelledByPatientSuffix
ØØ& >
;
ØØ> ?
}
∞∞ 
private
≤≤ 
static
≤≤ 
string
≤≤ +
BuildDoctorCancellationReason
≤≤ 7
(
≤≤7 8
Appointment
≤≤8 C
appointment
≤≤D O
,
≤≤O P
string
≤≤Q W
reason
≤≤X ^
,
≤≤^ _
int
≤≤` c
?
≤≤c d
currentDoctorId
≤≤e t
)
≤≤t u
{
≥≥ 
if
¥¥ 

(
¥¥ 
currentDoctorId
¥¥ 
!=
¥¥ 
appointment
¥¥ *
.
¥¥* +
DoctorId
¥¥+ 3
)
¥¥3 4
throw
¥¥5 :
new
¥¥; > 
ForbiddenException
¥¥? Q
(
¥¥Q R
ErrorMessages
¥¥R _
.
¥¥_ `2
#DoctorsCanManageOnlyOwnAppointments¥¥` É
)¥¥É Ñ
;¥¥Ñ Ö
if
µµ 

(
µµ 
appointment
µµ 
.
µµ 
Status
µµ 
!=
µµ !
AppointmentStatus
µµ" 3
.
µµ3 4
Pending
µµ4 ;
&&
µµ< >
appointment
µµ? J
.
µµJ K
Status
µµK Q
!=
µµR T
AppointmentStatus
µµU f
.
µµf g
	Confirmed
µµg p
)
µµp q
throw
µµr w
new
µµx {$
BusinessRuleExceptionµµ| ë
(µµë í
ErrorMessagesµµí ü
.µµü †B
2DoctorsCanCancelOnlyPendingOrConfirmedAppointmentsµµ† “
)µµ“ ”
;µµ” ‘
if
∂∂ 

(
∂∂ 
!
∂∂ !
IsAtLeastHoursAhead
∂∂  
(
∂∂  !
appointment
∂∂! ,
.
∂∂, -
AppointmentDate
∂∂- <
,
∂∂< =
appointment
∂∂> I
.
∂∂I J
AppointmentTime
∂∂J Y
,
∂∂Y Z8
)MinimumCancellationHoursBeforeAppointment∂∂[ Ñ
)∂∂Ñ Ö
)∂∂Ö Ü
throw∂∂á å
new∂∂ç ê%
BusinessRuleException∂∂ë ¶
(∂∂¶ ß
ErrorMessages∂∂ß ¥
.∂∂¥ µ9
)AppointmentCannotBeCancelledWithin24Hours∂∂µ ﬁ
)∂∂ﬁ ﬂ
;∂∂ﬂ ‡
return
∑∑ 
reason
∑∑ 
+
∑∑ 
ErrorMessages
∑∑ %
.
∑∑% &%
CancelledByDoctorSuffix
∑∑& =
;
∑∑= >
}
∏∏ 
private
∫∫ 
static
∫∫ 
bool
∫∫ !
IsAtLeastHoursAhead
∫∫ +
(
∫∫+ ,
DateOnly
∫∫, 4
date
∫∫5 9
,
∫∫9 :
TimeOnly
∫∫; C
time
∫∫D H
,
∫∫H I
int
∫∫J M
minimumHours
∫∫N Z
)
∫∫Z [
=>
∫∫\ ^
date
∫∫_ c
.
∫∫c d

ToDateTime
∫∫d n
(
∫∫n o
time
∫∫o s
)
∫∫s t
>=
∫∫u w
DateTime∫∫x Ä
.∫∫Ä Å
Now∫∫Å Ñ
.∫∫Ñ Ö
AddHours∫∫Ö ç
(∫∫ç é
minimumHours∫∫é ö
)∫∫ö õ
;∫∫õ ú
private
ºº 
static
ºº 
bool
ºº #
IsMoreThanMonthsAhead
ºº -
(
ºº- .
DateOnly
ºº. 6
date
ºº7 ;
,
ºº; <
int
ºº= @
maximumMonths
ººA N
)
ººN O
=>
ººP R
date
ººS W
>
ººX Y
DateOnly
ººZ b
.
ººb c
FromDateTime
ººc o
(
ººo p
DateTime
ººp x
.
ººx y
Today
ººy ~
)
ºº~ 
.ºº Ä
	AddMonthsººÄ â
(ººâ ä
maximumMonthsººä ó
)ººó ò
;ººò ô
private
ææ 
PagedResultDto
ææ 
<
ææ 
TDestination
ææ '
>
ææ' (
MapPagedResult
ææ) 7
<
ææ7 8
TSource
ææ8 ?
,
ææ? @
TDestination
ææA M
>
ææM N
(
ææN O
PagedResult
ææO Z
<
ææZ [
TSource
ææ[ b
>
ææb c
pagedResult
ææd o
)
ææo p
=>
ææq s
new
ææt w
(
ææw x
)
ææx y
{
øø 
Items
¿¿ 
=
¿¿ 
mapper
¿¿ 
.
¿¿ 
Map
¿¿ 
<
¿¿ 
List
¿¿ 
<
¿¿  
TDestination
¿¿  ,
>
¿¿, -
>
¿¿- .
(
¿¿. /
pagedResult
¿¿/ :
.
¿¿: ;
Items
¿¿; @
)
¿¿@ A
,
¿¿A B

PageNumber
¡¡ 
=
¡¡ 
pagedResult
¡¡  
.
¡¡  !

PageNumber
¡¡! +
,
¡¡+ ,
PageSize
¬¬ 
=
¬¬ 
pagedResult
¬¬ 
.
¬¬ 
PageSize
¬¬ '
,
¬¬' (

TotalCount
√√ 
=
√√ 
pagedResult
√√  
.
√√  !

TotalCount
√√! +
,
√√+ ,

TotalPages
ƒƒ 
=
ƒƒ 
pagedResult
ƒƒ  
.
ƒƒ  !

TotalPages
ƒƒ! +
}
≈≈ 
;
≈≈ 
}∆∆ ˆ†
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
AppointmentStatus	##r É
.
##É Ñ
Pending
##Ñ ã
)
##ã å
,
##å ç&
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
AppointmentStatus	$$t Ö
.
$$Ö Ü
	Confirmed
$$Ü è
)
$$è ê
,
$$ê ë&
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
AppointmentStatus	%%t Ö
.
%%Ö Ü
	Completed
%%Ü è
)
%%è ê
,
%%ê ë&
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
AppointmentStatus	&&t Ö
.
&&Ö Ü
	Cancelled
&&Ü è
)
&&è ê
,
&&ê ë#
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
)	'' Ä
,
''Ä Å*
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
==	((~ Ä
today
((Å Ü
&&
((á â
appointment
((ä ï
.
((ï ñ
Status
((ñ ú
==
((ù ü
AppointmentStatus
((† ±
.
((± ≤
Pending
((≤ π
)
((π ∫
,
((∫ ª,
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
))Ä Ç
today
))É à
&&
))â ã
appointment
))å ó
.
))ó ò
Status
))ò û
==
))ü °
AppointmentStatus
))¢ ≥
.
))≥ ¥
	Confirmed
))¥ Ω
)
))Ω æ
,
))æ ø,
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
**Ä Ç
today
**É à
&&
**â ã
appointment
**å ó
.
**ó ò
Status
**ò û
==
**ü °
AppointmentStatus
**¢ ≥
.
**≥ ¥
	Completed
**¥ Ω
)
**Ω æ
,
**æ ø,
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
++Ä Ç
today
++É à
&&
++â ã
appointment
++å ó
.
++ó ò
Status
++ò û
==
++ü °
AppointmentStatus
++¢ ≥
.
++≥ ¥
	Cancelled
++¥ Ω
)
++Ω æ
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
ÅÅ 

(
ÅÅ 
doctor
ÅÅ 
==
ÅÅ 
null
ÅÅ 
)
ÅÅ 
{
ÇÇ 	
throw
ÉÉ 
new
ÉÉ 
NotFoundException
ÉÉ '
(
ÉÉ' (
ErrorMessages
ÉÉ( 5
.
ÉÉ5 6
DoctorNotFound
ÉÉ6 D
)
ÉÉD E
;
ÉÉE F
}
ÑÑ 	
if
ÜÜ 

(
ÜÜ 
doctor
ÜÜ 
.
ÜÜ 
User
ÜÜ 
==
ÜÜ 
null
ÜÜ 
)
ÜÜ  
{
áá 	
throw
àà 
new
àà 
NotFoundException
àà '
(
àà' (
ErrorMessages
àà( 5
.
àà5 6
DoctorNotFound
àà6 D
)
ààD E
;
ààE F
}
ââ 	
await
ãã 0
"EnsureEmailIsAvailableForUserAsync
ãã 0
(
ãã0 1
dto
ãã1 4
.
ãã4 5
Email
ãã5 :
,
ãã: ;
doctor
ãã< B
.
ããB C
UserId
ããC I
)
ããI J
;
ããJ K
doctor
çç 
.
çç 
FullName
çç 
=
çç 
dto
çç 
.
çç 
FullName
çç &
;
çç& '
doctor
éé 
.
éé 
Specialisation
éé 
=
éé 
dto
éé  #
.
éé# $
Specialisation
éé$ 2
;
éé2 3
doctor
èè 
.
èè 
PracticeStartDate
èè  
=
èè! "
dto
èè# &
.
èè& '
PracticeStartDate
èè' 8
;
èè8 9
doctor
êê 
.
êê 
ConsultationFee
êê 
=
êê  
dto
êê! $
.
êê$ %
ConsultationFee
êê% 4
;
êê4 5
doctor
ëë 
.
ëë 
User
ëë 
.
ëë 
Email
ëë 
=
ëë 
dto
ëë 
.
ëë  
Email
ëë  %
.
ëë% &
Trim
ëë& *
(
ëë* +
)
ëë+ ,
;
ëë, -
doctor
íí 
.
íí 
User
íí 
.
íí 
UserName
íí 
=
íí 
dto
íí "
.
íí" #
Email
íí# (
.
íí( )
Trim
íí) -
(
íí- .
)
íí. /
;
íí/ 0
doctor
ìì 
.
ìì 
User
ìì 
.
ìì 
PhoneNumber
ìì 
=
ìì  !
dto
ìì" %
.
ìì% &
PhoneNumber
ìì& 1
;
ìì1 2
doctor
îî 
.
îî 
User
îî 
.
îî 
EmailConfirmed
îî "
=
îî# $
true
îî% )
;
îî) *
var
ññ 
updateUserResult
ññ 
=
ññ 
await
ññ $
userManager
ññ% 0
.
ññ0 1
UpdateAsync
ññ1 <
(
ññ< =
doctor
ññ= C
.
ññC D
User
ññD H
)
ññH I
;
ññI J
if
òò 

(
òò 
!
òò 
updateUserResult
òò 
.
òò 
	Succeeded
òò '
)
òò' (
{
ôô 	
var
öö 
errors
öö 
=
öö 
string
öö 
.
öö  
Join
öö  $
(
öö$ %
$str
öö% (
,
öö( )
updateUserResult
öö* :
.
öö: ;
Errors
öö; A
.
ööA B
Select
ööB H
(
ööH I
error
ööI N
=>
ööO Q
error
ööR W
.
ööW X
Description
ööX c
)
ööc d
)
ööd e
;
ööe f
throw
õõ 
new
õõ !
BadRequestException
õõ )
(
õõ) *
errors
õõ* 0
)
õõ0 1
;
õõ1 2
}
úú 	
await
ûû 
doctorRepository
ûû 
.
ûû 
UpdateAsync
ûû *
(
ûû* +
doctor
ûû+ 1
)
ûû1 2
;
ûû2 3
var
†† 
updatedDoctor
†† 
=
†† 
await
†† !
doctorRepository
††" 2
.
††2 3(
GetDoctorByIdWithUserAsync
††3 M
(
††M N
id
††N P
)
††P Q
;
††Q R
return
¢¢ 
updatedDoctor
¢¢ 
==
¢¢ 
null
¢¢  $
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
§§ 
mapper
§§ 
.
§§ 
Map
§§ 
<
§§ 
	DoctorDto
§§ "
>
§§" #
(
§§# $
updatedDoctor
§§$ 1
)
§§1 2
;
§§2 3
}
•• 
public
ßß 

async
ßß 
Task
ßß &
ResetDoctorPasswordAsync
ßß .
(
ßß. /
int
ßß/ 2
id
ßß3 5
,
ßß5 6#
AdminResetPasswordDto
ßß7 L
dto
ßßM P
)
ßßP Q
{
®® 
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
´´ 

(
´´ 
doctor
´´ 
==
´´ 
null
´´ 
||
´´ 
doctor
´´ $
.
´´$ %
User
´´% )
==
´´* ,
null
´´- 1
)
´´1 2
{
¨¨ 	
throw
≠≠ 
new
≠≠ 
NotFoundException
≠≠ '
(
≠≠' (
ErrorMessages
≠≠( 5
.
≠≠5 6
DoctorNotFound
≠≠6 D
)
≠≠D E
;
≠≠E F
}
ÆÆ 	
await
∞∞ $
ResetUserPasswordAsync
∞∞ $
(
∞∞$ %
doctor
∞∞% +
.
∞∞+ ,
User
∞∞, 0
,
∞∞0 1
dto
∞∞2 5
)
∞∞5 6
;
∞∞6 7
}
±± 
public
≥≥ 

async
≥≥ 
Task
≥≥ 
<
≥≥ 
PagedResultDto
≥≥ $
<
≥≥$ %
AppointmentDto
≥≥% 3
>
≥≥3 4
>
≥≥4 5(
GetDoctorAppointmentsAsync
≥≥6 P
(
≥≥P Q
int
≥≥Q T
doctorId
≥≥U ]
,
≥≥] ^
AppointmentStatus
≥≥_ p
?
≥≥p q
status
≥≥r x
,
≥≥x y!
PaginationQueryDto≥≥z å

pagination≥≥ç ó
)≥≥ó ò
{
¥¥ 
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
∑∑ 

(
∑∑ 
doctorExists
∑∑ 
==
∑∑ 
null
∑∑  
)
∑∑  !
{
∏∏ 	
throw
ππ 
new
ππ 
NotFoundException
ππ '
(
ππ' (
ErrorMessages
ππ( 5
.
ππ5 6
DoctorNotFound
ππ6 D
)
ππD E
;
ππE F
}
∫∫ 	
return
ºº 
await
ºº  
appointmentService
ºº '
.
ºº' (,
GetAppointmentsByDoctorIdAsync
ºº( F
(
ººF G
doctorId
ººG O
,
ººO P
status
ººQ W
,
ººW X

pagination
ººY c
)
ººc d
;
ººd e
}
ΩΩ 
public
øø 

async
øø 
Task
øø 
<
øø 
PagedResultDto
øø $
<
øø$ %

PatientDto
øø% /
>
øø/ 0
>
øø0 1
GetPatientsAsync
øø2 B
(
øøB C 
PaginationQueryDto
øøC U

pagination
øøV `
,
øø` a
string
øøb h
?
øøh i
search
øøj p
)
øøp q
{
¿¿ 
var
¡¡ 
patients
¡¡ 
=
¡¡ 
await
¡¡ 
patientRepository
¡¡ .
.
¡¡. /)
GetAllPatientsWithUserAsync
¡¡/ J
(
¡¡J K

pagination
¬¬ 
.
¬¬ 

PageNumber
¬¬ !
,
¬¬! "

pagination
√√ 
.
√√ 
PageSize
√√ 
,
√√  
search
ƒƒ 
)
ƒƒ 
;
ƒƒ 
return
∆∆ 
MapPagedResult
∆∆ 
<
∆∆ 
Patient
∆∆ %
,
∆∆% &

PatientDto
∆∆' 1
>
∆∆1 2
(
∆∆2 3
patients
∆∆3 ;
)
∆∆; <
;
∆∆< =
}
«« 
public
…… 

async
…… 
Task
…… 
<
…… 

PatientDto
……  
?
……  !
>
……! " 
UpdatePatientAsync
……# 5
(
……5 6
int
……6 9
id
……: <
,
……< =
UpdatePatientDto
……> N
dto
……O R
)
……R S
{
   
var
ÀÀ 
patient
ÀÀ 
=
ÀÀ 
await
ÀÀ 
patientRepository
ÀÀ -
.
ÀÀ- .)
GetPatientByIdWithUserAsync
ÀÀ. I
(
ÀÀI J
id
ÀÀJ L
)
ÀÀL M
;
ÀÀM N
if
ÕÕ 

(
ÕÕ 
patient
ÕÕ 
==
ÕÕ 
null
ÕÕ 
)
ÕÕ 
{
ŒŒ 	
throw
œœ 
new
œœ 
NotFoundException
œœ '
(
œœ' (
ErrorMessages
œœ( 5
.
œœ5 6
PatientNotFound
œœ6 E
)
œœE F
;
œœF G
}
–– 	
if
““ 

(
““ 
patient
““ 
.
““ 
User
““ 
==
““ 
null
““  
)
““  !
{
”” 	
throw
‘‘ 
new
‘‘ 
NotFoundException
‘‘ '
(
‘‘' (
ErrorMessages
‘‘( 5
.
‘‘5 6$
PatientAccountNotFound
‘‘6 L
)
‘‘L M
;
‘‘M N
}
’’ 	
await
◊◊ 0
"EnsureEmailIsAvailableForUserAsync
◊◊ 0
(
◊◊0 1
dto
◊◊1 4
.
◊◊4 5
Email
◊◊5 :
,
◊◊: ;
patient
◊◊< C
.
◊◊C D
UserId
◊◊D J
)
◊◊J K
;
◊◊K L
patient
ŸŸ 
.
ŸŸ 
FullName
ŸŸ 
=
ŸŸ 
dto
ŸŸ 
.
ŸŸ 
FullName
ŸŸ '
;
ŸŸ' (
patient
⁄⁄ 
.
⁄⁄ 
DateOfBirth
⁄⁄ 
=
⁄⁄ 
dto
⁄⁄ !
.
⁄⁄! "
DateOfBirth
⁄⁄" -
;
⁄⁄- .
patient
€€ 
.
€€ 
Gender
€€ 
=
€€ 
dto
€€ 
.
€€ 
Gender
€€ #
;
€€# $
patient
‹‹ 
.
‹‹ 
Address
‹‹ 
=
‹‹ 
dto
‹‹ 
.
‹‹ 
Address
‹‹ %
;
‹‹% &
patient
›› 
.
›› 
User
›› 
.
›› 
Email
›› 
=
›› 
dto
››  
.
››  !
Email
››! &
.
››& '
Trim
››' +
(
››+ ,
)
››, -
;
››- .
patient
ﬁﬁ 
.
ﬁﬁ 
User
ﬁﬁ 
.
ﬁﬁ 
UserName
ﬁﬁ 
=
ﬁﬁ 
dto
ﬁﬁ  #
.
ﬁﬁ# $
Email
ﬁﬁ$ )
.
ﬁﬁ) *
Trim
ﬁﬁ* .
(
ﬁﬁ. /
)
ﬁﬁ/ 0
;
ﬁﬁ0 1
patient
ﬂﬂ 
.
ﬂﬂ 
User
ﬂﬂ 
.
ﬂﬂ 
PhoneNumber
ﬂﬂ  
=
ﬂﬂ! "
dto
ﬂﬂ# &
.
ﬂﬂ& '
PhoneNumber
ﬂﬂ' 2
;
ﬂﬂ2 3
patient
‡‡ 
.
‡‡ 
User
‡‡ 
.
‡‡ 
EmailConfirmed
‡‡ #
=
‡‡$ %
true
‡‡& *
;
‡‡* +
var
‚‚ 
updateUserResult
‚‚ 
=
‚‚ 
await
‚‚ $
userManager
‚‚% 0
.
‚‚0 1
UpdateAsync
‚‚1 <
(
‚‚< =
patient
‚‚= D
.
‚‚D E
User
‚‚E I
)
‚‚I J
;
‚‚J K
if
‰‰ 

(
‰‰ 
!
‰‰ 
updateUserResult
‰‰ 
.
‰‰ 
	Succeeded
‰‰ '
)
‰‰' (
{
ÂÂ 	
var
ÊÊ 
errors
ÊÊ 
=
ÊÊ 
string
ÊÊ 
.
ÊÊ  
Join
ÊÊ  $
(
ÊÊ$ %
$str
ÊÊ% (
,
ÊÊ( )
updateUserResult
ÊÊ* :
.
ÊÊ: ;
Errors
ÊÊ; A
.
ÊÊA B
Select
ÊÊB H
(
ÊÊH I
error
ÊÊI N
=>
ÊÊO Q
error
ÊÊR W
.
ÊÊW X
Description
ÊÊX c
)
ÊÊc d
)
ÊÊd e
;
ÊÊe f
throw
ÁÁ 
new
ÁÁ !
BadRequestException
ÁÁ )
(
ÁÁ) *
errors
ÁÁ* 0
)
ÁÁ0 1
;
ÁÁ1 2
}
ËË 	
await
ÍÍ 
patientRepository
ÍÍ 
.
ÍÍ  
UpdateAsync
ÍÍ  +
(
ÍÍ+ ,
patient
ÍÍ, 3
)
ÍÍ3 4
;
ÍÍ4 5
var
ÏÏ 
updatedPatient
ÏÏ 
=
ÏÏ 
await
ÏÏ "
patientRepository
ÏÏ# 4
.
ÏÏ4 5)
GetPatientByIdWithUserAsync
ÏÏ5 P
(
ÏÏP Q
id
ÏÏQ S
)
ÏÏS T
;
ÏÏT U
return
ÓÓ 
updatedPatient
ÓÓ 
==
ÓÓ  
null
ÓÓ! %
?
ÔÔ 
throw
ÔÔ 
new
ÔÔ 
NotFoundException
ÔÔ )
(
ÔÔ) *
ErrorMessages
ÔÔ* 7
.
ÔÔ7 8
PatientNotFound
ÔÔ8 G
)
ÔÔG H
:
 
mapper
 
.
 
Map
 
<
 

PatientDto
 #
>
# $
(
$ %
updatedPatient
% 3
)
3 4
;
4 5
}
ÒÒ 
public
ÛÛ 

async
ÛÛ 
Task
ÛÛ '
ResetPatientPasswordAsync
ÛÛ /
(
ÛÛ/ 0
int
ÛÛ0 3
id
ÛÛ4 6
,
ÛÛ6 7#
AdminResetPasswordDto
ÛÛ8 M
dto
ÛÛN Q
)
ÛÛQ R
{
ÙÙ 
var
ıı 
patient
ıı 
=
ıı 
await
ıı 
patientRepository
ıı -
.
ıı- .)
GetPatientByIdWithUserAsync
ıı. I
(
ııI J
id
ııJ L
)
ııL M
;
ııM N
if
˜˜ 

(
˜˜ 
patient
˜˜ 
==
˜˜ 
null
˜˜ 
)
˜˜ 
{
¯¯ 	
throw
˘˘ 
new
˘˘ 
NotFoundException
˘˘ '
(
˘˘' (
ErrorMessages
˘˘( 5
.
˘˘5 6
PatientNotFound
˘˘6 E
)
˘˘E F
;
˘˘F G
}
˙˙ 	
if
¸¸ 

(
¸¸ 
patient
¸¸ 
.
¸¸ 
User
¸¸ 
==
¸¸ 
null
¸¸  
)
¸¸  !
{
˝˝ 	
throw
˛˛ 
new
˛˛ 
NotFoundException
˛˛ '
(
˛˛' (
ErrorMessages
˛˛( 5
.
˛˛5 6$
PatientAccountNotFound
˛˛6 L
)
˛˛L M
;
˛˛M N
}
ˇˇ 	
await
ÅÅ $
ResetUserPasswordAsync
ÅÅ $
(
ÅÅ$ %
patient
ÅÅ% ,
.
ÅÅ, -
User
ÅÅ- 1
,
ÅÅ1 2
dto
ÅÅ3 6
)
ÅÅ6 7
;
ÅÅ7 8
}
ÇÇ 
public
ÑÑ 

async
ÑÑ 
Task
ÑÑ 
<
ÑÑ 
PagedResultDto
ÑÑ $
<
ÑÑ$ %
AppointmentDto
ÑÑ% 3
>
ÑÑ3 4
>
ÑÑ4 5)
GetPatientAppointmentsAsync
ÑÑ6 Q
(
ÑÑQ R
int
ÑÑR U
	patientId
ÑÑV _
,
ÑÑ_ `
AppointmentStatus
ÑÑa r
?
ÑÑr s
status
ÑÑt z
,
ÑÑz {!
PaginationQueryDtoÑÑ| é

paginationÑÑè ô
)ÑÑô ö
{
ÖÖ 
return
ÜÜ 
await
ÜÜ  
appointmentService
ÜÜ '
.
ÜÜ' (-
GetAppointmentsByPatientIdAsync
ÜÜ( G
(
ÜÜG H
	patientId
ÜÜH Q
,
ÜÜQ R
status
ÜÜS Y
,
ÜÜY Z

pagination
ÜÜ[ e
)
ÜÜe f
;
ÜÜf g
}
áá 
public
ââ 

async
ââ 
Task
ââ 
<
ââ 
PagedResultDto
ââ $
<
ââ$ %"
AppointmentReportDto
ââ% 9
>
ââ9 :
>
ââ: ;(
GetAppointmentReportsAsync
ââ< V
(
ââV W 
PaginationQueryDto
ââW i

pagination
ââj t
)
âât u
{
ää 
var
ãã 
reports
ãã 
=
ãã 
await
ãã  
appointmentService
ãã .
.
ãã. /(
GetAppointmentReportsAsync
ãã/ I
(
ããI J
)
ããJ K
;
ããK L
var
çç 
orderedReports
çç 
=
çç 
reports
çç $
.
éé 
OrderByDescending
éé 
(
éé 
report
éé %
=>
éé& (
report
éé) /
.
éé/ 0
Date
éé0 4
)
éé4 5
.
èè 
ToList
èè 
(
èè 
)
èè 
;
èè 
var
ëë 

totalCount
ëë 
=
ëë 
orderedReports
ëë '
.
ëë' (
Count
ëë( -
;
ëë- .
var
íí 

totalPages
íí 
=
íí 
(
íí 
int
íí 
)
íí 
Math
íí "
.
íí" #
Ceiling
íí# *
(
íí* +

totalCount
íí+ 5
/
íí6 7
(
íí8 9
double
íí9 ?
)
íí? @

pagination
íí@ J
.
ííJ K
PageSize
ííK S
)
ííS T
;
ííT U
var
îî 
items
îî 
=
îî 
orderedReports
îî "
.
ïï 
Skip
ïï 
(
ïï 
(
ïï 

pagination
ïï 
.
ïï 

PageNumber
ïï (
-
ïï) *
$num
ïï+ ,
)
ïï, -
*
ïï. /

pagination
ïï0 :
.
ïï: ;
PageSize
ïï; C
)
ïïC D
.
ññ 
Take
ññ 
(
ññ 

pagination
ññ 
.
ññ 
PageSize
ññ %
)
ññ% &
.
óó 
ToList
óó 
(
óó 
)
óó 
;
óó 
return
ôô 
new
ôô 
PagedResultDto
ôô !
<
ôô! ""
AppointmentReportDto
ôô" 6
>
ôô6 7
{
öö 	
Items
õõ 
=
õõ 
items
õõ 
,
õõ 

PageNumber
úú 
=
úú 

pagination
úú #
.
úú# $

PageNumber
úú$ .
,
úú. /
PageSize
ùù 
=
ùù 

pagination
ùù !
.
ùù! "
PageSize
ùù" *
,
ùù* +

TotalCount
ûû 
=
ûû 

totalCount
ûû #
,
ûû# $

TotalPages
üü 
=
üü 

totalPages
üü #
}
†† 	
;
††	 

}
°° 
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
§§ 
date
§§ 
,
§§ 
AppointmentStatus
•• 
?
•• 
status
•• !
,
••! " 
PaginationQueryDto
¶¶ 

pagination
¶¶ %
)
¶¶% &
{
ßß 
return
®® 
await
®®  
appointmentService
®® '
.
®®' (1
#GetAppointmentsByDateAndStatusAsync
®®( K
(
®®K L
date
®®L P
,
®®P Q
status
®®R X
,
®®X Y

pagination
®®Z d
)
®®d e
;
®®e f
}
©© 
private
´´ 
async
´´ 
Task
´´ $
ResetUserPasswordAsync
´´ -
(
´´- .
IdentityUser
´´. :
user
´´; ?
,
´´? @#
AdminResetPasswordDto
´´A V
dto
´´W Z
)
´´Z [
{
¨¨ 
var
≠≠ 

resetToken
≠≠ 
=
≠≠ 
await
≠≠ 
userManager
≠≠ *
.
≠≠* +-
GeneratePasswordResetTokenAsync
≠≠+ J
(
≠≠J K
user
≠≠K O
)
≠≠O P
;
≠≠P Q
var
ÆÆ 
resetResult
ÆÆ 
=
ÆÆ 
await
ÆÆ 
userManager
ÆÆ  +
.
ÆÆ+ , 
ResetPasswordAsync
ÆÆ, >
(
ÆÆ> ?
user
ÆÆ? C
,
ÆÆC D

resetToken
ÆÆE O
,
ÆÆO P
dto
ÆÆQ T
.
ÆÆT U
NewPassword
ÆÆU `
)
ÆÆ` a
;
ÆÆa b
if
∞∞ 

(
∞∞ 
!
∞∞ 
resetResult
∞∞ 
.
∞∞ 
	Succeeded
∞∞ "
)
∞∞" #
{
±± 	
var
≤≤ 
errors
≤≤ 
=
≤≤ 
string
≤≤ 
.
≤≤  
Join
≤≤  $
(
≤≤$ %
$str
≤≤% (
,
≤≤( )
resetResult
≤≤* 5
.
≤≤5 6
Errors
≤≤6 <
.
≤≤< =
Select
≤≤= C
(
≤≤C D
error
≤≤D I
=>
≤≤J L
error
≤≤M R
.
≤≤R S
Description
≤≤S ^
)
≤≤^ _
)
≤≤_ `
;
≤≤` a
throw
≥≥ 
new
≥≥ !
BadRequestException
≥≥ )
(
≥≥) *
errors
≥≥* 0
)
≥≥0 1
;
≥≥1 2
}
¥¥ 	
}
µµ 
private
∑∑ 
async
∑∑ 
Task
∑∑ 0
"EnsureEmailIsAvailableForUserAsync
∑∑ 9
(
∑∑9 :
string
∑∑: @
email
∑∑A F
,
∑∑F G
string
∑∑H N
currentUserId
∑∑O \
)
∑∑\ ]
{
∏∏ 
var
ππ 
normalizedEmail
ππ 
=
ππ 
email
ππ #
.
ππ# $
Trim
ππ$ (
(
ππ( )
)
ππ) *
;
ππ* +
var
∫∫ 
existingUser
∫∫ 
=
∫∫ 
await
∫∫  
userManager
∫∫! ,
.
∫∫, -
FindByEmailAsync
∫∫- =
(
∫∫= >
normalizedEmail
∫∫> M
)
∫∫M N
;
∫∫N O
if
ºº 

(
ºº 
existingUser
ºº 
!=
ºº 
null
ºº  
&&
ºº! #
existingUser
ºº$ 0
.
ºº0 1
Id
ºº1 3
!=
ºº4 6
currentUserId
ºº7 D
)
ººD E
{
ΩΩ 	
throw
ææ 
new
ææ 
ConflictException
ææ '
(
ææ' (
ErrorMessages
ææ( 5
.
ææ5 6 
EmailAlreadyExists
ææ6 H
)
ææH I
;
ææI J
}
øø 	
}
¿¿ 
private
¬¬ 
PagedResultDto
¬¬ 
<
¬¬ 
TDestination
¬¬ '
>
¬¬' (
MapPagedResult
¬¬) 7
<
¬¬7 8
TSource
¬¬8 ?
,
¬¬? @
TDestination
¬¬A M
>
¬¬M N
(
¬¬N O
PagedResult
¬¬O Z
<
¬¬Z [
TSource
¬¬[ b
>
¬¬b c
pagedResult
¬¬d o
)
¬¬o p
{
√√ 
return
ƒƒ 
new
ƒƒ 
PagedResultDto
ƒƒ !
<
ƒƒ! "
TDestination
ƒƒ" .
>
ƒƒ. /
{
≈≈ 	
Items
∆∆ 
=
∆∆ 
mapper
∆∆ 
.
∆∆ 
Map
∆∆ 
<
∆∆ 
List
∆∆ #
<
∆∆# $
TDestination
∆∆$ 0
>
∆∆0 1
>
∆∆1 2
(
∆∆2 3
pagedResult
∆∆3 >
.
∆∆> ?
Items
∆∆? D
)
∆∆D E
,
∆∆E F

PageNumber
«« 
=
«« 
pagedResult
«« $
.
««$ %

PageNumber
««% /
,
««/ 0
PageSize
»» 
=
»» 
pagedResult
»» "
.
»»" #
PageSize
»»# +
,
»»+ ,

TotalCount
…… 
=
…… 
pagedResult
…… $
.
……$ %

TotalCount
……% /
,
……/ 0

TotalPages
   
=
   
pagedResult
   $
.
  $ %

TotalPages
  % /
}
ÀÀ 	
;
ÀÀ	 

}
ÃÃ 
}ÕÕ ü
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
},, À
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
} ˙	
bC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IDoctorAvailabilityCacheService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
;! "
public 
	interface +
IDoctorAvailabilityCacheService 0
{ 
Task 
< 	#
DoctorAvailableSlotsDto	  
?  !
>! "
GetDoctorSlotsAsync# 6
(6 7
int7 :
doctorId; C
,C D
DateOnlyE M
dateN R
)R S
;S T
Task		 
SetDoctorSlotsAsync			 
(		 
int		  
doctorId		! )
,		) *
DateOnly		+ 3
date		4 8
,		8 9#
DoctorAvailableSlotsDto		: Q
slots		R W
)		W X
;		X Y
Task "
RemoveDoctorSlotsAsync	 
(  
int  #
doctorId$ ,
,, -
DateOnly. 6
date7 ;
); <
;< =
Task .
"RemoveDoctorAvailabilityRangeAsync	 +
(+ ,
int, /
doctorId0 8
,8 9
int: =
monthsAhead> I
)I J
;J K
} ¯

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
RegisterDto 
request 
) 
; 
Task

 
<

 	
(

	 

bool


 
Success

 
,

 
string

 
Message

 &
,

& '
AuthResponseDto

( 7
?

7 8
Response

9 A
)

A B
>

B C

LoginAsync

D N
(

N O
LoginDto 
request 
) 
; 
Task 
< 	
(	 

bool
 
Success 
, 
string 
Message &
,& '
AuthResponseDto( 7
?7 8
Response9 A
)A B
>B C,
 CreateAuthResponseForUserIdAsync (
(( )
string) /
userId0 6
)6 7
;7 8
} ≤
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
PaginationQueryDto	s Ö

pagination
Ü ê
)
ê ë
;
ë í
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
PaginationQueryDto	q É

pagination
Ñ é
)
é è
;
è ê
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

pagination	 â
)
â ä
;
ä ã
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
}"" Ô
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
Ä ä
)
ä ã
;
ã å
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
PaginationQueryDto	!!o Å

pagination
!!Ç å
)
!!å ç
;
!!ç é
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
})) œ
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
} »	
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
} Ì
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
} Æ	
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
} ≤
^C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\INotificationRepository.cs
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
INotificationRepository (
:) *
IRepository+ 6
<6 7
Notification7 C
>C D
{ 
Task 
< 	
List	 
< 
Notification 
> 
> +
GetUnreadByRecipientUserIdAsync <
(< =
string= C
recipientUserIdD S
)S T
;T U
} æ+
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
}EE „'
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
}11 
bC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\Impl\NotificationRepository.cs
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
NotificationRepository #
(# $
HealthAxisDbContext$ 7
context8 ?
)? @
: 

Repository 
< 
Notification 
> 
( 
context &
)& '
,' (#
INotificationRepository) @
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
 
List

 
<

 
Notification

 '
>

' (
>

( )+
GetUnreadByRecipientUserIdAsync

* I
(

I J
string

J P
recipientUserId

Q `
)

` a
{ 
return 
await 
_context 
. 
Notifications +
. 
Where 
( 
notification 
=>  "
notification 
. 
RecipientUserId ,
==- /
recipientUserId0 ?
&&@ B
! 
notification 
. 
IsRead $
)$ %
. 
OrderByDescending 
( 
notification +
=>, .
notification/ ;
.; <
CreatedAtUtc< H
)H I
. 
ToListAsync 
( 
) 
; 
} 
} É:
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
}KK ∑{
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
ÄÄ 
<
ÄÄ 
Doctor
ÄÄ 
>
ÄÄ 
query
ÄÄ 
,
ÄÄ 
DoctorSortBy
ÅÅ 
sortBy
ÅÅ 
,
ÅÅ 
SortDirection
ÇÇ 
sortDirection
ÇÇ 
)
ÇÇ  
{
ÉÉ 
var
ÑÑ 

descending
ÑÑ 
=
ÑÑ 
sortDirection
ÑÑ &
==
ÑÑ' )
SortDirection
ÑÑ* 7
.
ÑÑ7 8
Desc
ÑÑ8 <
;
ÑÑ< =
return
ÜÜ 
sortBy
ÜÜ 
switch
ÜÜ 
{
áá 	
DoctorSortBy
àà 
.
àà 
Fee
àà 
=>
àà 

descending
àà  *
?
ââ 
query
ââ 
.
ââ 
OrderByDescending
ââ )
(
ââ) *
doctor
ââ* 0
=>
ââ1 3
doctor
ââ4 :
.
ââ: ;
ConsultationFee
ââ; J
)
ââJ K
.
ââK L
ThenBy
ââL R
(
ââR S
doctor
ââS Y
=>
ââZ \
doctor
ââ] c
.
ââc d
FullName
ââd l
)
ââl m
:
ää 
query
ää 
.
ää 
OrderBy
ää 
(
ää  
doctor
ää  &
=>
ää' )
doctor
ää* 0
.
ää0 1
ConsultationFee
ää1 @
)
ää@ A
.
ääA B
ThenBy
ääB H
(
ääH I
doctor
ääI O
=>
ääP R
doctor
ääS Y
.
ääY Z
FullName
ääZ b
)
ääb c
,
ääc d
DoctorSortBy
åå 
.
åå 

Experience
åå #
=>
åå$ &

descending
åå' 1
?
çç 
query
çç 
.
çç 
OrderBy
çç 
(
çç  
doctor
çç  &
=>
çç' )
doctor
çç* 0
.
çç0 1
PracticeStartDate
çç1 B
)
ççB C
.
ççC D
ThenBy
ççD J
(
ççJ K
doctor
ççK Q
=>
ççR T
doctor
ççU [
.
çç[ \
FullName
çç\ d
)
ççd e
:
éé 
query
éé 
.
éé 
OrderByDescending
éé )
(
éé) *
doctor
éé* 0
=>
éé1 3
doctor
éé4 :
.
éé: ;
PracticeStartDate
éé; L
)
ééL M
.
ééM N
ThenBy
ééN T
(
ééT U
doctor
ééU [
=>
éé\ ^
doctor
éé_ e
.
éée f
FullName
ééf n
)
één o
,
ééo p
_
êê 
=>
êê 

descending
êê 
?
ëë 
query
ëë 
.
ëë 
OrderByDescending
ëë )
(
ëë) *
doctor
ëë* 0
=>
ëë1 3
doctor
ëë4 :
.
ëë: ;
FullName
ëë; C
)
ëëC D
.
ëëD E
ThenBy
ëëE K
(
ëëK L
doctor
ëëL R
=>
ëëS U
doctor
ëëV \
.
ëë\ ]
Id
ëë] _
)
ëë_ `
:
íí 
query
íí 
.
íí 
OrderBy
íí 
(
íí  
doctor
íí  &
=>
íí' )
doctor
íí* 0
.
íí0 1
FullName
íí1 9
)
íí9 :
.
íí: ;
ThenBy
íí; A
(
ííA B
doctor
ííB H
=>
ííI K
doctor
ííL R
.
ííR S
Id
ííS U
)
ííU V
}
ìì 	
;
ìì	 

}
îî 
}ïï ™ø
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
:

 

Repository

 
<

 
Appointment

 
>

 
(

 
context

 %
)

% &
,

& '"
IAppointmentRepository

( >
{ 
public 

async 
Task 
< 
PagedResult !
<! "
Appointment" -
>- .
>. /#
GetAllAppointmentsAsync0 G
(G H
intH K

pageNumberL V
,V W
intX [
pageSize\ d
)d e
{ 
var 
query 
= &
GetAppointmentsWithDetails .
(. /
)/ 0
. 
OrderBy 
( 
appointment  
=>! #
appointment$ /
./ 0
AppointmentDate0 ?
)? @
. 
ThenBy 
( 
appointment 
=>  "
appointment# .
.. /
AppointmentTime/ >
)> ?
. 
ThenBy 
( 
appointment 
=>  "
appointment# .
.. /
Id/ 1
)1 2
;2 3
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
)X Y
=>Z \
await &
GetAppointmentsWithDetails (
(( )
)) *
.* +
FirstOrDefaultAsync+ >
(> ?
appointment? J
=>K M
appointmentN Y
.Y Z
IdZ \
==] _
appointmentId` m
)m n
;n o
public 

async 
Task 
< 
PagedResult !
<! "
Appointment" -
>- .
>. /+
GetAppointmentsByPatientIdAsync0 O
(O P
intP S
	patientIdT ]
,] ^
AppointmentStatus_ p
?p q
statusr x
,x y
intz }

pageNumber	~ à
,
à â
int
ä ç
pageSize
é ñ
)
ñ ó
{ 
var 
query 
= &
GetAppointmentsWithDetails .
(. /
)/ 0
.0 1
Where1 6
(6 7
appointment7 B
=>C E
appointmentF Q
.Q R
	PatientIdR [
==\ ^
	patientId_ h
)h i
;i j
if 

( 
status 
. 
HasValue 
) 
query "
=# $
query% *
.* +
Where+ 0
(0 1
appointment1 <
=>= ?
appointment@ K
.K L
StatusL R
==S U
statusV \
.\ ]
Value] b
)b c
;c d
query 
= 
query 
. 
OrderBy 
( 
appointment )
=>* ,
appointment- 8
.8 9
AppointmentDate9 H
)H I
.I J
ThenByJ P
(P Q
appointmentQ \
=>] _
appointment` k
.k l
AppointmentTimel {
){ |
.| }
ThenBy	} É
(
É Ñ
appointment
Ñ è
=>
ê í
appointment
ì û
.
û ü
Id
ü °
)
° ¢
;
¢ £
return 
await 
ToPagedResultAsync '
(' (
query( -
,- .

pageNumber/ 9
,9 :
pageSize; C
)C D
;D E
} 
public   

async   
Task   
<   
PagedResult   !
<  ! "
Appointment  " -
>  - .
>  . /*
GetAppointmentsByDoctorIdAsync  0 N
(  N O
int  O R
doctorId  S [
,  [ \
AppointmentStatus  ] n
?  n o
status  p v
,  v w
int  x {

pageNumber	  | Ü
,
  Ü á
int
  à ã
pageSize
  å î
)
  î ï
{!! 
var"" 
query"" 
="" &
GetAppointmentsWithDetails"" .
("". /
)""/ 0
.""0 1
Where""1 6
(""6 7
appointment""7 B
=>""C E
appointment""F Q
.""Q R
DoctorId""R Z
==""[ ]
doctorId""^ f
)""f g
;""g h
if## 

(## 
status## 
.## 
HasValue## 
)## 
query## "
=### $
query##% *
.##* +
Where##+ 0
(##0 1
appointment##1 <
=>##= ?
appointment##@ K
.##K L
Status##L R
==##S U
status##V \
.##\ ]
Value##] b
)##b c
;##c d
query$$ 
=$$ 
query$$ 
.$$ 
OrderBy$$ 
($$ 
appointment$$ )
=>$$* ,
appointment$$- 8
.$$8 9
AppointmentDate$$9 H
)$$H I
.$$I J
ThenBy$$J P
($$P Q
appointment$$Q \
=>$$] _
appointment$$` k
.$$k l
AppointmentTime$$l {
)$${ |
.$$| }
ThenBy	$$} É
(
$$É Ñ
appointment
$$Ñ è
=>
$$ê í
appointment
$$ì û
.
$$û ü
Id
$$ü °
)
$$° ¢
;
$$¢ £
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
<(( 
PagedResult(( !
<((! "
Appointment((" -
>((- .
>((. /1
%GetAppointmentsByDoctorIdAndDateAsync((0 U
(((U V
int((V Y
doctorId((Z b
,((b c
DateOnly((d l
date((m q
,((q r
int((s v

pageNumber	((w Å
,
((Å Ç
int
((É Ü
pageSize
((á è
)
((è ê
{)) 
var** 
query** 
=** &
GetAppointmentsWithDetails** .
(**. /
)**/ 0
.++ 
Where++ 
(++ 
appointment++ 
=>++ !
appointment++" -
.++- .
DoctorId++. 6
==++7 9
doctorId++: B
&&++C E
appointment++F Q
.++Q R
AppointmentDate++R a
==++b d
date++e i
)++i j
.,, 
OrderBy,, 
(,, 
appointment,,  
=>,,! #
appointment,,$ /
.,,/ 0
AppointmentTime,,0 ?
),,? @
.-- 
ThenBy-- 
(-- 
appointment-- 
=>--  "
appointment--# .
.--. /
Id--/ 1
)--1 2
;--2 3
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
>11. //
#GetAppointmentsByDateAndStatusAsync110 S
(11S T
DateOnly11T \
date11] a
,11a b
AppointmentStatus11c t
?11t u
status11v |
,11| }
int	11~ Å

pageNumber
11Ç å
,
11å ç
int
11é ë
pageSize
11í ö
)
11ö õ
{22 
var33 
query33 
=33 &
GetAppointmentsWithDetails33 .
(33. /
)33/ 0
.330 1
Where331 6
(336 7
appointment337 B
=>33C E
appointment33F Q
.33Q R
AppointmentDate33R a
==33b d
date33e i
)33i j
;33j k
if44 

(44 
status44 
.44 
HasValue44 
)44 
query44 "
=44# $
query44% *
.44* +
Where44+ 0
(440 1
appointment441 <
=>44= ?
appointment44@ K
.44K L
Status44L R
==44S U
status44V \
.44\ ]
Value44] b
)44b c
;44c d
query55 
=55 
query55 
.55 
OrderBy55 
(55 
appointment55 )
=>55* ,
appointment55- 8
.558 9
AppointmentTime559 H
)55H I
.55I J
ThenBy55J P
(55P Q
appointment55Q \
=>55] _
appointment55` k
.55k l
Id55l n
)55n o
;55o p
return66 
await66 
ToPagedResultAsync66 '
(66' (
query66( -
,66- .

pageNumber66/ 9
,669 :
pageSize66; C
)66C D
;66D E
}77 
public99 

async99 
Task99 
<99 
List99 
<99 
Appointment99 &
>99& '
>99' (.
"GetExpiredPendingAppointmentsAsync99) K
(99K L
DateTime99L T
cutoffDateTime99U c
)99c d
{:: 
var;; 

cutoffDate;; 
=;; 
DateOnly;; !
.;;! "
FromDateTime;;" .
(;;. /
cutoffDateTime;;/ =
);;= >
;;;> ?
var<< 

cutoffTime<< 
=<< 
TimeOnly<< !
.<<! "
FromDateTime<<" .
(<<. /
cutoffDateTime<</ =
)<<= >
;<<> ?
return== 
await== 
_context== 
.== 
Appointments== *
.>> 
Where>> 
(>> 
appointment>> 
=>>> !
appointment>>" -
.>>- .
Status>>. 4
==>>5 7
AppointmentStatus>>8 I
.>>I J
Pending>>J Q
&&>>R T
(?? 
appointment?? 
.?? 
AppointmentDate?? ,
<??- .

cutoffDate??/ 9
||??: <
appointment@@ 
.@@ 
AppointmentDate@@ ,
==@@- /

cutoffDate@@0 :
&&@@; =
appointment@@> I
.@@I J
AppointmentTime@@J Y
<=@@Z \

cutoffTime@@] g
)@@g h
)@@h i
.AA 
ToListAsyncAA 
(AA 
)AA 
;AA 
}BB 
publicDD 

asyncDD 
TaskDD 
<DD 
ListDD 
<DD 
AppointmentDD &
>DD& '
>DD' (0
$GetExpiredConfirmedAppointmentsAsyncDD) M
(DDM N
DateOnlyDDN V

beforeDateDDW a
)DDa b
=>DDc e
awaitEE 
_contextEE 
.EE 
AppointmentsEE #
.FF 
WhereFF 
(FF 
appointmentFF 
=>FF !
appointmentFF" -
.FF- .
StatusFF. 4
==FF5 7
AppointmentStatusFF8 I
.FFI J
	ConfirmedFFJ S
&&FFT V
appointmentFFW b
.FFb c
AppointmentDateFFc r
<FFs t

beforeDateFFu 
)	FF Ä
.GG 
ToListAsyncGG 
(GG 
)GG 
;GG 
publicII 

asyncII 
TaskII 
UpdateRangeAsyncII &
(II& '
IEnumerableII' 2
<II2 3
AppointmentII3 >
>II> ?
appointmentsII@ L
)IIL M
{JJ 
_contextKK 
.KK 
AppointmentsKK 
.KK 
UpdateRangeKK )
(KK) *
appointmentsKK* 6
)KK6 7
;KK7 8
awaitLL 
_contextLL 
.LL 
SaveChangesAsyncLL '
(LL' (
)LL( )
;LL) *
}MM 
publicOO 

asyncOO 
TaskOO 
<OO 
ListOO 
<OO  
AppointmentReportDtoOO /
>OO/ 0
>OO0 1&
GetAppointmentReportsAsyncOO2 L
(OOL M
)OOM N
=>OOO Q
awaitPP 
_contextPP 
.PP 
AppointmentsPP #
.QQ 
GroupByQQ 
(QQ 
appointmentQQ  
=>QQ! #
appointmentQQ$ /
.QQ/ 0
AppointmentDateQQ0 ?
)QQ? @
.RR 
SelectRR 
(RR 
groupRR 
=>RR 
newRR   
AppointmentReportDtoRR! 5
{SS 
DateTT 
=TT 
groupTT 
.TT 
KeyTT  
,TT  !
ConfirmedCountUU 
=UU  
groupUU! &
.UU& '
CountUU' ,
(UU, -
appointmentUU- 8
=>UU9 ;
appointmentUU< G
.UUG H
StatusUUH N
==UUO Q
AppointmentStatusUUR c
.UUc d
	ConfirmedUUd m
)UUm n
,UUn o
CancelledCountVV 
=VV  
groupVV! &
.VV& '
CountVV' ,
(VV, -
appointmentVV- 8
=>VV9 ;
appointmentVV< G
.VVG H
StatusVVH N
==VVO Q
AppointmentStatusVVR c
.VVc d
	CancelledVVd m
)VVm n
,VVn o
CompletedCountWW 
=WW  
groupWW! &
.WW& '
CountWW' ,
(WW, -
appointmentWW- 8
=>WW9 ;
appointmentWW< G
.WWG H
StatusWWH N
==WWO Q
AppointmentStatusWWR c
.WWc d
	CompletedWWd m
)WWm n
,WWn o
PendingCountXX 
=XX 
groupXX $
.XX$ %
CountXX% *
(XX* +
appointmentXX+ 6
=>XX7 9
appointmentXX: E
.XXE F
StatusXXF L
==XXM O
AppointmentStatusXXP a
.XXa b
PendingXXb i
)XXi j
,XXj k

TotalCountYY 
=YY 
groupYY "
.YY" #
CountYY# (
(YY( )
)YY) *
}ZZ 
)ZZ 
.[[ 
OrderByDescending[[ 
([[ 
report[[ %
=>[[& (
report[[) /
.[[/ 0
Date[[0 4
)[[4 5
.\\ 
ToListAsync\\ 
(\\ 
)\\ 
;\\ 
public^^ 

async^^ 
Task^^ 
<^^ 
bool^^ 
>^^ 3
'DoctorHasNonCancelledAppointmentAtAsync^^ C
(^^C D
int^^D G
doctorId^^H P
,^^P Q
DateOnly^^R Z
date^^[ _
,^^_ `
TimeOnly^^a i
time^^j n
)^^n o
=>^^p r
await__ 
_context__ 
.__ 
Appointments__ #
.__# $
AnyAsync__$ ,
(__, -
appointment__- 8
=>__9 ;
appointment__< G
.__G H
DoctorId__H P
==__Q S
doctorId__T \
&&__] _
appointment__` k
.__k l
AppointmentDate__l {
==__| ~
date	__ É
&&
__Ñ Ü
appointment
__á í
.
__í ì
AppointmentTime
__ì ¢
==
__£ •
time
__¶ ™
&&
__´ ≠
appointment
__Æ π
.
__π ∫
Status
__∫ ¿
!=
__¡ √
AppointmentStatus
__ƒ ’
.
__’ ÷
	Cancelled
__÷ ﬂ
)
__ﬂ ‡
;
__‡ ·
publicaa 

asyncaa 
Taskaa 
<aa 
Listaa 
<aa 
Appointmentaa &
>aa& '
>aa' (=
1GetNonCancelledAppointmentsByDoctorIdAndDateAsyncaa) Z
(aaZ [
intaa[ ^
doctorIdaa_ g
,aag h
DateOnlyaai q
dateaar v
)aav w
=>aax z
awaitbb 
_contextbb 
.bb 
Appointmentsbb #
.bb# $
Wherebb$ )
(bb) *
appointmentbb* 5
=>bb6 8
appointmentbb9 D
.bbD E
DoctorIdbbE M
==bbN P
doctorIdbbQ Y
&&bbZ \
appointmentbb] h
.bbh i
AppointmentDatebbi x
==bby {
date	bb| Ä
&&
bbÅ É
appointment
bbÑ è
.
bbè ê
Status
bbê ñ
!=
bbó ô
AppointmentStatus
bbö ´
.
bb´ ¨
	Cancelled
bb¨ µ
)
bbµ ∂
.
bb∂ ∑
ToListAsync
bb∑ ¬
(
bb¬ √
)
bb√ ƒ
;
bbƒ ≈
publicdd 

asyncdd 
Taskdd 
<dd 
Listdd 
<dd 
Appointmentdd &
>dd& '
>dd' (2
&GetNonCancelledAppointmentsByDateAsyncdd) O
(ddO P
DateOnlyddP X
dateddY ]
)dd] ^
=>dd_ a
awaitee 
_contextee 
.ee 
Appointmentsee #
.ee# $
AsNoTrackingee$ 0
(ee0 1
)ee1 2
.ee2 3
Whereee3 8
(ee8 9
appointmentee9 D
=>eeE G
appointmenteeH S
.eeS T
AppointmentDateeeT c
==eed f
dateeeg k
&&eel n
appointmenteeo z
.eez {
Status	ee{ Å
!=
eeÇ Ñ
AppointmentStatus
eeÖ ñ
.
eeñ ó
	Cancelled
eeó †
)
ee† °
.
ee° ¢
ToListAsync
ee¢ ≠
(
ee≠ Æ
)
eeÆ Ø
;
eeØ ∞
publicgg 

asyncgg 
Taskgg 
<gg 
boolgg 
>gg 4
(PatientHasNonCancelledAppointmentAtAsyncgg D
(ggD E
intggE H
	patientIdggI R
,ggR S
DateOnlyggT \
dategg] a
,gga b
TimeOnlyggc k
timeggl p
)ggp q
=>ggr t
awaithh 
_contexthh 
.hh 
Appointmentshh #
.hh# $
AnyAsynchh$ ,
(hh, -
appointmenthh- 8
=>hh9 ;
appointmenthh< G
.hhG H
	PatientIdhhH Q
==hhR T
	patientIdhhU ^
&&hh_ a
appointmenthhb m
.hhm n
AppointmentDatehhn }
==	hh~ Ä
date
hhÅ Ö
&&
hhÜ à
appointment
hhâ î
.
hhî ï
AppointmentTime
hhï §
==
hh• ß
time
hh® ¨
&&
hh≠ Ø
appointment
hh∞ ª
.
hhª º
Status
hhº ¬
!=
hh√ ≈
AppointmentStatus
hh∆ ◊
.
hh◊ ÿ
	Cancelled
hhÿ ·
)
hh· ‚
;
hh‚ „
publicjj 

asyncjj 
Taskjj 
<jj 
booljj 
>jj B
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsyncjj R
(jjR S
intjjS V
	patientIdjjW `
,jj` a
intjjb e
doctorIdjjf n
,jjn o
DateOnlyjjp x
datejjy }
)jj} ~
=>	jj Å
awaitkk 
_contextkk 
.kk 
Appointmentskk #
.kk# $
AnyAsynckk$ ,
(kk, -
appointmentkk- 8
=>kk9 ;
appointmentkk< G
.kkG H
	PatientIdkkH Q
==kkR T
	patientIdkkU ^
&&kk_ a
appointmentkkb m
.kkm n
DoctorIdkkn v
==kkw y
doctorId	kkz Ç
&&
kkÉ Ö
appointment
kkÜ ë
.
kkë í
AppointmentDate
kkí °
==
kk¢ §
date
kk• ©
&&
kk™ ¨
appointment
kk≠ ∏
.
kk∏ π
Status
kkπ ø
!=
kk¿ ¬
AppointmentStatus
kk√ ‘
.
kk‘ ’
	Cancelled
kk’ ﬁ
)
kkﬁ ﬂ
;
kkﬂ ‡
publicmm 

asyncmm 
Taskmm 
<mm 
boolmm 
>mm 5
)DoctorHasConfirmedAppointmentsOnDateAsyncmm E
(mmE F
intmmF I
doctorIdmmJ R
,mmR S
DateOnlymmT \
datemm] a
)mma b
=>mmc e
awaitnn 
_contextnn 
.nn 
Appointmentsnn #
.nn# $
AnyAsyncnn$ ,
(nn, -
appointmentnn- 8
=>nn9 ;
appointmentnn< G
.nnG H
DoctorIdnnH P
==nnQ S
doctorIdnnT \
&&nn] _
appointmentnn` k
.nnk l
AppointmentDatennl {
==nn| ~
date	nn É
&&
nnÑ Ü
appointment
nná í
.
nní ì
Status
nnì ô
==
nnö ú
AppointmentStatus
nnù Æ
.
nnÆ Ø
	Confirmed
nnØ ∏
)
nn∏ π
;
nnπ ∫
publicpp 

asyncpp 
Taskpp 
<pp 
Listpp 
<pp 
Appointmentpp &
>pp& '
>pp' (C
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsyncpp) `
(pp` a
intppa d
doctorIdppe m
,ppm n
DateOnlyppo w
dateppx |
)pp| }
=>	pp~ Ä
awaitqq 
_contextqq 
.qq 
Appointmentsqq #
.qq# $
Whereqq$ )
(qq) *
appointmentqq* 5
=>qq6 8
appointmentqq9 D
.qqD E
DoctorIdqqE M
==qqN P
doctorIdqqQ Y
&&qqZ \
appointmentqq] h
.qqh i
AppointmentDateqqi x
==qqy {
date	qq| Ä
&&
qqÅ É
(
qqÑ Ö
appointment
qqÖ ê
.
qqê ë
Status
qqë ó
==
qqò ö
AppointmentStatus
qqõ ¨
.
qq¨ ≠
Pending
qq≠ ¥
||
qqµ ∑
appointment
qq∏ √
.
qq√ ƒ
Status
qqƒ  
==
qqÀ Õ
AppointmentStatus
qqŒ ﬂ
.
qqﬂ ‡
	Confirmed
qq‡ È
)
qqÈ Í
)
qqÍ Î
.
qqÎ Ï
ToListAsync
qqÏ ˜
(
qq˜ ¯
)
qq¯ ˘
;
qq˘ ˙
publicss 

asyncss 
Taskss 
<ss 
boolss 
>ss 9
-DoctorHasConfirmedAppointmentWithPatientAsyncss I
(ssI J
intssJ M
doctorIdssN V
,ssV W
intssX [
	patientIdss\ e
)sse f
=>ssg i
awaittt 
_contexttt 
.tt 
Appointmentstt #
.tt# $
AnyAsynctt$ ,
(tt, -
appointmenttt- 8
=>tt9 ;
appointmenttt< G
.ttG H
DoctorIdttH P
==ttQ S
doctorIdttT \
&&tt] _
appointmenttt` k
.ttk l
	PatientIdttl u
==ttv x
	patientId	tty Ç
&&
ttÉ Ö
appointment
ttÜ ë
.
ttë í
Status
ttí ò
==
ttô õ
AppointmentStatus
ttú ≠
.
tt≠ Æ
	Confirmed
ttÆ ∑
)
tt∑ ∏
;
tt∏ π
privatevv 

IQueryablevv 
<vv 
Appointmentvv "
>vv" #&
GetAppointmentsWithDetailsvv$ >
(vv> ?
)vv? @
=>vvA C
_contextww 
.ww 
Appointmentsww 
.xx 
Includexx 
(xx 
appointmentxx  
=>xx! #
appointmentxx$ /
.xx/ 0
Patientxx0 7
)xx7 8
.yy 
Includeyy 
(yy 
appointmentyy  
=>yy! #
appointmentyy$ /
.yy/ 0
Doctoryy0 6
)yy6 7
.zz 
Includezz 
(zz 
appointmentzz  
=>zz! #
appointmentzz$ /
.zz/ 0
HealthRecordzz0 <
)zz< =
;zz= >
}{{ ˝
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
} ‰
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
}   …/
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
Task

 
<

 	
Appointment

	 
?

 
>

 .
"GetAppointmentByIdWithDetailsAsync

 9
(

9 :
int

: =
appointmentId

> K
)

K L
;

L M
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "+
GetAppointmentsByPatientIdAsync# B
(B C
intC F
	patientIdG P
,P Q
AppointmentStatusR c
?c d
statuse k
,k l
intm p

pageNumberq {
,{ |
int	} Ä
pageSize
Å â
)
â ä
;
ä ã
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "*
GetAppointmentsByDoctorIdAsync# A
(A B
intB E
doctorIdF N
,N O
AppointmentStatusP a
?a b
statusc i
,i j
intk n

pageNumbero y
,y z
int{ ~
pageSize	 á
)
á à
;
à â
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "1
%GetAppointmentsByDoctorIdAndDateAsync# H
(H I
intI L
doctorIdM U
,U V
DateOnlyW _
date` d
,d e
intf i

pageNumberj t
,t u
intv y
pageSize	z Ç
)
Ç É
;
É Ñ
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "/
#GetAppointmentsByDateAndStatusAsync# F
(F G
DateOnlyG O
dateP T
,T U
AppointmentStatusV g
?g h
statusi o
,o p
intq t

pageNumberu 
,	 Ä
int
Å Ñ
pageSize
Ö ç
)
ç é
;
é è
Task 
< 	
List	 
< 
Appointment 
> 
> .
"GetExpiredPendingAppointmentsAsync >
(> ?
DateTime? G
cutoffDateTimeH V
)V W
;W X
Task 
< 	
List	 
< 
Appointment 
> 
> 0
$GetExpiredConfirmedAppointmentsAsync @
(@ A
DateOnlyA I

beforeDateJ T
)T U
;U V
Task 
UpdateRangeAsync	 
( 
IEnumerable %
<% &
Appointment& 1
>1 2
appointments3 ?
)? @
;@ A
Task 
< 	
List	 
<  
AppointmentReportDto "
>" #
># $&
GetAppointmentReportsAsync% ?
(? @
)@ A
;A B
Task 
< 	
bool	 
> 3
'DoctorHasNonCancelledAppointmentAtAsync 6
(6 7
int7 :
doctorId; C
,C D
DateOnlyE M
dateN R
,R S
TimeOnlyT \
time] a
)a b
;b c
Task 
< 	
List	 
< 
Appointment 
> 
> =
1GetNonCancelledAppointmentsByDoctorIdAndDateAsync M
(M N
intN Q
doctorIdR Z
,Z [
DateOnly\ d
datee i
)i j
;j k
Task 
< 	
List	 
< 
Appointment 
> 
> 2
&GetNonCancelledAppointmentsByDateAsync B
(B C
DateOnlyC K
dateL P
)P Q
;Q R
Task 
< 	
bool	 
> 4
(PatientHasNonCancelledAppointmentAtAsync 7
(7 8
int8 ;
	patientId< E
,E F
DateOnlyG O
dateP T
,T U
TimeOnlyV ^
time_ c
)c d
;d e
Task 
< 	
bool	 
> B
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsync E
(E F
intF I
	patientIdJ S
,S T
intU X
doctorIdY a
,a b
DateOnlyc k
datel p
)p q
;q r
Task 
< 	
bool	 
> 5
)DoctorHasConfirmedAppointmentsOnDateAsync 8
(8 9
int9 <
doctorId= E
,E F
DateOnlyG O
dateP T
)T U
;U V
Task 
< 	
List	 
< 
Appointment 
> 
> C
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync S
(S T
intT W
doctorIdX `
,` a
DateOnlyb j
datek o
)o p
;p q
Task 
< 	
bool	 
> 9
-DoctorHasConfirmedAppointmentWithPatientAsync <
(< =
int= @
doctorIdA I
,I J
intK N
	patientIdO X
)X Y
;Y Z
} ˘≤
AC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Program.cs
Log 
. 
Logger 

= 
new 
LoggerConfiguration $
($ %
)% &
. 
MinimumLevel 
. 
Information 
( 
) 
. 
Enrich 
. 
FromLogContext 
( 
) 
. 
WriteTo 
. 
Console 
( 
) 
. !
CreateBootstrapLogger 
( 
) 
; 
try 
{ 
var 
builder 
= 
WebApplication  
.  !
CreateBuilder! .
(. /
args/ 3
)3 4
;4 5
const 	
string
 %
HealthAxisAdminCorsPolicy *
=+ ,
$str- H
;H I
var   
appName   
=   
builder   
.   
Configuration   '
[  ' (
$str  ( =
]  = >
??  ? A
$str  B R
;  R S
builder"" 
."" 
Host"" 
."" 

UseSerilog"" 
("" 
("" 
context"" $
,""$ %
services""& .
,"". /
configuration""0 =
)""= >
=>""? A
configuration""B O
.## 	
ReadFrom##	 
.## 
Configuration## 
(##  
context##  '
.##' (
Configuration##( 5
)##5 6
.$$ 	
ReadFrom$$	 
.$$ 
Services$$ 
($$ 
services$$ #
)$$# $
.%% 	
Enrich%%	 
.%% 
FromLogContext%% 
(%% 
)%%  
.&& 	
Enrich&&	 
.&& 
WithProperty&& 
(&& 
$str&& *
,&&* +
appName&&, 3
)&&3 4
)&&4 5
;&&5 6
builder(( 
.(( 
Services(( 
.(( 
AddCors(( 
((( 
options(( $
=>((% '
options((( /
.((/ 0
	AddPolicy((0 9
(((9 :%
HealthAxisAdminCorsPolicy)) !
,))! "
policy** 
=>** 
policy** 
.++ 
WithOrigins++ 
(++ 
$str,, (
,,,( )
$str-- '
,--' (
$str.. '
,..' (
$str// (
)//( )
.00 
AllowAnyHeader00 
(00 
)00 
.11 
AllowAnyMethod11 
(11 
)11 
)11 
)11 
;11  
builder33 
.33 
Services33 
.33 
AddControllers33 #
(33# $
)33$ %
.44 	
AddJsonOptions44	 
(44 
options44 
=>44  "
options55 
.55 !
JsonSerializerOptions55 )
.55) * 
PropertyNamingPolicy55* >
=55? @
JsonNamingPolicy66  
.66  !
	CamelCase66! *
)66* +
;66+ ,
builder88 
.88 
Services88 
.88 #
AddEndpointsApiExplorer88 ,
(88, -
)88- .
;88. /
builder99 
.99 
Services99 
.99 
AddSwaggerGen99 "
(99" #
options99# *
=>99+ -
{:: 
options;; 
.;; 

SwaggerDoc;; 
(;; 
$str;; 
,;;  
new;;! $
OpenApiInfo;;% 0
{<< 	
Title== 
=== 
$str== $
,==$ %
Version>> 
=>> 
$str>> 
}?? 	
)??	 

;??
 
optionsAA 
.AA !
AddSecurityDefinitionAA %
(AA% &
$strAA& .
,AA. /
newAA0 3!
OpenApiSecuritySchemeAA4 I
{BB 	
TypeCC 
=CC 
SecuritySchemeTypeCC %
.CC% &
HttpCC& *
,CC* +
SchemeDD 
=DD 
$strDD 
,DD 
BearerFormatEE 
=EE 
$strEE  
,EE  !
DescriptionFF 
=FF 
$strFF M
}GG 	
)GG	 

;GG
 
optionsII 
.II "
AddSecurityRequirementII &
(II& '
documentII' /
=>II0 2
newII3 6&
OpenApiSecurityRequirementII7 Q
{JJ 	
[KK 
newKK *
OpenApiSecuritySchemeReferenceKK /
(KK/ 0
$strKK0 8
,KK8 9
documentKK: B
)KKB C
]KKC D
=KKE F
[KKG H
]KKH I
}LL 	
)LL	 

;LL
 
}MM 
)MM 
;MM 
builderOO 
.OO 
ServicesOO 
.OO 
AddExceptionHandlerOO (
<OO( )"
GlobalExceptionHandlerOO) ?
>OO? @
(OO@ A
)OOA B
;OOB C
builderPP 
.PP 
ServicesPP 
.PP 
AddProblemDetailsPP &
(PP& '
)PP' (
;PP( )
builderRR 
.RR 
ServicesRR 
.RR 
AddDbContextRR !
<RR! "
HealthAxisDbContextRR" 5
>RR5 6
(RR6 7
optionsRR7 >
=>RR? A
optionsSS 
.SS 
UseSqlServerSS 
(SS 
builderTT 
.TT 
ConfigurationTT !
.TT! "
GetConnectionStringTT" 5
(TT5 6
$strTT6 D
)TTD E
)TTE F
)TTF G
;TTG H
builderVV 
.VV 
ServicesVV 
.VV 
AddIdentityVV  
<VV  !
IdentityUserVV! -
,VV- .
IdentityRoleVV/ ;
>VV; <
(VV< =
optionsVV= D
=>VVE G
{WW 
optionsXX 
.XX 
UserXX 
.XX 
RequireUniqueEmailXX '
=XX( )
trueXX* .
;XX. /
optionsYY 
.YY 
PasswordYY 
.YY 
RequireDigitYY %
=YY& '
trueYY( ,
;YY, -
optionsZZ 
.ZZ 
PasswordZZ 
.ZZ 
RequireUppercaseZZ )
=ZZ* +
trueZZ, 0
;ZZ0 1
options[[ 
.[[ 
Password[[ 
.[[ 
RequireLowercase[[ )
=[[* +
true[[, 0
;[[0 1
options\\ 
.\\ 
Password\\ 
.\\ "
RequireNonAlphanumeric\\ /
=\\0 1
true\\2 6
;\\6 7
options]] 
.]] 
Password]] 
.]] 
RequiredLength]] '
=]]( )
$num]]* +
;]]+ ,
}^^ 
)^^ 
.__ $
AddEntityFrameworkStores__ 
<__ 
HealthAxisDbContext__ 1
>__1 2
(__2 3
)__3 4
.`` $
AddDefaultTokenProviders`` 
(`` 
)`` 
;``  
varbb 
jwtSettingsbb 
=bb 
builderbb 
.bb 
Configurationbb +
.bb+ ,

GetSectionbb, 6
(bb6 7
$strbb7 <
)bb< =
;bb= >
builderdd 
.dd 
Servicesdd 
.dd 
AddAuthenticationdd &
(dd& '
optionsdd' .
=>dd/ 1
{ee 
optionsff 
.ff %
DefaultAuthenticateSchemeff )
=ff* +
JwtBearerDefaultsgg 
.gg  
AuthenticationSchemegg 2
;gg2 3
optionshh 
.hh "
DefaultChallengeSchemehh &
=hh' (
JwtBearerDefaultsii 
.ii  
AuthenticationSchemeii 2
;ii2 3
}jj 
)jj 
.kk 
AddJwtBearerkk 
(kk 
optionskk 
=>kk 
optionsll 
.ll %
TokenValidationParametersll )
=ll* +
newll, /%
TokenValidationParametersll0 I
{mm 	
ValidateIssuernn 
=nn 
truenn !
,nn! "
ValidIssueroo 
=oo 
jwtSettingsoo %
[oo% &
$stroo& .
]oo. /
,oo/ 0
ValidateAudiencepp 
=pp 
truepp #
,pp# $
ValidAudienceqq 
=qq 
jwtSettingsqq '
[qq' (
$strqq( 2
]qq2 3
,qq3 4
ValidateLifetimerr 
=rr 
truerr #
,rr# $$
ValidateIssuerSigningKeyss $
=ss% &
truess' +
,ss+ ,
IssuerSigningKeytt 
=tt 
newtt " 
SymmetricSecurityKeytt# 7
(tt7 8
Encodinguu 
.uu 
UTF8uu 
.uu 
GetBytesuu &
(uu& '
jwtSettingsuu' 2
[uu2 3
$struu3 8
]uu8 9
!uu9 :
)uu: ;
)uu; <
,uu< =
NameClaimTypevv 
=vv 

ClaimTypesvv &
.vv& '
Emailvv' ,
,vv, -
RoleClaimTypeww 
=ww 

ClaimTypesww &
.ww& '
Roleww' +
,ww+ ,
	ClockSkewxx 
=xx 
TimeSpanxx  
.xx  !
Zeroxx! %
}yy 	
)yy	 

;yy
 
builder{{ 
.{{ 
Services{{ 
.{{ 
AddAuthorization{{ %
({{% &
){{& '
;{{' (
builder}} 
.}} 
Services}} 
.}} 
	AddScoped}} 
<}} 
IDoctorRepository}} 0
,}}0 1
DoctorRepository}}2 B
>}}B C
(}}C D
)}}D E
;}}E F
builder~~ 
.~~ 
Services~~ 
.~~ 
	AddScoped~~ 
<~~ 
IPatientRepository~~ 1
,~~1 2
PatientRepository~~3 D
>~~D E
(~~E F
)~~F G
;~~G H
builder 
. 
Services 
. 
	AddScoped 
< "
IAppointmentRepository 5
,5 6!
AppointmentRepository7 L
>L M
(M N
)N O
;O P
builder
ÄÄ 
.
ÄÄ 
Services
ÄÄ 
.
ÄÄ 
	AddScoped
ÄÄ 
<
ÄÄ %
IHealthRecordRepository
ÄÄ 6
,
ÄÄ6 7$
HealthRecordRepository
ÄÄ8 N
>
ÄÄN O
(
ÄÄO P
)
ÄÄP Q
;
ÄÄQ R
builder
ÅÅ 
.
ÅÅ 
Services
ÅÅ 
.
ÅÅ 
	AddScoped
ÅÅ 
<
ÅÅ %
INotificationRepository
ÅÅ 6
,
ÅÅ6 7$
NotificationRepository
ÅÅ8 N
>
ÅÅN O
(
ÅÅO P
)
ÅÅP Q
;
ÅÅQ R
builder
ÉÉ 
.
ÉÉ 
Services
ÉÉ 
.
ÉÉ 
	AddScoped
ÉÉ 
<
ÉÉ 
IAuthService
ÉÉ +
,
ÉÉ+ ,
AuthService
ÉÉ- 8
>
ÉÉ8 9
(
ÉÉ9 :
)
ÉÉ: ;
;
ÉÉ; <
builder
ÑÑ 
.
ÑÑ 
Services
ÑÑ 
.
ÑÑ 
	AddScoped
ÑÑ 
<
ÑÑ 
IDoctorService
ÑÑ -
,
ÑÑ- .
DoctorService
ÑÑ/ <
>
ÑÑ< =
(
ÑÑ= >
)
ÑÑ> ?
;
ÑÑ? @
builder
ÖÖ 
.
ÖÖ 
Services
ÖÖ 
.
ÖÖ 
	AddScoped
ÖÖ 
<
ÖÖ 
IPatientService
ÖÖ .
,
ÖÖ. /
PatientService
ÖÖ0 >
>
ÖÖ> ?
(
ÖÖ? @
)
ÖÖ@ A
;
ÖÖA B
builder
ÜÜ 
.
ÜÜ 
Services
ÜÜ 
.
ÜÜ 
	AddScoped
ÜÜ 
<
ÜÜ !
IAppointmentService
ÜÜ 2
,
ÜÜ2 3 
AppointmentService
ÜÜ4 F
>
ÜÜF G
(
ÜÜG H
)
ÜÜH I
;
ÜÜI J
builder
áá 
.
áá 
Services
áá 
.
áá 
	AddScoped
áá 
<
áá "
IHealthRecordService
áá 3
,
áá3 4!
HealthRecordService
áá5 H
>
ááH I
(
ááI J
)
ááJ K
;
ááK L
builder
àà 
.
àà 
Services
àà 
.
àà 
	AddScoped
àà 
<
àà 
IAdminService
àà ,
,
àà, -
AdminService
àà. :
>
àà: ;
(
àà; <
)
àà< =
;
àà= >
builder
ââ 
.
ââ 
Services
ââ 
.
ââ 
	AddScoped
ââ 
<
ââ "
IAdminHandoffService
ââ 3
,
ââ3 4!
AdminHandoffService
ââ5 H
>
ââH I
(
ââI J
)
ââJ K
;
ââK L
builder
ää 
.
ää 
Services
ää 
.
ää 
	AddScoped
ää 
<
ää -
IDoctorAvailabilityCacheService
ää >
,
ää> ?,
DoctorAvailabilityCacheService
ãã &
>
ãã& '
(
ãã' (
)
ãã( )
;
ãã) *
builder
çç 
.
çç 
Services
çç 
.
çç 
AddMemoryCache
çç #
(
çç# $
)
çç$ %
;
çç% &
builder
èè 
.
èè 
Services
èè 
.
èè 
AddHostedService
èè %
<
èè% &
HeartbeatService
èè& 6
>
èè6 7
(
èè7 8
)
èè8 9
;
èè9 :
builder
êê 
.
êê 
Services
êê 
.
êê 
AddHostedService
êê %
<
êê% &(
NotificationCleanupService
êê& @
>
êê@ A
(
êêA B
)
êêB C
;
êêC D
builder
ëë 
.
ëë 
Services
ëë 
.
ëë 
AddHostedService
ëë %
<
ëë% &/
!PendingAppointmentDeadlineService
ëë& G
>
ëëG H
(
ëëH I
)
ëëI J
;
ëëJ K
builder
íí 
.
íí 
Services
íí 
.
íí 
AddHostedService
íí %
<
íí% &0
"ExpiredConfirmedAppointmentService
íí& H
>
ííH I
(
ííI J
)
ííJ K
;
ííK L
builder
îî 
.
îî 
Services
îî 
.
îî 
AddMassTransit
îî #
(
îî# $
options
îî$ +
=>
îî, .
{
ïï 
options
ññ 
.
ññ 
AddConsumer
ññ 
<
ññ '
AppointmentBookedConsumer
ññ 5
>
ññ5 6
(
ññ6 7
)
ññ7 8
;
ññ8 9
options
òò 
.
òò 
UsingRabbitMq
òò 
(
òò 
(
òò 
context
òò &
,
òò& '
configuration
òò( 5
)
òò5 6
=>
òò7 9
{
ôô 	
var
öö 
rabbit
öö 
=
öö 
builder
öö  
.
öö  !
Configuration
öö! .
.
öö. /

GetSection
öö/ 9
(
öö9 :
$str
öö: D
)
ööD E
;
ööE F
configuration
úú 
.
úú 
Host
úú 
(
úú 
rabbit
ùù 
[
ùù 
$str
ùù !
]
ùù! "
??
ùù# %
$str
ùù& 1
,
ùù1 2
rabbit
ûû 
[
ûû 
$str
ûû $
]
ûû$ %
??
ûû& (
$str
ûû) ,
,
ûû, -
host
üü 
=>
üü 
{
†† 
host
°° 
.
°° 
Username
°° !
(
°°! "
rabbit
°°" (
[
°°( )
$str
°°) 3
]
°°3 4
??
°°5 7
$str
°°8 ?
)
°°? @
;
°°@ A
host
¢¢ 
.
¢¢ 
Password
¢¢ !
(
¢¢! "
rabbit
¢¢" (
[
¢¢( )
$str
¢¢) 3
]
¢¢3 4
??
¢¢5 7
$str
¢¢8 ?
)
¢¢? @
;
¢¢@ A
}
££ 
)
££ 
;
££ 
configuration
•• 
.
•• 
ReceiveEndpoint
•• )
(
••) *
rabbit
¶¶ 
[
¶¶ 
$str
¶¶ /
]
¶¶/ 0
??
¶¶1 3
$str
ßß .
,
ßß. /
endpoint
®® 
=>
®® 
endpoint
®® $
.
®®$ %
ConfigureConsumer
®®% 6
<
®®6 7'
AppointmentBookedConsumer
®®7 P
>
®®P Q
(
®®Q R
context
©© 
)
©© 
)
©© 
;
©© 
}
™™ 	
)
™™	 

;
™™
 
}
´´ 
)
´´ 
;
´´ 
builder
≠≠ 
.
≠≠ 
Services
≠≠ 
.
≠≠ 
	Configure
≠≠ 
<
≠≠ 
GarnetOptions
≠≠ ,
>
≠≠, -
(
≠≠- .
builder
ÆÆ 
.
ÆÆ 
Configuration
ÆÆ 
.
ÆÆ 

GetSection
ÆÆ (
(
ÆÆ( )
$str
ÆÆ) 1
)
ÆÆ1 2
)
ÆÆ2 3
;
ÆÆ3 4
builder
∞∞ 
.
∞∞ 
Services
∞∞ 
.
∞∞ (
AddStackExchangeRedisCache
∞∞ /
(
∞∞/ 0
options
∞∞0 7
=>
∞∞8 :
{
±± 
var
≤≤ 
garnet
≤≤ 
=
≤≤ 
builder
≤≤ 
.
≤≤ 
Configuration
≤≤ *
.
≥≥ 

GetSection
≥≥ 
(
≥≥ 
$str
≥≥  
)
≥≥  !
.
¥¥ 
Get
¥¥ 
<
¥¥ 
GarnetOptions
¥¥ 
>
¥¥ 
(
¥¥  
)
¥¥  !
??
¥¥" $
new
¥¥% (
GarnetOptions
¥¥) 6
(
¥¥6 7
)
¥¥7 8
;
¥¥8 9
options
∂∂ 
.
∂∂ 
Configuration
∂∂ 
=
∂∂ 
garnet
∂∂  &
.
∂∂& '
ConnectionString
∂∂' 7
;
∂∂7 8
options
∑∑ 
.
∑∑ 
InstanceName
∑∑ 
=
∑∑ 
garnet
∑∑ %
.
∑∑% &
InstanceName
∑∑& 2
;
∑∑2 3
}
∏∏ 
)
∏∏ 
;
∏∏ 
builder
∫∫ 
.
∫∫ 
Services
∫∫ 
.
∫∫ 
AddAutoMapper
∫∫ "
(
∫∫" #
configuration
∫∫# 0
=>
∫∫1 3
configuration
ªª 
.
ªª 

AddProfile
ªª  
<
ªª  !
MappingProfile
ªª! /
>
ªª/ 0
(
ªª0 1
)
ªª1 2
)
ªª2 3
;
ªª3 4
var
ΩΩ 
app
ΩΩ 
=
ΩΩ 
builder
ΩΩ 
.
ΩΩ 
Build
ΩΩ 
(
ΩΩ 
)
ΩΩ 
;
ΩΩ 
app
øø 
.
øø !
UseExceptionHandler
øø 
(
øø 
)
øø 
;
øø 
app
¡¡ 
.
¡¡ &
UseSerilogRequestLogging
¡¡  
(
¡¡  !
options
¡¡! (
=>
¡¡) +
{
¬¬ 
options
√√ 
.
√√ 
MessageTemplate
√√ 
=
√√  !
$str
ƒƒ ^
;
ƒƒ^ _
}
≈≈ 
)
≈≈ 
;
≈≈ 
using
«« 	
(
««
 
var
«« 
scope
«« 
=
«« 
app
«« 
.
«« 
Services
«« #
.
««# $
CreateScope
««$ /
(
««/ 0
)
««0 1
)
««1 2
{
»» 
var
…… 
seedDemoData
…… 
=
…… 
builder
…… "
.
……" #
Configuration
……# 0
.
   
GetValue
   
<
   
bool
   
>
   
(
   
$str
   3
)
  3 4
;
  4 5
await
ÃÃ  
IdentityDataSeeder
ÃÃ  
.
ÃÃ  !
	SeedAsync
ÃÃ! *
(
ÃÃ* +
scope
ÕÕ 
.
ÕÕ 
ServiceProvider
ÕÕ !
.
ÕÕ! " 
GetRequiredService
ÕÕ" 4
<
ÕÕ4 5
RoleManager
ÕÕ5 @
<
ÕÕ@ A
IdentityRole
ÕÕA M
>
ÕÕM N
>
ÕÕN O
(
ÕÕO P
)
ÕÕP Q
,
ÕÕQ R
scope
ŒŒ 
.
ŒŒ 
ServiceProvider
ŒŒ !
.
ŒŒ! " 
GetRequiredService
ŒŒ" 4
<
ŒŒ4 5
UserManager
ŒŒ5 @
<
ŒŒ@ A
IdentityUser
ŒŒA M
>
ŒŒM N
>
ŒŒN O
(
ŒŒO P
)
ŒŒP Q
,
ŒŒQ R
scope
œœ 
.
œœ 
ServiceProvider
œœ !
.
œœ! " 
GetRequiredService
œœ" 4
<
œœ4 5!
HealthAxisDbContext
œœ5 H
>
œœH I
(
œœI J
)
œœJ K
,
œœK L
seedDemoData
–– 
)
–– 
;
–– 
}
—— 
if
”” 
(
”” 
app
”” 
.
”” 
Environment
”” 
.
”” 
IsDevelopment
”” %
(
””% &
)
””& '
)
””' (
{
‘‘ 
app
’’ 
.
’’ 

UseSwagger
’’ 
(
’’ 
)
’’ 
;
’’ 
app
÷÷ 
.
÷÷ 
UseSwaggerUI
÷÷ 
(
÷÷ 
)
÷÷ 
;
÷÷ 
}
◊◊ 
if
ŸŸ 
(
ŸŸ 
!
ŸŸ 	
app
ŸŸ	 
.
ŸŸ 
Environment
ŸŸ 
.
ŸŸ 
IsDevelopment
ŸŸ &
(
ŸŸ& '
)
ŸŸ' (
)
ŸŸ( )
{
⁄⁄ 
app
€€ 
.
€€ !
UseHttpsRedirection
€€ 
(
€€  
)
€€  !
;
€€! "
}
‹‹ 
app
ﬁﬁ 
.
ﬁﬁ 
UseCors
ﬁﬁ 
(
ﬁﬁ '
HealthAxisAdminCorsPolicy
ﬁﬁ )
)
ﬁﬁ) *
;
ﬁﬁ* +
app
ﬂﬂ 
.
ﬂﬂ 
UseAuthentication
ﬂﬂ 
(
ﬂﬂ 
)
ﬂﬂ 
;
ﬂﬂ 
app
‡‡ 
.
‡‡ 
UseAuthorization
‡‡ 
(
‡‡ 
)
‡‡ 
;
‡‡ 
app
·· 
.
·· 
MapControllers
·· 
(
·· 
)
·· 
;
·· 
Log
„„ 
.
„„ 
Information
„„ 
(
„„ 
$str
„„ 0
,
„„0 1
appName
„„2 9
)
„„9 :
;
„„: ;
await
ÂÂ 	
app
ÂÂ
 
.
ÂÂ 
RunAsync
ÂÂ 
(
ÂÂ 
)
ÂÂ 
;
ÂÂ 
}ÊÊ 
catchÁÁ 
(
ÁÁ 
	Exception
ÁÁ 
	exception
ÁÁ 
)
ÁÁ 
{ËË 
Log
ÈÈ 
.
ÈÈ 
Fatal
ÈÈ 
(
ÈÈ 
	exception
ÈÈ 
,
ÈÈ 
$str
ÈÈ B
)
ÈÈB C
;
ÈÈC D
}ÍÍ 
finallyÎÎ 
{ÏÏ 
await
ÌÌ 	
Log
ÌÌ
 
.
ÌÌ  
CloseAndFlushAsync
ÌÌ  
(
ÌÌ  !
)
ÌÌ! "
;
ÌÌ" #
}ÓÓ ‡
OC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Options\GarnetOptions.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Options  
{ 
public 

class 
GarnetOptions 
{ 
public 
string 
ConnectionString &
{' (
get) ,
;, -
set. 1
;1 2
}4 5
=6 7
$str8 H
;H I
public 
string 
InstanceName "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 ?
;? @
} 
}		 ∞
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
}"" ›
MC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Models\Notification.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Models 
;  
public 
class 
Notification 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public		 

string		 
RecipientUserId		 !
{		" #
get		$ '
;		' (
set		) ,
;		, -
}		. /
=		0 1
string		2 8
.		8 9
Empty		9 >
;		> ?
public 

IdentityUser 
? 
RecipientUser &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
public 

string 
Title 
{ 
get 
; 
set "
;" #
}$ %
=& '
string( .
.. /
Empty/ 4
;4 5
public 

string 
Message 
{ 
get 
;  
set! $
;$ %
}& '
=( )
string* 0
.0 1
Empty1 6
;6 7
public 

string 
NotificationType "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
string3 9
.9 :
Empty: ?
;? @
public 

bool 
IsRead 
{ 
get 
; 
set !
;! "
}# $
public 

DateTime 
CreatedAtUtc  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
DateTime1 9
.9 :
UtcNow: @
;@ A
public 

DateTime 
? 
	ReadAtUtc 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 
? 
RelatedEntityType $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

int 
? 
RelatedEntityId 
{  !
get" %
;% &
set' *
;* +
}, -
} ﬁ
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
}!! õ!
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
}&& û3
fC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Migrations\20260707042527_AddedNotifications.cs
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
class		 
AddedNotifications		 +
:		, -
	Migration		. 7
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
$str %
,% &
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
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 6
,6 7
nullable8 @
:@ A
falseB G
)G H
. 

Annotation #
(# $
$str$ 8
,8 9
$str: @
)@ A
,A B
RecipientUserId #
=$ %
table& +
.+ ,
Column, 2
<2 3
string3 9
>9 :
(: ;
type; ?
:? @
$strA P
,P Q
nullableR Z
:Z [
false\ a
)a b
,b c
Title 
= 
table !
.! "
Column" (
<( )
string) /
>/ 0
(0 1
type1 5
:5 6
$str7 F
,F G
	maxLengthH Q
:Q R
$numS V
,V W
nullableX `
:` a
falseb g
)g h
,h i
Message 
= 
table #
.# $
Column$ *
<* +
string+ 1
>1 2
(2 3
type3 7
:7 8
$str9 H
,H I
	maxLengthJ S
:S T
$numU X
,X Y
nullableZ b
:b c
falsed i
)i j
,j k
NotificationType $
=% &
table' ,
., -
Column- 3
<3 4
string4 :
>: ;
(; <
type< @
:@ A
$strB Q
,Q R
	maxLengthS \
:\ ]
$num^ a
,a b
nullablec k
:k l
falsem r
)r s
,s t
IsRead 
= 
table "
." #
Column# )
<) *
bool* .
>. /
(/ 0
type0 4
:4 5
$str6 ;
,; <
nullable= E
:E F
falseG L
)L M
,M N
CreatedAtUtc  
=! "
table# (
.( )
Column) /
</ 0
DateTime0 8
>8 9
(9 :
type: >
:> ?
$str@ K
,K L
nullableM U
:U V
falseW \
)\ ]
,] ^
	ReadAtUtc 
= 
table  %
.% &
Column& ,
<, -
DateTime- 5
>5 6
(6 7
type7 ;
:; <
$str= H
,H I
nullableJ R
:R S
trueT X
)X Y
,Y Z
RelatedEntityType %
=& '
table( -
.- .
Column. 4
<4 5
string5 ;
>; <
(< =
type= A
:A B
$strC R
,R S
	maxLengthT ]
:] ^
$num_ b
,b c
nullabled l
:l m
truen r
)r s
,s t
RelatedEntityId #
=$ %
table& +
.+ ,
Column, 2
<2 3
int3 6
>6 7
(7 8
type8 <
:< =
$str> C
,C D
nullableE M
:M N
trueO S
)S T
} 
, 
constraints 
: 
table "
=># %
{ 
table   
.   

PrimaryKey   $
(  $ %
$str  % 7
,  7 8
x  9 :
=>  ; =
x  > ?
.  ? @
Id  @ B
)  B C
;  C D
table!! 
.!! 

ForeignKey!! $
(!!$ %
name"" 
:"" 
$str"" L
,""L M
column## 
:## 
x##  !
=>##" $
x##% &
.##& '
RecipientUserId##' 6
,##6 7
principalTable$$ &
:$$& '
$str$$( 5
,$$5 6
principalColumn%% '
:%%' (
$str%%) -
,%%- .
onDelete&&  
:&&  !
ReferentialAction&&" 3
.&&3 4
Restrict&&4 <
)&&< =
;&&= >
}'' 
)'' 
;'' 
migrationBuilder)) 
.)) 
CreateIndex)) (
())( )
name** 
:** 
$str** 5
,**5 6
table++ 
:++ 
$str++ &
,++& '
column,, 
:,, 
$str,, &
),,& '
;,,' (
migrationBuilder.. 
... 
CreateIndex.. (
(..( )
name// 
:// 
$str// /
,/// 0
table00 
:00 
$str00 &
,00& '
column11 
:11 
$str11  
)11  !
;11! "
migrationBuilder33 
.33 
CreateIndex33 (
(33( )
name44 
:44 
$str44 8
,448 9
table55 
:55 
$str55 &
,55& '
column66 
:66 
$str66 )
)66) *
;66* +
}77 	
	protected:: 
override:: 
void:: 
Down::  $
(::$ %
MigrationBuilder::% 5
migrationBuilder::6 F
)::F G
{;; 	
migrationBuilder<< 
.<< 
	DropTable<< &
(<<& '
name== 
:== 
$str== %
)==% &
;==& '
}>> 	
}?? 
}@@ ì
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
} ≤*
]C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Messaging\AppointmentBookedConsumer.cs
	namespace 	

HealthAxis
 
. 
API 
. 
	Messaging "
;" #
public 
class %
AppointmentBookedConsumer &
:' (
	IConsumer) 2
<2 3"
AppointmentBookedEvent3 I
>I J
{		 
private

 
const

 
string

 -
!AppointmentBookedNotificationType

 :
=

; <
$str

= P
;

P Q
private 
readonly 
IDoctorRepository &
_doctorRepository' 8
;8 9
private 
readonly #
INotificationRepository ,#
_notificationRepository- D
;D E
private 
readonly 
ILogger 
< %
AppointmentBookedConsumer 6
>6 7
_logger8 ?
;? @
public 
%
AppointmentBookedConsumer $
($ %
IDoctorRepository 
doctorRepository *
,* +#
INotificationRepository "
notificationRepository  6
,6 7
ILogger 
< %
AppointmentBookedConsumer )
>) *
logger+ 1
)1 2
{ 
_doctorRepository 
= 
doctorRepository ,
;, -#
_notificationRepository 
=  !"
notificationRepository" 8
;8 9
_logger 
= 
logger 
; 
} 
public 

async 
Task 
Consume 
( 
ConsumeContext ,
<, -"
AppointmentBookedEvent- C
>C D
contextE L
)L M
{ 
var 
appointmentEvent 
= 
context &
.& '
Message' .
;. /
var 
doctor 
= 
await 
_doctorRepository ,
. 
GetDoctorByIdAsync 
(  
appointmentEvent  0
.0 1
DoctorId1 9
)9 :
;: ;
if   

(   
doctor   
==   
null   
)   
{!! 	
_logger"" 
."" 

LogWarning"" 
("" 
$str	## ü
,
##ü †
appointmentEvent$$  
.$$  !
AppointmentId$$! .
,$$. /
appointmentEvent%%  
.%%  !
DoctorId%%! )
)%%) *
;%%* +
return'' 
;'' 
}(( 	
var** 
notification** 
=** 
new** 
Notification** +
{++ 	
RecipientUserId,, 
=,, 
doctor,, $
.,,$ %
UserId,,% +
,,,+ ,
Title-- 
=-- 
$str-- ,
,--, -
Message.. 
=.. 
$"// 
$str// :
{//: ;
appointmentEvent//; K
.//K L
AppointmentId//L Y
}//Y Z
$str//Z \
"//\ ]
+//^ _
$"00 
$str00 
{00 
appointmentEvent00 /
.00/ 0
	PatientId000 9
}009 :
$str00: B
{00B C
appointmentEvent00C S
.00S T
ScheduledDate00T a
}00a b
$str00b d
"00d e
+00f g
$"11 
$str11 
{11 
appointmentEvent11 )
.11) *
TimeSlot11* 2
}112 3
$str113 4
"114 5
,115 6
NotificationType22 
=22 -
!AppointmentBookedNotificationType22 @
,22@ A
IsRead33 
=33 
false33 
,33 
CreatedAtUtc44 
=44 
DateTime44 #
.44# $
UtcNow44$ *
,44* +
RelatedEntityType55 
=55 
nameof55  &
(55& '
Appointment55' 2
)552 3
,553 4
RelatedEntityId66 
=66 
appointmentEvent66 .
.66. /
AppointmentId66/ <
}77 	
;77	 

var99 
createdNotification99 
=99  !
await99" '#
_notificationRepository99( ?
.99? @
AddAsync99@ H
(99H I
notification99I U
)99U V
;99V W
if;; 

(;; 
_logger;; 
.;; 
	IsEnabled;; 
(;; 
LogLevel;; &
.;;& '
Information;;' 2
);;2 3
);;3 4
{<< 	
_logger== 
.== 
LogInformation== "
(==" #
$str	>> Ï
,
>>Ï Ì
appointmentEvent??  
.??  !
AppointmentId??! .
,??. /
appointmentEvent@@  
.@@  !
	PatientId@@! *
,@@* +
appointmentEventAA  
.AA  !
DoctorIdAA! )
,AA) *
createdNotificationBB #
.BB# $
IdBB$ &
,BB& '
appointmentEventCC  
.CC  !
ScheduledDateCC! .
,CC. /
appointmentEventDD  
.DD  !
TimeSlotDD! )
)DD) *
;DD* +
}EE 	
}FF 
}GG î⁄
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
ÄÄ &
:
ÄÄ& '
$str
ÄÄ( 5
,
ÄÄ5 6
principalColumn
ÅÅ '
:
ÅÅ' (
$str
ÅÅ) -
,
ÅÅ- .
onDelete
ÇÇ  
:
ÇÇ  !
ReferentialAction
ÇÇ" 3
.
ÇÇ3 4
Cascade
ÇÇ4 ;
)
ÇÇ; <
;
ÇÇ< =
table
ÉÉ 
.
ÉÉ 

ForeignKey
ÉÉ $
(
ÉÉ$ %
name
ÑÑ 
:
ÑÑ 
$str
ÑÑ E
,
ÑÑE F
column
ÖÖ 
:
ÖÖ 
x
ÖÖ  !
=>
ÖÖ" $
x
ÖÖ% &
.
ÖÖ& '
UserId
ÖÖ' -
,
ÖÖ- .
principalTable
ÜÜ &
:
ÜÜ& '
$str
ÜÜ( 5
,
ÜÜ5 6
principalColumn
áá '
:
áá' (
$str
áá) -
,
áá- .
onDelete
àà  
:
àà  !
ReferentialAction
àà" 3
.
àà3 4
Cascade
àà4 ;
)
àà; <
;
àà< =
}
ââ 
)
ââ 
;
ââ 
migrationBuilder
ãã 
.
ãã 
CreateTable
ãã (
(
ãã( )
name
åå 
:
åå 
$str
åå (
,
åå( )
columns
çç 
:
çç 
table
çç 
=>
çç !
new
çç" %
{
éé 
UserId
èè 
=
èè 
table
èè "
.
èè" #
Column
èè# )
<
èè) *
string
èè* 0
>
èè0 1
(
èè1 2
type
èè2 6
:
èè6 7
$str
èè8 G
,
èèG H
nullable
èèI Q
:
èèQ R
false
èèS X
)
èèX Y
,
èèY Z
LoginProvider
êê !
=
êê" #
table
êê$ )
.
êê) *
Column
êê* 0
<
êê0 1
string
êê1 7
>
êê7 8
(
êê8 9
type
êê9 =
:
êê= >
$str
êê? N
,
êêN O
nullable
êêP X
:
êêX Y
false
êêZ _
)
êê_ `
,
êê` a
Name
ëë 
=
ëë 
table
ëë  
.
ëë  !
Column
ëë! '
<
ëë' (
string
ëë( .
>
ëë. /
(
ëë/ 0
type
ëë0 4
:
ëë4 5
$str
ëë6 E
,
ëëE F
nullable
ëëG O
:
ëëO P
false
ëëQ V
)
ëëV W
,
ëëW X
Value
íí 
=
íí 
table
íí !
.
íí! "
Column
íí" (
<
íí( )
string
íí) /
>
íí/ 0
(
íí0 1
type
íí1 5
:
íí5 6
$str
íí7 F
,
ííF G
nullable
ííH P
:
ííP Q
true
ííR V
)
ííV W
}
ìì 
,
ìì 
constraints
îî 
:
îî 
table
îî "
=>
îî# %
{
ïï 
table
ññ 
.
ññ 

PrimaryKey
ññ $
(
ññ$ %
$str
ññ% :
,
ññ: ;
x
ññ< =
=>
ññ> @
new
ññA D
{
ññE F
x
ññG H
.
ññH I
UserId
ññI O
,
ññO P
x
ññQ R
.
ññR S
LoginProvider
ññS `
,
ññ` a
x
ññb c
.
ññc d
Name
ññd h
}
ññi j
)
ññj k
;
ññk l
table
óó 
.
óó 

ForeignKey
óó $
(
óó$ %
name
òò 
:
òò 
$str
òò F
,
òòF G
column
ôô 
:
ôô 
x
ôô  !
=>
ôô" $
x
ôô% &
.
ôô& '
UserId
ôô' -
,
ôô- .
principalTable
öö &
:
öö& '
$str
öö( 5
,
öö5 6
principalColumn
õõ '
:
õõ' (
$str
õõ) -
,
õõ- .
onDelete
úú  
:
úú  !
ReferentialAction
úú" 3
.
úú3 4
Cascade
úú4 ;
)
úú; <
;
úú< =
}
ùù 
)
ùù 
;
ùù 
migrationBuilder
üü 
.
üü 
CreateTable
üü (
(
üü( )
name
†† 
:
†† 
$str
†† 
,
††  
columns
°° 
:
°° 
table
°° 
=>
°° !
new
°°" %
{
¢¢ 
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
§§ 

Annotation
§§ #
(
§§# $
$str
§§$ 8
,
§§8 9
$str
§§: @
)
§§@ A
,
§§A B
UserId
•• 
=
•• 
table
•• "
.
••" #
Column
••# )
<
••) *
string
••* 0
>
••0 1
(
••1 2
type
••2 6
:
••6 7
$str
••8 G
,
••G H
nullable
••I Q
:
••Q R
false
••S X
)
••X Y
,
••Y Z
FullName
¶¶ 
=
¶¶ 
table
¶¶ $
.
¶¶$ %
Column
¶¶% +
<
¶¶+ ,
string
¶¶, 2
>
¶¶2 3
(
¶¶3 4
type
¶¶4 8
:
¶¶8 9
$str
¶¶: I
,
¶¶I J
	maxLength
¶¶K T
:
¶¶T U
$num
¶¶V Y
,
¶¶Y Z
nullable
¶¶[ c
:
¶¶c d
false
¶¶e j
)
¶¶j k
,
¶¶k l
Specialisation
ßß "
=
ßß# $
table
ßß% *
.
ßß* +
Column
ßß+ 1
<
ßß1 2
string
ßß2 8
>
ßß8 9
(
ßß9 :
type
ßß: >
:
ßß> ?
$str
ßß@ O
,
ßßO P
	maxLength
ßßQ Z
:
ßßZ [
$num
ßß\ _
,
ßß_ `
nullable
ßßa i
:
ßßi j
false
ßßk p
)
ßßp q
,
ßßq r
PracticeStartDate
®® %
=
®®& '
table
®®( -
.
®®- .
Column
®®. 4
<
®®4 5
DateOnly
®®5 =
>
®®= >
(
®®> ?
type
®®? C
:
®®C D
$str
®®E K
,
®®K L
nullable
®®M U
:
®®U V
false
®®W \
)
®®\ ]
,
®®] ^
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
™™ 
=
™™  !
table
™™" '
.
™™' (
Column
™™( .
<
™™. /
bool
™™/ 3
>
™™3 4
(
™™4 5
type
™™5 9
:
™™9 :
$str
™™; @
,
™™@ A
nullable
™™B J
:
™™J K
false
™™L Q
)
™™Q R
}
´´ 
,
´´ 
constraints
¨¨ 
:
¨¨ 
table
¨¨ "
=>
¨¨# %
{
≠≠ 
table
ÆÆ 
.
ÆÆ 

PrimaryKey
ÆÆ $
(
ÆÆ$ %
$str
ÆÆ% 1
,
ÆÆ1 2
x
ÆÆ3 4
=>
ÆÆ5 7
x
ÆÆ8 9
.
ÆÆ9 :
Id
ÆÆ: <
)
ÆÆ< =
;
ÆÆ= >
table
ØØ 
.
ØØ 

ForeignKey
ØØ $
(
ØØ$ %
name
∞∞ 
:
∞∞ 
$str
∞∞ =
,
∞∞= >
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
≤≤ &
:
≤≤& '
$str
≤≤( 5
,
≤≤5 6
principalColumn
≥≥ '
:
≥≥' (
$str
≥≥) -
,
≥≥- .
onDelete
¥¥  
:
¥¥  !
ReferentialAction
¥¥" 3
.
¥¥3 4
Restrict
¥¥4 <
)
¥¥< =
;
¥¥= >
}
µµ 
)
µµ 
;
µµ 
migrationBuilder
∑∑ 
.
∑∑ 
CreateTable
∑∑ (
(
∑∑( )
name
∏∏ 
:
∏∏ 
$str
∏∏  
,
∏∏  !
columns
ππ 
:
ππ 
table
ππ 
=>
ππ !
new
ππ" %
{
∫∫ 
Id
ªª 
=
ªª 
table
ªª 
.
ªª 
Column
ªª %
<
ªª% &
int
ªª& )
>
ªª) *
(
ªª* +
type
ªª+ /
:
ªª/ 0
$str
ªª1 6
,
ªª6 7
nullable
ªª8 @
:
ªª@ A
false
ªªB G
)
ªªG H
.
ºº 

Annotation
ºº #
(
ºº# $
$str
ºº$ 8
,
ºº8 9
$str
ºº: @
)
ºº@ A
,
ººA B
UserId
ΩΩ 
=
ΩΩ 
table
ΩΩ "
.
ΩΩ" #
Column
ΩΩ# )
<
ΩΩ) *
string
ΩΩ* 0
>
ΩΩ0 1
(
ΩΩ1 2
type
ΩΩ2 6
:
ΩΩ6 7
$str
ΩΩ8 G
,
ΩΩG H
nullable
ΩΩI Q
:
ΩΩQ R
false
ΩΩS X
)
ΩΩX Y
,
ΩΩY Z
FullName
ææ 
=
ææ 
table
ææ $
.
ææ$ %
Column
ææ% +
<
ææ+ ,
string
ææ, 2
>
ææ2 3
(
ææ3 4
type
ææ4 8
:
ææ8 9
$str
ææ: I
,
ææI J
	maxLength
ææK T
:
ææT U
$num
ææV Y
,
ææY Z
nullable
ææ[ c
:
ææc d
false
ææe j
)
ææj k
,
ææk l
DateOfBirth
øø 
=
øø  !
table
øø" '
.
øø' (
Column
øø( .
<
øø. /
DateOnly
øø/ 7
>
øø7 8
(
øø8 9
type
øø9 =
:
øø= >
$str
øø? E
,
øøE F
nullable
øøG O
:
øøO P
false
øøQ V
)
øøV W
,
øøW X
Gender
¿¿ 
=
¿¿ 
table
¿¿ "
.
¿¿" #
Column
¿¿# )
<
¿¿) *
string
¿¿* 0
>
¿¿0 1
(
¿¿1 2
type
¿¿2 6
:
¿¿6 7
$str
¿¿8 F
,
¿¿F G
	maxLength
¿¿H Q
:
¿¿Q R
$num
¿¿S U
,
¿¿U V
nullable
¿¿W _
:
¿¿_ `
false
¿¿a f
)
¿¿f g
,
¿¿g h
Address
¡¡ 
=
¡¡ 
table
¡¡ #
.
¡¡# $
Column
¡¡$ *
<
¡¡* +
string
¡¡+ 1
>
¡¡1 2
(
¡¡2 3
type
¡¡3 7
:
¡¡7 8
$str
¡¡9 H
,
¡¡H I
	maxLength
¡¡J S
:
¡¡S T
$num
¡¡U X
,
¡¡X Y
nullable
¡¡Z b
:
¡¡b c
false
¡¡d i
)
¡¡i j
}
¬¬ 
,
¬¬ 
constraints
√√ 
:
√√ 
table
√√ "
=>
√√# %
{
ƒƒ 
table
≈≈ 
.
≈≈ 

PrimaryKey
≈≈ $
(
≈≈$ %
$str
≈≈% 2
,
≈≈2 3
x
≈≈4 5
=>
≈≈6 8
x
≈≈9 :
.
≈≈: ;
Id
≈≈; =
)
≈≈= >
;
≈≈> ?
table
∆∆ 
.
∆∆ 

ForeignKey
∆∆ $
(
∆∆$ %
name
«« 
:
«« 
$str
«« >
,
««> ?
column
»» 
:
»» 
x
»»  !
=>
»»" $
x
»»% &
.
»»& '
UserId
»»' -
,
»»- .
principalTable
…… &
:
……& '
$str
……( 5
,
……5 6
principalColumn
   '
:
  ' (
$str
  ) -
,
  - .
onDelete
ÀÀ  
:
ÀÀ  !
ReferentialAction
ÀÀ" 3
.
ÀÀ3 4
Restrict
ÀÀ4 <
)
ÀÀ< =
;
ÀÀ= >
}
ÃÃ 
)
ÃÃ 
;
ÃÃ 
migrationBuilder
ŒŒ 
.
ŒŒ 
CreateTable
ŒŒ (
(
ŒŒ( )
name
œœ 
:
œœ 
$str
œœ $
,
œœ$ %
columns
–– 
:
–– 
table
–– 
=>
–– !
new
––" %
{
—— 
Id
““ 
=
““ 
table
““ 
.
““ 
Column
““ %
<
““% &
int
““& )
>
““) *
(
““* +
type
““+ /
:
““/ 0
$str
““1 6
,
““6 7
nullable
““8 @
:
““@ A
false
““B G
)
““G H
.
”” 

Annotation
”” #
(
””# $
$str
””$ 8
,
””8 9
$str
””: @
)
””@ A
,
””A B
	PatientId
‘‘ 
=
‘‘ 
table
‘‘  %
.
‘‘% &
Column
‘‘& ,
<
‘‘, -
int
‘‘- 0
>
‘‘0 1
(
‘‘1 2
type
‘‘2 6
:
‘‘6 7
$str
‘‘8 =
,
‘‘= >
nullable
‘‘? G
:
‘‘G H
false
‘‘I N
)
‘‘N O
,
‘‘O P
DoctorId
’’ 
=
’’ 
table
’’ $
.
’’$ %
Column
’’% +
<
’’+ ,
int
’’, /
>
’’/ 0
(
’’0 1
type
’’1 5
:
’’5 6
$str
’’7 <
,
’’< =
nullable
’’> F
:
’’F G
false
’’H M
)
’’M N
,
’’N O
AppointmentDate
÷÷ #
=
÷÷$ %
table
÷÷& +
.
÷÷+ ,
Column
÷÷, 2
<
÷÷2 3
DateOnly
÷÷3 ;
>
÷÷; <
(
÷÷< =
type
÷÷= A
:
÷÷A B
$str
÷÷C I
,
÷÷I J
nullable
÷÷K S
:
÷÷S T
false
÷÷U Z
)
÷÷Z [
,
÷÷[ \
AppointmentTime
◊◊ #
=
◊◊$ %
table
◊◊& +
.
◊◊+ ,
Column
◊◊, 2
<
◊◊2 3
TimeOnly
◊◊3 ;
>
◊◊; <
(
◊◊< =
type
◊◊= A
:
◊◊A B
$str
◊◊C I
,
◊◊I J
nullable
◊◊K S
:
◊◊S T
false
◊◊U Z
)
◊◊Z [
,
◊◊[ \
Status
ÿÿ 
=
ÿÿ 
table
ÿÿ "
.
ÿÿ" #
Column
ÿÿ# )
<
ÿÿ) *
string
ÿÿ* 0
>
ÿÿ0 1
(
ÿÿ1 2
type
ÿÿ2 6
:
ÿÿ6 7
$str
ÿÿ8 F
,
ÿÿF G
	maxLength
ÿÿH Q
:
ÿÿQ R
$num
ÿÿS U
,
ÿÿU V
nullable
ÿÿW _
:
ÿÿ_ `
false
ÿÿa f
)
ÿÿf g
,
ÿÿg h 
CancellationReason
ŸŸ &
=
ŸŸ' (
table
ŸŸ) .
.
ŸŸ. /
Column
ŸŸ/ 5
<
ŸŸ5 6
string
ŸŸ6 <
>
ŸŸ< =
(
ŸŸ= >
type
ŸŸ> B
:
ŸŸB C
$str
ŸŸD S
,
ŸŸS T
	maxLength
ŸŸU ^
:
ŸŸ^ _
$num
ŸŸ` c
,
ŸŸc d
nullable
ŸŸe m
:
ŸŸm n
true
ŸŸo s
)
ŸŸs t
}
⁄⁄ 
,
⁄⁄ 
constraints
€€ 
:
€€ 
table
€€ "
=>
€€# %
{
‹‹ 
table
›› 
.
›› 

PrimaryKey
›› $
(
››$ %
$str
››% 6
,
››6 7
x
››8 9
=>
››: <
x
››= >
.
››> ?
Id
››? A
)
››A B
;
››B C
table
ﬁﬁ 
.
ﬁﬁ 

ForeignKey
ﬁﬁ $
(
ﬁﬁ$ %
name
ﬂﬂ 
:
ﬂﬂ 
$str
ﬂﬂ @
,
ﬂﬂ@ A
column
‡‡ 
:
‡‡ 
x
‡‡  !
=>
‡‡" $
x
‡‡% &
.
‡‡& '
DoctorId
‡‡' /
,
‡‡/ 0
principalTable
·· &
:
··& '
$str
··( 1
,
··1 2
principalColumn
‚‚ '
:
‚‚' (
$str
‚‚) -
,
‚‚- .
onDelete
„„  
:
„„  !
ReferentialAction
„„" 3
.
„„3 4
Restrict
„„4 <
)
„„< =
;
„„= >
table
‰‰ 
.
‰‰ 

ForeignKey
‰‰ $
(
‰‰$ %
name
ÂÂ 
:
ÂÂ 
$str
ÂÂ B
,
ÂÂB C
column
ÊÊ 
:
ÊÊ 
x
ÊÊ  !
=>
ÊÊ" $
x
ÊÊ% &
.
ÊÊ& '
	PatientId
ÊÊ' 0
,
ÊÊ0 1
principalTable
ÁÁ &
:
ÁÁ& '
$str
ÁÁ( 2
,
ÁÁ2 3
principalColumn
ËË '
:
ËË' (
$str
ËË) -
,
ËË- .
onDelete
ÈÈ  
:
ÈÈ  !
ReferentialAction
ÈÈ" 3
.
ÈÈ3 4
Restrict
ÈÈ4 <
)
ÈÈ< =
;
ÈÈ= >
}
ÍÍ 
)
ÍÍ 
;
ÍÍ 
migrationBuilder
ÏÏ 
.
ÏÏ 
CreateTable
ÏÏ (
(
ÏÏ( )
name
ÌÌ 
:
ÌÌ 
$str
ÌÌ %
,
ÌÌ% &
columns
ÓÓ 
:
ÓÓ 
table
ÓÓ 
=>
ÓÓ !
new
ÓÓ" %
{
ÔÔ 
Id
 
=
 
table
 
.
 
Column
 %
<
% &
int
& )
>
) *
(
* +
type
+ /
:
/ 0
$str
1 6
,
6 7
nullable
8 @
:
@ A
false
B G
)
G H
.
ÒÒ 

Annotation
ÒÒ #
(
ÒÒ# $
$str
ÒÒ$ 8
,
ÒÒ8 9
$str
ÒÒ: @
)
ÒÒ@ A
,
ÒÒA B
AppointmentId
ÚÚ !
=
ÚÚ" #
table
ÚÚ$ )
.
ÚÚ) *
Column
ÚÚ* 0
<
ÚÚ0 1
int
ÚÚ1 4
>
ÚÚ4 5
(
ÚÚ5 6
type
ÚÚ6 :
:
ÚÚ: ;
$str
ÚÚ< A
,
ÚÚA B
nullable
ÚÚC K
:
ÚÚK L
false
ÚÚM R
)
ÚÚR S
,
ÚÚS T
	VisitDate
ÛÛ 
=
ÛÛ 
table
ÛÛ  %
.
ÛÛ% &
Column
ÛÛ& ,
<
ÛÛ, -
DateOnly
ÛÛ- 5
>
ÛÛ5 6
(
ÛÛ6 7
type
ÛÛ7 ;
:
ÛÛ; <
$str
ÛÛ= C
,
ÛÛC D
nullable
ÛÛE M
:
ÛÛM N
false
ÛÛO T
)
ÛÛT U
,
ÛÛU V
	Diagnosis
ÙÙ 
=
ÙÙ 
table
ÙÙ  %
.
ÙÙ% &
Column
ÙÙ& ,
<
ÙÙ, -
string
ÙÙ- 3
>
ÙÙ3 4
(
ÙÙ4 5
type
ÙÙ5 9
:
ÙÙ9 :
$str
ÙÙ; J
,
ÙÙJ K
	maxLength
ÙÙL U
:
ÙÙU V
$num
ÙÙW Z
,
ÙÙZ [
nullable
ÙÙ\ d
:
ÙÙd e
false
ÙÙf k
)
ÙÙk l
,
ÙÙl m
Prescription
ıı  
=
ıı! "
table
ıı# (
.
ıı( )
Column
ıı) /
<
ıı/ 0
string
ıı0 6
>
ıı6 7
(
ıı7 8
type
ıı8 <
:
ıı< =
$str
ıı> M
,
ııM N
	maxLength
ııO X
:
ııX Y
$num
ııZ ]
,
ıı] ^
nullable
ıı_ g
:
ııg h
false
ııi n
)
ıın o
,
ııo p
Notes
ˆˆ 
=
ˆˆ 
table
ˆˆ !
.
ˆˆ! "
Column
ˆˆ" (
<
ˆˆ( )
string
ˆˆ) /
>
ˆˆ/ 0
(
ˆˆ0 1
type
ˆˆ1 5
:
ˆˆ5 6
$str
ˆˆ7 G
,
ˆˆG H
	maxLength
ˆˆI R
:
ˆˆR S
$num
ˆˆT X
,
ˆˆX Y
nullable
ˆˆZ b
:
ˆˆb c
true
ˆˆd h
)
ˆˆh i
}
˜˜ 
,
˜˜ 
constraints
¯¯ 
:
¯¯ 
table
¯¯ "
=>
¯¯# %
{
˘˘ 
table
˙˙ 
.
˙˙ 

PrimaryKey
˙˙ $
(
˙˙$ %
$str
˙˙% 7
,
˙˙7 8
x
˙˙9 :
=>
˙˙; =
x
˙˙> ?
.
˙˙? @
Id
˙˙@ B
)
˙˙B C
;
˙˙C D
table
˚˚ 
.
˚˚ 

ForeignKey
˚˚ $
(
˚˚$ %
name
¸¸ 
:
¸¸ 
$str
¸¸ K
,
¸¸K L
column
˝˝ 
:
˝˝ 
x
˝˝  !
=>
˝˝" $
x
˝˝% &
.
˝˝& '
AppointmentId
˝˝' 4
,
˝˝4 5
principalTable
˛˛ &
:
˛˛& '
$str
˛˛( 6
,
˛˛6 7
principalColumn
ˇˇ '
:
ˇˇ' (
$str
ˇˇ) -
,
ˇˇ- .
onDelete
ÄÄ  
:
ÄÄ  !
ReferentialAction
ÄÄ" 3
.
ÄÄ3 4
Restrict
ÄÄ4 <
)
ÄÄ< =
;
ÄÄ= >
}
ÅÅ 
)
ÅÅ 
;
ÅÅ 
migrationBuilder
ÉÉ 
.
ÉÉ 
CreateIndex
ÉÉ (
(
ÉÉ( )
name
ÑÑ 
:
ÑÑ 
$str
ÑÑ 0
,
ÑÑ0 1
table
ÖÖ 
:
ÖÖ 
$str
ÖÖ %
,
ÖÖ% &
column
ÜÜ 
:
ÜÜ 
$str
ÜÜ "
)
ÜÜ" #
;
ÜÜ# $
migrationBuilder
àà 
.
àà 
CreateIndex
àà (
(
àà( )
name
ââ 
:
ââ 
$str
ââ 1
,
ââ1 2
table
ää 
:
ää 
$str
ää %
,
ää% &
column
ãã 
:
ãã 
$str
ãã #
)
ãã# $
;
ãã$ %
migrationBuilder
çç 
.
çç 
CreateIndex
çç (
(
çç( )
name
éé 
:
éé 
$str
éé 2
,
éé2 3
table
èè 
:
èè 
$str
èè )
,
èè) *
column
êê 
:
êê 
$str
êê  
)
êê  !
;
êê! "
migrationBuilder
íí 
.
íí 
CreateIndex
íí (
(
íí( )
name
ìì 
:
ìì 
$str
ìì %
,
ìì% &
table
îî 
:
îî 
$str
îî $
,
îî$ %
column
ïï 
:
ïï 
$str
ïï (
,
ïï( )
unique
ññ 
:
ññ 
true
ññ 
,
ññ 
filter
óó 
:
óó 
$str
óó 6
)
óó6 7
;
óó7 8
migrationBuilder
ôô 
.
ôô 
CreateIndex
ôô (
(
ôô( )
name
öö 
:
öö 
$str
öö 2
,
öö2 3
table
õõ 
:
õõ 
$str
õõ )
,
õõ) *
column
úú 
:
úú 
$str
úú  
)
úú  !
;
úú! "
migrationBuilder
ûû 
.
ûû 
CreateIndex
ûû (
(
ûû( )
name
üü 
:
üü 
$str
üü 2
,
üü2 3
table
†† 
:
†† 
$str
†† )
,
††) *
column
°° 
:
°° 
$str
°°  
)
°°  !
;
°°! "
migrationBuilder
££ 
.
££ 
CreateIndex
££ (
(
££( )
name
§§ 
:
§§ 
$str
§§ 1
,
§§1 2
table
•• 
:
•• 
$str
•• (
,
••( )
column
¶¶ 
:
¶¶ 
$str
¶¶  
)
¶¶  !
;
¶¶! "
migrationBuilder
®® 
.
®® 
CreateIndex
®® (
(
®®( )
name
©© 
:
©© 
$str
©© "
,
©©" #
table
™™ 
:
™™ 
$str
™™ $
,
™™$ %
column
´´ 
:
´´ 
$str
´´ )
)
´´) *
;
´´* +
migrationBuilder
≠≠ 
.
≠≠ 
CreateIndex
≠≠ (
(
≠≠( )
name
ÆÆ 
:
ÆÆ 
$str
ÆÆ %
,
ÆÆ% &
table
ØØ 
:
ØØ 
$str
ØØ $
,
ØØ$ %
column
∞∞ 
:
∞∞ 
$str
∞∞ ,
,
∞∞, -
unique
±± 
:
±± 
true
±± 
,
±± 
filter
≤≤ 
:
≤≤ 
$str
≤≤ :
)
≤≤: ;
;
≤≤; <
migrationBuilder
¥¥ 
.
¥¥ 
CreateIndex
¥¥ (
(
¥¥( )
name
µµ 
:
µµ 
$str
µµ )
,
µµ) *
table
∂∂ 
:
∂∂ 
$str
∂∂  
,
∂∂  !
column
∑∑ 
:
∑∑ 
$str
∑∑  
,
∑∑  !
unique
∏∏ 
:
∏∏ 
true
∏∏ 
)
∏∏ 
;
∏∏ 
migrationBuilder
∫∫ 
.
∫∫ 
CreateIndex
∫∫ (
(
∫∫( )
name
ªª 
:
ªª 
$str
ªª 6
,
ªª6 7
table
ºº 
:
ºº 
$str
ºº &
,
ºº& '
column
ΩΩ 
:
ΩΩ 
$str
ΩΩ '
,
ΩΩ' (
unique
ææ 
:
ææ 
true
ææ 
)
ææ 
;
ææ 
migrationBuilder
¿¿ 
.
¿¿ 
CreateIndex
¿¿ (
(
¿¿( )
name
¡¡ 
:
¡¡ 
$str
¡¡ *
,
¡¡* +
table
¬¬ 
:
¬¬ 
$str
¬¬ !
,
¬¬! "
column
√√ 
:
√√ 
$str
√√  
,
√√  !
unique
ƒƒ 
:
ƒƒ 
true
ƒƒ 
)
ƒƒ 
;
ƒƒ 
}
≈≈ 	
	protected
»» 
override
»» 
void
»» 
Down
»»  $
(
»»$ %
MigrationBuilder
»»% 5
migrationBuilder
»»6 F
)
»»F G
{
…… 	
migrationBuilder
   
.
   
	DropTable
   &
(
  & '
name
ÀÀ 
:
ÀÀ 
$str
ÀÀ (
)
ÀÀ( )
;
ÀÀ) *
migrationBuilder
ÕÕ 
.
ÕÕ 
	DropTable
ÕÕ &
(
ÕÕ& '
name
ŒŒ 
:
ŒŒ 
$str
ŒŒ (
)
ŒŒ( )
;
ŒŒ) *
migrationBuilder
–– 
.
–– 
	DropTable
–– &
(
––& '
name
—— 
:
—— 
$str
—— (
)
——( )
;
——) *
migrationBuilder
”” 
.
”” 
	DropTable
”” &
(
””& '
name
‘‘ 
:
‘‘ 
$str
‘‘ '
)
‘‘' (
;
‘‘( )
migrationBuilder
÷÷ 
.
÷÷ 
	DropTable
÷÷ &
(
÷÷& '
name
◊◊ 
:
◊◊ 
$str
◊◊ (
)
◊◊( )
;
◊◊) *
migrationBuilder
ŸŸ 
.
ŸŸ 
	DropTable
ŸŸ &
(
ŸŸ& '
name
⁄⁄ 
:
⁄⁄ 
$str
⁄⁄ %
)
⁄⁄% &
;
⁄⁄& '
migrationBuilder
‹‹ 
.
‹‹ 
	DropTable
‹‹ &
(
‹‹& '
name
›› 
:
›› 
$str
›› #
)
››# $
;
››$ %
migrationBuilder
ﬂﬂ 
.
ﬂﬂ 
	DropTable
ﬂﬂ &
(
ﬂﬂ& '
name
‡‡ 
:
‡‡ 
$str
‡‡ $
)
‡‡$ %
;
‡‡% &
migrationBuilder
‚‚ 
.
‚‚ 
	DropTable
‚‚ &
(
‚‚& '
name
„„ 
:
„„ 
$str
„„ 
)
„„  
;
„„  !
migrationBuilder
ÂÂ 
.
ÂÂ 
	DropTable
ÂÂ &
(
ÂÂ& '
name
ÊÊ 
:
ÊÊ 
$str
ÊÊ  
)
ÊÊ  !
;
ÊÊ! "
migrationBuilder
ËË 
.
ËË 
	DropTable
ËË &
(
ËË& '
name
ÈÈ 
:
ÈÈ 
$str
ÈÈ #
)
ÈÈ# $
;
ÈÈ$ %
}
ÍÍ 	
}
ÎÎ 
}ÏÏ Õ,
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
ILogger 
< "
GlobalExceptionHandler "
>" #
logger$ *
)* +
:, -
IExceptionHandler. ?
{		 
public

 

async

 
	ValueTask

 
<

 
bool

 
>

  
TryHandleAsync

! /
(

/ 0
HttpContext 
httpContext 
,  
	Exception 
	exception 
, 
CancellationToken 
cancellationToken +
)+ ,
{ 
var 
( 

statusCode 
, 
message  
)  !
=" #
MapException$ 0
(0 1
	exception1 :
): ;
;; <
if 

( 

statusCode 
>= 
StatusCodes %
.% &(
Status500InternalServerError& B
)B C
{ 	
logger 
. 
LogError 
( 
	exception 
, 
$str p
,p q
httpContext 
. 
Request #
.# $
Method$ *
,* +
httpContext 
. 
Request #
.# $
Path$ (
,( )

statusCode 
) 
; 
} 	
else 
{ 	
logger 
. 

LogWarning 
( 
$str	 õ
,
õ ú
httpContext 
. 
Request #
.# $
Method$ *
,* +
httpContext 
. 
Request #
.# $
Path$ (
,( )

statusCode   
,   
	exception!! 
.!! 
GetType!! !
(!!! "
)!!" #
.!!# $
Name!!$ (
,!!( )
message"" 
)"" 
;"" 
}## 	
var%% 
response%% 
=%% 
new%% 
ErrorResponseDto%% +
{&& 	

StatusCode'' 
='' 

statusCode'' #
,''# $
Message(( 
=(( 
message(( 
,(( 
Details)) 
=)) 

statusCode))  
>=))! #
StatusCodes))$ /
.))/ 0(
Status500InternalServerError))0 L
?** 
$str** '
:++ 
	exception++ 
.++ 
GetType++ #
(++# $
)++$ %
.++% &
Name++& *
,++* +
	Timestamp,, 
=,, 
DateTime,,  
.,,  !
UtcNow,,! '
,,,' (
Path-- 
=-- 
httpContext-- 
.-- 
Request-- &
.--& '
Path--' +
}.. 	
;..	 

httpContext00 
.00 
Response00 
.00 

StatusCode00 '
=00( )

statusCode00* 4
;004 5
await22 
httpContext22 
.22 
Response22 "
.22" #
WriteAsJsonAsync22# 3
(223 4
response33 
,33 
cancellationToken44 
)44 
;44 
return66 
true66 
;66 
}77 
private99 
static99 
(99 
int99 

StatusCode99 "
,99" #
string99$ *
Message99+ 2
)992 3
MapException994 @
(99@ A
	Exception:: 
	exception:: 
):: 
{;; 
return<< 
	exception<< 
switch<< 
{== 	
AppException>> 
appException>> %
=>>>& (
(?? 
appException?? 
.?? 

StatusCode?? (
,??( )
appException??* 6
.??6 7
Message??7 >
)??> ?
,??? @!
ArgumentNullExceptionAA !
=>AA" $
(BB 
StatusCodesBB 
.BB 
Status400BadRequestBB 0
,BB0 1
	exceptionBB2 ;
.BB; <
MessageBB< C
)BBC D
,BBD E
ArgumentExceptionDD 
=>DD  
(EE 
StatusCodesEE 
.EE 
Status400BadRequestEE 0
,EE0 1
	exceptionEE2 ;
.EE; <
MessageEE< C
)EEC D
,EED E%
InvalidOperationExceptionGG %
=>GG& (
(HH 
StatusCodesHH 
.HH 
Status400BadRequestHH 0
,HH0 1
	exceptionHH2 ;
.HH; <
MessageHH< C
)HHC D
,HHD E 
KeyNotFoundExceptionJJ  
=>JJ! #
(KK 
StatusCodesKK 
.KK 
Status404NotFoundKK .
,KK. /
	exceptionKK0 9
.KK9 :
MessageKK: A
)KKA B
,KKB C'
UnauthorizedAccessExceptionMM '
=>MM( *
(NN 
StatusCodesNN 
.NN 
Status403ForbiddenNN /
,NN/ 0
	exceptionNN1 :
.NN: ;
MessageNN; B
)NNB C
,NNC D
_PP 
=>PP 
(QQ 
StatusCodesQQ 
.QQ (
Status500InternalServerErrorQQ 9
,QQ9 :
$strRR 3
)RR3 4
}SS 	
;SS	 

}TT 
}UU ö
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
} ËT
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
{ #
ConfigureDoctorMappings 
(  
)  !
;! "$
ConfigurePatientMappings  
(  !
)! "
;" #(
ConfigureAppointmentMappings $
($ %
)% &
;& ')
ConfigureHealthRecordMappings %
(% &
)& '
;' (
} 
private 
void #
ConfigureDoctorMappings (
(( )
)) *
{ 
	CreateMap 
< 
Doctor 
, 
PublicDoctorDto )
>) *
(* +
)+ ,
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
YearsOfExperience$ 5
,5 6
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src* -
.- .&
CalculateYearsOfExperience. H
(H I
)I J
)J K
)K L
;L M
	CreateMap 
< 
Doctor 
, 
	DoctorDto #
># $
($ %
)% &
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
YearsOfExperience$ 5
,5 6
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src* -
.- .&
CalculateYearsOfExperience. H
(H I
)I J
)J K
)K L
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
Email$ )
,) *
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src 
. 
User 
!= 
null  $
&&% '
src( +
.+ ,
User, 0
.0 1
Email1 6
!=7 9
null: >
?   
src   
.   
User   "
.  " #
Email  # (
:!! 
string!!  
.!!  !
Empty!!! &
)!!& '
)!!' (
."" 
	ForMember"" 
("" 
dest"" 
=>"" 
dest"" #
.""# $
PhoneNumber""$ /
,""/ 0
opt## 
=>## 
opt## 
.## 
MapFrom## "
(##" #
src### &
=>##' )
src$$ 
.$$ 
User$$ 
!=$$ 
null$$  $
&&$$% '
src$$( +
.$$+ ,
User$$, 0
.$$0 1
PhoneNumber$$1 <
!=$$= ?
null$$@ D
?%% 
src%% 
.%% 
User%% "
.%%" #
PhoneNumber%%# .
:&& 
string&&  
.&&  !
Empty&&! &
)&&& '
)&&' (
;&&( )
}'' 
private)) 
void)) $
ConfigurePatientMappings)) )
())) *
)))* +
{** 
	CreateMap++ 
<++ 
Patient++ 
,++ 

PatientDto++ %
>++% &
(++& '
)++' (
.,, 
	ForMember,, 
(,, 
dest,, 
=>,, 
dest,, #
.,,# $
Email,,$ )
,,,) *
opt-- 
=>-- 
opt-- 
.-- 
MapFrom-- "
(--" #
src--# &
=>--' )
src.. 
... 
User.. 
!=.. 
null..  $
&&..% '
src..( +
...+ ,
User.., 0
...0 1
Email..1 6
!=..7 9
null..: >
?// 
src// 
.// 
User// "
.//" #
Email//# (
:00 
string00  
.00  !
Empty00! &
)00& '
)00' (
.11 
	ForMember11 
(11 
dest11 
=>11 
dest11 #
.11# $
PhoneNumber11$ /
,11/ 0
opt22 
=>22 
opt22 
.22 
MapFrom22 "
(22" #
src22# &
=>22' )
src33 
.33 
User33 
!=33 
null33  $
&&33% '
src33( +
.33+ ,
User33, 0
.330 1
PhoneNumber331 <
!=33= ?
null33@ D
?44 
src44 
.44 
User44 "
.44" #
PhoneNumber44# .
:55 
string55  
.55  !
Empty55! &
)55& '
)55' (
;55( )
}66 
private88 
void88 (
ConfigureAppointmentMappings88 -
(88- .
)88. /
{99 
	CreateMap:: 
<:: 
Appointment:: 
,:: 
AppointmentDto:: -
>::- .
(::. /
)::/ 0
.;; 
	ForMember;; 
(;; 
dest;; 
=>;; 
dest;; #
.;;# $
PatientName;;$ /
,;;/ 0
opt<< 
=><< 
opt<< 
.<< 
MapFrom<< "
(<<" #
src<<# &
=><<' )
src== 
.== 
Patient== 
!===  "
null==# '
?>> 
src>> 
.>> 
Patient>> %
.>>% &
FullName>>& .
:?? 
string??  
.??  !
Empty??! &
)??& '
)??' (
.@@ 
	ForMember@@ 
(@@ 
dest@@ 
=>@@ 
dest@@ #
.@@# $

DoctorName@@$ .
,@@. /
optAA 
=>AA 
optAA 
.AA 
MapFromAA "
(AA" #
srcAA# &
=>AA' )
srcBB 
.BB 
DoctorBB 
!=BB !
nullBB" &
?CC 
srcCC 
.CC 
DoctorCC $
.CC$ %
FullNameCC% -
:DD 
stringDD  
.DD  !
EmptyDD! &
)DD& '
)DD' (
.EE 
	ForMemberEE 
(EE 
destEE 
=>EE 
destEE #
.EE# $
HealthRecordIdEE$ 2
,EE2 3
optFF 
=>FF 
optFF 
.FF 
MapFromFF "
(FF" #
srcFF# &
=>FF' )
srcGG 
.GG 
HealthRecordGG $
!=GG% '
nullGG( ,
?HH 
srcHH 
.HH 
HealthRecordHH *
.HH* +
IdHH+ -
:II 
(II 
intII 
?II 
)II  
nullII  $
)II$ %
)II% &
;II& '
	CreateMapKK 
<KK  
CreateAppointmentDtoKK &
,KK& '
AppointmentKK( 3
>KK3 4
(KK4 5
)KK5 6
;KK6 7
}LL 
privateNN 
voidNN )
ConfigureHealthRecordMappingsNN .
(NN. /
)NN/ 0
{OO 
	CreateMapPP 
<PP 
HealthRecordPP 
,PP 
HealthRecordDtoPP  /
>PP/ 0
(PP0 1
)PP1 2
.QQ 
	ForMemberQQ 
(QQ 
destQQ 
=>QQ 
destQQ #
.QQ# $
	PatientIdQQ$ -
,QQ- .
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
nullSS' +
?TT 
srcTT 
.TT 
AppointmentTT )
.TT) *
	PatientIdTT* 3
:UU 
$numUU 
)UU 
)UU 
.VV 
	ForMemberVV 
(VV 
destVV 
=>VV 
destVV #
.VV# $
DoctorIdVV$ ,
,VV, -
optWW 
=>WW 
optWW 
.WW 
MapFromWW "
(WW" #
srcWW# &
=>WW' )
srcXX 
.XX 
AppointmentXX #
!=XX$ &
nullXX' +
?YY 
srcYY 
.YY 
AppointmentYY )
.YY) *
DoctorIdYY* 2
:ZZ 
$numZZ 
)ZZ 
)ZZ 
.[[ 
	ForMember[[ 
([[ 
dest[[ 
=>[[ 
dest[[ #
.[[# $
PatientName[[$ /
,[[/ 0
opt\\ 
=>\\ 
opt\\ 
.\\ 
MapFrom\\ "
(\\" #
src\\# &
=>\\' )
src]] 
.]] 
Appointment]] #
!=]]$ &
null]]' +
&&]], .
src]]/ 2
.]]2 3
Appointment]]3 >
.]]> ?
Patient]]? F
!=]]G I
null]]J N
?^^ 
src^^ 
.^^ 
Appointment^^ )
.^^) *
Patient^^* 1
.^^1 2
FullName^^2 :
:__ 
string__  
.__  !
Empty__! &
)__& '
)__' (
.`` 
	ForMember`` 
(`` 
dest`` 
=>`` 
dest`` #
.``# $

PatientAge``$ .
,``. /
optaa 
=>aa 
optaa 
.aa 
MapFromaa "
(aa" #
srcaa# &
=>aa' )
srcaa* -
.aa- .

PatientAgeaa. 8
)aa8 9
)aa9 :
.bb 
	ForMemberbb 
(bb 
destbb 
=>bb 
destbb #
.bb# $

DoctorNamebb$ .
,bb. /
optcc 
=>cc 
optcc 
.cc 
MapFromcc "
(cc" #
srccc# &
=>cc' )
srcdd 
.dd 
Appointmentdd #
!=dd$ &
nulldd' +
&&dd, .
srcdd/ 2
.dd2 3
Appointmentdd3 >
.dd> ?
Doctordd? E
!=ddF H
nullddI M
?ee 
srcee 
.ee 
Appointmentee )
.ee) *
Doctoree* 0
.ee0 1
FullNameee1 9
:ff 
stringff  
.ff  !
Emptyff! &
)ff& '
)ff' (
;ff( )
}gg 
}hh ‘
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
}-- ¥	
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
} …
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
}		 §
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
}		 ≤
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
}		 ¨
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
}		 ÷
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
} ¡

TC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Events\UserRegisteredEvent.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Events 
;  
public 
class 
UserRegisteredEvent  
{ 
public 

string 
UserType 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
public 

int 
ReferenceId 
{ 
get  
;  !
set" %
;% &
}' (
public		 

string		 
UserId		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
=		' (
string		) /
.		/ 0
Empty		0 5
;		5 6
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
=& '
string( .
.. /
Empty/ 4
;4 5
public 

DateTime 
RegisteredAtUtc #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} Ì	
WC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Events\AppointmentBookedEvent.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Events 
;  
public 
class "
AppointmentBookedEvent #
{ 
public 

int 
AppointmentId 
{ 
get "
;" #
set$ '
;' (
}) *
public 

int 
	PatientId 
{ 
get 
; 
set  #
;# $
}% &
public		 

int		 
DoctorId		 
{		 
get		 
;		 
set		 "
;		" #
}		$ %
public 

DateOnly 
ScheduledDate !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

TimeOnly 
TimeSlot 
{ 
get "
;" #
set$ '
;' (
}) *
public 

DateTime 

OccurredAt 
{  
get! $
;$ %
set& )
;) *
}+ ,
} Áñ
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
resetPassword	mmv É
:
mmÉ Ñ
true
mmÖ â
)
mmâ ä
;
mmä ã
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
$num	yy~ Ä
)
yyÄ Å
,
yyÅ Ç
$num
yyÉ á
,
yyá à
true
yyâ ç
)
yyç é
,
yyé è
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
AddYears	zz} Ö
(
zzÖ Ü
-
zzÜ á
$num
zzá à
)
zzà â
,
zzâ ä
$num
zzã è
,
zzè ê
false
zzë ñ
)
zzñ ó
,
zzó ò
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
AddYears	{{| Ñ
(
{{Ñ Ö
-
{{Ö Ü
$num
{{Ü á
)
{{á à
,
{{à â
$num
{{ä é
,
{{é è
true
{{ê î
)
{{î ï
,
{{ï ñ
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
.	|| Ä
AddYears
||Ä à
(
||à â
-
||â ä
$num
||ä ã
)
||ã å
,
||å ç
$num
||é í
,
||í ì
true
||î ò
)
||ò ô
,
||ô ö
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
AddYears	}}| Ñ
(
}}Ñ Ö
-
}}Ö Ü
$num
}}Ü à
)
}}à â
,
}}â ä
$num
}}ã è
,
}}è ê
true
}}ë ï
)
}}ï ñ
,
}}ñ ó
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
AddYears	~~z Ç
(
~~Ç É
-
~~É Ñ
$num
~~Ñ Ü
)
~~Ü á
,
~~á à
$num
~~â ç
,
~~ç é
false
~~è î
)
~~î ï
,
~~ï ñ
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
today	{ Ä
.
Ä Å
AddYears
Å â
(
â ä
-
ä ã
$num
ã ç
)
ç é
,
é è
$num
ê î
,
î ï
true
ñ ö
)
ö õ
,
õ ú
new
ÄÄ 

SeedDoctor
ÄÄ 
(
ÄÄ 
$str
ÄÄ )
,
ÄÄ) *
$str
ÄÄ+ H
,
ÄÄH I
$str
ÄÄJ V
,
ÄÄV W"
DoctorSpecialisation
ÄÄX l
.
ÄÄl m
Orthopaedics
ÄÄm y
,
ÄÄy z
todayÄÄ{ Ä
.ÄÄÄ Å
AddYearsÄÄÅ â
(ÄÄâ ä
-ÄÄä ã
$numÄÄã ç
)ÄÄç é
,ÄÄé è
$numÄÄê î
,ÄÄî ï
trueÄÄñ ö
)ÄÄö õ
,ÄÄõ ú
new
ÅÅ 

SeedDoctor
ÅÅ 
(
ÅÅ 
$str
ÅÅ *
,
ÅÅ* +
$str
ÅÅ, J
,
ÅÅJ K
$str
ÅÅL X
,
ÅÅX Y"
DoctorSpecialisation
ÅÅZ n
.
ÅÅn o

Pediatrics
ÅÅo y
,
ÅÅy z
todayÅÅ{ Ä
.ÅÅÄ Å
AddYearsÅÅÅ â
(ÅÅâ ä
-ÅÅä ã
$numÅÅã å
)ÅÅå ç
,ÅÅç é
$numÅÅè ì
,ÅÅì î
trueÅÅï ô
)ÅÅô ö
,ÅÅö õ
new
ÇÇ 

SeedDoctor
ÇÇ 
(
ÇÇ 
$str
ÇÇ )
,
ÇÇ) *
$str
ÇÇ+ H
,
ÇÇH I
$str
ÇÇJ V
,
ÇÇV W"
DoctorSpecialisation
ÇÇX l
.
ÇÇl m

Pediatrics
ÇÇm w
,
ÇÇw x
today
ÇÇy ~
.
ÇÇ~ 
AddYearsÇÇ á
(ÇÇá à
-ÇÇà â
$numÇÇâ ã
)ÇÇã å
,ÇÇå ç
$numÇÇé í
,ÇÇí ì
trueÇÇî ò
)ÇÇò ô
,ÇÇô ö
new
ÉÉ 

SeedDoctor
ÉÉ 
(
ÉÉ 
$str
ÉÉ *
,
ÉÉ* +
$str
ÉÉ, J
,
ÉÉJ K
$str
ÉÉL X
,
ÉÉX Y"
DoctorSpecialisation
ÉÉZ n
.
ÉÉn o
GeneralMedicine
ÉÉo ~
,
ÉÉ~ 
todayÉÉÄ Ö
.ÉÉÖ Ü
AddYearsÉÉÜ é
(ÉÉé è
-ÉÉè ê
$numÉÉê í
)ÉÉí ì
,ÉÉì î
$numÉÉï ô
,ÉÉô ö
trueÉÉõ ü
)ÉÉü †
,ÉÉ† °
new
ÑÑ 

SeedDoctor
ÑÑ 
(
ÑÑ 
$str
ÑÑ )
,
ÑÑ) *
$str
ÑÑ+ H
,
ÑÑH I
$str
ÑÑJ V
,
ÑÑV W"
DoctorSpecialisation
ÑÑX l
.
ÑÑl m
GeneralMedicine
ÑÑm |
,
ÑÑ| }
todayÑÑ~ É
.ÑÑÉ Ñ
AddYearsÑÑÑ å
(ÑÑå ç
-ÑÑç é
$numÑÑé ê
)ÑÑê ë
,ÑÑë í
$numÑÑì ó
,ÑÑó ò
trueÑÑô ù
)ÑÑù û
,ÑÑû ü
new
ÖÖ 

SeedDoctor
ÖÖ 
(
ÖÖ 
$str
ÖÖ )
,
ÖÖ) *
$str
ÖÖ+ H
,
ÖÖH I
$str
ÖÖJ V
,
ÖÖV W"
DoctorSpecialisation
ÖÖX l
.
ÖÖl m

Psychiatry
ÖÖm w
,
ÖÖw x
today
ÖÖy ~
.
ÖÖ~ 
AddYearsÖÖ á
(ÖÖá à
-ÖÖà â
$numÖÖâ ä
)ÖÖä ã
,ÖÖã å
$numÖÖç ë
,ÖÖë í
trueÖÖì ó
)ÖÖó ò
,ÖÖò ô
new
ÜÜ 

SeedDoctor
ÜÜ 
(
ÜÜ 
$str
ÜÜ )
,
ÜÜ) *
$str
ÜÜ+ H
,
ÜÜH I
$str
ÜÜJ V
,
ÜÜV W"
DoctorSpecialisation
ÜÜX l
.
ÜÜl m

Psychiatry
ÜÜm w
,
ÜÜw x
today
ÜÜy ~
.
ÜÜ~ 
AddYearsÜÜ á
(ÜÜá à
-ÜÜà â
$numÜÜâ ä
)ÜÜä ã
,ÜÜã å
$numÜÜç ë
,ÜÜë í
trueÜÜì ó
)ÜÜó ò
,ÜÜò ô
new
áá 

SeedDoctor
áá 
(
áá 
$str
áá (
,
áá( )
$str
áá* F
,
ááF G
$str
ááH T
,
ááT U"
DoctorSpecialisation
ááV j
.
ááj k
	Radiology
áák t
,
áát u
today
ááv {
.
áá{ |
AddYearsáá| Ñ
(ááÑ Ö
-ááÖ Ü
$numááÜ á
)ááá à
,ááà â
$numááä é
,ááé è
trueááê î
)ááî ï
,ááï ñ
new
àà 

SeedDoctor
àà 
(
àà 
$str
àà )
,
àà) *
$str
àà+ H
,
ààH I
$str
ààJ V
,
ààV W"
DoctorSpecialisation
ààX l
.
ààl m
	Radiology
ààm v
,
ààv w
today
ààx }
.
àà} ~
AddYearsàà~ Ü
(ààÜ á
-ààá à
$numààà ä
)ààä ã
,ààã å
$numààç ë
,ààë í
falseààì ò
)ààò ô
,ààô ö
new
ââ 

SeedDoctor
ââ 
(
ââ 
$str
ââ *
,
ââ* +
$str
ââ, Q
,
ââQ R
$str
ââS _
,
ââ_ `"
DoctorSpecialisation
ââa u
.
ââu v

Gynecologyââv Ä
,ââÄ Å
todayââÇ á
.ââá à
AddYearsââà ê
(ââê ë
-ââë í
$numââí î
)ââî ï
,ââï ñ
$numââó õ
,ââõ ú
trueââù °
)ââ° ¢
,ââ¢ £
new
ää 

SeedDoctor
ää 
(
ää 
$str
ää (
,
ää( )
$str
ää* M
,
ääM N
$str
ääO [
,
ää[ \"
DoctorSpecialisation
ää] q
.
ääq r

Gynecology
äär |
,
ää| }
todayää~ É
.ääÉ Ñ
AddYearsääÑ å
(ääå ç
-ääç é
$numääé è
)ääè ê
,ääê ë
$numääí ñ
,ääñ ó
trueääò ú
)ääú ù
,ääù û
new
ãã 

SeedDoctor
ãã 
(
ãã 
$str
ãã &
,
ãã& '
$str
ãã( I
,
ããI J
$str
ããK W
,
ããW X"
DoctorSpecialisation
ããY m
.
ããm n
ENT
ããn q
,
ããq r
today
ããs x
.
ããx y
AddYearsããy Å
(ããÅ Ç
-ããÇ É
$numããÉ Ö
)ããÖ Ü
,ããÜ á
$numããà å
,ããå ç
trueããé í
)ããí ì
,ããì î
new
åå 

SeedDoctor
åå 
(
åå 
$str
åå )
,
åå) *
$str
åå+ O
,
ååO P
$str
ååQ ]
,
åå] ^"
DoctorSpecialisation
åå_ s
.
åås t
ENT
ååt w
,
ååw x
today
ååy ~
.
åå~ 
AddYearsåå á
(ååá à
-ååà â
$numååâ ã
)ååã å
,ååå ç
$numååé í
,ååí ì
trueååî ò
)ååò ô
}
çç 	
;
çç	 

foreach
èè 
(
èè 
var
èè 
seed
èè 
in
èè 
doctorSeeds
èè (
)
èè( )
{
êê 	
var
ëë 
user
ëë 
=
ëë 
await
ëë %
EnsureUserWithRoleAsync
ëë 4
(
ëë4 5
userManager
ëë5 @
,
ëë@ A
seed
ëëB F
.
ëëF G
Email
ëëG L
,
ëëL M
seed
ëëN R
.
ëëR S
PhoneNumber
ëëS ^
,
ëë^ _
DoctorPassword
ëë` n
,
ëën o
AppRoles
ëëp x
.
ëëx y
Doctor
ëëy 
,ëë Ä
resetPasswordëëÅ é
:ëëé è
trueëëê î
)ëëî ï
;ëëï ñ
var
ìì 
doctor
ìì 
=
ìì 
new
ìì 
Doctor
ìì #
{
îî 
UserId
ïï 
=
ïï 
user
ïï 
.
ïï 
Id
ïï  
,
ïï  !
FullName
ññ 
=
ññ 
RemoveDoctorTitle
ññ ,
(
ññ, -
seed
ññ- 1
.
ññ1 2
FullName
ññ2 :
)
ññ: ;
,
ññ; <
Specialisation
óó 
=
óó  
seed
óó! %
.
óó% &
Specialisation
óó& 4
,
óó4 5
PracticeStartDate
òò !
=
òò" #
seed
òò$ (
.
òò( )
PracticeStartDate
òò) :
,
òò: ;
ConsultationFee
ôô 
=
ôô  !
seed
ôô" &
.
ôô& '
ConsultationFee
ôô' 6
,
ôô6 7
IsAvailable
öö 
=
öö 
seed
öö "
.
öö" #
IsAvailable
öö# .
}
õõ 
;
õõ 
await
ùù 
context
ùù 
.
ùù 
Doctors
ùù !
.
ùù! "
AddAsync
ùù" *
(
ùù* +
doctor
ùù+ 1
)
ùù1 2
;
ùù2 3
}
ûû 	
await
†† 
context
†† 
.
†† 
SaveChangesAsync
†† &
(
††& '
)
††' (
;
††( )
return
¢¢ 
await
¢¢ 
context
¢¢ 
.
¢¢ 
Doctors
¢¢ $
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
§§ 
OrderBy
§§ 
(
§§ 
doctor
§§ 
=>
§§ 
doctor
§§ %
.
§§% &
Id
§§& (
)
§§( )
.
•• 
ToListAsync
•• 
(
•• 
)
•• 
;
•• 
}
¶¶ 
private
®® 
static
®® 
async
®® 
Task
®® 
<
®® 
List
®® "
<
®®" #
Patient
®®# *
>
®®* +
>
®®+ ,
SeedPatientsAsync
®®- >
(
®®> ?
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
™™ 
context
™™ #
)
™™# $
{
´´ 
var
¨¨ 
today
¨¨ 
=
¨¨ 
DateOnly
¨¨ 
.
¨¨ 
FromDateTime
¨¨ )
(
¨¨) *
DateTime
¨¨* 2
.
¨¨2 3
Today
¨¨3 8
)
¨¨8 9
;
¨¨9 :
var
ÆÆ 
patientSeeds
ÆÆ 
=
ÆÆ 
new
ÆÆ 
[
ÆÆ 
]
ÆÆ  
{
ØØ 	
new
∞∞ 
SeedPatient
∞∞ 
(
∞∞ 
$str
∞∞ )
,
∞∞) *
$str
∞∞+ D
,
∞∞D E
$str
∞∞F R
,
∞∞R S
today
∞∞T Y
.
∞∞Y Z
AddYears
∞∞Z b
(
∞∞b c
-
∞∞c d
$num
∞∞d f
)
∞∞f g
.
∞∞g h
	AddMonths
∞∞h q
(
∞∞q r
-
∞∞r s
$num
∞∞s t
)
∞∞t u
,
∞∞u v
$str
∞∞w }
,
∞∞} ~
$str∞∞ ì
)∞∞ì î
,∞∞î ï
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
,±± Ä
$str±±Å ê
)±±ê ë
,±±ë í
new
≤≤ 
SeedPatient
≤≤ 
(
≤≤ 
$str
≤≤ (
,
≤≤( )
$str
≤≤* B
,
≤≤B C
$str
≤≤D P
,
≤≤P Q
today
≤≤R W
.
≤≤W X
AddYears
≤≤X `
(
≤≤` a
-
≤≤a b
$num
≤≤b d
)
≤≤d e
.
≤≤e f
	AddMonths
≤≤f o
(
≤≤o p
-
≤≤p q
$num
≤≤q r
)
≤≤r s
,
≤≤s t
$str
≤≤u {
,
≤≤{ |
$str≤≤} ç
)≤≤ç é
,≤≤é è
new
≥≥ 
SeedPatient
≥≥ 
(
≥≥ 
$str
≥≥ (
,
≥≥( )
$str
≥≥* B
,
≥≥B C
$str
≥≥D P
,
≥≥P Q
today
≥≥R W
.
≥≥W X
AddYears
≥≥X `
(
≥≥` a
-
≥≥a b
$num
≥≥b d
)
≥≥d e
.
≥≥e f
	AddMonths
≥≥f o
(
≥≥o p
-
≥≥p q
$num
≥≥q r
)
≥≥r s
,
≥≥s t
$str
≥≥u }
,
≥≥} ~
$str≥≥ ë
)≥≥ë í
,≥≥í ì
new
¥¥ 
SeedPatient
¥¥ 
(
¥¥ 
$str
¥¥ *
,
¥¥* +
$str
¥¥, F
,
¥¥F G
$str
¥¥H T
,
¥¥T U
today
¥¥V [
.
¥¥[ \
AddYears
¥¥\ d
(
¥¥d e
-
¥¥e f
$num
¥¥f h
)
¥¥h i
.
¥¥i j
	AddMonths
¥¥j s
(
¥¥s t
-
¥¥t u
$num
¥¥u v
)
¥¥v w
,
¥¥w x
$str
¥¥y 
,¥¥ Ä
$str¥¥Å ì
)¥¥ì î
,¥¥î ï
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
$strµµ í
)µµí ì
,µµì î
new
∂∂ 
SeedPatient
∂∂ 
(
∂∂ 
$str
∂∂ +
,
∂∂+ ,
$str
∂∂- H
,
∂∂H I
$str
∂∂J V
,
∂∂V W
today
∂∂X ]
.
∂∂] ^
AddYears
∂∂^ f
(
∂∂f g
-
∂∂g h
$num
∂∂h j
)
∂∂j k
.
∂∂k l
	AddMonths
∂∂l u
(
∂∂u v
-
∂∂v w
$num
∂∂w x
)
∂∂x y
,
∂∂y z
$str∂∂{ É
,∂∂É Ñ
$str∂∂Ö ó
)∂∂ó ò
,∂∂ò ô
new
∑∑ 
SeedPatient
∑∑ 
(
∑∑ 
$str
∑∑ )
,
∑∑) *
$str
∑∑+ D
,
∑∑D E
$str
∑∑F R
,
∑∑R S
today
∑∑T Y
.
∑∑Y Z
AddYears
∑∑Z b
(
∑∑b c
-
∑∑c d
$num
∑∑d f
)
∑∑f g
.
∑∑g h
	AddMonths
∑∑h q
(
∑∑q r
-
∑∑r s
$num
∑∑s t
)
∑∑t u
,
∑∑u v
$str
∑∑w }
,
∑∑} ~
$str∑∑ è
)∑∑è ê
,∑∑ê ë
new
∏∏ 
SeedPatient
∏∏ 
(
∏∏ 
$str
∏∏ '
,
∏∏' (
$str
∏∏) @
,
∏∏@ A
$str
∏∏B N
,
∏∏N O
today
∏∏P U
.
∏∏U V
AddYears
∏∏V ^
(
∏∏^ _
-
∏∏_ `
$num
∏∏` b
)
∏∏b c
.
∏∏c d
	AddMonths
∏∏d m
(
∏∏m n
-
∏∏n o
$num
∏∏o p
)
∏∏p q
,
∏∏q r
$str
∏∏s {
,
∏∏{ |
$str∏∏} é
)∏∏é è
,∏∏è ê
new
ππ 
SeedPatient
ππ 
(
ππ 
$str
ππ '
,
ππ' (
$str
ππ) @
,
ππ@ A
$str
ππB N
,
ππN O
today
ππP U
.
ππU V
AddYears
ππV ^
(
ππ^ _
-
ππ_ `
$num
ππ` b
)
ππb c
.
ππc d
	AddMonths
ππd m
(
ππm n
-
ππn o
$num
ππo p
)
ππp q
,
ππq r
$str
ππs y
,
ππy z
$strππ{ è
)ππè ê
,ππê ë
new
∫∫ 
SeedPatient
∫∫ 
(
∫∫ 
$str
∫∫ )
,
∫∫) *
$str
∫∫+ D
,
∫∫D E
$str
∫∫F R
,
∫∫R S
today
∫∫T Y
.
∫∫Y Z
AddYears
∫∫Z b
(
∫∫b c
-
∫∫c d
$num
∫∫d f
)
∫∫f g
.
∫∫g h
	AddMonths
∫∫h q
(
∫∫q r
-
∫∫r s
$num
∫∫s t
)
∫∫t u
,
∫∫u v
$str
∫∫w 
,∫∫ Ä
$str∫∫Å ô
)∫∫ô ö
,∫∫ö õ
new
ªª 
SeedPatient
ªª 
(
ªª 
$str
ªª )
,
ªª) *
$str
ªª+ D
,
ªªD E
$str
ªªF R
,
ªªR S
today
ªªT Y
.
ªªY Z
AddYears
ªªZ b
(
ªªb c
-
ªªc d
$num
ªªd f
)
ªªf g
.
ªªg h
	AddMonths
ªªh q
(
ªªq r
-
ªªr s
$num
ªªs t
)
ªªt u
,
ªªu v
$str
ªªw }
,
ªª} ~
$strªª è
)ªªè ê
,ªªê ë
new
ºº 
SeedPatient
ºº 
(
ºº 
$str
ºº .
,
ºº. /
$str
ºº0 N
,
ººN O
$str
ººP \
,
ºº\ ]
today
ºº^ c
.
ººc d
AddYears
ººd l
(
ººl m
-
ººm n
$num
ººn p
)
ººp q
.
ººq r
	AddMonths
ººr {
(
ºº{ |
-
ºº| }
$num
ºº} ~
)
ºº~ 
,ºº Ä
$strººÅ â
,ººâ ä
$strººã ú
)ººú ù
,ººù û
new
ΩΩ 
SeedPatient
ΩΩ 
(
ΩΩ 
$str
ΩΩ ,
,
ΩΩ, -
$str
ΩΩ. J
,
ΩΩJ K
$str
ΩΩL X
,
ΩΩX Y
today
ΩΩZ _
.
ΩΩ_ `
AddYears
ΩΩ` h
(
ΩΩh i
-
ΩΩi j
$num
ΩΩj l
)
ΩΩl m
.
ΩΩm n
	AddMonths
ΩΩn w
(
ΩΩw x
-
ΩΩx y
$num
ΩΩy z
)
ΩΩz {
,
ΩΩ{ |
$strΩΩ} É
,ΩΩÉ Ñ
$strΩΩÖ ó
)ΩΩó ò
,ΩΩò ô
new
ææ 
SeedPatient
ææ 
(
ææ 
$str
ææ )
,
ææ) *
$str
ææ+ D
,
ææD E
$str
ææF R
,
ææR S
today
ææT Y
.
ææY Z
AddYears
ææZ b
(
ææb c
-
ææc d
$num
ææd f
)
ææf g
.
ææg h
	AddMonths
ææh q
(
ææq r
-
æær s
$num
ææs t
)
ææt u
,
ææu v
$str
ææw 
,ææ Ä
$strææÅ î
)ææî ï
,ææï ñ
new
øø 
SeedPatient
øø 
(
øø 
$str
øø *
,
øø* +
$str
øø, F
,
øøF G
$str
øøH T
,
øøT U
today
øøV [
.
øø[ \
AddYears
øø\ d
(
øød e
-
øøe f
$num
øøf h
)
øøh i
.
øøi j
	AddMonths
øøj s
(
øøs t
-
øøt u
$num
øøu v
)
øøv w
,
øøw x
$str
øøy 
,øø Ä
$strøøÅ ï
)øøï ñ
,øøñ ó
new
¿¿ 
SeedPatient
¿¿ 
(
¿¿ 
$str
¿¿ &
,
¿¿& '
$str
¿¿( >
,
¿¿> ?
$str
¿¿@ L
,
¿¿L M
today
¿¿N S
.
¿¿S T
AddYears
¿¿T \
(
¿¿\ ]
-
¿¿] ^
$num
¿¿^ `
)
¿¿` a
.
¿¿a b
	AddMonths
¿¿b k
(
¿¿k l
-
¿¿l m
$num
¿¿m n
)
¿¿n o
,
¿¿o p
$str
¿¿q y
,
¿¿y z
$str¿¿{ ë
)¿¿ë í
,¿¿í ì
new
¡¡ 
SeedPatient
¡¡ 
(
¡¡ 
$str
¡¡ .
,
¡¡. /
$str
¡¡0 N
,
¡¡N O
$str
¡¡P \
,
¡¡\ ]
today
¡¡^ c
.
¡¡c d
AddYears
¡¡d l
(
¡¡l m
-
¡¡m n
$num
¡¡n p
)
¡¡p q
.
¡¡q r
	AddMonths
¡¡r {
(
¡¡{ |
-
¡¡| }
$num
¡¡} ~
)
¡¡~ 
,¡¡ Ä
$str¡¡Å á
,¡¡á à
$str¡¡â õ
)¡¡õ ú
}
¬¬ 	
;
¬¬	 

foreach
ƒƒ 
(
ƒƒ 
var
ƒƒ 
seed
ƒƒ 
in
ƒƒ 
patientSeeds
ƒƒ )
)
ƒƒ) *
{
≈≈ 	
var
∆∆ 
user
∆∆ 
=
∆∆ 
await
∆∆ %
EnsureUserWithRoleAsync
∆∆ 4
(
∆∆4 5
userManager
∆∆5 @
,
∆∆@ A
seed
∆∆B F
.
∆∆F G
Email
∆∆G L
,
∆∆L M
seed
∆∆N R
.
∆∆R S
PhoneNumber
∆∆S ^
,
∆∆^ _
PatientPassword
∆∆` o
,
∆∆o p
AppRoles
∆∆q y
.
∆∆y z
Patient∆∆z Å
,∆∆Å Ç
resetPassword∆∆É ê
:∆∆ê ë
true∆∆í ñ
)∆∆ñ ó
;∆∆ó ò
var
»» 
patient
»» 
=
»» 
new
»» 
Patient
»» %
{
…… 
UserId
   
=
   
user
   
.
   
Id
    
,
    !
FullName
ÀÀ 
=
ÀÀ 
seed
ÀÀ 
.
ÀÀ  
FullName
ÀÀ  (
,
ÀÀ( )
DateOfBirth
ÃÃ 
=
ÃÃ 
seed
ÃÃ "
.
ÃÃ" #
DateOfBirth
ÃÃ# .
,
ÃÃ. /
Gender
ÕÕ 
=
ÕÕ 
seed
ÕÕ 
.
ÕÕ 
Gender
ÕÕ $
,
ÕÕ$ %
Address
ŒŒ 
=
ŒŒ 
seed
ŒŒ 
.
ŒŒ 
Address
ŒŒ &
}
œœ 
;
œœ 
await
—— 
context
—— 
.
—— 
Patients
—— "
.
——" #
AddAsync
——# +
(
——+ ,
patient
——, 3
)
——3 4
;
——4 5
}
““ 	
await
‘‘ 
context
‘‘ 
.
‘‘ 
SaveChangesAsync
‘‘ &
(
‘‘& '
)
‘‘' (
;
‘‘( )
return
÷÷ 
await
÷÷ 
context
÷÷ 
.
÷÷ 
Patients
÷÷ %
.
◊◊ 
Include
◊◊ 
(
◊◊ 
patient
◊◊ 
=>
◊◊ 
patient
◊◊  '
.
◊◊' (
User
◊◊( ,
)
◊◊, -
.
ÿÿ 
OrderBy
ÿÿ 
(
ÿÿ 
patient
ÿÿ 
=>
ÿÿ 
patient
ÿÿ  '
.
ÿÿ' (
Id
ÿÿ( *
)
ÿÿ* +
.
ŸŸ 
ToListAsync
ŸŸ 
(
ŸŸ 
)
ŸŸ 
;
ŸŸ 
}
⁄⁄ 
private
‹‹ 
static
‹‹ 
async
‹‹ 
Task
‹‹ 3
%SeedAppointmentsAndHealthRecordsAsync
‹‹ C
(
‹‹C D!
HealthAxisDbContext
›› 
context
›› #
,
››# $
IReadOnlyList
ﬁﬁ 
<
ﬁﬁ 
Doctor
ﬁﬁ 
>
ﬁﬁ 
doctors
ﬁﬁ %
,
ﬁﬁ% &
IReadOnlyList
ﬂﬂ 
<
ﬂﬂ 
Patient
ﬂﬂ 
>
ﬂﬂ 
patients
ﬂﬂ '
)
ﬂﬂ' (
{
‡‡ 
if
·· 

(
·· 
doctors
·· 
.
·· 
Count
·· 
==
·· 
$num
·· 
||
·· !
patients
··" *
.
··* +
Count
··+ 0
==
··1 3
$num
··4 5
)
··5 6
{
‚‚ 	
return
„„ 
;
„„ 
}
‰‰ 	
var
ÊÊ 
today
ÊÊ 
=
ÊÊ 
DateOnly
ÊÊ 
.
ÊÊ 
FromDateTime
ÊÊ )
(
ÊÊ) *
DateTime
ÊÊ* 2
.
ÊÊ2 3
Today
ÊÊ3 8
)
ÊÊ8 9
;
ÊÊ9 :
var
ÁÁ 
doctorByEmail
ÁÁ 
=
ÁÁ 
doctors
ÁÁ #
.
ËË 
Where
ËË 
(
ËË 
doctor
ËË 
=>
ËË 
doctor
ËË #
.
ËË# $
User
ËË$ (
?
ËË( )
.
ËË) *
Email
ËË* /
is
ËË0 2
not
ËË3 6
null
ËË7 ;
)
ËË; <
.
ÈÈ 
ToDictionary
ÈÈ 
(
ÈÈ 
doctor
ÈÈ  
=>
ÈÈ! #
doctor
ÈÈ$ *
.
ÈÈ* +
User
ÈÈ+ /
!
ÈÈ/ 0
.
ÈÈ0 1
Email
ÈÈ1 6
!
ÈÈ6 7
,
ÈÈ7 8
StringComparer
ÈÈ9 G
.
ÈÈG H
OrdinalIgnoreCase
ÈÈH Y
)
ÈÈY Z
;
ÈÈZ [
var
ÎÎ $
doctorBySpecialisation
ÎÎ "
=
ÎÎ# $
doctors
ÎÎ% ,
.
ÏÏ 
GroupBy
ÏÏ 
(
ÏÏ 
doctor
ÏÏ 
=>
ÏÏ 
doctor
ÏÏ %
.
ÏÏ% &
Specialisation
ÏÏ& 4
)
ÏÏ4 5
.
ÌÌ 
ToDictionary
ÌÌ 
(
ÌÌ 
group
ÌÌ 
=>
ÌÌ  "
group
ÌÌ# (
.
ÌÌ( )
Key
ÌÌ) ,
,
ÌÌ, -
group
ÌÌ. 3
=>
ÌÌ4 6
group
ÌÌ7 <
.
ÌÌ< =
First
ÌÌ= B
(
ÌÌB C
)
ÌÌC D
)
ÌÌD E
;
ÌÌE F
var
ÔÔ 
appointmentSeeds
ÔÔ 
=
ÔÔ #
BuildAppointmentSeeds
ÔÔ 4
(
ÔÔ4 5
today
ÔÔ5 :
,
ÔÔ: ;
doctorByEmail
ÔÔ< I
,
ÔÔI J$
doctorBySpecialisation
ÔÔK a
,
ÔÔa b
patients
ÔÔc k
)
ÔÔk l
;
ÔÔl m
var
 .
 completedAppointmentsWithRecords
 ,
=
- .
new
/ 2
List
3 7
<
7 8
(
8 9
Appointment
9 D
Appointment
E P
,
P Q
SeedAppointment
R a
Seed
b f
)
f g
>
g h
(
h i
)
i j
;
j k
foreach
ÚÚ 
(
ÚÚ 
var
ÚÚ 
seed
ÚÚ 
in
ÚÚ 
appointmentSeeds
ÚÚ -
)
ÚÚ- .
{
ÛÛ 	
var
ÙÙ 
appointment
ÙÙ 
=
ÙÙ 
new
ÙÙ !
Appointment
ÙÙ" -
{
ıı 
	PatientId
ˆˆ 
=
ˆˆ 
seed
ˆˆ  
.
ˆˆ  !
Patient
ˆˆ! (
.
ˆˆ( )
Id
ˆˆ) +
,
ˆˆ+ ,
DoctorId
˜˜ 
=
˜˜ 
seed
˜˜ 
.
˜˜  
Doctor
˜˜  &
.
˜˜& '
Id
˜˜' )
,
˜˜) *
AppointmentDate
¯¯ 
=
¯¯  !
seed
¯¯" &
.
¯¯& '
Date
¯¯' +
,
¯¯+ ,
AppointmentTime
˘˘ 
=
˘˘  !
seed
˘˘" &
.
˘˘& '
Time
˘˘' +
,
˘˘+ ,
Status
˙˙ 
=
˙˙ 
seed
˙˙ 
.
˙˙ 
Status
˙˙ $
,
˙˙$ % 
CancellationReason
˚˚ "
=
˚˚# $
seed
˚˚% )
.
˚˚) * 
CancellationReason
˚˚* <
}
¸¸ 
;
¸¸ 
await
˛˛ 
context
˛˛ 
.
˛˛ 
Appointments
˛˛ &
.
˛˛& '
AddAsync
˛˛' /
(
˛˛/ 0
appointment
˛˛0 ;
)
˛˛; <
;
˛˛< =
if
ÄÄ 
(
ÄÄ 
seed
ÄÄ 
.
ÄÄ 
HealthRecord
ÄÄ !
!=
ÄÄ" $
null
ÄÄ% )
&&
ÄÄ* ,
seed
ÄÄ- 1
.
ÄÄ1 2
Status
ÄÄ2 8
==
ÄÄ9 ;
AppointmentStatus
ÄÄ< M
.
ÄÄM N
	Completed
ÄÄN W
)
ÄÄW X
{
ÅÅ .
 completedAppointmentsWithRecords
ÇÇ 0
.
ÇÇ0 1
Add
ÇÇ1 4
(
ÇÇ4 5
(
ÇÇ5 6
appointment
ÇÇ6 A
,
ÇÇA B
seed
ÇÇC G
)
ÇÇG H
)
ÇÇH I
;
ÇÇI J
}
ÉÉ 
}
ÑÑ 	
await
ÜÜ 
context
ÜÜ 
.
ÜÜ 
SaveChangesAsync
ÜÜ &
(
ÜÜ& '
)
ÜÜ' (
;
ÜÜ( )
foreach
àà 
(
àà 
var
àà 
(
àà 
appointment
àà !
,
àà! "
seed
àà# '
)
àà' (
in
àà) +.
 completedAppointmentsWithRecords
àà, L
)
ààL M
{
ââ 	
var
ää 

seedRecord
ää 
=
ää 
seed
ää !
.
ää! "
HealthRecord
ää" .
!
ää. /
;
ää/ 0
await
åå 
context
åå 
.
åå 
HealthRecords
åå '
.
åå' (
AddAsync
åå( 0
(
åå0 1
new
åå1 4
HealthRecord
åå5 A
{
çç 
AppointmentId
éé 
=
éé 
appointment
éé  +
.
éé+ ,
Id
éé, .
,
éé. /

PatientAge
èè 
=
èè 
CalculateAge
èè )
(
èè) *
seed
èè* .
.
èè. /
Patient
èè/ 6
.
èè6 7
DateOfBirth
èè7 B
,
èèB C
appointment
èèD O
.
èèO P
AppointmentDate
èèP _
)
èè_ `
,
èè` a
	VisitDate
êê 
=
êê 

seedRecord
êê &
.
êê& '
	VisitDate
êê' 0
,
êê0 1
	Diagnosis
ëë 
=
ëë 

seedRecord
ëë &
.
ëë& '
	Diagnosis
ëë' 0
,
ëë0 1
Prescription
íí 
=
íí 

seedRecord
íí )
.
íí) *
Prescription
íí* 6
,
íí6 7
Notes
ìì 
=
ìì 

seedRecord
ìì "
.
ìì" #
Notes
ìì# (
}
îî 
)
îî 
;
îî 
}
ïï 	
await
óó 
context
óó 
.
óó 
SaveChangesAsync
óó &
(
óó& '
)
óó' (
;
óó( )
}
òò 
private
öö 
static
öö 
IReadOnlyList
öö  
<
öö  !
SeedAppointment
öö! 0
>
öö0 1#
BuildAppointmentSeeds
öö2 G
(
ööG H
DateOnly
õõ 
today
õõ 
,
õõ !
IReadOnlyDictionary
úú 
<
úú 
string
úú "
,
úú" #
Doctor
úú$ *
>
úú* +
doctorByEmail
úú, 9
,
úú9 :!
IReadOnlyDictionary
ùù 
<
ùù "
DoctorSpecialisation
ùù 0
,
ùù0 1
Doctor
ùù2 8
>
ùù8 9$
doctorBySpecialisation
ùù: P
,
ùùP Q
IReadOnlyList
ûû 
<
ûû 
Patient
ûû 
>
ûû 
patients
ûû '
)
ûû' (
{
üü 
Doctor
†† 
Anjali
†† 
(
†† 
)
†† 
=>
†† 
doctorByEmail
†† (
[
††( ) 
PrimaryDoctorEmail
††) ;
]
††; <
;
††< =
Doctor
°° 
Doctor
°° 
(
°° "
DoctorSpecialisation
°° *
specialisation
°°+ 9
)
°°9 :
=>
°°; =$
doctorBySpecialisation
°°> T
[
°°T U
specialisation
°°U c
]
°°c d
;
°°d e
Patient
¢¢ 
Patient
¢¢ 
(
¢¢ 
int
¢¢ 
index
¢¢ !
)
¢¢! "
=>
¢¢# %
patients
¢¢& .
[
¢¢. /
index
¢¢/ 4
%
¢¢5 6
patients
¢¢7 ?
.
¢¢? @
Count
¢¢@ E
]
¢¢E F
;
¢¢F G
return
§§ 
[
•• 	
new
ßß 
(
ßß 
Patient
ßß 
(
ßß 
$num
ßß 
)
ßß 
,
ßß 
Anjali
ßß "
(
ßß" #
)
ßß# $
,
ßß$ %
today
ßß& +
.
ßß+ ,
AddDays
ßß, 3
(
ßß3 4
-
ßß4 5
$num
ßß5 8
)
ßß8 9
,
ßß9 :
new
ßß; >
TimeOnly
ßß? G
(
ßßG H
$num
ßßH I
,
ßßI J
$num
ßßK L
)
ßßL M
,
ßßM N
AppointmentStatus
ßßO `
.
ßß` a
	Completed
ßßa j
,
ßßj k
null
ßßl p
,
ßßp q
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
®®4 7
)
®®7 8
,
®®8 9
$str
®®: \
,
®®\ ]
$str®®^ ö
,®®ö õ
$str®®ú  
)®®  À
)®®À Ã
,®®Ã Õ
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
™™ 
SeedHealthRecord
™™ $
(
™™$ %
today
™™% *
.
™™* +
AddDays
™™+ 2
(
™™2 3
-
™™3 4
$num
™™4 7
)
™™7 8
,
™™8 9
$str
™™: Q
,
™™Q R
$str™™S á
,™™á à
$str™™â ¬
)™™¬ √
)™™√ ƒ
,™™ƒ ≈
new
´´ 
(
´´ 
Patient
´´ 
(
´´ 
$num
´´ 
)
´´ 
,
´´ 
Anjali
´´ "
(
´´" #
)
´´# $
,
´´$ %
today
´´& +
.
´´+ ,
AddDays
´´, 3
(
´´3 4
-
´´4 5
$num
´´5 7
)
´´7 8
,
´´8 9
new
´´: =
TimeOnly
´´> F
(
´´F G
$num
´´G I
,
´´I J
$num
´´K L
)
´´L M
,
´´M N
AppointmentStatus
´´O `
.
´´` a
	Completed
´´a j
,
´´j k
null
´´l p
,
´´p q
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
¨¨4 6
)
¨¨6 7
,
¨¨7 8
$str
¨¨9 Z
,
¨¨Z [
$str¨¨\ û
,¨¨û ü
$str¨¨† Á
)¨¨Á Ë
)¨¨Ë È
,¨¨È Í
new
≠≠ 
(
≠≠ 
Patient
≠≠ 
(
≠≠ 
$num
≠≠ 
)
≠≠ 
,
≠≠ 
Anjali
≠≠ "
(
≠≠" #
)
≠≠# $
,
≠≠$ %
today
≠≠& +
.
≠≠+ ,
AddDays
≠≠, 3
(
≠≠3 4
-
≠≠4 5
$num
≠≠5 7
)
≠≠7 8
,
≠≠8 9
new
≠≠: =
TimeOnly
≠≠> F
(
≠≠F G
$num
≠≠G H
,
≠≠H I
$num
≠≠J L
)
≠≠L M
,
≠≠M N
AppointmentStatus
≠≠O `
.
≠≠` a
	Completed
≠≠a j
,
≠≠j k
null
≠≠l p
,
≠≠p q
new
ÆÆ 
SeedHealthRecord
ÆÆ $
(
ÆÆ$ %
today
ÆÆ% *
.
ÆÆ* +
AddDays
ÆÆ+ 2
(
ÆÆ2 3
-
ÆÆ3 4
$num
ÆÆ4 6
)
ÆÆ6 7
,
ÆÆ7 8
$str
ÆÆ9 Q
,
ÆÆQ R
$strÆÆS Ñ
,ÆÆÑ Ö
$strÆÆÜ Õ
)ÆÆÕ Œ
)ÆÆŒ œ
,ÆÆœ –
new
ØØ 
(
ØØ 
Patient
ØØ 
(
ØØ 
$num
ØØ 
)
ØØ 
,
ØØ 
Anjali
ØØ "
(
ØØ" #
)
ØØ# $
,
ØØ$ %
today
ØØ& +
.
ØØ+ ,
AddDays
ØØ, 3
(
ØØ3 4
-
ØØ4 5
$num
ØØ5 7
)
ØØ7 8
,
ØØ8 9
new
ØØ: =
TimeOnly
ØØ> F
(
ØØF G
$num
ØØG I
,
ØØI J
$num
ØØK L
)
ØØL M
,
ØØM N
AppointmentStatus
ØØO `
.
ØØ` a
	Completed
ØØa j
,
ØØj k
null
ØØl p
,
ØØp q
new
∞∞ 
SeedHealthRecord
∞∞ $
(
∞∞$ %
today
∞∞% *
.
∞∞* +
AddDays
∞∞+ 2
(
∞∞2 3
-
∞∞3 4
$num
∞∞4 6
)
∞∞6 7
,
∞∞7 8
$str
∞∞9 R
,
∞∞R S
$str∞∞T á
,∞∞á à
$str∞∞â –
)∞∞– —
)∞∞— “
,∞∞“ ”
new
≤≤ 
(
≤≤ 
Patient
≤≤ 
(
≤≤ 
$num
≤≤ 
)
≤≤ 
,
≤≤ 
Anjali
≤≤ "
(
≤≤" #
)
≤≤# $
,
≤≤$ %
today
≤≤& +
.
≤≤+ ,
AddDays
≤≤, 3
(
≤≤3 4
-
≤≤4 5
$num
≤≤5 8
)
≤≤8 9
,
≤≤9 :
new
≤≤; >
TimeOnly
≤≤? G
(
≤≤G H
$num
≤≤H J
,
≤≤J K
$num
≤≤L M
)
≤≤M N
,
≤≤N O
AppointmentStatus
≤≤P a
.
≤≤a b
	Completed
≤≤b k
,
≤≤k l
null
≤≤m q
,
≤≤q r
new
≥≥ 
SeedHealthRecord
≥≥ $
(
≥≥$ %
today
≥≥% *
.
≥≥* +
AddDays
≥≥+ 2
(
≥≥2 3
-
≥≥3 4
$num
≥≥4 7
)
≥≥7 8
,
≥≥8 9
$str
≥≥: ]
,
≥≥] ^
$str≥≥_ å
,≥≥å ç
$str≥≥é À
)≥≥À Ã
)≥≥Ã Õ
,≥≥Õ Œ
new
¥¥ 
(
¥¥ 
Patient
¥¥ 
(
¥¥ 
$num
¥¥ 
)
¥¥ 
,
¥¥ 
Anjali
¥¥ "
(
¥¥" #
)
¥¥# $
,
¥¥$ %
today
¥¥& +
.
¥¥+ ,
AddDays
¥¥, 3
(
¥¥3 4
-
¥¥4 5
$num
¥¥5 7
)
¥¥7 8
,
¥¥8 9
new
¥¥: =
TimeOnly
¥¥> F
(
¥¥F G
$num
¥¥G I
,
¥¥I J
$num
¥¥K M
)
¥¥M N
,
¥¥N O
AppointmentStatus
¥¥P a
.
¥¥a b
	Completed
¥¥b k
,
¥¥k l
null
¥¥m q
,
¥¥q r
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
$strµµT Å
,µµÅ Ç
$strµµÉ Ω
)µµΩ æ
)µµæ ø
,µµø ¿
new
∂∂ 
(
∂∂ 
Patient
∂∂ 
(
∂∂ 
$num
∂∂ 
)
∂∂ 
,
∂∂ 
Anjali
∂∂ "
(
∂∂" #
)
∂∂# $
,
∂∂$ %
today
∂∂& +
.
∂∂+ ,
AddDays
∂∂, 3
(
∂∂3 4
-
∂∂4 5
$num
∂∂5 7
)
∂∂7 8
,
∂∂8 9
new
∂∂: =
TimeOnly
∂∂> F
(
∂∂F G
$num
∂∂G I
,
∂∂I J
$num
∂∂K L
)
∂∂L M
,
∂∂M N
AppointmentStatus
∂∂O `
.
∂∂` a
	Completed
∂∂a j
,
∂∂j k
null
∂∂l p
,
∂∂p q
new
∑∑ 
SeedHealthRecord
∑∑ $
(
∑∑$ %
today
∑∑% *
.
∑∑* +
AddDays
∑∑+ 2
(
∑∑2 3
-
∑∑3 4
$num
∑∑4 6
)
∑∑6 7
,
∑∑7 8
$str
∑∑9 Q
,
∑∑Q R
$str∑∑S ã
,∑∑ã å
$str∑∑ç Ã
)∑∑Ã Õ
)∑∑Õ Œ
,∑∑Œ œ
new
ππ 
(
ππ 
Patient
ππ 
(
ππ 
$num
ππ 
)
ππ 
,
ππ 
Anjali
ππ "
(
ππ" #
)
ππ# $
,
ππ$ %
today
ππ& +
.
ππ+ ,
AddDays
ππ, 3
(
ππ3 4
-
ππ4 5
$num
ππ5 8
)
ππ8 9
,
ππ9 :
new
ππ; >
TimeOnly
ππ? G
(
ππG H
$num
ππH J
,
ππJ K
$num
ππL M
)
ππM N
,
ππN O
AppointmentStatus
ππP a
.
ππa b
	Completed
ππb k
,
ππk l
null
ππm q
,
ππq r
new
∫∫ 
SeedHealthRecord
∫∫ $
(
∫∫$ %
today
∫∫% *
.
∫∫* +
AddDays
∫∫+ 2
(
∫∫2 3
-
∫∫3 4
$num
∫∫4 7
)
∫∫7 8
,
∫∫8 9
$str
∫∫: T
,
∫∫T U
$str∫∫V ê
,∫∫ê ë
$str∫∫í º
)∫∫º Ω
)∫∫Ω æ
,∫∫æ ø
new
ªª 
(
ªª 
Patient
ªª 
(
ªª 
$num
ªª 
)
ªª 
,
ªª 
Anjali
ªª "
(
ªª" #
)
ªª# $
,
ªª$ %
today
ªª& +
.
ªª+ ,
AddDays
ªª, 3
(
ªª3 4
-
ªª4 5
$num
ªª5 7
)
ªª7 8
,
ªª8 9
new
ªª: =
TimeOnly
ªª> F
(
ªªF G
$num
ªªG I
,
ªªI J
$num
ªªK M
)
ªªM N
,
ªªN O
AppointmentStatus
ªªP a
.
ªªa b
	Completed
ªªb k
,
ªªk l
null
ªªm q
,
ªªq r
new
ºº 
SeedHealthRecord
ºº $
(
ºº$ %
today
ºº% *
.
ºº* +
AddDays
ºº+ 2
(
ºº2 3
-
ºº3 4
$num
ºº4 6
)
ºº6 7
,
ºº7 8
$str
ºº9 O
,
ººO P
$str
ººQ z
,
ººz {
$strºº| ≠
)ºº≠ Æ
)ººÆ Ø
,ººØ ∞
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
Anjali
ΩΩ "
(
ΩΩ" #
)
ΩΩ# $
,
ΩΩ$ %
today
ΩΩ& +
.
ΩΩ+ ,
AddDays
ΩΩ, 3
(
ΩΩ3 4
-
ΩΩ4 5
$num
ΩΩ5 7
)
ΩΩ7 8
,
ΩΩ8 9
new
ΩΩ: =
TimeOnly
ΩΩ> F
(
ΩΩF G
$num
ΩΩG I
,
ΩΩI J
$num
ΩΩK L
)
ΩΩL M
,
ΩΩM N
AppointmentStatus
ΩΩO `
.
ΩΩ` a
	Completed
ΩΩa j
,
ΩΩj k
null
ΩΩl p
,
ΩΩp q
new
ææ 
SeedHealthRecord
ææ $
(
ææ$ %
today
ææ% *
.
ææ* +
AddDays
ææ+ 2
(
ææ2 3
-
ææ3 4
$num
ææ4 6
)
ææ6 7
,
ææ7 8
$str
ææ9 W
,
ææW X
$strææY â
,ææâ ä
$strææã ∞
)ææ∞ ±
)ææ± ≤
,ææ≤ ≥
new
¿¿ 
(
¿¿ 
Patient
¿¿ 
(
¿¿ 
$num
¿¿ 
)
¿¿ 
,
¿¿ 
Anjali
¿¿ "
(
¿¿" #
)
¿¿# $
,
¿¿$ %
today
¿¿& +
.
¿¿+ ,
AddDays
¿¿, 3
(
¿¿3 4
-
¿¿4 5
$num
¿¿5 8
)
¿¿8 9
,
¿¿9 :
new
¿¿; >
TimeOnly
¿¿? G
(
¿¿G H
$num
¿¿H J
,
¿¿J K
$num
¿¿L M
)
¿¿M N
,
¿¿N O
AppointmentStatus
¿¿P a
.
¿¿a b
	Completed
¿¿b k
,
¿¿k l
null
¿¿m q
,
¿¿q r
new
¡¡ 
SeedHealthRecord
¡¡ $
(
¡¡$ %
today
¡¡% *
.
¡¡* +
AddDays
¡¡+ 2
(
¡¡2 3
-
¡¡3 4
$num
¡¡4 7
)
¡¡7 8
,
¡¡8 9
$str
¡¡: ]
,
¡¡] ^
$str¡¡_ â
,¡¡â ä
$str¡¡ã ∑
)¡¡∑ ∏
)¡¡∏ π
,¡¡π ∫
new
¬¬ 
(
¬¬ 
Patient
¬¬ 
(
¬¬ 
$num
¬¬ 
)
¬¬ 
,
¬¬ 
Anjali
¬¬ "
(
¬¬" #
)
¬¬# $
,
¬¬$ %
today
¬¬& +
.
¬¬+ ,
AddDays
¬¬, 3
(
¬¬3 4
-
¬¬4 5
$num
¬¬5 7
)
¬¬7 8
,
¬¬8 9
new
¬¬: =
TimeOnly
¬¬> F
(
¬¬F G
$num
¬¬G I
,
¬¬I J
$num
¬¬K M
)
¬¬M N
,
¬¬N O
AppointmentStatus
¬¬P a
.
¬¬a b
	Completed
¬¬b k
,
¬¬k l
null
¬¬m q
,
¬¬q r
new
√√ 
SeedHealthRecord
√√ $
(
√√$ %
today
√√% *
.
√√* +
AddDays
√√+ 2
(
√√2 3
-
√√3 4
$num
√√4 6
)
√√6 7
,
√√7 8
$str
√√9 _
,
√√_ `
$str√√a î
,√√î ï
$str√√ñ ≥
)√√≥ ¥
)√√¥ µ
,√√µ ∂
new
ƒƒ 
(
ƒƒ 
Patient
ƒƒ 
(
ƒƒ 
$num
ƒƒ 
)
ƒƒ 
,
ƒƒ 
Anjali
ƒƒ "
(
ƒƒ" #
)
ƒƒ# $
,
ƒƒ$ %
today
ƒƒ& +
.
ƒƒ+ ,
AddDays
ƒƒ, 3
(
ƒƒ3 4
-
ƒƒ4 5
$num
ƒƒ5 7
)
ƒƒ7 8
,
ƒƒ8 9
new
ƒƒ: =
TimeOnly
ƒƒ> F
(
ƒƒF G
$num
ƒƒG I
,
ƒƒI J
$num
ƒƒK L
)
ƒƒL M
,
ƒƒM N
AppointmentStatus
ƒƒO `
.
ƒƒ` a
	Completed
ƒƒa j
,
ƒƒj k
null
ƒƒl p
,
ƒƒp q
new
≈≈ 
SeedHealthRecord
≈≈ $
(
≈≈$ %
today
≈≈% *
.
≈≈* +
AddDays
≈≈+ 2
(
≈≈2 3
-
≈≈3 4
$num
≈≈4 6
)
≈≈6 7
,
≈≈7 8
$str
≈≈9 ^
,
≈≈^ _
$str
≈≈` ~
,
≈≈~ 
$str≈≈Ä π
)≈≈π ∫
)≈≈∫ ª
,≈≈ª º
new
∆∆ 
(
∆∆ 
Patient
∆∆ 
(
∆∆ 
$num
∆∆ 
)
∆∆ 
,
∆∆ 
Anjali
∆∆ "
(
∆∆" #
)
∆∆# $
,
∆∆$ %
today
∆∆& +
.
∆∆+ ,
AddDays
∆∆, 3
(
∆∆3 4
-
∆∆4 5
$num
∆∆5 6
)
∆∆6 7
,
∆∆7 8
new
∆∆9 <
TimeOnly
∆∆= E
(
∆∆E F
$num
∆∆F H
,
∆∆H I
$num
∆∆J L
)
∆∆L M
,
∆∆M N
AppointmentStatus
∆∆O `
.
∆∆` a
	Completed
∆∆a j
,
∆∆j k
null
∆∆l p
,
∆∆p q
new
«« 
SeedHealthRecord
«« $
(
««$ %
today
««% *
.
««* +
AddDays
««+ 2
(
««2 3
-
««3 4
$num
««4 5
)
««5 6
,
««6 7
$str
««8 X
,
««X Y
$str««Z å
,««å ç
$str««é π
)««π ∫
)««∫ ª
,««ª º
new
…… 
(
…… 
Patient
…… 
(
…… 
$num
…… 
)
…… 
,
…… 
Anjali
…… "
(
……" #
)
……# $
,
……$ %
today
……& +
,
……+ ,
new
……- 0
TimeOnly
……1 9
(
……9 :
$num
……: ;
,
……; <
$num
……= >
)
……> ?
,
……? @
AppointmentStatus
……A R
.
……R S
	Confirmed
……S \
,
……\ ]
null
……^ b
,
……b c
null
……d h
)
……h i
,
……i j
new
   
(
   
Patient
   
(
   
$num
   
)
   
,
   
Anjali
   "
(
  " #
)
  # $
,
  $ %
today
  & +
,
  + ,
new
  - 0
TimeOnly
  1 9
(
  9 :
$num
  : <
,
  < =
$num
  > ?
)
  ? @
,
  @ A
AppointmentStatus
  B S
.
  S T
Pending
  T [
,
  [ \
null
  ] a
,
  a b
null
  c g
)
  g h
,
  h i
new
ÀÀ 
(
ÀÀ 
Patient
ÀÀ 
(
ÀÀ 
$num
ÀÀ 
)
ÀÀ 
,
ÀÀ 
Anjali
ÀÀ "
(
ÀÀ" #
)
ÀÀ# $
,
ÀÀ$ %
today
ÀÀ& +
,
ÀÀ+ ,
new
ÀÀ- 0
TimeOnly
ÀÀ1 9
(
ÀÀ9 :
$num
ÀÀ: <
,
ÀÀ< =
$num
ÀÀ> ?
)
ÀÀ? @
,
ÀÀ@ A
AppointmentStatus
ÀÀB S
.
ÀÀS T
	Confirmed
ÀÀT ]
,
ÀÀ] ^
null
ÀÀ_ c
,
ÀÀc d
null
ÀÀe i
)
ÀÀi j
,
ÀÀj k
new
ÃÃ 
(
ÃÃ 
Patient
ÃÃ 
(
ÃÃ 
$num
ÃÃ 
)
ÃÃ 
,
ÃÃ 
Anjali
ÃÃ "
(
ÃÃ" #
)
ÃÃ# $
,
ÃÃ$ %
today
ÃÃ& +
,
ÃÃ+ ,
new
ÃÃ- 0
TimeOnly
ÃÃ1 9
(
ÃÃ9 :
$num
ÃÃ: <
,
ÃÃ< =
$num
ÃÃ> ?
)
ÃÃ? @
,
ÃÃ@ A
AppointmentStatus
ÃÃB S
.
ÃÃS T
Pending
ÃÃT [
,
ÃÃ[ \
null
ÃÃ] a
,
ÃÃa b
null
ÃÃc g
)
ÃÃg h
,
ÃÃh i
new
ÕÕ 
(
ÕÕ 
Patient
ÕÕ 
(
ÕÕ 
$num
ÕÕ 
)
ÕÕ 
,
ÕÕ 
Anjali
ÕÕ "
(
ÕÕ" #
)
ÕÕ# $
,
ÕÕ$ %
today
ÕÕ& +
,
ÕÕ+ ,
new
ÕÕ- 0
TimeOnly
ÕÕ1 9
(
ÕÕ9 :
$num
ÕÕ: <
,
ÕÕ< =
$num
ÕÕ> ?
)
ÕÕ? @
,
ÕÕ@ A
AppointmentStatus
ÕÕB S
.
ÕÕS T
	Cancelled
ÕÕT ]
,
ÕÕ] ^
$strÕÕ_ ï
,ÕÕï ñ
nullÕÕó õ
)ÕÕõ ú
,ÕÕú ù
new
œœ 
(
œœ 
Patient
œœ 
(
œœ 
$num
œœ 
)
œœ 
,
œœ 
Anjali
œœ "
(
œœ" #
)
œœ# $
,
œœ$ %
today
œœ& +
.
œœ+ ,
AddDays
œœ, 3
(
œœ3 4
$num
œœ4 5
)
œœ5 6
,
œœ6 7
new
œœ8 ;
TimeOnly
œœ< D
(
œœD E
$num
œœE F
,
œœF G
$num
œœH I
)
œœI J
,
œœJ K
AppointmentStatus
œœL ]
.
œœ] ^
Pending
œœ^ e
,
œœe f
null
œœg k
,
œœk l
null
œœm q
)
œœq r
,
œœr s
new
–– 
(
–– 
Patient
–– 
(
–– 
$num
–– 
)
–– 
,
–– 
Anjali
–– "
(
––" #
)
––# $
,
––$ %
today
––& +
.
––+ ,
AddDays
––, 3
(
––3 4
$num
––4 5
)
––5 6
,
––6 7
new
––8 ;
TimeOnly
––< D
(
––D E
$num
––E G
,
––G H
$num
––I J
)
––J K
,
––K L
AppointmentStatus
––M ^
.
––^ _
	Confirmed
––_ h
,
––h i
null
––j n
,
––n o
null
––p t
)
––t u
,
––u v
new
—— 
(
—— 
Patient
—— 
(
—— 
$num
—— 
)
—— 
,
—— 
Anjali
—— "
(
——" #
)
——# $
,
——$ %
today
——& +
.
——+ ,
AddDays
——, 3
(
——3 4
$num
——4 5
)
——5 6
,
——6 7
new
——8 ;
TimeOnly
——< D
(
——D E
$num
——E G
,
——G H
$num
——I J
)
——J K
,
——K L
AppointmentStatus
——M ^
.
——^ _
Pending
——_ f
,
——f g
null
——h l
,
——l m
null
——n r
)
——r s
,
——s t
new
““ 
(
““ 
Patient
““ 
(
““ 
$num
““ 
)
““ 
,
““ 
Anjali
““ "
(
““" #
)
““# $
,
““$ %
today
““& +
.
““+ ,
AddDays
““, 3
(
““3 4
$num
““4 5
)
““5 6
,
““6 7
new
““8 ;
TimeOnly
““< D
(
““D E
$num
““E G
,
““G H
$num
““I J
)
““J K
,
““K L
AppointmentStatus
““M ^
.
““^ _
	Confirmed
““_ h
,
““h i
null
““j n
,
““n o
null
““p t
)
““t u
,
““u v
new
”” 
(
”” 
Patient
”” 
(
”” 
$num
”” 
)
”” 
,
”” 
Anjali
”” "
(
””" #
)
””# $
,
””$ %
today
””& +
.
””+ ,
AddDays
””, 3
(
””3 4
$num
””4 5
)
””5 6
,
””6 7
new
””8 ;
TimeOnly
””< D
(
””D E
$num
””E G
,
””G H
$num
””I J
)
””J K
,
””K L
AppointmentStatus
””M ^
.
””^ _
Pending
””_ f
,
””f g
null
””h l
,
””l m
null
””n r
)
””r s
,
””s t
new
‘‘ 
(
‘‘ 
Patient
‘‘ 
(
‘‘ 
$num
‘‘ 
)
‘‘ 
,
‘‘ 
Anjali
‘‘ #
(
‘‘# $
)
‘‘$ %
,
‘‘% &
today
‘‘' ,
.
‘‘, -
AddDays
‘‘- 4
(
‘‘4 5
$num
‘‘5 7
)
‘‘7 8
,
‘‘8 9
new
‘‘: =
TimeOnly
‘‘> F
(
‘‘F G
$num
‘‘G H
,
‘‘H I
$num
‘‘J L
)
‘‘L M
,
‘‘M N
AppointmentStatus
‘‘O `
.
‘‘` a
	Confirmed
‘‘a j
,
‘‘j k
null
‘‘l p
,
‘‘p q
null
‘‘r v
)
‘‘v w
,
‘‘w x
new
’’ 
(
’’ 
Patient
’’ 
(
’’ 
$num
’’ 
)
’’ 
,
’’ 
Anjali
’’ #
(
’’# $
)
’’$ %
,
’’% &
today
’’' ,
.
’’, -
AddDays
’’- 4
(
’’4 5
$num
’’5 7
)
’’7 8
,
’’8 9
new
’’: =
TimeOnly
’’> F
(
’’F G
$num
’’G I
,
’’I J
$num
’’K M
)
’’M N
,
’’N O
AppointmentStatus
’’P a
.
’’a b
Pending
’’b i
,
’’i j
null
’’k o
,
’’o p
null
’’q u
)
’’u v
,
’’v w
new
÷÷ 
(
÷÷ 
Patient
÷÷ 
(
÷÷ 
$num
÷÷ 
)
÷÷ 
,
÷÷ 
Anjali
÷÷ #
(
÷÷# $
)
÷÷$ %
,
÷÷% &
today
÷÷' ,
.
÷÷, -
AddDays
÷÷- 4
(
÷÷4 5
$num
÷÷5 7
)
÷÷7 8
,
÷÷8 9
new
÷÷: =
TimeOnly
÷÷> F
(
÷÷F G
$num
÷÷G I
,
÷÷I J
$num
÷÷K M
)
÷÷M N
,
÷÷N O
AppointmentStatus
÷÷P a
.
÷÷a b
	Confirmed
÷÷b k
,
÷÷k l
null
÷÷m q
,
÷÷q r
null
÷÷s w
)
÷÷w x
,
÷÷x y
new
ŸŸ 
(
ŸŸ 
Patient
ŸŸ 
(
ŸŸ 
$num
ŸŸ 
)
ŸŸ 
,
ŸŸ 
Doctor
ŸŸ "
(
ŸŸ" #"
DoctorSpecialisation
ŸŸ# 7
.
ŸŸ7 8
Dermatology
ŸŸ8 C
)
ŸŸC D
,
ŸŸD E
today
ŸŸF K
.
ŸŸK L
AddDays
ŸŸL S
(
ŸŸS T
-
ŸŸT U
$num
ŸŸU V
)
ŸŸV W
,
ŸŸW X
new
ŸŸY \
TimeOnly
ŸŸ] e
(
ŸŸe f
$num
ŸŸf g
,
ŸŸg h
$num
ŸŸi j
)
ŸŸj k
,
ŸŸk l
AppointmentStatus
ŸŸm ~
.
ŸŸ~ 
	CompletedŸŸ à
,ŸŸà â
nullŸŸä é
,ŸŸé è
new
⁄⁄ 
SeedHealthRecord
⁄⁄ $
(
⁄⁄$ %
today
⁄⁄% *
.
⁄⁄* +
AddDays
⁄⁄+ 2
(
⁄⁄2 3
-
⁄⁄3 4
$num
⁄⁄4 5
)
⁄⁄5 6
,
⁄⁄6 7
$str
⁄⁄8 Q
,
⁄⁄Q R
$str⁄⁄S â
,⁄⁄â ä
$str⁄⁄ã ©
)⁄⁄© ™
)⁄⁄™ ´
,⁄⁄´ ¨
new
€€ 
(
€€ 
Patient
€€ 
(
€€ 
$num
€€ 
)
€€ 
,
€€ 
Doctor
€€ "
(
€€" #"
DoctorSpecialisation
€€# 7
.
€€7 8
	Neurology
€€8 A
)
€€A B
,
€€B C
today
€€D I
.
€€I J
AddDays
€€J Q
(
€€Q R
-
€€R S
$num
€€S T
)
€€T U
,
€€U V
new
€€W Z
TimeOnly
€€[ c
(
€€c d
$num
€€d f
,
€€f g
$num
€€h i
)
€€i j
,
€€j k
AppointmentStatus
€€l }
.
€€} ~
	Completed€€~ á
,€€á à
null€€â ç
,€€ç é
new
‹‹ 
SeedHealthRecord
‹‹ $
(
‹‹$ %
today
‹‹% *
.
‹‹* +
AddDays
‹‹+ 2
(
‹‹2 3
-
‹‹3 4
$num
‹‹4 5
)
‹‹5 6
,
‹‹6 7
$str
‹‹8 I
,
‹‹I J
$str
‹‹K n
,
‹‹n o
$str‹‹p â
)‹‹â ä
)‹‹ä ã
,‹‹ã å
new
›› 
(
›› 
Patient
›› 
(
›› 
$num
›› 
)
›› 
,
›› 
Doctor
›› "
(
››" #"
DoctorSpecialisation
››# 7
.
››7 8
Orthopaedics
››8 D
)
››D E
,
››E F
today
››G L
.
››L M
AddDays
››M T
(
››T U
-
››U V
$num
››V W
)
››W X
,
››X Y
new
››Z ]
TimeOnly
››^ f
(
››f g
$num
››g i
,
››i j
$num
››k l
)
››l m
,
››m n 
AppointmentStatus››o Ä
.››Ä Å
	Completed››Å ä
,››ä ã
null››å ê
,››ê ë
new
ﬁﬁ 
SeedHealthRecord
ﬁﬁ $
(
ﬁﬁ$ %
today
ﬁﬁ% *
.
ﬁﬁ* +
AddDays
ﬁﬁ+ 2
(
ﬁﬁ2 3
-
ﬁﬁ3 4
$num
ﬁﬁ4 5
)
ﬁﬁ5 6
,
ﬁﬁ6 7
$str
ﬁﬁ8 K
,
ﬁﬁK L
$str
ﬁﬁM y
,
ﬁﬁy z
$strﬁﬁ{ §
)ﬁﬁ§ •
)ﬁﬁ• ¶
,ﬁﬁ¶ ß
new
ﬂﬂ 
(
ﬂﬂ 
Patient
ﬂﬂ 
(
ﬂﬂ 
$num
ﬂﬂ 
)
ﬂﬂ 
,
ﬂﬂ 
Doctor
ﬂﬂ "
(
ﬂﬂ" #"
DoctorSpecialisation
ﬂﬂ# 7
.
ﬂﬂ7 8

Pediatrics
ﬂﬂ8 B
)
ﬂﬂB C
,
ﬂﬂC D
today
ﬂﬂE J
.
ﬂﬂJ K
AddDays
ﬂﬂK R
(
ﬂﬂR S
-
ﬂﬂS T
$num
ﬂﬂT U
)
ﬂﬂU V
,
ﬂﬂV W
new
ﬂﬂX [
TimeOnly
ﬂﬂ\ d
(
ﬂﬂd e
$num
ﬂﬂe g
,
ﬂﬂg h
$num
ﬂﬂi j
)
ﬂﬂj k
,
ﬂﬂk l
AppointmentStatus
ﬂﬂm ~
.
ﬂﬂ~ 
	Completedﬂﬂ à
,ﬂﬂà â
nullﬂﬂä é
,ﬂﬂé è
new
‡‡ 
SeedHealthRecord
‡‡ $
(
‡‡$ %
today
‡‡% *
.
‡‡* +
AddDays
‡‡+ 2
(
‡‡2 3
-
‡‡3 4
$num
‡‡4 5
)
‡‡5 6
,
‡‡6 7
$str
‡‡8 [
,
‡‡[ \
$str
‡‡] |
,
‡‡| }
$str‡‡~ ©
)‡‡© ™
)‡‡™ ´
,‡‡´ ¨
new
·· 
(
·· 
Patient
·· 
(
·· 
$num
·· 
)
·· 
,
·· 
Doctor
·· #
(
··# $"
DoctorSpecialisation
··$ 8
.
··8 9
GeneralMedicine
··9 H
)
··H I
,
··I J
today
··K P
.
··P Q
AddDays
··Q X
(
··X Y
-
··Y Z
$num
··Z \
)
··\ ]
,
··] ^
new
··_ b
TimeOnly
··c k
(
··k l
$num
··l n
,
··n o
$num
··p q
)
··q r
,
··r s 
AppointmentStatus··t Ö
.··Ö Ü
	Completed··Ü è
,··è ê
null··ë ï
,··ï ñ
new
‚‚ 
SeedHealthRecord
‚‚ $
(
‚‚$ %
today
‚‚% *
.
‚‚* +
AddDays
‚‚+ 2
(
‚‚2 3
-
‚‚3 4
$num
‚‚4 6
)
‚‚6 7
,
‚‚7 8
$str
‚‚9 R
,
‚‚R S
$str‚‚T Å
,‚‚Å Ç
$str‚‚É ú
)‚‚ú ù
)‚‚ù û
,‚‚û ü
new
„„ 
(
„„ 
Patient
„„ 
(
„„ 
$num
„„ 
)
„„ 
,
„„ 
Doctor
„„ #
(
„„# $"
DoctorSpecialisation
„„$ 8
.
„„8 9

Psychiatry
„„9 C
)
„„C D
,
„„D E
today
„„F K
.
„„K L
AddDays
„„L S
(
„„S T
-
„„T U
$num
„„U W
)
„„W X
,
„„X Y
new
„„Z ]
TimeOnly
„„^ f
(
„„f g
$num
„„g i
,
„„i j
$num
„„k l
)
„„l m
,
„„m n 
AppointmentStatus„„o Ä
.„„Ä Å
	Completed„„Å ä
,„„ä ã
null„„å ê
,„„ê ë
new
‰‰ 
SeedHealthRecord
‰‰ $
(
‰‰$ %
today
‰‰% *
.
‰‰* +
AddDays
‰‰+ 2
(
‰‰2 3
-
‰‰3 4
$num
‰‰4 6
)
‰‰6 7
,
‰‰7 8
$str
‰‰9 K
,
‰‰K L
$str
‰‰M x
,
‰‰x y
$str‰‰z §
)‰‰§ •
)‰‰• ¶
,‰‰¶ ß
new
ÂÂ 
(
ÂÂ 
Patient
ÂÂ 
(
ÂÂ 
$num
ÂÂ 
)
ÂÂ 
,
ÂÂ 
Doctor
ÂÂ #
(
ÂÂ# $"
DoctorSpecialisation
ÂÂ$ 8
.
ÂÂ8 9
	Radiology
ÂÂ9 B
)
ÂÂB C
,
ÂÂC D
today
ÂÂE J
.
ÂÂJ K
AddDays
ÂÂK R
(
ÂÂR S
-
ÂÂS T
$num
ÂÂT V
)
ÂÂV W
,
ÂÂW X
new
ÂÂY \
TimeOnly
ÂÂ] e
(
ÂÂe f
$num
ÂÂf g
,
ÂÂg h
$num
ÂÂi k
)
ÂÂk l
,
ÂÂl m
AppointmentStatus
ÂÂn 
.ÂÂ Ä
	CompletedÂÂÄ â
,ÂÂâ ä
nullÂÂã è
,ÂÂè ê
new
ÊÊ 
SeedHealthRecord
ÊÊ $
(
ÊÊ$ %
today
ÊÊ% *
.
ÊÊ* +
AddDays
ÊÊ+ 2
(
ÊÊ2 3
-
ÊÊ3 4
$num
ÊÊ4 6
)
ÊÊ6 7
,
ÊÊ7 8
$str
ÊÊ9 V
,
ÊÊV W
$str
ÊÊX s
,
ÊÊs t
$strÊÊu ó
)ÊÊó ò
)ÊÊò ô
,ÊÊô ö
new
ÁÁ 
(
ÁÁ 
Patient
ÁÁ 
(
ÁÁ 
$num
ÁÁ 
)
ÁÁ 
,
ÁÁ 
Doctor
ÁÁ #
(
ÁÁ# $"
DoctorSpecialisation
ÁÁ$ 8
.
ÁÁ8 9

Gynecology
ÁÁ9 C
)
ÁÁC D
,
ÁÁD E
today
ÁÁF K
.
ÁÁK L
AddDays
ÁÁL S
(
ÁÁS T
-
ÁÁT U
$num
ÁÁU W
)
ÁÁW X
,
ÁÁX Y
new
ÁÁZ ]
TimeOnly
ÁÁ^ f
(
ÁÁf g
$num
ÁÁg i
,
ÁÁi j
$num
ÁÁk m
)
ÁÁm n
,
ÁÁn o 
AppointmentStatusÁÁp Å
.ÁÁÅ Ç
	CompletedÁÁÇ ã
,ÁÁã å
nullÁÁç ë
,ÁÁë í
new
ËË 
SeedHealthRecord
ËË $
(
ËË$ %
today
ËË% *
.
ËË* +
AddDays
ËË+ 2
(
ËË2 3
-
ËË3 4
$num
ËË4 6
)
ËË6 7
,
ËË7 8
$str
ËË9 U
,
ËËU V
$str
ËËW ~
,
ËË~ 
$strËËÄ ∞
)ËË∞ ±
)ËË± ≤
,ËË≤ ≥
new
ÈÈ 
(
ÈÈ 
Patient
ÈÈ 
(
ÈÈ 
$num
ÈÈ 
)
ÈÈ 
,
ÈÈ 
Doctor
ÈÈ #
(
ÈÈ# $"
DoctorSpecialisation
ÈÈ$ 8
.
ÈÈ8 9
ENT
ÈÈ9 <
)
ÈÈ< =
,
ÈÈ= >
today
ÈÈ? D
.
ÈÈD E
AddDays
ÈÈE L
(
ÈÈL M
-
ÈÈM N
$num
ÈÈN P
)
ÈÈP Q
,
ÈÈQ R
new
ÈÈS V
TimeOnly
ÈÈW _
(
ÈÈ_ `
$num
ÈÈ` b
,
ÈÈb c
$num
ÈÈd f
)
ÈÈf g
,
ÈÈg h
AppointmentStatus
ÈÈi z
.
ÈÈz {
	CompletedÈÈ{ Ñ
,ÈÈÑ Ö
nullÈÈÜ ä
,ÈÈä ã
new
ÍÍ 
SeedHealthRecord
ÍÍ $
(
ÍÍ$ %
today
ÍÍ% *
.
ÍÍ* +
AddDays
ÍÍ+ 2
(
ÍÍ2 3
-
ÍÍ3 4
$num
ÍÍ4 6
)
ÍÍ6 7
,
ÍÍ7 8
$str
ÍÍ9 I
,
ÍÍI J
$str
ÍÍK j
,
ÍÍj k
$strÍÍl ú
)ÍÍú ù
)ÍÍù û
,ÍÍû ü
new
ÎÎ 
(
ÎÎ 
Patient
ÎÎ 
(
ÎÎ 
$num
ÎÎ 
)
ÎÎ 
,
ÎÎ 
Doctor
ÎÎ #
(
ÎÎ# $"
DoctorSpecialisation
ÎÎ$ 8
.
ÎÎ8 9
GeneralMedicine
ÎÎ9 H
)
ÎÎH I
,
ÎÎI J
today
ÎÎK P
.
ÎÎP Q
AddDays
ÎÎQ X
(
ÎÎX Y
-
ÎÎY Z
$num
ÎÎZ \
)
ÎÎ\ ]
,
ÎÎ] ^
new
ÎÎ_ b
TimeOnly
ÎÎc k
(
ÎÎk l
$num
ÎÎl m
,
ÎÎm n
$num
ÎÎo q
)
ÎÎq r
,
ÎÎr s 
AppointmentStatusÎÎt Ö
.ÎÎÖ Ü
	CompletedÎÎÜ è
,ÎÎè ê
nullÎÎë ï
,ÎÎï ñ
new
ÏÏ 
SeedHealthRecord
ÏÏ $
(
ÏÏ$ %
today
ÏÏ% *
.
ÏÏ* +
AddDays
ÏÏ+ 2
(
ÏÏ2 3
-
ÏÏ3 4
$num
ÏÏ4 6
)
ÏÏ6 7
,
ÏÏ7 8
$str
ÏÏ9 Q
,
ÏÏQ R
$strÏÏS à
,ÏÏà â
$strÏÏä ∏
)ÏÏ∏ π
)ÏÏπ ∫
,ÏÏ∫ ª
new
ÌÌ 
(
ÌÌ 
Patient
ÌÌ 
(
ÌÌ 
$num
ÌÌ 
)
ÌÌ 
,
ÌÌ 
Doctor
ÌÌ #
(
ÌÌ# $"
DoctorSpecialisation
ÌÌ$ 8
.
ÌÌ8 9

Psychiatry
ÌÌ9 C
)
ÌÌC D
,
ÌÌD E
today
ÌÌF K
.
ÌÌK L
AddDays
ÌÌL S
(
ÌÌS T
-
ÌÌT U
$num
ÌÌU W
)
ÌÌW X
,
ÌÌX Y
new
ÌÌZ ]
TimeOnly
ÌÌ^ f
(
ÌÌf g
$num
ÌÌg i
,
ÌÌi j
$num
ÌÌk m
)
ÌÌm n
,
ÌÌn o 
AppointmentStatusÌÌp Å
.ÌÌÅ Ç
	CompletedÌÌÇ ã
,ÌÌã å
nullÌÌç ë
,ÌÌë í
new
ÓÓ 
SeedHealthRecord
ÓÓ $
(
ÓÓ$ %
today
ÓÓ% *
.
ÓÓ* +
AddDays
ÓÓ+ 2
(
ÓÓ2 3
-
ÓÓ3 4
$num
ÓÓ4 6
)
ÓÓ6 7
,
ÓÓ7 8
$str
ÓÓ9 S
,
ÓÓS T
$strÓÓU ã
,ÓÓã å
$strÓÓç ≥
)ÓÓ≥ ¥
)ÓÓ¥ µ
,ÓÓµ ∂
new
ÔÔ 
(
ÔÔ 
Patient
ÔÔ 
(
ÔÔ 
$num
ÔÔ 
)
ÔÔ 
,
ÔÔ 
Doctor
ÔÔ #
(
ÔÔ# $"
DoctorSpecialisation
ÔÔ$ 8
.
ÔÔ8 9
ENT
ÔÔ9 <
)
ÔÔ< =
,
ÔÔ= >
today
ÔÔ? D
.
ÔÔD E
AddDays
ÔÔE L
(
ÔÔL M
-
ÔÔM N
$num
ÔÔN P
)
ÔÔP Q
,
ÔÔQ R
new
ÔÔS V
TimeOnly
ÔÔW _
(
ÔÔ_ `
$num
ÔÔ` b
,
ÔÔb c
$num
ÔÔd f
)
ÔÔf g
,
ÔÔg h
AppointmentStatus
ÔÔi z
.
ÔÔz {
	CompletedÔÔ{ Ñ
,ÔÔÑ Ö
nullÔÔÜ ä
,ÔÔä ã
new
 
SeedHealthRecord
 $
(
$ %
today
% *
.
* +
AddDays
+ 2
(
2 3
-
3 4
$num
4 6
)
6 7
,
7 8
$str
9 U
,
U V
$strW Ç
,Ç É
$strÑ ∏
)∏ π
)π ∫
,∫ ª
new
ÚÚ 
(
ÚÚ 
Patient
ÚÚ 
(
ÚÚ 
$num
ÚÚ 
)
ÚÚ 
,
ÚÚ 
Doctor
ÚÚ #
(
ÚÚ# $"
DoctorSpecialisation
ÚÚ$ 8
.
ÚÚ8 9
Dermatology
ÚÚ9 D
)
ÚÚD E
,
ÚÚE F
today
ÚÚG L
,
ÚÚL M
new
ÚÚN Q
TimeOnly
ÚÚR Z
(
ÚÚZ [
$num
ÚÚ[ \
,
ÚÚ\ ]
$num
ÚÚ^ `
)
ÚÚ` a
,
ÚÚa b
AppointmentStatus
ÚÚc t
.
ÚÚt u
	Confirmed
ÚÚu ~
,
ÚÚ~ 
nullÚÚÄ Ñ
,ÚÚÑ Ö
nullÚÚÜ ä
)ÚÚä ã
,ÚÚã å
new
ÛÛ 
(
ÛÛ 
Patient
ÛÛ 
(
ÛÛ 
$num
ÛÛ 
)
ÛÛ 
,
ÛÛ 
Doctor
ÛÛ #
(
ÛÛ# $"
DoctorSpecialisation
ÛÛ$ 8
.
ÛÛ8 9
GeneralMedicine
ÛÛ9 H
)
ÛÛH I
,
ÛÛI J
today
ÛÛK P
,
ÛÛP Q
new
ÛÛR U
TimeOnly
ÛÛV ^
(
ÛÛ^ _
$num
ÛÛ_ a
,
ÛÛa b
$num
ÛÛc e
)
ÛÛe f
,
ÛÛf g
AppointmentStatus
ÛÛh y
.
ÛÛy z
PendingÛÛz Å
,ÛÛÅ Ç
nullÛÛÉ á
,ÛÛá à
nullÛÛâ ç
)ÛÛç é
,ÛÛé è
new
ÙÙ 
(
ÙÙ 
Patient
ÙÙ 
(
ÙÙ 
$num
ÙÙ 
)
ÙÙ 
,
ÙÙ 
Doctor
ÙÙ #
(
ÙÙ# $"
DoctorSpecialisation
ÙÙ$ 8
.
ÙÙ8 9
ENT
ÙÙ9 <
)
ÙÙ< =
,
ÙÙ= >
today
ÙÙ? D
,
ÙÙD E
new
ÙÙF I
TimeOnly
ÙÙJ R
(
ÙÙR S
$num
ÙÙS U
,
ÙÙU V
$num
ÙÙW Y
)
ÙÙY Z
,
ÙÙZ [
AppointmentStatus
ÙÙ\ m
.
ÙÙm n
	Cancelled
ÙÙn w
,
ÙÙw x
$strÙÙy £
,ÙÙ£ §
nullÙÙ• ©
)ÙÙ© ™
,ÙÙ™ ´
new
ˆˆ 
(
ˆˆ 
Patient
ˆˆ 
(
ˆˆ 
$num
ˆˆ 
)
ˆˆ 
,
ˆˆ 
Doctor
ˆˆ #
(
ˆˆ# $"
DoctorSpecialisation
ˆˆ$ 8
.
ˆˆ8 9
	Neurology
ˆˆ9 B
)
ˆˆB C
,
ˆˆC D
today
ˆˆE J
.
ˆˆJ K
AddDays
ˆˆK R
(
ˆˆR S
$num
ˆˆS T
)
ˆˆT U
,
ˆˆU V
new
ˆˆW Z
TimeOnly
ˆˆ[ c
(
ˆˆc d
$num
ˆˆd e
,
ˆˆe f
$num
ˆˆg i
)
ˆˆi j
,
ˆˆj k
AppointmentStatus
ˆˆl }
.
ˆˆ} ~
Pendingˆˆ~ Ö
,ˆˆÖ Ü
nullˆˆá ã
,ˆˆã å
nullˆˆç ë
)ˆˆë í
,ˆˆí ì
new
˜˜ 
(
˜˜ 
Patient
˜˜ 
(
˜˜ 
$num
˜˜ 
)
˜˜ 
,
˜˜ 
Doctor
˜˜ #
(
˜˜# $"
DoctorSpecialisation
˜˜$ 8
.
˜˜8 9
Orthopaedics
˜˜9 E
)
˜˜E F
,
˜˜F G
today
˜˜H M
.
˜˜M N
AddDays
˜˜N U
(
˜˜U V
$num
˜˜V W
)
˜˜W X
,
˜˜X Y
new
˜˜Z ]
TimeOnly
˜˜^ f
(
˜˜f g
$num
˜˜g i
,
˜˜i j
$num
˜˜k m
)
˜˜m n
,
˜˜n o 
AppointmentStatus˜˜p Å
.˜˜Å Ç
	Confirmed˜˜Ç ã
,˜˜ã å
null˜˜ç ë
,˜˜ë í
null˜˜ì ó
)˜˜ó ò
,˜˜ò ô
new
¯¯ 
(
¯¯ 
Patient
¯¯ 
(
¯¯ 
$num
¯¯ 
)
¯¯ 
,
¯¯ 
Doctor
¯¯ #
(
¯¯# $"
DoctorSpecialisation
¯¯$ 8
.
¯¯8 9

Pediatrics
¯¯9 C
)
¯¯C D
,
¯¯D E
today
¯¯F K
.
¯¯K L
AddDays
¯¯L S
(
¯¯S T
$num
¯¯T U
)
¯¯U V
,
¯¯V W
new
¯¯X [
TimeOnly
¯¯\ d
(
¯¯d e
$num
¯¯e g
,
¯¯g h
$num
¯¯i k
)
¯¯k l
,
¯¯l m
AppointmentStatus
¯¯n 
.¯¯ Ä
Pending¯¯Ä á
,¯¯á à
null¯¯â ç
,¯¯ç é
null¯¯è ì
)¯¯ì î
,¯¯î ï
new
˘˘ 
(
˘˘ 
Patient
˘˘ 
(
˘˘ 
$num
˘˘ 
)
˘˘ 
,
˘˘ 
Doctor
˘˘ #
(
˘˘# $"
DoctorSpecialisation
˘˘$ 8
.
˘˘8 9

Psychiatry
˘˘9 C
)
˘˘C D
,
˘˘D E
today
˘˘F K
.
˘˘K L
AddDays
˘˘L S
(
˘˘S T
$num
˘˘T U
)
˘˘U V
,
˘˘V W
new
˘˘X [
TimeOnly
˘˘\ d
(
˘˘d e
$num
˘˘e g
,
˘˘g h
$num
˘˘i k
)
˘˘k l
,
˘˘l m
AppointmentStatus
˘˘n 
.˘˘ Ä
	Confirmed˘˘Ä â
,˘˘â ä
null˘˘ã è
,˘˘è ê
null˘˘ë ï
)˘˘ï ñ
,˘˘ñ ó
new
˙˙ 
(
˙˙ 
Patient
˙˙ 
(
˙˙ 
$num
˙˙ 
)
˙˙ 
,
˙˙ 
Doctor
˙˙ #
(
˙˙# $"
DoctorSpecialisation
˙˙$ 8
.
˙˙8 9

Gynecology
˙˙9 C
)
˙˙C D
,
˙˙D E
today
˙˙F K
.
˙˙K L
AddDays
˙˙L S
(
˙˙S T
$num
˙˙T U
)
˙˙U V
,
˙˙V W
new
˙˙X [
TimeOnly
˙˙\ d
(
˙˙d e
$num
˙˙e g
,
˙˙g h
$num
˙˙i k
)
˙˙k l
,
˙˙l m
AppointmentStatus
˙˙n 
.˙˙ Ä
Pending˙˙Ä á
,˙˙á à
null˙˙â ç
,˙˙ç é
null˙˙è ì
)˙˙ì î
,˙˙î ï
new
˚˚ 
(
˚˚ 
Patient
˚˚ 
(
˚˚ 
$num
˚˚ 
)
˚˚ 
,
˚˚ 
Doctor
˚˚ "
(
˚˚" #"
DoctorSpecialisation
˚˚# 7
.
˚˚7 8
	Radiology
˚˚8 A
)
˚˚A B
,
˚˚B C
today
˚˚D I
.
˚˚I J
AddDays
˚˚J Q
(
˚˚Q R
$num
˚˚R T
)
˚˚T U
,
˚˚U V
new
˚˚W Z
TimeOnly
˚˚[ c
(
˚˚c d
$num
˚˚d f
,
˚˚f g
$num
˚˚h i
)
˚˚i j
,
˚˚j k
AppointmentStatus
˚˚l }
.
˚˚} ~
	Confirmed˚˚~ á
,˚˚á à
null˚˚â ç
,˚˚ç é
null˚˚è ì
)˚˚ì î
,˚˚î ï
new
˝˝ 
(
˝˝ 
Patient
˝˝ 
(
˝˝ 
$num
˝˝ 
)
˝˝ 
,
˝˝ 
Doctor
˝˝ #
(
˝˝# $"
DoctorSpecialisation
˝˝$ 8
.
˝˝8 9

Cardiology
˝˝9 C
)
˝˝C D
,
˝˝D E
today
˝˝F K
.
˝˝K L
AddDays
˝˝L S
(
˝˝S T
-
˝˝T U
$num
˝˝U W
)
˝˝W X
,
˝˝X Y
new
˝˝Z ]
TimeOnly
˝˝^ f
(
˝˝f g
$num
˝˝g h
,
˝˝h i
$num
˝˝j k
)
˝˝k l
,
˝˝l m
AppointmentStatus
˝˝n 
.˝˝ Ä
	Cancelled˝˝Ä â
,˝˝â ä
$str˝˝ã ƒ
,˝˝ƒ ≈
null˝˝∆  
)˝˝  À
,˝˝À Ã
new
˛˛ 
(
˛˛ 
Patient
˛˛ 
(
˛˛ 
$num
˛˛ 
)
˛˛ 
,
˛˛ 
Doctor
˛˛ #
(
˛˛# $"
DoctorSpecialisation
˛˛$ 8
.
˛˛8 9
Dermatology
˛˛9 D
)
˛˛D E
,
˛˛E F
today
˛˛G L
.
˛˛L M
AddDays
˛˛M T
(
˛˛T U
-
˛˛U V
$num
˛˛V X
)
˛˛X Y
,
˛˛Y Z
new
˛˛[ ^
TimeOnly
˛˛_ g
(
˛˛g h
$num
˛˛h j
,
˛˛j k
$num
˛˛l m
)
˛˛m n
,
˛˛n o 
AppointmentStatus˛˛p Å
.˛˛Å Ç
	Cancelled˛˛Ç ã
,˛˛ã å
$str˛˛ç µ
,˛˛µ ∂
null˛˛∑ ª
)˛˛ª º
]
ˇˇ 	
;
ˇˇ	 

}
ÄÄ 
private
ÇÇ 
static
ÇÇ 
async
ÇÇ 
Task
ÇÇ 
<
ÇÇ 
IdentityUser
ÇÇ *
>
ÇÇ* +%
EnsureUserWithRoleAsync
ÇÇ, C
(
ÇÇC D
UserManager
ÉÉ 
<
ÉÉ 
IdentityUser
ÉÉ  
>
ÉÉ  !
userManager
ÉÉ" -
,
ÉÉ- .
string
ÑÑ 
email
ÑÑ 
,
ÑÑ 
string
ÖÖ 
phoneNumber
ÖÖ 
,
ÖÖ 
string
ÜÜ 
password
ÜÜ 
,
ÜÜ 
string
áá 
role
áá 
,
áá 
bool
àà 
resetPassword
àà 
=
àà 
false
àà "
)
àà" #
{
ââ 
var
ää 
existingUser
ää 
=
ää 
await
ää  
userManager
ää! ,
.
ää, -
FindByEmailAsync
ää- =
(
ää= >
email
ää> C
)
ääC D
;
ääD E
if
åå 

(
åå 
existingUser
åå 
==
åå 
null
åå  
)
åå  !
{
çç 	
existingUser
éé 
=
éé 
new
éé 
IdentityUser
éé +
{
èè 
UserName
êê 
=
êê 
email
êê  
,
êê  !
Email
ëë 
=
ëë 
email
ëë 
,
ëë 
PhoneNumber
íí 
=
íí 
phoneNumber
íí )
,
íí) *
EmailConfirmed
ìì 
=
ìì  
true
ìì! %
}
îî 
;
îî 
var
ññ 
result
ññ 
=
ññ 
await
ññ 
userManager
ññ *
.
ññ* +
CreateAsync
ññ+ 6
(
ññ6 7
existingUser
ññ7 C
,
ññC D
password
ññE M
)
ññM N
;
ññN O
if
òò 
(
òò 
!
òò 
result
òò 
.
òò 
	Succeeded
òò !
)
òò! "
{
ôô 
var
öö 
errors
öö 
=
öö 
string
öö #
.
öö# $
Join
öö$ (
(
öö( )
$str
öö) ,
,
öö, -
result
öö. 4
.
öö4 5
Errors
öö5 ;
.
öö; <
Select
öö< B
(
ööB C
error
ööC H
=>
ööI K
error
ööL Q
.
ööQ R
Description
ööR ]
)
öö] ^
)
öö^ _
;
öö_ `
throw
õõ 
new
õõ '
InvalidOperationException
õõ 3
(
õõ3 4
$"
õõ4 6
$str
õõ6 J
{
õõJ K
email
õõK P
}
õõP Q
$str
õõQ S
{
õõS T
errors
õõT Z
}
õõZ [
"
õõ[ \
)
õõ\ ]
;
õõ] ^
}
úú 
}
ùù 	
else
ûû 
{
üü 	
existingUser
†† 
.
†† 
UserName
†† !
=
††" #
email
††$ )
;
††) *
existingUser
°° 
.
°° 
Email
°° 
=
°°  
email
°°! &
;
°°& '
existingUser
¢¢ 
.
¢¢ 
PhoneNumber
¢¢ $
=
¢¢% &
phoneNumber
¢¢' 2
;
¢¢2 3
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
•• 
updateResult
•• 
=
•• 
await
•• $
userManager
••% 0
.
••0 1
UpdateAsync
••1 <
(
••< =
existingUser
••= I
)
••I J
;
••J K
if
ßß 
(
ßß 
!
ßß 
updateResult
ßß 
.
ßß 
	Succeeded
ßß '
)
ßß' (
{
®® 
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
™™ 
new
™™ '
InvalidOperationException
™™ 3
(
™™3 4
$"
™™4 6
$str
™™6 S
{
™™S T
email
™™T Y
}
™™Y Z
$str
™™Z \
{
™™\ ]
errors
™™] c
}
™™c d
"
™™d e
)
™™e f
;
™™f g
}
´´ 
if
≠≠ 
(
≠≠ 
resetPassword
≠≠ 
)
≠≠ 
{
ÆÆ 
var
ØØ 
token
ØØ 
=
ØØ 
await
ØØ !
userManager
ØØ" -
.
ØØ- .-
GeneratePasswordResetTokenAsync
ØØ. M
(
ØØM N
existingUser
ØØN Z
)
ØØZ [
;
ØØ[ \
var
∞∞ 
passwordResult
∞∞ "
=
∞∞# $
await
∞∞% *
userManager
∞∞+ 6
.
∞∞6 7 
ResetPasswordAsync
∞∞7 I
(
∞∞I J
existingUser
∞∞J V
,
∞∞V W
token
∞∞X ]
,
∞∞] ^
password
∞∞_ g
)
∞∞g h
;
∞∞h i
if
≤≤ 
(
≤≤ 
!
≤≤ 
passwordResult
≤≤ #
.
≤≤# $
	Succeeded
≤≤$ -
)
≤≤- .
{
≥≥ 
var
¥¥ 
errors
¥¥ 
=
¥¥  
string
¥¥! '
.
¥¥' (
Join
¥¥( ,
(
¥¥, -
$str
¥¥- 0
,
¥¥0 1
passwordResult
¥¥2 @
.
¥¥@ A
Errors
¥¥A G
.
¥¥G H
Select
¥¥H N
(
¥¥N O
error
¥¥O T
=>
¥¥U W
error
¥¥X ]
.
¥¥] ^
Description
¥¥^ i
)
¥¥i j
)
¥¥j k
;
¥¥k l
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
∂∂ 
}
∑∑ 
}
∏∏ 	
if
∫∫ 

(
∫∫ 
!
∫∫ 
await
∫∫ 
userManager
∫∫ 
.
∫∫ 
IsInRoleAsync
∫∫ ,
(
∫∫, -
existingUser
∫∫- 9
,
∫∫9 :
role
∫∫; ?
)
∫∫? @
)
∫∫@ A
{
ªª 	
var
ºº 

roleResult
ºº 
=
ºº 
await
ºº "
userManager
ºº# .
.
ºº. /
AddToRoleAsync
ºº/ =
(
ºº= >
existingUser
ºº> J
,
ººJ K
role
ººL P
)
ººP Q
;
ººQ R
if
ææ 
(
ææ 
!
ææ 

roleResult
ææ 
.
ææ 
	Succeeded
ææ %
)
ææ% &
{
øø 
var
¿¿ 
errors
¿¿ 
=
¿¿ 
string
¿¿ #
.
¿¿# $
Join
¿¿$ (
(
¿¿( )
$str
¿¿) ,
,
¿¿, -

roleResult
¿¿. 8
.
¿¿8 9
Errors
¿¿9 ?
.
¿¿? @
Select
¿¿@ F
(
¿¿F G
error
¿¿G L
=>
¿¿M O
error
¿¿P U
.
¿¿U V
Description
¿¿V a
)
¿¿a b
)
¿¿b c
;
¿¿c d
throw
¡¡ 
new
¡¡ '
InvalidOperationException
¡¡ 3
(
¡¡3 4
$"
¡¡4 6
$str
¡¡6 L
{
¡¡L M
role
¡¡M Q
}
¡¡Q R
$str
¡¡R V
{
¡¡V W
email
¡¡W \
}
¡¡\ ]
$str
¡¡] _
{
¡¡_ `
errors
¡¡` f
}
¡¡f g
"
¡¡g h
)
¡¡h i
;
¡¡i j
}
¬¬ 
}
√√ 	
return
≈≈ 
existingUser
≈≈ 
;
≈≈ 
}
∆∆ 
private
»» 
static
»» 
int
»» 
CalculateAge
»» #
(
»»# $
DateOnly
»»$ ,
dateOfBirth
»»- 8
,
»»8 9
DateOnly
»»: B
referenceDate
»»C P
)
»»P Q
{
…… 
var
   
age
   
=
   
referenceDate
   
.
    
Year
    $
-
  % &
dateOfBirth
  ' 2
.
  2 3
Year
  3 7
;
  7 8
if
ÃÃ 

(
ÃÃ 
referenceDate
ÃÃ 
<
ÃÃ 
dateOfBirth
ÃÃ '
.
ÃÃ' (
AddYears
ÃÃ( 0
(
ÃÃ0 1
age
ÃÃ1 4
)
ÃÃ4 5
)
ÃÃ5 6
{
ÕÕ 	
age
ŒŒ 
--
ŒŒ 
;
ŒŒ 
}
œœ 	
return
—— 
age
—— 
;
—— 
}
““ 
private
‘‘ 
static
‘‘ 
string
‘‘ 
RemoveDoctorTitle
‘‘ +
(
‘‘+ ,
string
‘‘, 2
fullName
‘‘3 ;
)
‘‘; <
{
’’ 
return
÷÷ 
fullName
÷÷ 
.
÷÷ 

StartsWith
÷÷ "
(
÷÷" #
$str
÷÷# )
,
÷÷) *
StringComparison
÷÷+ ;
.
÷÷; <
OrdinalIgnoreCase
÷÷< M
)
÷÷M N
?
◊◊ 
fullName
◊◊ 
[
◊◊ 
$num
◊◊ 
..
◊◊ 
]
◊◊ 
:
ÿÿ 
fullName
ÿÿ 
;
ÿÿ 
}
ŸŸ 
private
€€ 
sealed
€€ 
record
€€ 
SeedUser
€€ "
(
€€" #
string
€€# )
Email
€€* /
,
€€/ 0
string
€€1 7
PhoneNumber
€€8 C
)
€€C D
;
€€D E
private
›› 
sealed
›› 
record
›› 

SeedDoctor
›› $
(
››$ %
string
ﬁﬁ 
FullName
ﬁﬁ 
,
ﬁﬁ 
string
ﬂﬂ 
Email
ﬂﬂ 
,
ﬂﬂ 
string
‡‡ 
PhoneNumber
‡‡ 
,
‡‡ "
DoctorSpecialisation
·· 
Specialisation
·· +
,
··+ ,
DateOnly
‚‚ 
PracticeStartDate
‚‚ "
,
‚‚" #
decimal
„„ 
ConsultationFee
„„ 
,
„„  
bool
‰‰ 
IsAvailable
‰‰ 
)
‰‰ 
;
‰‰ 
private
ÊÊ 
sealed
ÊÊ 
record
ÊÊ 
SeedPatient
ÊÊ %
(
ÊÊ% &
string
ÁÁ 
FullName
ÁÁ 
,
ÁÁ 
string
ËË 
Email
ËË 
,
ËË 
string
ÈÈ 
PhoneNumber
ÈÈ 
,
ÈÈ 
DateOnly
ÍÍ 
DateOfBirth
ÍÍ 
,
ÍÍ 
string
ÎÎ 
Gender
ÎÎ 
,
ÎÎ 
string
ÏÏ 
Address
ÏÏ 
)
ÏÏ 
;
ÏÏ 
private
ÓÓ 
sealed
ÓÓ 
record
ÓÓ 
SeedAppointment
ÓÓ )
(
ÓÓ) *
Patient
ÔÔ 
Patient
ÔÔ 
,
ÔÔ 
Doctor
 
Doctor
 
,
 
DateOnly
ÒÒ 
Date
ÒÒ 
,
ÒÒ 
TimeOnly
ÚÚ 
Time
ÚÚ 
,
ÚÚ 
AppointmentStatus
ÛÛ 
Status
ÛÛ  
,
ÛÛ  !
string
ÙÙ 
?
ÙÙ  
CancellationReason
ÙÙ "
,
ÙÙ" #
SeedHealthRecord
ıı 
?
ıı 
HealthRecord
ıı &
)
ıı& '
;
ıı' (
private
˜˜ 
sealed
˜˜ 
record
˜˜ 
SeedHealthRecord
˜˜ *
(
˜˜* +
DateOnly
¯¯ 
	VisitDate
¯¯ 
,
¯¯ 
string
˘˘ 
	Diagnosis
˘˘ 
,
˘˘ 
string
˙˙ 
Prescription
˙˙ 
,
˙˙ 
string
˚˚ 
?
˚˚ 
Notes
˚˚ 
)
˚˚ 
;
˚˚ 
}¸¸ ûW
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
}9 :
public 

DbSet 
< 
Notification 
> 
Notifications ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
	protected 
override 
void 
OnModelCreating +
(+ ,
ModelBuilder, 8
builder9 @
)@ A
{ 
base 
. 
OnModelCreating 
( 
builder $
)$ %
;% &
builder 
. 
Entity 
< 
IdentityUser #
># $
($ %
)% &
. 
HasOne 
< 
Doctor 
> 
( 
) 
. 
WithOne 
( 
doctor 
=> 
doctor %
.% &
User& *
)* +
. 
HasForeignKey 
< 
Doctor !
>! "
(" #
doctor# )
=>* ,
doctor- 3
.3 4
UserId4 :
): ;
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Restrict% -
)- .
;. /
builder 
. 
Entity 
< 
IdentityUser #
># $
($ %
)% &
. 
HasOne 
< 
Patient 
> 
( 
) 
.   
WithOne   
(   
patient   
=>   
patient    '
.  ' (
User  ( ,
)  , -
.!! 
HasForeignKey!! 
<!! 
Patient!! "
>!!" #
(!!# $
patient!!$ +
=>!!, .
patient!!/ 6
.!!6 7
UserId!!7 =
)!!= >
."" 
OnDelete"" 
("" 
DeleteBehavior"" $
.""$ %
Restrict""% -
)""- .
;"". /
builder$$ 
.$$ 
Entity$$ 
<$$ 
Appointment$$ "
>$$" #
($$# $
)$$$ %
.%% 
HasOne%% 
(%% 
appointment%% 
=>%%  "
appointment%%# .
.%%. /
Patient%%/ 6
)%%6 7
.&& 
WithMany&& 
(&& 
patient&& 
=>&&  
patient&&! (
.&&( )
Appointments&&) 5
)&&5 6
.'' 
HasForeignKey'' 
('' 
appointment'' &
=>''' )
appointment''* 5
.''5 6
	PatientId''6 ?
)''? @
.(( 
OnDelete(( 
((( 
DeleteBehavior(( $
.(($ %
Restrict((% -
)((- .
;((. /
builder** 
.** 
Entity** 
<** 
Appointment** "
>**" #
(**# $
)**$ %
.++ 
HasOne++ 
(++ 
appointment++ 
=>++  "
appointment++# .
.++. /
Doctor++/ 5
)++5 6
.,, 
WithMany,, 
(,, 
doctor,, 
=>,, 
doctor,,  &
.,,& '
Appointments,,' 3
),,3 4
.-- 
HasForeignKey-- 
(-- 
appointment-- &
=>--' )
appointment--* 5
.--5 6
DoctorId--6 >
)--> ?
... 
OnDelete.. 
(.. 
DeleteBehavior.. $
...$ %
Restrict..% -
)..- .
;... /
builder00 
.00 
Entity00 
<00 
Appointment00 "
>00" #
(00# $
)00$ %
.11 
Property11 
(11 
appointment11 !
=>11" $
appointment11% 0
.110 1
Status111 7
)117 8
.22 
HasConversion22 
<22 
string22 !
>22! "
(22" #
)22# $
.33 
HasMaxLength33 
(33 
$num33 
)33 
.44 

IsRequired44 
(44 
)44 
;44 
builder66 
.66 
Entity66 
<66 
Appointment66 "
>66" #
(66# $
)66$ %
.77 
HasOne77 
(77 
appointment77 
=>77  "
appointment77# .
.77. /
HealthRecord77/ ;
)77; <
.88 
WithOne88 
(88 
record88 
=>88 
record88 %
.88% &
Appointment88& 1
)881 2
.99 
HasForeignKey99 
<99 
HealthRecord99 '
>99' (
(99( )
record99) /
=>990 2
record993 9
.999 :
AppointmentId99: G
)99G H
.:: 
OnDelete:: 
(:: 
DeleteBehavior:: $
.::$ %
Restrict::% -
)::- .
;::. /
builder<< 
.<< 
Entity<< 
<<< 
HealthRecord<< #
><<# $
(<<$ %
)<<% &
.== 
HasIndex== 
(== 
record== 
=>== 
record==  &
.==& '
AppointmentId==' 4
)==4 5
.>> 
IsUnique>> 
(>> 
)>> 
;>> 
builder@@ 
.@@ 
Entity@@ 
<@@ 
Doctor@@ 
>@@ 
(@@ 
)@@  
.AA 
PropertyAA 
(AA 
doctorAA 
=>AA 
doctorAA  &
.AA& '
SpecialisationAA' 5
)AA5 6
.BB 
HasConversionBB 
<BB 
stringBB !
>BB! "
(BB" #
)BB# $
.CC 
HasMaxLengthCC 
(CC 
$numCC 
)CC 
.DD 

IsRequiredDD 
(DD 
)DD 
;DD 
builderFF 
.FF 
EntityFF 
<FF 
NotificationFF #
>FF# $
(FF$ %
)FF% &
.GG 
HasOneGG 
(GG 
notificationGG  
=>GG! #
notificationGG$ 0
.GG0 1
RecipientUserGG1 >
)GG> ?
.HH 
WithManyHH 
(HH 
)HH 
.II 
HasForeignKeyII 
(II 
notificationII '
=>II( *
notificationII+ 7
.II7 8
RecipientUserIdII8 G
)IIG H
.JJ 
OnDeleteJJ 
(JJ 
DeleteBehaviorJJ $
.JJ$ %
RestrictJJ% -
)JJ- .
;JJ. /
builderLL 
.LL 
EntityLL 
<LL 
NotificationLL #
>LL# $
(LL$ %
)LL% &
.MM 
PropertyMM 
(MM 
notificationMM "
=>MM# %
notificationMM& 2
.MM2 3
TitleMM3 8
)MM8 9
.NN 
HasMaxLengthNN 
(NN 
$numNN 
)NN 
.OO 

IsRequiredOO 
(OO 
)OO 
;OO 
builderQQ 
.QQ 
EntityQQ 
<QQ 
NotificationQQ #
>QQ# $
(QQ$ %
)QQ% &
.RR 
PropertyRR 
(RR 
notificationRR "
=>RR# %
notificationRR& 2
.RR2 3
MessageRR3 :
)RR: ;
.SS 
HasMaxLengthSS 
(SS 
$numSS 
)SS 
.TT 

IsRequiredTT 
(TT 
)TT 
;TT 
builderVV 
.VV 
EntityVV 
<VV 
NotificationVV #
>VV# $
(VV$ %
)VV% &
.WW 
PropertyWW 
(WW 
notificationWW "
=>WW# %
notificationWW& 2
.WW2 3
NotificationTypeWW3 C
)WWC D
.XX 
HasMaxLengthXX 
(XX 
$numXX 
)XX 
.YY 

IsRequiredYY 
(YY 
)YY 
;YY 
builder[[ 
.[[ 
Entity[[ 
<[[ 
Notification[[ #
>[[# $
([[$ %
)[[% &
.\\ 
Property\\ 
(\\ 
notification\\ "
=>\\# %
notification\\& 2
.\\2 3
RelatedEntityType\\3 D
)\\D E
.]] 
HasMaxLength]] 
(]] 
$num]] 
)]] 
;]] 
builder__ 
.__ 
Entity__ 
<__ 
Notification__ #
>__# $
(__$ %
)__% &
.`` 
HasIndex`` 
(`` 
notification`` "
=>``# %
notification``& 2
.``2 3
RecipientUserId``3 B
)``B C
;``C D
builderbb 
.bb 
Entitybb 
<bb 
Notificationbb #
>bb# $
(bb$ %
)bb% &
.cc 
HasIndexcc 
(cc 
notificationcc "
=>cc# %
notificationcc& 2
.cc2 3
CreatedAtUtccc3 ?
)cc? @
;cc@ A
builderee 
.ee 
Entityee 
<ee 
Notificationee #
>ee# $
(ee$ %
)ee% &
.ff 
HasIndexff 
(ff 
notificationff "
=>ff# %
notificationff& 2
.ff2 3
IsReadff3 9
)ff9 :
;ff: ;
}gg 
}hh á5
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
}PP ¸L
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
ÅÅ 
CreatedAtAction
ÅÅ 
(
ÅÅ 
nameof
ÅÅ %
(
ÅÅ% &!
GetHealthRecordById
ÅÅ& 9
)
ÅÅ9 :
,
ÅÅ: ;
new
ÅÅ< ?
{
ÅÅ@ A
id
ÅÅB D
=
ÅÅE F
record
ÅÅG M
.
ÅÅM N
Id
ÅÅN P
}
ÅÅQ R
,
ÅÅR S
record
ÅÅT Z
)
ÅÅZ [
;
ÅÅ[ \
}
ÇÇ 
private
ÑÑ 
bool
ÑÑ 
IsOwnPatientId
ÑÑ 
(
ÑÑ  
int
ÑÑ  #
	patientId
ÑÑ$ -
)
ÑÑ- .
{
ÖÖ 
return
ÜÜ 
User
ÜÜ 
.
ÜÜ 
GetPatientId
ÜÜ  
(
ÜÜ  !
)
ÜÜ! "
==
ÜÜ# %
	patientId
ÜÜ& /
;
ÜÜ/ 0
}
áá 
}ââ ©P
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
ÅÅ 
availability
ÅÅ 
=
ÅÅ 
await
ÅÅ  
doctorService
ÅÅ! .
.
ÅÅ. /%
UpdateAvailabilityAsync
ÅÅ/ F
(
ÅÅF G
id
ÇÇ 
,
ÇÇ 
request
ÉÉ 
,
ÉÉ 
currentRole
ÑÑ 
,
ÑÑ 
User
ÖÖ 
.
ÖÖ 
GetDoctorId
ÖÖ 
(
ÖÖ 
)
ÖÖ 
)
ÖÖ 
;
ÖÖ  
return
áá 
Ok
áá 
(
áá 
availability
áá 
)
áá 
;
áá  
}
àà 
}ââ ˘
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
}-- Ém
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
ÄÄ 
	patientId
ÄÄ 
=
ÄÄ 
User
ÄÄ  
.
ÄÄ  !
GetPatientId
ÄÄ! -
(
ÄÄ- .
)
ÄÄ. /
;
ÄÄ/ 0
if
ÇÇ 
(
ÇÇ 
	patientId
ÇÇ 
==
ÇÇ 
null
ÇÇ !
||
ÇÇ" $
	patientId
ÇÇ% .
.
ÇÇ. /
Value
ÇÇ/ 4
!=
ÇÇ5 7
request
ÇÇ8 ?
.
ÇÇ? @
	PatientId
ÇÇ@ I
)
ÇÇI J
{
ÉÉ 
return
ÑÑ 
Forbid
ÑÑ 
(
ÑÑ 
)
ÑÑ 
;
ÑÑ  
}
ÖÖ 
}
ÜÜ 	
var
àà 
appointment
àà 
=
àà 
await
àà  
appointmentService
àà  2
.
àà2 3$
CreateAppointmentAsync
àà3 I
(
ààI J
request
ààJ Q
)
ààQ R
;
ààR S
return
ää 
appointment
ää 
==
ää 
null
ää "
?
ãã 
throw
ãã 
new
ãã '
InvalidOperationException
ãã 1
(
ãã1 2
ErrorMessages
ãã2 ?
.
ãã? @'
UnableToCreateAppointment
ãã@ Y
)
ããY Z
:
åå 
CreatedAtAction
åå 
(
åå 
nameof
åå $
(
åå$ % 
GetAppointmentById
åå% 7
)
åå7 8
,
åå8 9
new
åå: =
{
åå> ?
id
åå@ B
=
ååC D
appointment
ååE P
.
ååP Q
Id
ååQ S
}
ååT U
,
ååU V
appointment
ååW b
)
ååb c
;
ååc d
}
çç 
[
èè 
HttpPut
èè 
(
èè 
$str
èè 
)
èè 
]
èè  
[
êê 
	Authorize
êê 
(
êê #
AuthenticationSchemes
êê $
=
êê% &
JwtBearerDefaults
êê' 8
.
êê8 9"
AuthenticationScheme
êê9 M
,
êêM N
Roles
êêO T
=
êêU V
AppRoles
êêW _
.
êê_ ` 
PatientDoctorAdmin
êê` r
)
êêr s
]
êês t
public
ëë 

async
ëë 
Task
ëë 
<
ëë 
IActionResult
ëë #
>
ëë# $%
UpdateAppointmentStatus
ëë% <
(
ëë< =
int
ëë= @
id
ëëA C
,
ëëC D(
UpdateAppointmentStatusDto
ëëE _
request
ëë` g
)
ëëg h
{
íí 
var
ìì 
currentRole
ìì 
=
ìì 
User
ìì 
.
ìì 
GetCurrentRole
ìì -
(
ìì- .
)
ìì. /
;
ìì/ 0
if
ïï 

(
ïï 
currentRole
ïï 
==
ïï 
null
ïï 
)
ïï  
{
ññ 	
return
óó 
Forbid
óó 
(
óó 
)
óó 
;
óó 
}
òò 	
var
öö 
appointment
öö 
=
öö 
await
öö  
appointmentService
öö  2
.
öö2 3*
UpdateAppointmentStatusAsync
öö3 O
(
ööO P
id
õõ 
,
õõ 
request
úú 
,
úú 
currentRole
ùù 
,
ùù 
User
ûû 
.
ûû 
GetPatientId
ûû 
(
ûû 
)
ûû 
,
ûû  
User
üü 
.
üü 
GetDoctorId
üü 
(
üü 
)
üü 
)
üü 
;
üü  
return
°° 
Ok
°° 
(
°° 
appointment
°° 
)
°° 
;
°° 
}
¢¢ 
}§§ ¥-
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
ÄÄ 
appointments
ÄÄ 
=
ÄÄ 
await
ÄÄ  
adminService
ÄÄ! -
.
ÄÄ- ..
 GetAppointmentReportDetailsAsync
ÄÄ. N
(
ÄÄN O
date
ÅÅ 
,
ÅÅ 
status
ÇÇ 
,
ÇÇ 

pagination
ÉÉ 
)
ÉÉ 
;
ÉÉ 
return
ÖÖ 
Ok
ÖÖ 
(
ÖÖ 
appointments
ÖÖ 
)
ÖÖ 
;
ÖÖ  
}
ÜÜ 
}áá ‡#
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
}66 ⁄A
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
public 

const 
string 
InvalidRefreshToken +
=, -
$str. F
;F G
public 

const 
string 
RefreshTokenExpired +
=, -
$str. J
;J K
public 

const 
string 
PasswordsDoNotMatch +
=, -
$str. G
;G H
public		 

const		 
string		 "
EmailAlreadyRegistered		 .
=		/ 0
$str		1 O
;		O P
public

 

const

 
string

 
EmailAlreadyExists

 *
=

+ ,
$str

- U
;

U V
public 

const 
string 
PatientNotFound '
=( )
$str* >
;> ?
public 

const 
string "
PatientAccountNotFound .
=/ 0
$str1 M
;M N
public 

const 
string "
PatientProfileNotFound .
=/ 0
$str1 _
;_ `
public 

const 
string 
DoctorNotFound &
=' (
$str) <
;< =
public 

const 
string '
DoctorNotFoundAfterCreation 3
=4 5
$str6 X
;X Y
public 

const 
string !
DoctorProfileNotFound -
=. /
$str0 ]
;] ^
public 

const 
string 
DoctorUnavailable )
=* +
$str, W
;W X
public 

const 
string "
DoctorAvailableMessage .
=/ 0
$str1 G
;G H
public 

const 
string $
DoctorUnavailableMessage 0
=1 2
$str3 M
;M N
public 

const 
string @
4DoctorCannotDeactivateWithConfirmedAppointmentsToday L
=M N
$str	O “
;
“ ”
public 

const 
string /
#DoctorsCanUpdateOnlyOwnAvailability ;
=< =
$str> o
;o p
public 

const 
string -
!DoctorEmergencyCancellationReason 9
=: ;
$str< 
;	 Ä
public 

const 
string 
AppointmentNotFound +
=, -
$str. F
;F G
public 

const 
string ,
 AppointmentNotFoundAfterCreation 8
=9 :
$str; b
;b c
public 

const 
string )
AppointmentDateCannotBeInPast 5
=6 7
$str8 a
;a b
public 

const 
string 6
*AppointmentMustBeBookedAtLeast48HoursAhead B
=C D
$str	E è
;
è ê
public 

const 
string ;
/AppointmentCannotBeBookedMoreThanSixMonthsAhead G
=H I
$str	J à
;
à â
public 

const 
string #
DoctorSlotAlreadyBooked /
=0 1
$str2 t
;t u
public 

const 
string $
PatientSlotAlreadyBooked 0
=1 2
$str3 v
;v w
public 

const 
string 8
,PatientAlreadyHasAppointmentWithDoctorOnDate D
=E F
$str	G í
;
í ì
public 

const 
string 1
%OnlyPendingAppointmentsCanBeConfirmed =
=> ?
$str@ m
;m n
public   

const   
string   /
#DoctorsCanManageOnlyOwnAppointments   ;
=  < =
$str  > o
;  o p
public!! 

const!! 
string!! 0
$PatientsCanManageOnlyOwnAppointments!! <
=!!= >
$str!!? q
;!!q r
public"" 

const"" 
string"" &
CancellationReasonRequired"" 2
=""3 4
$str""5 W
;""W X
public## 

const## 
string## 2
&CompletedAppointmentsCannotBeCancelled## >
=##? @
$str##A n
;##n o
public$$ 

const$$ 
string$$ 7
+CancelledAppointmentsCannotBeCancelledAgain$$ C
=$$D E
$str$$F t
;$$t u
public%% 

const%% 
string%% 5
)AppointmentCannotBeCancelledWithin24Hours%% A
=%%B C
$str	%%D å
;
%%å ç
public&& 

const&& 
string&& 7
+AppointmentCompletedOnlyThroughHealthRecord&& C
=&&D E
$str	&&F á
;
&&á à
public'' 

const'' 
string'' 2
&UnsupportedAppointmentStatusTransition'' >
=''? @
$str''A m
;''m n
public(( 

const(( 
string(( 1
%PendingAppointmentAutoCancelledReason(( =
=((> ?
$str	((@ ∞
;
((∞ ±
public)) 

const)) 
string)) :
.ExpiredConfirmedAppointmentAutoCancelledReason)) F
=))G H
$str	))I ≠
;
))≠ Æ
public** 

const** 
string** $
CancelledByPatientSuffix** 0
=**1 2
$str**3 L
;**L M
public++ 

const++ 
string++ #
CancelledByDoctorSuffix++ /
=++0 1
$str++2 J
;++J K
public,, 

const,, 
string,, "
CancelledByAdminSuffix,, .
=,,/ 0
$str,,1 H
;,,H I
public-- 

const-- 
string-- ?
3AppointmentCannotBeDeletedBecauseHealthRecordExists-- K
=--L M
$str	--N ¢
;
--¢ £
public.. 

const.. 
string..  
HealthRecordNotFound.. ,
=..- .
$str../ I
;..I J
public// 

const// 
string// -
!HealthRecordNotFoundAfterCreation// 9
=//: ;
$str//< e
;//e f
public00 

const00 
string00 <
0DoctorCanCreateHealthRecordOnlyForOwnAppointment00 H
=00I J
$str	00K é
;
00é è
public11 

const11 
string11 3
'OnlyConfirmedAppointmentsCanBeCompleted11 ?
=11@ A
$str11B q
;11q r
public22 

const22 
string22 9
-HealthRecordCanBeCreatedOnlyOnAppointmentDate22 E
=22F G
$str	22H Ö
;
22Ö Ü
public33 

const33 
string33 -
!VisitDateMustMatchAppointmentDate33 9
=33: ;
$str33< e
;33e f
public44 

const44 
string44 3
'HealthRecordAlreadyExistsForAppointment44 ?
=44@ A
$str44B x
;44x y
public55 

const55 
string55  
UnableToCreateDoctor55 ,
=55- .
$str55/ I
;55I J
public66 

const66 
string66 %
UnableToCreateAppointment66 1
=662 3
$str664 S
;66S T
public77 

const77 
string77 &
UnableToCreateHealthRecord77 2
=773 4
$str775 V
;77V W
public88 

const88 
string88 4
(PatientsCanCancelOnlyPendingAppointments88 @
=88A B
$str88C s
;88s t
public99 

const99 
string99 >
2DoctorsCanCancelOnlyPendingOrConfirmedAppointments99 J
=99K L
$str	99M â
;
99â ä
}:: ÇB
nC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\BackgroundServices\PendingAppointmentDeadlineService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
BackgroundServices +
;+ ,
public 
class -
!PendingAppointmentDeadlineService .
(. / 
IServiceScopeFactory		 
scopeFactory		 %
,		% &
ILogger

 
<

 -
!PendingAppointmentDeadlineService

 -
>

- .
logger

/ 5
)

5 6
:

7 8
BackgroundService

9 J
{ 
private 
const 
int %
ConfirmationDeadlineHours /
=0 1
$num2 4
;4 5
private 
static 
readonly 
TimeSpan $
CheckInterval% 2
=3 4
TimeSpan5 =
.= >
FromMinutes> I
(I J
$numJ L
)L M
;M N
	protected 
override 
async 
Task !
ExecuteAsync" .
(. /
CancellationToken/ @
stoppingTokenA N
)N O
{ 
logger 
. 
LogInformation 
( 
$str J
)J K
;K L
await 1
%CancelExpiredPendingAppointmentsAsync 3
(3 4
stoppingToken4 A
)A B
;B C
var 
initialDelay 
= %
GetDelayUntilNextHalfHour 4
(4 5
)5 6
;6 7
logger 
. 
LogDebug 
( 
$str R
,R S
initialDelay 
) 
; 
await 
Task 
. 
Delay 
( 
initialDelay %
,% &
stoppingToken' 4
)4 5
;5 6
using 
var 
timer 
= 
new 
PeriodicTimer +
(+ ,
CheckInterval, 9
)9 :
;: ;
do 

{   	
await!! 1
%CancelExpiredPendingAppointmentsAsync!! 7
(!!7 8
stoppingToken!!8 E
)!!E F
;!!F G
}"" 	
while## 
(## 
await## 
timer## 
.##  
WaitForNextTickAsync## /
(##/ 0
stoppingToken##0 =
)##= >
)##> ?
;##? @
}$$ 
private&& 
async&& 
Task&& 1
%CancelExpiredPendingAppointmentsAsync&& <
(&&< =
CancellationToken'' 
stoppingToken'' '
)''' (
{(( 
try)) 
{** 	
await++ 
using++ 
var++ 
scope++ !
=++" #
scopeFactory++$ 0
.++0 1
CreateAsyncScope++1 A
(++A B
)++B C
;++C D
var,, 

repository,, 
=,, 
scope,, "
.,," #
ServiceProvider,,# 2
.-- 
GetRequiredService-- #
<--# $"
IAppointmentRepository--$ :
>--: ;
(--; <
)--< =
;--= >
var.. 
cache.. 
=.. 
scope.. 
... 
ServiceProvider.. -
.// 
GetRequiredService// #
<//# $+
IDoctorAvailabilityCacheService//$ C
>//C D
(//D E
)//E F
;//F G
var11 
cutoff11 
=11 
DateTime11 !
.11! "
Now11" %
.11% &
AddHours11& .
(11. /%
ConfirmationDeadlineHours11/ H
)11H I
;11I J
var22 
appointments22 
=22 
await22 $

repository22% /
.33 .
"GetExpiredPendingAppointmentsAsync33 3
(333 4
cutoff334 :
)33: ;
;33; <
if55 
(55 
appointments55 
.55 
Count55 "
==55# %
$num55& '
)55' (
{66 
logger77 
.77 
LogDebug77 
(77  
$str88 j
)88j k
;88k l
return99 
;99 
}:: 
foreach<< 
(<< 
var<< 
appointment<< $
in<<% '
appointments<<( 4
)<<4 5
{== 
appointment>> 
.>> 
Status>> "
=>># $
AppointmentStatus>>% 6
.>>6 7
	Cancelled>>7 @
;>>@ A
appointment?? 
.?? 
CancellationReason?? .
=??/ 0
ErrorMessages@@ !
.@@! "1
%PendingAppointmentAutoCancelledReason@@" G
;@@G H
}AA 
awaitCC 

repositoryCC 
.CC 
UpdateRangeAsyncCC -
(CC- .
appointmentsCC. :
)CC: ;
;CC; <
foreachEE 
(EE 
varEE 
appointmentEE $
inEE% '
appointmentsEE( 4
)EE4 5
{FF 
awaitGG 
cacheGG 
.GG "
RemoveDoctorSlotsAsyncGG 2
(GG2 3
appointmentHH 
.HH  
DoctorIdHH  (
,HH( )
appointmentII 
.II  
AppointmentDateII  /
)II/ 0
;II0 1
}JJ 
loggerLL 
.LL 
LogInformationLL !
(LL! "
$strMM {
,MM{ |
appointmentsNN 
.NN 
CountNN "
)NN" #
;NN# $
}OO 	
catchPP 
(PP &
OperationCanceledExceptionPP )
	exceptionPP* 3
)PP3 4
whenPP5 9
(PP: ;
stoppingTokenPP; H
.PPH I#
IsCancellationRequestedPPI `
)PP` a
{QQ 	
loggerRR 
.RR 
LogDebugRR 
(RR 
	exceptionSS 
,SS 
$strTT O
)TTO P
;TTP Q
}UU 	
catchVV 
(VV 
	ExceptionVV 
	exceptionVV "
)VV" #
{WW 	
loggerXX 
.XX 
LogErrorXX 
(XX 
	exceptionXX %
,XX% &
$strXX' S
)XXS T
;XXT U
}YY 	
}ZZ 
private\\ 
static\\ 
TimeSpan\\ %
GetDelayUntilNextHalfHour\\ 5
(\\5 6
)\\6 7
{]] 
var^^ 
now^^ 
=^^ 
DateTime^^ 
.^^ 
Now^^ 
;^^ 
var__ 
nextRun__ 
=__ 
now__ 
.__ 
Minute__  
<__! "
$num__# %
?`` 
new`` 
DateTime`` 
(`` 
now`` 
.`` 
Year`` #
,``# $
now``% (
.``( )
Month``) .
,``. /
now``0 3
.``3 4
Day``4 7
,``7 8
now``9 <
.``< =
Hour``= A
,``A B
$num``C E
,``E F
$num``G H
,``H I
now``J M
.``M N
Kind``N R
)``R S
:aa 
newaa 
DateTimeaa 
(aa 
nowaa 
.aa 
Yearaa #
,aa# $
nowaa% (
.aa( )
Monthaa) .
,aa. /
nowaa0 3
.aa3 4
Dayaa4 7
,aa7 8
nowaa9 <
.aa< =
Houraa= A
,aaA B
$numaaC D
,aaD E
$numaaF G
,aaG H
nowaaI L
.aaL M
KindaaM Q
)aaQ R
.bb 
AddHoursbb 
(bb 
$numbb 
)bb 
;bb 
returndd 
nextRundd 
-dd 
nowdd 
;dd 
}ee 
publicgg 

overridegg 
Taskgg 
	StopAsyncgg "
(gg" #
CancellationTokengg# 4
cancellationTokengg5 F
)ggF G
{hh 
loggerii 
.ii 
LogInformationii 
(ii 
$strii K
)iiK L
;iiL M
returnjj 
basejj 
.jj 
	StopAsyncjj 
(jj 
cancellationTokenjj /
)jj/ 0
;jj0 1
}kk 
}ll „+
gC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\BackgroundServices\NotificationCleanupService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
BackgroundServices +
;+ ,
public 
class &
NotificationCleanupService '
(' ( 
IServiceScopeFactory 
scopeFactory %
,% &
ILogger 
< &
NotificationCleanupService &
>& '
logger( .
). /
:0 1
BackgroundService2 C
{		 
private

 
static

 
readonly

 
TimeSpan

 $
CleanupInterval

% 4
=

5 6
TimeSpan

7 ?
.

? @
	FromHours

@ I
(

I J
$num

J K
)

K L
;

L M
private 
static 
readonly 
TimeSpan $
RetentionPeriod% 4
=5 6
TimeSpan7 ?
.? @
FromDays@ H
(H I
$numI K
)K L
;L M
	protected 
override 
async 
Task !
ExecuteAsync" .
(. /
CancellationToken/ @
stoppingTokenA N
)N O
{ 
logger 
. 
LogInformation 
( 
$str C
)C D
;D E
await 
RunCleanupAsync 
( 
stoppingToken +
)+ ,
;, -
using 
var 
timer 
= 
new 
PeriodicTimer +
(+ ,
CleanupInterval, ;
); <
;< =
while 
( 
await 
timer 
.  
WaitForNextTickAsync /
(/ 0
stoppingToken0 =
)= >
)> ?
{ 	
await 
RunCleanupAsync !
(! "
stoppingToken" /
)/ 0
;0 1
} 	
} 
private 
async 
Task 
RunCleanupAsync &
(& '
CancellationToken' 8
stoppingToken9 F
)F G
{ 
try 
{ 	
await 
using 
var 
scope !
=" #
scopeFactory$ 0
.0 1
CreateAsyncScope1 A
(A B
)B C
;C D
var   
context   
=   
scope   
.    
ServiceProvider    /
.  / 0
GetRequiredService  0 B
<  B C
HealthAxisDbContext  C V
>  V W
(  W X
)  X Y
;  Y Z
var!! 
cutoffDateUtc!! 
=!! 
DateTime!!  (
.!!( )
UtcNow!!) /
.!!/ 0
Subtract!!0 8
(!!8 9
RetentionPeriod!!9 H
)!!H I
;!!I J
var## 
oldNotifications##  
=##! "
await### (
context##) 0
.##0 1
Notifications##1 >
.$$ 
Where$$ 
($$ 
notification$$ #
=>$$$ &
notification$$' 3
.$$3 4
CreatedAtUtc$$4 @
<$$A B
cutoffDateUtc$$C P
)$$P Q
.%% 
ToListAsync%% 
(%% 
stoppingToken%% *
)%%* +
;%%+ ,
if'' 
('' 
oldNotifications''  
.''  !
Count''! &
==''' )
$num''* +
)''+ ,
{(( 
logger)) 
.)) 
LogDebug)) 
())  
$str** Q
)**Q R
;**R S
return++ 
;++ 
},, 
context.. 
... 
Notifications.. !
...! "
RemoveRange.." -
(..- .
oldNotifications... >
)..> ?
;..? @
await// 
context// 
.// 
SaveChangesAsync// *
(//* +
stoppingToken//+ 8
)//8 9
;//9 :
logger11 
.11 
LogInformation11 !
(11! "
$str22 U
,22U V
oldNotifications33  
.33  !
Count33! &
)33& '
;33' (
}44 	
catch55 
(55 &
OperationCanceledException55 )
	exception55* 3
)553 4
when555 9
(55: ;
stoppingToken55; H
.55H I#
IsCancellationRequested55I `
)55` a
{66 	
logger77 
.77 
LogDebug77 
(77 
	exception88 
,88 
$str99 A
)99A B
;99B C
}:: 	
catch;; 
(;; 
	Exception;; 
	exception;; "
);;" #
{<< 	
logger== 
.== 
LogError== 
(== 
	exception== %
,==% &
$str==' E
)==E F
;==F G
}>> 	
}?? 
publicAA 

overrideAA 
TaskAA 
	StopAsyncAA "
(AA" #
CancellationTokenAA# 4
cancellationTokenAA5 F
)AAF G
{BB 
loggerCC 
.CC 
LogInformationCC 
(CC 
$strCC D
)CCD E
;CCE F
returnDD 
baseDD 
.DD 
	StopAsyncDD 
(DD 
cancellationTokenDD /
)DD/ 0
;DD0 1
}EE 
}FF Õ
]C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\BackgroundServices\HeartbeatService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
BackgroundServices +
;+ ,
public 
class 
HeartbeatService 
( 
ILogger 
< 
HeartbeatService 
> 
logger $
)$ %
:& '
BackgroundService( 9
{ 
private 
static 
readonly 
TimeSpan $
HeartbeatInterval% 6
=7 8
TimeSpan9 A
.A B
FromSecondsB M
(M N
$numN P
)P Q
;Q R
	protected 
override 
async 
Task !
ExecuteAsync" .
(. /
CancellationToken/ @
stoppingTokenA N
)N O
{		 
logger

 
.

 
LogInformation

 
(

 
$str

 9
)

9 :
;

: ;
while 
( 
! 
stoppingToken 
. #
IsCancellationRequested 5
)5 6
{ 	
if 
( 
logger 
. 
	IsEnabled  
(  !
LogLevel! )
.) *
Information* 5
)5 6
)6 7
{ 
logger 
. 
LogInformation %
(% &
$str G
,G H
DateTime 
. 
UtcNow #
)# $
;$ %
} 
await 
Task 
. 
Delay 
( 
HeartbeatInterval .
,. /
stoppingToken0 =
)= >
;> ?
} 	
} 
public 

override 
Task 
	StopAsync "
(" #
CancellationToken# 4
cancellationToken5 F
)F G
{ 
logger 
. 
LogInformation 
( 
$str :
): ;
;; <
return 
base 
. 
	StopAsync 
( 
cancellationToken /
)/ 0
;0 1
} 
} ·8
oC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\BackgroundServices\ExpiredConfirmedAppointmentService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
BackgroundServices +
;+ ,
public 
class .
"ExpiredConfirmedAppointmentService /
(/ 0 
IServiceScopeFactory		 
scopeFactory		 %
,		% &
ILogger

 
<

 .
"ExpiredConfirmedAppointmentService

 .
>

. /
logger

0 6
)

6 7
:

8 9
BackgroundService

: K
{ 
private 
static 
readonly 
TimeSpan $
CheckInterval% 2
=3 4
TimeSpan5 =
.= >
FromDays> F
(F G
$numG H
)H I
;I J
	protected 
override 
async 
Task !
ExecuteAsync" .
(. /
CancellationToken/ @
stoppingTokenA N
)N O
{ 
logger 
. 
LogInformation 
( 
$str K
)K L
;L M
await 3
'CancelExpiredConfirmedAppointmentsAsync 5
(5 6
stoppingToken6 C
)C D
;D E
var 
initialDelay 
= %
GetDelayUntilNextMidnight 4
(4 5
)5 6
;6 7
logger 
. 
LogDebug 
( 
$str S
,S T
initialDelay 
) 
; 
await 
Task 
. 
Delay 
( 
initialDelay %
,% &
stoppingToken' 4
)4 5
;5 6
using 
var 
timer 
= 
new 
PeriodicTimer +
(+ ,
CheckInterval, 9
)9 :
;: ;
do 

{ 	
await   3
'CancelExpiredConfirmedAppointmentsAsync   9
(  9 :
stoppingToken  : G
)  G H
;  H I
}!! 	
while"" 
("" 
await"" 
timer"" 
.""  
WaitForNextTickAsync"" /
(""/ 0
stoppingToken""0 =
)""= >
)""> ?
;""? @
}## 
private%% 
async%% 
Task%% 3
'CancelExpiredConfirmedAppointmentsAsync%% >
(%%> ?
CancellationToken&& 
stoppingToken&& '
)&&' (
{'' 
try(( 
{)) 	
await** 
using** 
var** 
scope** !
=**" #
scopeFactory**$ 0
.**0 1
CreateAsyncScope**1 A
(**A B
)**B C
;**C D
var++ 

repository++ 
=++ 
scope++ "
.++" #
ServiceProvider++# 2
.,, 
GetRequiredService,, #
<,,# $"
IAppointmentRepository,,$ :
>,,: ;
(,,; <
),,< =
;,,= >
var-- 
cache-- 
=-- 
scope-- 
.-- 
ServiceProvider-- -
... 
GetRequiredService.. #
<..# $+
IDoctorAvailabilityCacheService..$ C
>..C D
(..D E
)..E F
;..F G
var00 
today00 
=00 
DateOnly00  
.00  !
FromDateTime00! -
(00- .
DateTime00. 6
.006 7
Today007 <
)00< =
;00= >
var11 
appointments11 
=11 
await11 $

repository11% /
.22 0
$GetExpiredConfirmedAppointmentsAsync22 5
(225 6
today226 ;
)22; <
;22< =
if44 
(44 
appointments44 
.44 
Count44 "
==44# %
$num44& '
)44' (
{55 
logger66 
.66 
LogDebug66 
(66  
$str77 k
)77k l
;77l m
return88 
;88 
}99 
foreach;; 
(;; 
var;; 
appointment;; $
in;;% '
appointments;;( 4
);;4 5
{<< 
appointment== 
.== 
Status== "
===# $
AppointmentStatus==% 6
.==6 7
	Cancelled==7 @
;==@ A
appointment>> 
.>> 
CancellationReason>> .
=>>/ 0
ErrorMessages?? !
.??! ":
.ExpiredConfirmedAppointmentAutoCancelledReason??" P
;??P Q
}@@ 
awaitBB 

repositoryBB 
.BB 
UpdateRangeAsyncBB -
(BB- .
appointmentsBB. :
)BB: ;
;BB; <
foreachDD 
(DD 
varDD 
appointmentDD $
inDD% '
appointmentsDD( 4
)DD4 5
{EE 
awaitFF 
cacheFF 
.FF "
RemoveDoctorSlotsAsyncFF 2
(FF2 3
appointmentGG 
.GG  
DoctorIdGG  (
,GG( )
appointmentHH 
.HH  
AppointmentDateHH  /
)HH/ 0
;HH0 1
}II 
loggerKK 
.KK 
LogInformationKK !
(KK! "
$strLL s
,LLs t
appointmentsMM 
.MM 
CountMM "
)MM" #
;MM# $
}NN 	
catchOO 
(OO &
OperationCanceledExceptionOO )
	exceptionOO* 3
)OO3 4
whenOO5 9
(OO: ;
stoppingTokenOO; H
.OOH I#
IsCancellationRequestedOOI `
)OO` a
{PP 	
loggerQQ 
.QQ 
LogDebugQQ 
(QQ 
	exceptionRR 
,RR 
$strSS P
)SSP Q
;SSQ R
}TT 	
catchUU 
(UU 
	ExceptionUU 
	exceptionUU "
)UU" #
{VV 	
loggerWW 
.WW 
LogErrorWW 
(WW 
	exceptionWW %
,WW% &
$strWW' T
)WWT U
;WWU V
}XX 	
}YY 
private[[ 
static[[ 
TimeSpan[[ %
GetDelayUntilNextMidnight[[ 5
([[5 6
)[[6 7
{\\ 
var]] 
now]] 
=]] 
DateTime]] 
.]] 
Now]] 
;]] 
return^^ 
now^^ 
.^^ 
Date^^ 
.^^ 
AddDays^^ 
(^^  
$num^^  !
)^^! "
-^^# $
now^^% (
;^^( )
}__ 
publicaa 

overrideaa 
Taskaa 
	StopAsyncaa "
(aa" #
CancellationTokenaa# 4
cancellationTokenaa5 F
)aaF G
{bb 
loggercc 
.cc 
LogInformationcc 
(cc 
$strcc L
)ccL M
;ccM N
returndd 
basedd 
.dd 
	StopAsyncdd 
(dd 
cancellationTokendd /
)dd/ 0
;dd0 1
}ee 
}ff 