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
} √E
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
}:: 	
await<< .
"EnsureEmailIsAvailableForUserAsync<< 0
(<<0 1
dto<<1 4
.<<4 5
Email<<5 :
,<<: ;
patient<<< C
.<<C D
UserId<<D J
)<<J K
;<<K L
patient>> 
.>> 
FullName>> 
=>> 
dto>> 
.>> 
FullName>> '
;>>' (
patient?? 
.?? 
DateOfBirth?? 
=?? 
dto?? !
.??! "
DateOfBirth??" -
;??- .
patient@@ 
.@@ 
Gender@@ 
=@@ 
dto@@ 
.@@ 
Gender@@ #
;@@# $
patientAA 
.AA 
AddressAA 
=AA 
dtoAA 
.AA 
AddressAA %
;AA% &
patientBB 
.BB 
UserBB 
.BB 
EmailBB 
=BB 
dtoBB  
.BB  !
EmailBB! &
.BB& '
TrimBB' +
(BB+ ,
)BB, -
;BB- .
patientCC 
.CC 
UserCC 
.CC 
UserNameCC 
=CC 
dtoCC  #
.CC# $
EmailCC$ )
.CC) *
TrimCC* .
(CC. /
)CC/ 0
;CC0 1
patientDD 
.DD 
UserDD 
.DD 
PhoneNumberDD  
=DD! "
dtoDD# &
.DD& '
PhoneNumberDD' 2
;DD2 3
patientEE 
.EE 
UserEE 
.EE 
EmailConfirmedEE #
=EE$ %
trueEE& *
;EE* +
varGG 
updateUserResultGG 
=GG 
awaitGG $
userManagerGG% 0
.GG0 1
UpdateAsyncGG1 <
(GG< =
patientGG= D
.GGD E
UserGGE I
)GGI J
;GGJ K
ifII 

(II 
!II 
updateUserResultII 
.II 
	SucceededII '
)II' (
{JJ 	
varKK 
errorsKK 
=KK 
stringKK 
.KK  
JoinKK  $
(KK$ %
$strKK% (
,KK( )
updateUserResultKK* :
.KK: ;
ErrorsKK; A
.KKA B
SelectKKB H
(KKH I
errorKKI N
=>KKO Q
errorKKR W
.KKW X
DescriptionKKX c
)KKc d
)KKd e
;KKe f
throwLL 
newLL 
BadRequestExceptionLL )
(LL) *
errorsLL* 0
)LL0 1
;LL1 2
}MM 	
awaitOO 
patientRepositoryOO 
.OO  
UpdateAsyncOO  +
(OO+ ,
patientOO, 3
)OO3 4
;OO4 5
varQQ 
updatedPatientQQ 
=QQ 
awaitQQ "
patientRepositoryQQ# 4
.QQ4 5'
GetPatientByIdWithUserAsyncQQ5 P
(QQP Q
idQQQ S
)QQS T
;QQT U
ifSS 

(SS 
updatedPatientSS 
==SS 
nullSS "
)SS" #
{TT 	
throwUU 
newUU 
NotFoundExceptionUU '
(UU' (
ErrorMessagesUU( 5
.UU5 6
PatientNotFoundUU6 E
)UUE F
;UUF G
}VV 	
returnXX 
mapperXX 
.XX 
MapXX 
<XX 

PatientDtoXX $
>XX$ %
(XX% &
updatedPatientXX& 4
)XX4 5
;XX5 6
}YY 
private[[ 
async[[ 
Task[[ .
"EnsureEmailIsAvailableForUserAsync[[ 9
([[9 :
string[[: @
email[[A F
,[[F G
string[[H N
currentUserId[[O \
)[[\ ]
{\\ 
var]] 
normalizedEmail]] 
=]] 
email]] #
.]]# $
Trim]]$ (
(]]( )
)]]) *
;]]* +
var^^ 
existingUser^^ 
=^^ 
await^^  
userManager^^! ,
.^^, -
FindByEmailAsync^^- =
(^^= >
normalizedEmail^^> M
)^^M N
;^^N O
if`` 

(`` 
existingUser`` 
!=`` 
null``  
&&``! #
existingUser``$ 0
.``0 1
Id``1 3
!=``4 6
currentUserId``7 D
)``D E
{aa 	
throwbb 
newbb 
ConflictExceptionbb '
(bb' (
ErrorMessagesbb( 5
.bb5 6
EmailAlreadyExistsbb6 H
)bbH I
;bbI J
}cc 	
}dd 
}ee µc
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
int   
	patientId  	 
,   
int!! 
doctorId!!	 
,!! 
PaginationQueryDto"" 

pagination"" "
)""" #
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
public.. 

async.. 
Task.. 
<.. 
PagedResultDto.. $
<..$ %
HealthRecordDto..% 4
>..4 5
>..5 67
+GetHealthRecordsByPatientIdAndDoctorIdAsync..7 b
(..b c
int// 
	patientId// 
,// 
int00 
doctorId00 
,00 
PaginationQueryDto11 

pagination11 %
)11% &
{22 
var33 
records33 
=33 
await33 "
healthRecordRepository33 2
.332 37
+GetHealthRecordsByPatientIdAndDoctorIdAsync333 ^
(33^ _
	patientId44 
,44 
doctorId55 
,55 

pagination66 
.66 

PageNumber66 !
,66! "

pagination77 
.77 
PageSize77 
)77  
;77  !
return99 
MapPagedResult99 
<99 
HealthRecord99 *
,99* +
HealthRecordDto99, ;
>99; <
(99< =
records99= D
)99D E
;99E F
}:: 
public<< 

async<< 
Task<< 
<<< 
HealthRecordDto<< %
><<% &$
GetHealthRecordByIdAsync<<' ?
(<<? @
int<<@ C
id<<D F
)<<F G
{== 
var>> 
record>> 
=>> 
await>> "
healthRecordRepository>> 1
.>>1 2/
#GetHealthRecordByIdWithDetailsAsync>>2 U
(>>U V
id>>V X
)>>X Y
;>>Y Z
if@@ 

(@@ 
record@@ 
==@@ 
null@@ 
)@@ 
{AA 	
throwBB 
newBB 
NotFoundExceptionBB '
(BB' (
ErrorMessagesBB( 5
.BB5 6 
HealthRecordNotFoundBB6 J
)BBJ K
;BBK L
}CC 	
returnEE 
mapperEE 
.EE 
MapEE 
<EE 
HealthRecordDtoEE )
>EE) *
(EE* +
recordEE+ 1
)EE1 2
;EE2 3
}FF 
publicHH 

asyncHH 
TaskHH 
<HH 
HealthRecordDtoHH %
>HH% &#
CreateHealthRecordAsyncHH' >
(HH> ?!
CreateHealthRecordDtoHH? T
dtoHHU X
,HHX Y
intHHZ ]
doctorIdHH^ f
)HHf g
{II 
varJJ 
appointmentJJ 
=JJ 
awaitJJ !
appointmentRepositoryJJ  5
.JJ5 6.
"GetAppointmentByIdWithDetailsAsyncJJ6 X
(JJX Y
dtoJJY \
.JJ\ ]
AppointmentIdJJ] j
)JJj k
;JJk l
ifLL 

(LL 
appointmentLL 
==LL 
nullLL 
)LL  
{MM 	
throwNN 
newNN 
NotFoundExceptionNN '
(NN' (
ErrorMessagesNN( 5
.NN5 6
AppointmentNotFoundNN6 I
)NNI J
;NNJ K
}OO 	
ifQQ 

(QQ 
appointmentQQ 
.QQ 
DoctorIdQQ  
!=QQ! #
doctorIdQQ$ ,
)QQ, -
{RR 	
throwSS 
newSS 
ForbiddenExceptionSS (
(SS( )
ErrorMessagesSS) 6
.SS6 7<
0DoctorCanCreateHealthRecordOnlyForOwnAppointmentSS7 g
)SSg h
;SSh i
}TT 	
ifVV 

(VV 
appointmentVV 
.VV 
StatusVV 
!=VV !
AppointmentStatusVV" 3
.VV3 4
	ConfirmedVV4 =
)VV= >
{WW 	
throwXX 
newXX !
BusinessRuleExceptionXX +
(XX+ ,
ErrorMessagesXX, 9
.XX9 :3
'OnlyConfirmedAppointmentsCanBeCompletedXX: a
)XXa b
;XXb c
}YY 	
var[[ 
today[[ 
=[[ 
DateOnly[[ 
.[[ 
FromDateTime[[ )
([[) *
DateTime[[* 2
.[[2 3
Today[[3 8
)[[8 9
;[[9 :
if]] 

(]] 
appointment]] 
.]] 
AppointmentDate]] '
!=]]( *
today]]+ 0
)]]0 1
{^^ 	
throw__ 
new__ !
BusinessRuleException__ +
(__+ ,
ErrorMessages__, 9
.__9 :9
-HealthRecordCanBeCreatedOnlyOnAppointmentDate__: g
)__g h
;__h i
}`` 	
ifbb 

(bb 
dtobb 
.bb 
	VisitDatebb 
!=bb 
appointmentbb (
.bb( )
AppointmentDatebb) 8
)bb8 9
{cc 	
throwdd 
newdd !
BusinessRuleExceptiondd +
(dd+ ,
ErrorMessagesdd, 9
.dd9 :-
!VisitDateMustMatchAppointmentDatedd: [
)dd[ \
;dd\ ]
}ee 	
vargg 
existingRecordgg 
=gg 
awaitgg ""
healthRecordRepositorygg# 9
.gg9 :/
#GetHealthRecordByAppointmentIdAsyncgg: ]
(gg] ^
dtogg^ a
.gga b
AppointmentIdggb o
)ggo p
;ggp q
ifii 

(ii 
existingRecordii 
!=ii 
nullii "
)ii" #
{jj 	
throwkk 
newkk 
ConflictExceptionkk '
(kk' (
ErrorMessageskk( 5
.kk5 63
'HealthRecordAlreadyExistsForAppointmentkk6 ]
)kk] ^
;kk^ _
}ll 	
awaitnn 
usingnn 
varnn 
transactionnn #
=nn$ %
awaitnn& +
contextnn, 3
.nn3 4
Databasenn4 <
.nn< =!
BeginTransactionAsyncnn= R
(nnR S
)nnS T
;nnT U
trypp 
{qq 	
varrr 
healthRecordrr 
=rr 
newrr "
HealthRecordrr# /
{ss 
AppointmentIdtt 
=tt 
dtott  #
.tt# $
AppointmentIdtt$ 1
,tt1 2
	VisitDateuu 
=uu 
dtouu 
.uu  
	VisitDateuu  )
,uu) *
	Diagnosisvv 
=vv 
dtovv 
.vv  
	Diagnosisvv  )
,vv) *
Prescriptionww 
=ww 
dtoww "
.ww" #
Prescriptionww# /
,ww/ 0
Notesxx 
=xx 
dtoxx 
.xx 
Notesxx !
}yy 
;yy 
var{{ 
createdRecord{{ 
={{ 
await{{  %"
healthRecordRepository{{& <
.{{< =
AddAsync{{= E
({{E F
healthRecord{{F R
){{R S
;{{S T
appointment}} 
.}} 
Status}} 
=}}  
AppointmentStatus}}! 2
.}}2 3
	Completed}}3 <
;}}< =
await~~ !
appointmentRepository~~ '
.~~' (
UpdateAsync~~( 3
(~~3 4
appointment~~4 ?
)~~? @
;~~@ A
await
ÄÄ 
transaction
ÄÄ 
.
ÄÄ 
CommitAsync
ÄÄ )
(
ÄÄ) *
)
ÄÄ* +
;
ÄÄ+ ,
var
ÇÇ 
recordWithDetails
ÇÇ !
=
ÇÇ" #
await
ÇÇ$ )$
healthRecordRepository
ÇÇ* @
.
ÇÇ@ A1
#GetHealthRecordByIdWithDetailsAsync
ÇÇA d
(
ÇÇd e
createdRecord
ÇÇe r
.
ÇÇr s
Id
ÇÇs u
)
ÇÇu v
;
ÇÇv w
return
ÑÑ 
recordWithDetails
ÑÑ $
==
ÑÑ% '
null
ÑÑ( ,
?
ÖÖ 
throw
ÖÖ 
new
ÖÖ 
NotFoundException
ÖÖ -
(
ÖÖ- .
ErrorMessages
ÖÖ. ;
.
ÖÖ; </
!HealthRecordNotFoundAfterCreation
ÖÖ< ]
)
ÖÖ] ^
:
ÜÜ 
mapper
ÜÜ 
.
ÜÜ 
Map
ÜÜ 
<
ÜÜ 
HealthRecordDto
ÜÜ ,
>
ÜÜ, -
(
ÜÜ- .
recordWithDetails
ÜÜ. ?
)
ÜÜ? @
;
ÜÜ@ A
}
áá 	
catch
àà 
{
ââ 	
await
ää 
transaction
ää 
.
ää 
RollbackAsync
ää +
(
ää+ ,
)
ää, -
;
ää- .
throw
ãã 
;
ãã 
}
åå 	
}
çç 
private
èè 
PagedResultDto
èè 
<
èè 
TDestination
èè '
>
èè' (
MapPagedResult
èè) 7
<
èè7 8
TSource
èè8 ?
,
èè? @
TDestination
èèA M
>
èèM N
(
èèN O
PagedResult
èèO Z
<
èèZ [
TSource
èè[ b
>
èèb c
pagedResult
èèd o
)
èèo p
{
êê 
return
ëë 
new
ëë 
PagedResultDto
ëë !
<
ëë! "
TDestination
ëë" .
>
ëë. /
{
íí 	
Items
ìì 
=
ìì 
mapper
ìì 
.
ìì 
Map
ìì 
<
ìì 
List
ìì #
<
ìì# $
TDestination
ìì$ 0
>
ìì0 1
>
ìì1 2
(
ìì2 3
pagedResult
ìì3 >
.
ìì> ?
Items
ìì? D
)
ììD E
,
ììE F

PageNumber
îî 
=
îî 
pagedResult
îî $
.
îî$ %

PageNumber
îî% /
,
îî/ 0
PageSize
ïï 
=
ïï 
pagedResult
ïï "
.
ïï" #
PageSize
ïï# +
,
ïï+ ,

TotalCount
ññ 
=
ññ 
pagedResult
ññ $
.
ññ$ %

TotalCount
ññ% /
,
ññ/ 0

TotalPages
óó 
=
óó 
pagedResult
óó $
.
óó$ %

TotalPages
óó% /
}
òò 	
;
òò	 

}
ôô 
}öö Æx
UC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\DoctorService.cs
	namespace

 	

HealthAxis


 
.

 
API

 
.

 
Services

 !
.

! "
Impl

" &
;

& '
public 
class 
DoctorService 
( 
IDoctorRepository 
doctorRepository &
,& '
IMapper 
mapper 
, "
IAppointmentRepository 
? !
appointmentRepository 1
=2 3
null4 8
)8 9
:: ;
IDoctorService< J
{ 
public 

async 
Task 
< 
PagedResultDto $
<$ %
PublicDoctorDto% 4
>4 5
>5 6
GetAllDoctorsAsync7 I
(I J
PaginationQueryDto 

pagination %
,% & 
DoctorSpecialisation 
? 
specialisation ,
), -
{ 
var 
doctors 
= 
await 
doctorRepository ,
., -
GetAllDoctorsAsync- ?
(? @

pagination 
. 

PageNumber !
,! "

pagination 
. 
PageSize 
,  
specialisation 
) 
; 
return 
MapPagedResult 
< 

HealthAxis (
.( )
API) ,
., -
Models- 3
.3 4
Doctor4 :
,: ;
PublicDoctorDto< K
>K L
(L M
doctorsM T
)T U
;U V
} 
public 

async 
Task 
< 
PublicDoctorDto %
?% &
>& '
GetDoctorByIdAsync( :
(: ;
int; >
id? A
)A B
{ 
var 
doctor 
= 
await 
doctorRepository +
.+ ,
GetDoctorByIdAsync, >
(> ?
id? A
)A B
;B C
if!! 

(!! 
doctor!! 
==!! 
null!! 
)!! 
{"" 	
return## 
null## 
;## 
}$$ 	
return&& 
mapper&& 
.&& 
Map&& 
<&& 
PublicDoctorDto&& )
>&&) *
(&&* +
doctor&&+ 1
)&&1 2
;&&2 3
}'' 
public)) 

async)) 
Task)) 
<)) 
PublicDoctorDto)) %
?))% &
>))& '"
GetDoctorByUserIdAsync))( >
())> ?
string))? E
userId))F L
)))L M
{** 
var++ 
doctor++ 
=++ 
await++ 
doctorRepository++ +
.+++ ,"
GetDoctorByUserIdAsync++, B
(++B C
userId++C I
)++I J
;++J K
if-- 

(-- 
doctor-- 
==-- 
null-- 
)-- 
{.. 	
return// 
null// 
;// 
}00 	
return22 
mapper22 
.22 
Map22 
<22 
PublicDoctorDto22 )
>22) *
(22* +
doctor22+ 1
)221 2
;222 3
}33 
public55 

async55 
Task55 
<55 !
DoctorAvailabilityDto55 +
?55+ ,
>55, - 
GetAvailabilityAsync55. B
(55B C
int55C F
id55G I
)55I J
{66 
var77 
availability77 
=77 
await77  
doctorRepository77! 1
.771 2 
GetAvailabilityAsync772 F
(77F G
id77G I
)77I J
;77J K
if99 

(99 
availability99 
==99 
null99  
)99  !
{:: 	
return;; 
null;; 
;;; 
}<< 	
return>> 
new>> !
DoctorAvailabilityDto>> (
{?? 	
DoctorId@@ 
=@@ 
id@@ 
,@@ 
IsAvailableAA 
=AA 
availabilityAA &
.AA& '
ValueAA' ,
,AA, -
MessageBB 
=BB 
availabilityBB "
.BB" #
ValueBB# (
?CC 
ErrorMessagesCC 
.CC  "
DoctorAvailableMessageCC  6
:DD 
ErrorMessagesDD 
.DD  $
DoctorUnavailableMessageDD  8
}EE 	
;EE	 

}FF 
publicHH 

asyncHH 
TaskHH 
<HH !
DoctorAvailabilityDtoHH +
>HH+ ,#
UpdateAvailabilityAsyncHH- D
(HHD E
intII 
idII 

,II
 '
UpdateDoctorAvailabilityDtoJJ 
dtoJJ  #
,JJ# $
stringKK 

currentRoleKK 
,KK 
intLL 
?LL 
currentDoctorIdLL	 
)LL 
{MM 
varNN )
appointmentRepositoryInstanceNN )
=NN* +!
appointmentRepositoryNN, A
??OO 
throwOO 
newOO %
InvalidOperationExceptionOO 2
(OO2 3
$strOO3 v
)OOv w
;OOw x
varQQ 
doctorQQ 
=QQ 
awaitQQ 
doctorRepositoryQQ +
.QQ+ ,
GetDoctorByIdAsyncQQ, >
(QQ> ?
idQQ? A
)QQA B
;QQB C
ifSS 

(SS 
doctorSS 
==SS 
nullSS 
)SS 
{TT 	
throwUU 
newUU 
NotFoundExceptionUU '
(UU' (
ErrorMessagesUU( 5
.UU5 6
DoctorNotFoundUU6 D
)UUD E
;UUE F
}VV 	0
$ValidateAvailabilityUpdatePermissionXX ,
(XX, -
idXX- /
,XX/ 0
currentRoleXX1 <
,XX< =
currentDoctorIdXX> M
)XXM N
;XXN O
varZZ 
isDeactivationZZ 
=ZZ 
doctorZZ #
.ZZ# $
IsAvailableZZ$ /
&&ZZ0 2
!ZZ3 4
dtoZZ4 7
.ZZ7 8
IsAvailableZZ8 C
;ZZC D
if\\ 

(\\ 
isDeactivation\\ 
)\\ 
{]] 	
await^^ #
HandleDeactivationAsync^^ )
(^^) *
id__ 
,__ 
currentRole`` 
,`` )
appointmentRepositoryInstanceaa -
)aa- .
;aa. /
}bb 	
doctordd 
.dd 
IsAvailabledd 
=dd 
dtodd  
.dd  !
IsAvailabledd! ,
;dd, -
varff 
updatedDoctorff 
=ff 
awaitff !
doctorRepositoryff" 2
.ff2 3
UpdateAsyncff3 >
(ff> ?
doctorff? E
)ffE F
;ffF G
ifhh 

(hh 
updatedDoctorhh 
==hh 
nullhh !
)hh! "
{ii 	
throwjj 
newjj 
NotFoundExceptionjj '
(jj' (
ErrorMessagesjj( 5
.jj5 6
DoctorNotFoundjj6 D
)jjD E
;jjE F
}kk 	
returnmm !
CreateAvailabilityDtomm $
(mm$ %
updatedDoctormm% 2
.mm2 3
Idmm3 5
,mm5 6
updatedDoctormm7 D
.mmD E
IsAvailablemmE P
)mmP Q
;mmQ R
}nn 
privatepp 
PagedResultDtopp 
<pp 
TDestinationpp '
>pp' (
MapPagedResultpp) 7
<pp7 8
TSourcepp8 ?
,pp? @
TDestinationppA M
>ppM N
(ppN O
PagedResultppO Z
<ppZ [
TSourcepp[ b
>ppb c
pagedResultppd o
)ppo p
{qq 
returnrr 
newrr 
PagedResultDtorr !
<rr! "
TDestinationrr" .
>rr. /
{ss 	
Itemstt 
=tt 
mappertt 
.tt 
Maptt 
<tt 
Listtt #
<tt# $
TDestinationtt$ 0
>tt0 1
>tt1 2
(tt2 3
pagedResulttt3 >
.tt> ?
Itemstt? D
)ttD E
,ttE F

PageNumberuu 
=uu 
pagedResultuu $
.uu$ %

PageNumberuu% /
,uu/ 0
PageSizevv 
=vv 
pagedResultvv "
.vv" #
PageSizevv# +
,vv+ ,

TotalCountww 
=ww 
pagedResultww $
.ww$ %

TotalCountww% /
,ww/ 0

TotalPagesxx 
=xx 
pagedResultxx $
.xx$ %

TotalPagesxx% /
}yy 	
;yy	 

}zz 
private{{ 
static{{ 
void{{ 0
$ValidateAvailabilityUpdatePermission{{ <
({{< =
int|| 
doctorId|| 
,|| 
string}} 

currentRole}} 
,}} 
int~~ 
?~~ 
currentDoctorId~~	 
)~~ 
{ 
if
ÄÄ 

(
ÄÄ 
currentRole
ÄÄ 
==
ÄÄ 
AppRoles
ÄÄ #
.
ÄÄ# $
Doctor
ÄÄ$ *
&&
ÄÄ+ -
currentDoctorId
ÄÄ. =
!=
ÄÄ> @
doctorId
ÄÄA I
)
ÄÄI J
{
ÅÅ 	
throw
ÇÇ 
new
ÇÇ  
ForbiddenException
ÇÇ (
(
ÇÇ( )
ErrorMessages
ÇÇ) 6
.
ÇÇ6 71
#DoctorsCanUpdateOnlyOwnAvailability
ÇÇ7 Z
)
ÇÇZ [
;
ÇÇ[ \
}
ÉÉ 	
if
ÖÖ 

(
ÖÖ 
currentRole
ÖÖ 
!=
ÖÖ 
AppRoles
ÖÖ #
.
ÖÖ# $
Doctor
ÖÖ$ *
&&
ÖÖ+ -
currentRole
ÖÖ. 9
!=
ÖÖ: <
AppRoles
ÖÖ= E
.
ÖÖE F
Admin
ÖÖF K
)
ÖÖK L
{
ÜÜ 	
throw
áá 
new
áá  
ForbiddenException
áá (
(
áá( )
ErrorMessages
áá) 6
.
áá6 74
&UnsupportedAppointmentStatusTransition
áá7 ]
)
áá] ^
;
áá^ _
}
àà 	
}
ââ 
private
ãã 
static
ãã #
DoctorAvailabilityDto
ãã (#
CreateAvailabilityDto
ãã) >
(
ãã> ?
int
ãã? B
doctorId
ããC K
,
ããK L
bool
ããM Q
isAvailable
ããR ]
)
ãã] ^
{
åå 
return
çç 
new
çç #
DoctorAvailabilityDto
çç (
{
éé 	
DoctorId
èè 
=
èè 
doctorId
èè 
,
èè  
IsAvailable
êê 
=
êê 
isAvailable
êê %
,
êê% &
Message
ëë 
=
ëë 
isAvailable
ëë !
?
íí 
ErrorMessages
íí 
.
íí  $
DoctorAvailableMessage
íí  6
:
ìì 
ErrorMessages
ìì 
.
ìì  &
DoctorUnavailableMessage
ìì  8
}
îî 	
;
îî	 

}
ïï 
private
ññ 
static
ññ 
async
ññ 
Task
ññ %
HandleDeactivationAsync
ññ 5
(
ññ5 6
int
óó 
doctorId
óó 
,
óó 
string
òò 

currentRole
òò 
,
òò $
IAppointmentRepository
ôô +
appointmentRepositoryInstance
ôô 8
)
ôô8 9
{
öö 
var
õõ 
today
õõ 
=
õõ 
DateOnly
õõ 
.
õõ 
FromDateTime
õõ )
(
õõ) *
DateTime
õõ* 2
.
õõ2 3
Today
õõ3 8
)
õõ8 9
;
õõ9 :
if
ùù 

(
ùù 
currentRole
ùù 
==
ùù 
AppRoles
ùù #
.
ùù# $
Doctor
ùù$ *
)
ùù* +
{
ûû 	
await
üü 0
"EnsureDoctorCanDeactivateSelfAsync
üü 4
(
üü4 5
doctorId
†† 
,
†† 
today
°° 
,
°° +
appointmentRepositoryInstance
¢¢ -
)
¢¢- .
;
¢¢. /
return
§§ 
;
§§ 
}
•• 	
if
ßß 

(
ßß 
currentRole
ßß 
==
ßß 
AppRoles
ßß #
.
ßß# $
Admin
ßß$ )
)
ßß) *
{
®® 	
await
©© ?
1CancelTodaysAppointmentsForAdminDeactivationAsync
©© C
(
©©C D
doctorId
™™ 
,
™™ 
today
´´ 
,
´´ +
appointmentRepositoryInstance
¨¨ -
)
¨¨- .
;
¨¨. /
}
≠≠ 	
}
ÆÆ 
private
∞∞ 
static
∞∞ 
async
∞∞ 
Task
∞∞ 0
"EnsureDoctorCanDeactivateSelfAsync
∞∞ @
(
∞∞@ A
int
±± 
doctorId
±± 
,
±± 
DateOnly
≤≤ 
today
≤≤ 
,
≤≤ $
IAppointmentRepository
≥≥ +
appointmentRepositoryInstance
≥≥ <
)
≥≥< =
{
¥¥ 
var
µµ +
hasConfirmedAppointmentsToday
µµ )
=
µµ* +
await
µµ, 1+
appointmentRepositoryInstance
µµ2 O
.
∂∂ 7
)DoctorHasConfirmedAppointmentsOnDateAsync
∂∂ 6
(
∂∂6 7
doctorId
∂∂7 ?
,
∂∂? @
today
∂∂A F
)
∂∂F G
;
∂∂G H
if
∏∏ 

(
∏∏ +
hasConfirmedAppointmentsToday
∏∏ )
)
∏∏) *
{
ππ 	
throw
∫∫ 
new
∫∫ #
BusinessRuleException
∫∫ +
(
∫∫+ ,
ErrorMessages
∫∫, 9
.
∫∫9 :B
4DoctorCannotDeactivateWithConfirmedAppointmentsToday
∫∫: n
)
∫∫n o
;
∫∫o p
}
ªª 	
}
ºº 
private
ææ 
static
ææ 
async
ææ 
Task
ææ ?
1CancelTodaysAppointmentsForAdminDeactivationAsync
ææ O
(
ææO P
int
øø 
doctorId
øø 
,
øø 
DateOnly
¿¿ 
today
¿¿ 
,
¿¿ $
IAppointmentRepository
¡¡ +
appointmentRepositoryInstance
¡¡ <
)
¡¡< =
{
¬¬ 
var
√√ "
appointmentsToCancel
√√  
=
√√! "
await
√√# (+
appointmentRepositoryInstance
√√) F
.
ƒƒ E
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync
ƒƒ D
(
ƒƒD E
doctorId
ƒƒE M
,
ƒƒM N
today
ƒƒO T
)
ƒƒT U
;
ƒƒU V
foreach
∆∆ 
(
∆∆ 
var
∆∆ 
appointment
∆∆  
in
∆∆! #"
appointmentsToCancel
∆∆$ 8
)
∆∆8 9
{
«« 	
appointment
»» 
.
»» 
Status
»» 
=
»»  
AppointmentStatus
»»! 2
.
»»2 3
	Cancelled
»»3 <
;
»»< =
appointment
…… 
.
……  
CancellationReason
…… *
=
……+ ,
ErrorMessages
……- :
.
……: ;/
!DoctorEmergencyCancellationReason
……; \
;
……\ ]
await
ÀÀ +
appointmentRepositoryInstance
ÀÀ /
.
ÀÀ/ 0
UpdateAsync
ÀÀ0 ;
(
ÀÀ; <
appointment
ÀÀ< G
)
ÀÀG H
;
ÀÀH I
}
ÃÃ 	
}
ÕÕ 
}ŒŒ ó≥
SC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\AuthService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
.! "
Impl" &
;& '
public 
class 
AuthService 
( 
UserManager 
< 
IdentityUser 
> 
userManager )
,) *
HealthAxisDbContext 
context 
,  
IPatientRepository 
patientRepository (
,( )
IDoctorRepository 
doctorRepository &
,& '
IConfiguration 
configuration  
)  !
:" #
IAuthService$ 0
{ 
private 
const 
string  
RefreshTokenProvider -
=. /
$str0 <
;< =
private 
const 
string 
RefreshTokenName )
=* +
$str, :
;: ;
private 
const 
string "
RefreshTokenExpiryName /
=0 1
$str2 I
;I J
public 

async 
Task 
< 
( 
bool 
Success #
,# $
string% +
Message, 3
,3 4
string5 ;
UserId< B
)B C
>C D
RegisterAsyncE R
(R S
RegisterDtoS ^
request_ f
)f g
{ 
if   

(   
request   
.   
Password   
!=   
request    '
.  ' (
ConfirmPassword  ( 7
)  7 8
{!! 	
return"" 
("" 
false"" 
,"" 
ErrorMessages"" (
.""( )
PasswordsDoNotMatch"") <
,""< =
string""> D
.""D E
Empty""E J
)""J K
;""K L
}## 	
var%% 
existingUser%% 
=%% 
await%%  
userManager%%! ,
.%%, -
FindByEmailAsync%%- =
(%%= >
request%%> E
.%%E F
Email%%F K
)%%K L
;%%L M
if'' 

('' 
existingUser'' 
!='' 
null''  
)''  !
{(( 	
return)) 
()) 
false)) 
,)) 
ErrorMessages)) (
.))( )"
EmailAlreadyRegistered))) ?
,))? @
string))A G
.))G H
Empty))H M
)))M N
;))N O
}** 	
await,, 
using,, 
var,, 
transaction,, #
=,,$ %
await,,& +
context,,, 3
.,,3 4
Database,,4 <
.,,< =!
BeginTransactionAsync,,= R
(,,R S
),,S T
;,,T U
try.. 
{// 	
var00 
user00 
=00 
new00 
IdentityUser00 '
{11 
UserName22 
=22 
request22 "
.22" #
Email22# (
,22( )
Email33 
=33 
request33 
.33  
Email33  %
,33% &
EmailConfirmed44 
=44  
true44! %
,44% &
PhoneNumber55 
=55 
request55 %
.55% &
PhoneNumber55& 1
}66 
;66 
var88 
createResult88 
=88 
await88 $
userManager88% 0
.880 1
CreateAsync881 <
(88< =
user88= A
,88A B
request88C J
.88J K
Password88K S
)88S T
;88T U
if:: 
(:: 
!:: 
createResult:: 
.:: 
	Succeeded:: '
)::' (
{;; 
var<< 
errors<< 
=<< 
string<< #
.<<# $
Join<<$ (
(<<( )
$str<<) -
,<<- .
createResult<</ ;
.<<; <
Errors<<< B
.<<B C
Select<<C I
(<<I J
error<<J O
=><<P R
error<<S X
.<<X Y
Description<<Y d
)<<d e
)<<e f
;<<f g
await== 
transaction== !
.==! "
RollbackAsync==" /
(==/ 0
)==0 1
;==1 2
return>> 
(>> 
false>> 
,>> 
errors>> %
,>>% &
string>>' -
.>>- .
Empty>>. 3
)>>3 4
;>>4 5
}?? 
varAA 

roleResultAA 
=AA 
awaitAA "
userManagerAA# .
.AA. /
AddToRoleAsyncAA/ =
(AA= >
userAA> B
,AAB C
AppRolesAAD L
.AAL M
PatientAAM T
)AAT U
;AAU V
ifCC 
(CC 
!CC 

roleResultCC 
.CC 
	SucceededCC %
)CC% &
{DD 
varEE 
errorsEE 
=EE 
stringEE #
.EE# $
JoinEE$ (
(EE( )
$strEE) -
,EE- .

roleResultEE/ 9
.EE9 :
ErrorsEE: @
.EE@ A
SelectEEA G
(EEG H
errorEEH M
=>EEN P
errorEEQ V
.EEV W
DescriptionEEW b
)EEb c
)EEc d
;EEd e
awaitFF 
transactionFF !
.FF! "
RollbackAsyncFF" /
(FF/ 0
)FF0 1
;FF1 2
returnGG 
(GG 
falseGG 
,GG 
errorsGG %
,GG% &
stringGG' -
.GG- .
EmptyGG. 3
)GG3 4
;GG4 5
}HH 
varJJ 
patientJJ 
=JJ 
newJJ 
PatientJJ %
{KK 
UserIdLL 
=LL 
userLL 
.LL 
IdLL  
,LL  !
FullNameMM 
=MM 
requestMM "
.MM" #
FullNameMM# +
,MM+ ,
DateOfBirthNN 
=NN 
requestNN %
.NN% &
DateOfBirthNN& 1
,NN1 2
GenderOO 
=OO 
requestOO  
.OO  !
GenderOO! '
,OO' (
AddressPP 
=PP 
requestPP !
.PP! "
AddressPP" )
}QQ 
;QQ 
awaitSS 
contextSS 
.SS 
PatientsSS "
.SS" #
AddAsyncSS# +
(SS+ ,
patientSS, 3
)SS3 4
;SS4 5
awaitTT 
contextTT 
.TT 
SaveChangesAsyncTT *
(TT* +
)TT+ ,
;TT, -
awaitVV 
transactionVV 
.VV 
CommitAsyncVV )
(VV) *
)VV* +
;VV+ ,
returnXX 
(XX 
trueXX 
,XX 
$strXX 9
,XX9 :
userXX; ?
.XX? @
IdXX@ B
)XXB C
;XXC D
}YY 	
catchZZ 
{[[ 	
await\\ 
transaction\\ 
.\\ 
RollbackAsync\\ +
(\\+ ,
)\\, -
;\\- .
throw]] 
;]] 
}^^ 	
}__ 
publicaa 

asyncaa 
Taskaa 
<aa 
(aa 
boolaa 
Successaa #
,aa# $
stringaa% +
Messageaa, 3
,aa3 4
AuthResponseDtoaa5 D
?aaD E
ResponseaaF N
)aaN O
>aaO P

LoginAsyncaaQ [
(aa[ \
LoginDtoaa\ d
requestaae l
)aal m
{bb 
varcc 
usercc 
=cc 
awaitcc 
userManagercc $
.cc$ %
FindByEmailAsynccc% 5
(cc5 6
requestcc6 =
.cc= >
Emailcc> C
)ccC D
;ccD E
ifee 

(ee 
useree 
==ee 
nullee 
)ee 
{ff 	
returngg 
(gg 
falsegg 
,gg 
ErrorMessagesgg (
.gg( )
InvalidCredentialsgg) ;
,gg; <
nullgg= A
)ggA B
;ggB C
}hh 	
varjj 
isPasswordValidjj 
=jj 
awaitjj #
userManagerjj$ /
.jj/ 0
CheckPasswordAsyncjj0 B
(jjB C
userjjC G
,jjG H
requestjjI P
.jjP Q
PasswordjjQ Y
)jjY Z
;jjZ [
ifll 

(ll 
!ll 
isPasswordValidll 
)ll 
{mm 	
returnnn 
(nn 
falsenn 
,nn 
ErrorMessagesnn (
.nn( )
InvalidCredentialsnn) ;
,nn; <
nullnn= A
)nnA B
;nnB C
}oo 	
varqq 
profileResultqq 
=qq 
awaitqq !!
BuildUserProfileAsyncqq" 7
(qq7 8
userqq8 <
)qq< =
;qq= >
ifss 

(ss 
!ss 
profileResultss 
.ss 
Successss "
)ss" #
{tt 	
returnuu 
(uu 
falseuu 
,uu 
profileResultuu (
.uu( )
Messageuu) 0
,uu0 1
nulluu2 6
)uu6 7
;uu7 8
}vv 	
varxx 
responsexx 
=xx 
awaitxx %
GenerateAuthResponseAsyncxx 6
(xx6 7
useryy 
,yy 
profileResultzz 
.zz 
Roleszz 
,zz  
profileResult{{ 
.{{ 
Role{{ 
,{{ 
profileResult|| 
.|| 
	PatientId|| #
,||# $
profileResult}} 
.}} 
DoctorId}} "
,}}" #
$str~~ *
)~~* +
;~~+ ,
return
ÄÄ 
(
ÄÄ 
true
ÄÄ 
,
ÄÄ 
response
ÄÄ 
.
ÄÄ 
Message
ÄÄ &
,
ÄÄ& '
response
ÄÄ( 0
)
ÄÄ0 1
;
ÄÄ1 2
}
ÅÅ 
private
«« 
async
«« 
Task
«« 
<
«« 
(
«« 
bool
«« 
Success
«« $
,
««$ %
string
««& ,
Message
««- 4
,
««4 5
IList
««6 ;
<
««; <
string
««< B
>
««B C
Roles
««D I
,
««I J
string
««K Q
Role
««R V
,
««V W
int
««X [
?
««[ \
	PatientId
««] f
,
««f g
int
««h k
?
««k l
DoctorId
««m u
)
««u v
>
««v w$
BuildUserProfileAsync««x ç
(««ç é
IdentityUser««é ö
user««õ ü
)««ü †
{
»» 
var
…… 
roles
…… 
=
…… 
await
…… 
userManager
…… %
.
……% &
GetRolesAsync
……& 3
(
……3 4
user
……4 8
)
……8 9
;
……9 :
var
   
role
   
=
   
roles
   
.
   
FirstOrDefault
   '
(
  ' (
)
  ( )
??
  * ,
string
  - 3
.
  3 4
Empty
  4 9
;
  9 :
int
ÃÃ 
?
ÃÃ 
	patientId
ÃÃ 
=
ÃÃ 
null
ÃÃ 
;
ÃÃ 
int
ÕÕ 
?
ÕÕ 
doctorId
ÕÕ 
=
ÕÕ 
null
ÕÕ 
;
ÕÕ 
if
œœ 

(
œœ 
string
œœ 
.
œœ 
Equals
œœ 
(
œœ 
role
œœ 
,
œœ 
AppRoles
œœ  (
.
œœ( )
Patient
œœ) 0
,
œœ0 1
StringComparison
œœ2 B
.
œœB C
OrdinalIgnoreCase
œœC T
)
œœT U
)
œœU V
{
–– 	
var
—— 
patient
—— 
=
—— 
await
—— 
patientRepository
——  1
.
——1 2%
GetPatientByUserIdAsync
——2 I
(
——I J
user
——J N
.
——N O
Id
——O Q
)
——Q R
;
——R S
if
”” 
(
”” 
patient
”” 
==
”” 
null
”” 
)
””  
{
‘‘ 
return
’’ 
(
’’ 
false
’’ 
,
’’ 
ErrorMessages
’’ ,
.
’’, -$
PatientProfileNotFound
’’- C
,
’’C D
roles
’’E J
,
’’J K
role
’’L P
,
’’P Q
null
’’R V
,
’’V W
null
’’X \
)
’’\ ]
;
’’] ^
}
÷÷ 
	patientId
ÿÿ 
=
ÿÿ 
patient
ÿÿ 
.
ÿÿ  
Id
ÿÿ  "
;
ÿÿ" #
}
ŸŸ 	
if
€€ 

(
€€ 
string
€€ 
.
€€ 
Equals
€€ 
(
€€ 
role
€€ 
,
€€ 
AppRoles
€€  (
.
€€( )
Doctor
€€) /
,
€€/ 0
StringComparison
€€1 A
.
€€A B
OrdinalIgnoreCase
€€B S
)
€€S T
)
€€T U
{
‹‹ 	
var
›› 
doctor
›› 
=
›› 
await
›› 
doctorRepository
›› /
.
››/ 0$
GetDoctorByUserIdAsync
››0 F
(
››F G
user
››G K
.
››K L
Id
››L N
)
››N O
;
››O P
if
ﬂﬂ 
(
ﬂﬂ 
doctor
ﬂﬂ 
==
ﬂﬂ 
null
ﬂﬂ 
)
ﬂﬂ 
{
‡‡ 
return
·· 
(
·· 
false
·· 
,
·· 
ErrorMessages
·· ,
.
··, -#
DoctorProfileNotFound
··- B
,
··B C
roles
··D I
,
··I J
role
··K O
,
··O P
null
··Q U
,
··U V
null
··W [
)
··[ \
;
··\ ]
}
‚‚ 
doctorId
‰‰ 
=
‰‰ 
doctor
‰‰ 
.
‰‰ 
Id
‰‰  
;
‰‰  !
}
ÂÂ 	
return
ÁÁ 
(
ÁÁ 
true
ÁÁ 
,
ÁÁ 
string
ÁÁ 
.
ÁÁ 
Empty
ÁÁ "
,
ÁÁ" #
roles
ÁÁ$ )
,
ÁÁ) *
role
ÁÁ+ /
,
ÁÁ/ 0
	patientId
ÁÁ1 :
,
ÁÁ: ;
doctorId
ÁÁ< D
)
ÁÁD E
;
ÁÁE F
}
ËË 
private
ÍÍ 
async
ÍÍ 
Task
ÍÍ 
<
ÍÍ 
AuthResponseDto
ÍÍ &
>
ÍÍ& ''
GenerateAuthResponseAsync
ÍÍ( A
(
ÍÍA B
IdentityUser
ÎÎ 
user
ÎÎ 
,
ÎÎ 
IList
ÏÏ 
<
ÏÏ 
string
ÏÏ 
>
ÏÏ 
roles
ÏÏ 
,
ÏÏ 
string
ÌÌ 
role
ÌÌ 
,
ÌÌ 
int
ÓÓ 
?
ÓÓ 
	patientId
ÓÓ 
,
ÓÓ 
int
ÔÔ 
?
ÔÔ 
doctorId
ÔÔ 
,
ÔÔ 
string
 
message
 
)
 
{
ÒÒ 
var
ÚÚ 
	expiresIn
ÚÚ 
=
ÚÚ 
int
ÚÚ 
.
ÚÚ 
Parse
ÚÚ !
(
ÚÚ! "
configuration
ÚÚ" /
.
ÚÚ/ 0

GetSection
ÚÚ0 :
(
ÚÚ: ;
$str
ÚÚ; @
)
ÚÚ@ A
[
ÚÚA B
$str
ÚÚB `
]
ÚÚ` a
!
ÚÚa b
)
ÚÚb c
;
ÚÚc d
var
ÛÛ 
token
ÛÛ 
=
ÛÛ 
GenerateToken
ÛÛ !
(
ÛÛ! "
user
ÛÛ" &
,
ÛÛ& '
roles
ÛÛ( -
,
ÛÛ- .
	expiresIn
ÛÛ/ 8
,
ÛÛ8 9
	patientId
ÛÛ: C
,
ÛÛC D
doctorId
ÛÛE M
)
ÛÛM N
;
ÛÛN O
return
˘˘ 
new
˘˘ 
AuthResponseDto
˘˘ "
{
˙˙ 	
AccessToken
˚˚ 
=
˚˚ 
token
˚˚ 
,
˚˚  
Message
˝˝ 
=
˝˝ 
message
˝˝ 
,
˝˝ 
	ExpiresIn
˛˛ 
=
˛˛ 
	expiresIn
˛˛ !
,
˛˛! "
UserId
ˇˇ 
=
ˇˇ 
user
ˇˇ 
.
ˇˇ 
Id
ˇˇ 
,
ˇˇ 
	PatientId
ÄÄ 
=
ÄÄ 
	patientId
ÄÄ !
,
ÄÄ! "
DoctorId
ÅÅ 
=
ÅÅ 
doctorId
ÅÅ 
,
ÅÅ  
Email
ÇÇ 
=
ÇÇ 
user
ÇÇ 
.
ÇÇ 
Email
ÇÇ 
??
ÇÇ !
string
ÇÇ" (
.
ÇÇ( )
Empty
ÇÇ) .
,
ÇÇ. /
Role
ÉÉ 
=
ÉÉ 
role
ÉÉ 
}
ÑÑ 	
;
ÑÑ	 

}
ÖÖ 
private
®® 
string
®® 
GenerateToken
®®  
(
®®  !
IdentityUser
©© 
user
©© 
,
©© 
IList
™™ 
<
™™ 
string
™™ 
>
™™ 
roles
™™ 
,
™™ 
int
´´ 
	expiresIn
´´ 
,
´´ 
int
¨¨ 
?
¨¨ 
	patientId
¨¨ 
,
¨¨ 
int
≠≠ 
?
≠≠ 
doctorId
≠≠ 
)
≠≠ 
{
ÆÆ 
var
ØØ 
jwtSettings
ØØ 
=
ØØ 
configuration
ØØ '
.
ØØ' (

GetSection
ØØ( 2
(
ØØ2 3
$str
ØØ3 8
)
ØØ8 9
;
ØØ9 :
var
±± 
key
±± 
=
±± 
new
±± "
SymmetricSecurityKey
±± *
(
±±* +
Encoding
≤≤ 
.
≤≤ 
UTF8
≤≤ 
.
≤≤ 
GetBytes
≤≤ "
(
≤≤" #
jwtSettings
≤≤# .
[
≤≤. /
$str
≤≤/ 4
]
≤≤4 5
!
≤≤5 6
)
≤≤6 7
)
≥≥ 	
;
≥≥	 

var
µµ 
credentials
µµ 
=
µµ 
new
µµ  
SigningCredentials
µµ 0
(
µµ0 1
key
µµ1 4
,
µµ4 5 
SecurityAlgorithms
µµ6 H
.
µµH I

HmacSha256
µµI S
)
µµS T
;
µµT U
var
∑∑ 
claims
∑∑ 
=
∑∑ 
new
∑∑ 
List
∑∑ 
<
∑∑ 
Claim
∑∑ #
>
∑∑# $
{
∏∏ 	
new
ππ 
Claim
ππ 
(
ππ 
AppClaimTypes
ππ #
.
ππ# $
UserId
ππ$ *
,
ππ* +
user
ππ, 0
.
ππ0 1
Id
ππ1 3
)
ππ3 4
,
ππ4 5
new
∫∫ 
Claim
∫∫ 
(
∫∫ %
JwtRegisteredClaimNames
∫∫ -
.
∫∫- .
Sub
∫∫. 1
,
∫∫1 2
user
∫∫3 7
.
∫∫7 8
Id
∫∫8 :
)
∫∫: ;
,
∫∫; <
new
ªª 
Claim
ªª 
(
ªª %
JwtRegisteredClaimNames
ªª -
.
ªª- .
Email
ªª. 3
,
ªª3 4
user
ªª5 9
.
ªª9 :
Email
ªª: ?
??
ªª@ B
string
ªªC I
.
ªªI J
Empty
ªªJ O
)
ªªO P
,
ªªP Q
new
ºº 
Claim
ºº 
(
ºº 

ClaimTypes
ºº  
.
ºº  !
NameIdentifier
ºº! /
,
ºº/ 0
user
ºº1 5
.
ºº5 6
Id
ºº6 8
)
ºº8 9
,
ºº9 :
new
ΩΩ 
Claim
ΩΩ 
(
ΩΩ 

ClaimTypes
ΩΩ  
.
ΩΩ  !
Email
ΩΩ! &
,
ΩΩ& '
user
ΩΩ( ,
.
ΩΩ, -
Email
ΩΩ- 2
??
ΩΩ3 5
string
ΩΩ6 <
.
ΩΩ< =
Empty
ΩΩ= B
)
ΩΩB C
,
ΩΩC D
new
ææ 
Claim
ææ 
(
ææ %
JwtRegisteredClaimNames
ææ -
.
ææ- .
Jti
ææ. 1
,
ææ1 2
Guid
ææ3 7
.
ææ7 8
NewGuid
ææ8 ?
(
ææ? @
)
ææ@ A
.
ææA B
ToString
ææB J
(
ææJ K
)
ææK L
)
ææL M
}
øø 	
;
øø	 

foreach
¡¡ 
(
¡¡ 
var
¡¡ 
role
¡¡ 
in
¡¡ 
roles
¡¡ "
)
¡¡" #
{
¬¬ 	
claims
√√ 
.
√√ 
Add
√√ 
(
√√ 
new
√√ 
Claim
√√  
(
√√  !
AppClaimTypes
√√! .
.
√√. /
Role
√√/ 3
,
√√3 4
role
√√5 9
)
√√9 :
)
√√: ;
;
√√; <
claims
ƒƒ 
.
ƒƒ 
Add
ƒƒ 
(
ƒƒ 
new
ƒƒ 
Claim
ƒƒ  
(
ƒƒ  !

ClaimTypes
ƒƒ! +
.
ƒƒ+ ,
Role
ƒƒ, 0
,
ƒƒ0 1
role
ƒƒ2 6
)
ƒƒ6 7
)
ƒƒ7 8
;
ƒƒ8 9
}
≈≈ 	
if
«« 

(
«« 
	patientId
«« 
.
«« 
HasValue
«« 
)
«« 
{
»» 	
claims
…… 
.
…… 
Add
…… 
(
…… 
new
…… 
Claim
……  
(
……  !
AppClaimTypes
……! .
.
……. /
	PatientId
……/ 8
,
……8 9
	patientId
……: C
.
……C D
Value
……D I
.
……I J
ToString
……J R
(
……R S
)
……S T
)
……T U
)
……U V
;
……V W
}
   	
if
ÃÃ 

(
ÃÃ 
doctorId
ÃÃ 
.
ÃÃ 
HasValue
ÃÃ 
)
ÃÃ 
{
ÕÕ 	
claims
ŒŒ 
.
ŒŒ 
Add
ŒŒ 
(
ŒŒ 
new
ŒŒ 
Claim
ŒŒ  
(
ŒŒ  !
AppClaimTypes
ŒŒ! .
.
ŒŒ. /
DoctorId
ŒŒ/ 7
,
ŒŒ7 8
doctorId
ŒŒ9 A
.
ŒŒA B
Value
ŒŒB G
.
ŒŒG H
ToString
ŒŒH P
(
ŒŒP Q
)
ŒŒQ R
)
ŒŒR S
)
ŒŒS T
;
ŒŒT U
}
œœ 	
var
—— 
token
—— 
=
—— 
new
—— 
JwtSecurityToken
—— (
(
——( )
issuer
““ 
:
““ 
jwtSettings
““ 
[
““  
$str
““  (
]
““( )
,
““) *
audience
”” 
:
”” 
jwtSettings
”” !
[
””! "
$str
””" ,
]
””, -
,
””- .
claims
‘‘ 
:
‘‘ 
claims
‘‘ 
,
‘‘ 
expires
’’ 
:
’’ 
DateTime
’’ 
.
’’ 
UtcNow
’’ $
.
’’$ %

AddMinutes
’’% /
(
’’/ 0
	expiresIn
’’0 9
)
’’9 :
,
’’: ; 
signingCredentials
÷÷ 
:
÷÷ 
credentials
÷÷  +
)
◊◊ 	
;
◊◊	 

return
ŸŸ 
new
ŸŸ %
JwtSecurityTokenHandler
ŸŸ *
(
ŸŸ* +
)
ŸŸ+ ,
.
ŸŸ, -

WriteToken
ŸŸ- 7
(
ŸŸ7 8
token
ŸŸ8 =
)
ŸŸ= >
;
ŸŸ> ?
}
⁄⁄ 
}ÏÏ ÷
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
int )
MinimumHoursBeforeAppointment 3
=4 5
$num6 8
;8 9
public 

async 
Task 
< 
PagedResultDto $
<$ %
AppointmentDto% 3
>3 4
>4 5#
GetAllAppointmentsAsync6 M
(M N
PaginationQueryDtoN `

paginationa k
)k l
{ 
await 5
)AutoCancelExpiredPendingAppointmentsAsync 7
(7 8
)8 9
;9 :
var 
appointments 
= 
await  !
appointmentRepository! 6
.6 7#
GetAllAppointmentsAsync7 N
(N O

pagination 
. 

PageNumber !
,! "

pagination 
. 
PageSize 
)  
;  !
return 
MapPagedResult 
< 
Appointment )
,) *
AppointmentDto+ 9
>9 :
(: ;
appointments; G
)G H
;H I
} 
public   

async   
Task   
<   
AppointmentDto   $
>  $ %#
GetAppointmentByIdAsync  & =
(  = >
int  > A
id  B D
)  D E
{!! 
await"" 5
)AutoCancelExpiredPendingAppointmentsAsync"" 7
(""7 8
)""8 9
;""9 :
var$$ 
appointment$$ 
=$$ 
await$$ !
appointmentRepository$$  5
.$$5 6.
"GetAppointmentByIdWithDetailsAsync$$6 X
($$X Y
id$$Y [
)$$[ \
;$$\ ]
if&& 

(&& 
appointment&& 
==&& 
null&& 
)&&  
{'' 	
throw(( 
new(( 
NotFoundException(( '
(((' (
ErrorMessages((( 5
.((5 6
AppointmentNotFound((6 I
)((I J
;((J K
})) 	
return++ 
mapper++ 
.++ 
Map++ 
<++ 
AppointmentDto++ (
>++( )
(++) *
appointment++* 5
)++5 6
;++6 7
},, 
public.. 

async.. 
Task.. 
<.. 
AppointmentDto.. $
?..$ %
>..% &"
CreateAppointmentAsync..' =
(..= > 
CreateAppointmentDto..> R
dto..S V
)..V W
{// 
await00 0
$ValidateAppointmentCanBeCreatedAsync00 2
(002 3
dto003 6
)006 7
;007 8
var22 
appointment22 
=22 
new22 
Appointment22 )
{33 	
	PatientId44 
=44 
dto44 
.44 
	PatientId44 %
,44% &
DoctorId55 
=55 
dto55 
.55 
DoctorId55 #
,55# $
AppointmentDate66 
=66 
dto66 !
.66! "
AppointmentDate66" 1
,661 2
AppointmentTime77 
=77 
dto77 !
.77! "
AppointmentTime77" 1
,771 2
Status88 
=88 
AppointmentStatus88 &
.88& '
Pending88' .
}99 	
;99	 

var;; 
createdAppointment;; 
=;;  
await;;! &!
appointmentRepository;;' <
.;;< =
AddAsync;;= E
(;;E F
appointment;;F Q
);;Q R
;;;R S
var== "
appointmentWithDetails== "
===# $
await==% *!
appointmentRepository==+ @
.==@ A.
"GetAppointmentByIdWithDetailsAsync==A c
(==c d
createdAppointment==d v
.==v w
Id==w y
)==y z
;==z {
return?? "
appointmentWithDetails?? %
==??& (
null??) -
?@@ 
throw@@ 
new@@ 
NotFoundException@@ )
(@@) *
ErrorMessages@@* 7
.@@7 8,
 AppointmentNotFoundAfterCreation@@8 X
)@@X Y
:AA 
mapperAA 
.AA 
MapAA 
<AA 
AppointmentDtoAA '
>AA' (
(AA( )"
appointmentWithDetailsAA) ?
)AA? @
;AA@ A
}BB 
publicDD 

asyncDD 
TaskDD 
<DD 
PagedResultDtoDD $
<DD$ %
AppointmentDtoDD% 3
>DD3 4
>DD4 5*
GetAppointmentsByDoctorIdAsyncDD6 T
(DDT U
intEE 
doctorIdEE 
,EE 
AppointmentStatusFF 
?FF 
statusFF 
,FF 
PaginationQueryDtoGG 

paginationGG !
)GG! "
{HH 
awaitII 5
)AutoCancelExpiredPendingAppointmentsAsyncII 7
(II7 8
)II8 9
;II9 :
varKK 
appointmentsKK 
=KK 
awaitKK  !
appointmentRepositoryKK! 6
.KK6 7*
GetAppointmentsByDoctorIdAsyncKK7 U
(KKU V
doctorIdLL 
,LL 
statusMM 
,MM 

paginationNN 
.NN 

PageNumberNN !
,NN! "

paginationOO 
.OO 
PageSizeOO 
)OO  
;OO  !
returnQQ 
MapPagedResultQQ 
<QQ 
AppointmentQQ )
,QQ) *
AppointmentDtoQQ+ 9
>QQ9 :
(QQ: ;
appointmentsQQ; G
)QQG H
;QQH I
}RR 
publicTT 

asyncTT 
TaskTT 
<TT 
PagedResultDtoTT $
<TT$ %
AppointmentDtoTT% 3
>TT3 4
>TT4 5+
GetAppointmentsByPatientIdAsyncTT6 U
(TTU V
intUU 
	patientIdUU 
,UU 
AppointmentStatusVV 
?VV 
statusVV 
,VV 
PaginationQueryDtoWW 

paginationWW !
)WW! "
{XX 
awaitYY 5
)AutoCancelExpiredPendingAppointmentsAsyncYY 7
(YY7 8
)YY8 9
;YY9 :
var[[ 
appointments[[ 
=[[ 
await[[  !
appointmentRepository[[! 6
.[[6 7+
GetAppointmentsByPatientIdAsync[[7 V
([[V W
	patientId\\ 
,\\ 
status]] 
,]] 

pagination^^ 
.^^ 

PageNumber^^ !
,^^! "

pagination__ 
.__ 
PageSize__ 
)__  
;__  !
returnaa 
MapPagedResultaa 
<aa 
Appointmentaa )
,aa) *
AppointmentDtoaa+ 9
>aa9 :
(aa: ;
appointmentsaa; G
)aaG H
;aaH I
}bb 
publicdd 

asyncdd 
Taskdd 
<dd 
PagedResultDtodd $
<dd$ %
AppointmentDtodd% 3
>dd3 4
>dd4 51
%GetAppointmentsByDoctorIdAndDateAsyncdd6 [
(dd[ \
intee 
doctorIdee 
,ee 
DateOnlyff 
dateff 
,ff 
PaginationQueryDtogg 

paginationgg %
)gg% &
{hh 
awaitii 5
)AutoCancelExpiredPendingAppointmentsAsyncii 7
(ii7 8
)ii8 9
;ii9 :
varkk 
appointmentskk 
=kk 
awaitkk  !
appointmentRepositorykk! 6
.kk6 71
%GetAppointmentsByDoctorIdAndDateAsynckk7 \
(kk\ ]
doctorIdll 
,ll 
datemm 
,mm 

paginationnn 
.nn 

PageNumbernn !
,nn! "

paginationoo 
.oo 
PageSizeoo 
)oo  
;oo  !
returnqq 
MapPagedResultqq 
<qq 
Appointmentqq )
,qq) *
AppointmentDtoqq+ 9
>qq9 :
(qq: ;
appointmentsqq; G
)qqG H
;qqH I
}rr 
publictt 

asynctt 
Tasktt 
<tt 
PagedResultDtott $
<tt$ %
AppointmentDtott% 3
>tt3 4
>tt4 5/
#GetAppointmentsByDateAndStatusAsynctt6 Y
(ttY Z
DateOnlyuu 
dateuu 
,uu 
AppointmentStatusvv 
?vv 
statusvv !
,vv! "
PaginationQueryDtoww 

paginationww %
)ww% &
{xx 
awaityy 5
)AutoCancelExpiredPendingAppointmentsAsyncyy 7
(yy7 8
)yy8 9
;yy9 :
var{{ 
appointments{{ 
={{ 
await{{  !
appointmentRepository{{! 6
.{{6 7/
#GetAppointmentsByDateAndStatusAsync{{7 Z
({{Z [
date|| 
,|| 
status}} 
,}} 

pagination~~ 
.~~ 

PageNumber~~ !
,~~! "

pagination 
. 
PageSize 
)  
;  !
return
ÅÅ 
MapPagedResult
ÅÅ 
<
ÅÅ 
Appointment
ÅÅ )
,
ÅÅ) *
AppointmentDto
ÅÅ+ 9
>
ÅÅ9 :
(
ÅÅ: ;
appointments
ÅÅ; G
)
ÅÅG H
;
ÅÅH I
}
ÇÇ 
public
ÑÑ 

async
ÑÑ 
Task
ÑÑ 
<
ÑÑ 
AppointmentDto
ÑÑ $
?
ÑÑ$ %
>
ÑÑ% &*
UpdateAppointmentStatusAsync
ÑÑ' C
(
ÑÑC D
int
ÖÖ 
id
ÖÖ 
,
ÖÖ (
UpdateAppointmentStatusDto
ÜÜ "
dto
ÜÜ# &
,
ÜÜ& '
string
áá 
currentRole
áá 
,
áá 
int
àà 
?
àà 
currentPatientId
àà 
,
àà 
int
ââ 
?
ââ 
currentDoctorId
ââ 
)
ââ 
{
ää 
await
ãã 7
)AutoCancelExpiredPendingAppointmentsAsync
ãã 7
(
ãã7 8
)
ãã8 9
;
ãã9 :
var
çç 
appointment
çç 
=
çç 
await
çç #
appointmentRepository
çç  5
.
çç5 60
"GetAppointmentByIdWithDetailsAsync
çç6 X
(
ççX Y
id
ççY [
)
çç[ \
;
çç\ ]
if
èè 

(
èè 
appointment
èè 
==
èè 
null
èè 
)
èè  
{
êê 	
throw
ëë 
new
ëë 
NotFoundException
ëë '
(
ëë' (
ErrorMessages
ëë( 5
.
ëë5 6!
AppointmentNotFound
ëë6 I
)
ëëI J
;
ëëJ K
}
íí 	
switch
îî 
(
îî 
dto
îî 
.
îî 
Status
îî 
)
îî 
{
ïï 	
case
ññ 
AppointmentStatus
ññ "
.
ññ" #
	Confirmed
ññ# ,
:
ññ, - 
ConfirmAppointment
óó "
(
óó" #
appointment
óó# .
,
óó. /
currentRole
óó0 ;
,
óó; <
currentDoctorId
óó= L
)
óóL M
;
óóM N
break
òò 
;
òò 
case
öö 
AppointmentStatus
öö "
.
öö" #
	Cancelled
öö# ,
:
öö, -
CancelAppointment
õõ !
(
õõ! "
appointment
õõ" -
,
õõ- .
dto
õõ/ 2
,
õõ2 3
currentRole
õõ4 ?
,
õõ? @
currentPatientId
õõA Q
,
õõQ R
currentDoctorId
õõS b
)
õõb c
;
õõc d
break
úú 
;
úú 
case
ûû 
AppointmentStatus
ûû "
.
ûû" #
	Completed
ûû# ,
:
ûû, -
throw
üü 
new
üü #
BusinessRuleException
üü /
(
üü/ 0
ErrorMessages
üü0 =
.
üü= >9
+AppointmentCompletedOnlyThroughHealthRecord
üü> i
)
üüi j
;
üüj k
default
°° 
:
°° 
throw
¢¢ 
new
¢¢ #
BusinessRuleException
¢¢ /
(
¢¢/ 0
ErrorMessages
¢¢0 =
.
¢¢= >4
&UnsupportedAppointmentStatusTransition
¢¢> d
)
¢¢d e
;
¢¢e f
}
££ 	
await
•• #
appointmentRepository
•• #
.
••# $
UpdateAsync
••$ /
(
••/ 0
appointment
••0 ;
)
••; <
;
••< =
var
ßß $
appointmentWithDetails
ßß "
=
ßß# $
await
ßß% *#
appointmentRepository
ßß+ @
.
ßß@ A0
"GetAppointmentByIdWithDetailsAsync
ßßA c
(
ßßc d
id
ßßd f
)
ßßf g
;
ßßg h
return
©© $
appointmentWithDetails
©© %
==
©©& (
null
©©) -
?
™™ 
throw
™™ 
new
™™ 
NotFoundException
™™ )
(
™™) *
ErrorMessages
™™* 7
.
™™7 8!
AppointmentNotFound
™™8 K
)
™™K L
:
´´ 
mapper
´´ 
.
´´ 
Map
´´ 
<
´´ 
AppointmentDto
´´ '
>
´´' (
(
´´( )$
appointmentWithDetails
´´) ?
)
´´? @
;
´´@ A
}
¨¨ 
public
ÆÆ 

async
ÆÆ 
Task
ÆÆ 
<
ÆÆ 
List
ÆÆ 
<
ÆÆ "
AppointmentReportDto
ÆÆ /
>
ÆÆ/ 0
>
ÆÆ0 1(
GetAppointmentReportsAsync
ÆÆ2 L
(
ÆÆL M
)
ÆÆM N
{
ØØ 
await
∞∞ 7
)AutoCancelExpiredPendingAppointmentsAsync
∞∞ 7
(
∞∞7 8
)
∞∞8 9
;
∞∞9 :
return
≤≤ 
await
≤≤ #
appointmentRepository
≤≤ *
.
≤≤* +(
GetAppointmentReportsAsync
≤≤+ E
(
≤≤E F
)
≤≤F G
;
≤≤G H
}
≥≥ 
private
µµ 
async
µµ 
Task
µµ 2
$ValidateAppointmentCanBeCreatedAsync
µµ ;
(
µµ; <"
CreateAppointmentDto
µµ< P
dto
µµQ T
)
µµT U
{
∂∂ 
var
∑∑ 
patient
∑∑ 
=
∑∑ 
await
∑∑ 
patientRepository
∑∑ -
.
∑∑- .
GetByIdAsync
∑∑. :
(
∑∑: ;
dto
∑∑; >
.
∑∑> ?
	PatientId
∑∑? H
)
∑∑H I
;
∑∑I J
if
ππ 

(
ππ 
patient
ππ 
==
ππ 
null
ππ 
)
ππ 
{
∫∫ 	
throw
ªª 
new
ªª 
NotFoundException
ªª '
(
ªª' (
ErrorMessages
ªª( 5
.
ªª5 6
PatientNotFound
ªª6 E
)
ªªE F
;
ªªF G
}
ºº 	
var
ææ 
doctor
ææ 
=
ææ 
await
ææ 
doctorRepository
ææ +
.
ææ+ , 
GetDoctorByIdAsync
ææ, >
(
ææ> ?
dto
ææ? B
.
ææB C
DoctorId
ææC K
)
ææK L
;
ææL M
if
¿¿ 

(
¿¿ 
doctor
¿¿ 
==
¿¿ 
null
¿¿ 
)
¿¿ 
{
¡¡ 	
throw
¬¬ 
new
¬¬ 
NotFoundException
¬¬ '
(
¬¬' (
ErrorMessages
¬¬( 5
.
¬¬5 6
DoctorNotFound
¬¬6 D
)
¬¬D E
;
¬¬E F
}
√√ 	
if
≈≈ 

(
≈≈ 
!
≈≈ 
doctor
≈≈ 
.
≈≈ 
IsAvailable
≈≈ 
)
≈≈  
{
∆∆ 	
throw
«« 
new
«« #
BusinessRuleException
«« +
(
««+ ,
ErrorMessages
««, 9
.
««9 :
DoctorUnavailable
««: K
)
««K L
;
««L M
}
»» 	
if
   

(
   
!
   #
IsAtLeast24HoursAhead
   "
(
  " #
dto
  # &
.
  & '
AppointmentDate
  ' 6
,
  6 7
dto
  8 ;
.
  ; <
AppointmentTime
  < K
)
  K L
)
  L M
{
ÀÀ 	
throw
ÃÃ 
new
ÃÃ #
BusinessRuleException
ÃÃ +
(
ÃÃ+ ,
ErrorMessages
ÃÃ, 9
.
ÃÃ9 :8
*AppointmentMustBeBookedAtLeast24HoursAhead
ÃÃ: d
)
ÃÃd e
;
ÃÃe f
}
ÕÕ 	
if
œœ 

(
œœ 
await
œœ #
appointmentRepository
œœ '
.
œœ' (5
'DoctorHasNonCancelledAppointmentAtAsync
œœ( O
(
œœO P
dto
–– 
.
–– 
DoctorId
–– 
,
–– 
dto
—— 
.
—— 
AppointmentDate
—— #
,
——# $
dto
““ 
.
““ 
AppointmentTime
““ #
)
““# $
)
““$ %
{
”” 	
throw
‘‘ 
new
‘‘ 
ConflictException
‘‘ '
(
‘‘' (
ErrorMessages
‘‘( 5
.
‘‘5 6%
DoctorSlotAlreadyBooked
‘‘6 M
)
‘‘M N
;
‘‘N O
}
’’ 	
if
◊◊ 

(
◊◊ 
await
◊◊ #
appointmentRepository
◊◊ '
.
◊◊' (6
(PatientHasNonCancelledAppointmentAtAsync
◊◊( P
(
◊◊P Q
dto
ÿÿ 
.
ÿÿ 
	PatientId
ÿÿ 
,
ÿÿ 
dto
ŸŸ 
.
ŸŸ 
AppointmentDate
ŸŸ #
,
ŸŸ# $
dto
⁄⁄ 
.
⁄⁄ 
AppointmentTime
⁄⁄ #
)
⁄⁄# $
)
⁄⁄$ %
{
€€ 	
throw
‹‹ 
new
‹‹ 
ConflictException
‹‹ '
(
‹‹' (
ErrorMessages
‹‹( 5
.
‹‹5 6&
PatientSlotAlreadyBooked
‹‹6 N
)
‹‹N O
;
‹‹O P
}
›› 	
if
ﬂﬂ 

(
ﬂﬂ 
await
ﬂﬂ #
appointmentRepository
ﬂﬂ '
.
ﬂﬂ' (D
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsync
ﬂﬂ( ^
(
ﬂﬂ^ _
dto
‡‡ 
.
‡‡ 
	PatientId
‡‡ 
,
‡‡ 
dto
·· 
.
·· 
DoctorId
·· 
,
·· 
dto
‚‚ 
.
‚‚ 
AppointmentDate
‚‚ #
)
‚‚# $
)
‚‚$ %
{
„„ 	
throw
‰‰ 
new
‰‰ 
ConflictException
‰‰ '
(
‰‰' (
ErrorMessages
‰‰( 5
.
‰‰5 6:
,PatientAlreadyHasAppointmentWithDoctorOnDate
‰‰6 b
)
‰‰b c
;
‰‰c d
}
ÂÂ 	
}
ÊÊ 
private
ËË 
static
ËË 
void
ËË  
ConfirmAppointment
ËË *
(
ËË* +
Appointment
ËË+ 6
appointment
ËË7 B
,
ËËB C
string
ËËD J
currentRole
ËËK V
,
ËËV W
int
ËËX [
?
ËË[ \
currentDoctorId
ËË] l
)
ËËl m
{
ÈÈ 
if
ÍÍ 

(
ÍÍ 
appointment
ÍÍ 
.
ÍÍ 
Status
ÍÍ 
!=
ÍÍ !
AppointmentStatus
ÍÍ" 3
.
ÍÍ3 4
Pending
ÍÍ4 ;
)
ÍÍ; <
{
ÎÎ 	
throw
ÏÏ 
new
ÏÏ #
BusinessRuleException
ÏÏ +
(
ÏÏ+ ,
ErrorMessages
ÏÏ, 9
.
ÏÏ9 :3
%OnlyPendingAppointmentsCanBeConfirmed
ÏÏ: _
)
ÏÏ_ `
;
ÏÏ` a
}
ÌÌ 	
if
ÔÔ 

(
ÔÔ 
currentRole
ÔÔ 
==
ÔÔ 
AppRoles
ÔÔ #
.
ÔÔ# $
Patient
ÔÔ$ +
)
ÔÔ+ ,
{
 	
throw
ÒÒ 
new
ÒÒ  
ForbiddenException
ÒÒ (
(
ÒÒ( )
ErrorMessages
ÒÒ) 6
.
ÒÒ6 74
&UnsupportedAppointmentStatusTransition
ÒÒ7 ]
)
ÒÒ] ^
;
ÒÒ^ _
}
ÚÚ 	
if
ÙÙ 

(
ÙÙ 
currentRole
ÙÙ 
==
ÙÙ 
AppRoles
ÙÙ #
.
ÙÙ# $
Doctor
ÙÙ$ *
&&
ÙÙ+ -
currentDoctorId
ÙÙ. =
!=
ÙÙ> @
appointment
ÙÙA L
.
ÙÙL M
DoctorId
ÙÙM U
)
ÙÙU V
{
ıı 	
throw
ˆˆ 
new
ˆˆ  
ForbiddenException
ˆˆ (
(
ˆˆ( )
ErrorMessages
ˆˆ) 6
.
ˆˆ6 71
#DoctorsCanManageOnlyOwnAppointments
ˆˆ7 Z
)
ˆˆZ [
;
ˆˆ[ \
}
˜˜ 	
appointment
˘˘ 
.
˘˘ 
Status
˘˘ 
=
˘˘ 
AppointmentStatus
˘˘ .
.
˘˘. /
	Confirmed
˘˘/ 8
;
˘˘8 9
appointment
˙˙ 
.
˙˙  
CancellationReason
˙˙ &
=
˙˙' (
null
˙˙) -
;
˙˙- .
}
˚˚ 
private
˝˝ 
static
˝˝ 
void
˝˝ 
CancelAppointment
˝˝ )
(
˝˝) *
Appointment
˛˛ 
appointment
˛˛ 
,
˛˛  (
UpdateAppointmentStatusDto
ˇˇ "
dto
ˇˇ# &
,
ˇˇ& '
string
ÄÄ 
currentRole
ÄÄ 
,
ÄÄ 
int
ÅÅ 
?
ÅÅ 
currentPatientId
ÅÅ 
,
ÅÅ 
int
ÇÇ 
?
ÇÇ 
currentDoctorId
ÇÇ 
)
ÇÇ 
{
ÉÉ 
if
ÑÑ 

(
ÑÑ 
string
ÑÑ 
.
ÑÑ  
IsNullOrWhiteSpace
ÑÑ %
(
ÑÑ% &
dto
ÑÑ& )
.
ÑÑ) * 
CancellationReason
ÑÑ* <
)
ÑÑ< =
)
ÑÑ= >
{
ÖÖ 	
throw
ÜÜ 
new
ÜÜ #
BusinessRuleException
ÜÜ +
(
ÜÜ+ ,
ErrorMessages
ÜÜ, 9
.
ÜÜ9 :(
CancellationReasonRequired
ÜÜ: T
)
ÜÜT U
;
ÜÜU V
}
áá 	
if
ââ 

(
ââ 
appointment
ââ 
.
ââ 
Status
ââ 
==
ââ !
AppointmentStatus
ââ" 3
.
ââ3 4
	Completed
ââ4 =
)
ââ= >
{
ää 	
throw
ãã 
new
ãã #
BusinessRuleException
ãã +
(
ãã+ ,
ErrorMessages
ãã, 9
.
ãã9 :4
&CompletedAppointmentsCannotBeCancelled
ãã: `
)
ãã` a
;
ããa b
}
åå 	
if
éé 

(
éé 
appointment
éé 
.
éé 
Status
éé 
==
éé !
AppointmentStatus
éé" 3
.
éé3 4
	Cancelled
éé4 =
)
éé= >
{
èè 	
throw
êê 
new
êê #
BusinessRuleException
êê +
(
êê+ ,
ErrorMessages
êê, 9
.
êê9 :9
+CancelledAppointmentsCannotBeCancelledAgain
êê: e
)
êêe f
;
êêf g
}
ëë 	
var
ìì 
reason
ìì 
=
ìì 
dto
ìì 
.
ìì  
CancellationReason
ìì +
.
ìì+ ,
Trim
ìì, 0
(
ìì0 1
)
ìì1 2
;
ìì2 3
if
ïï 

(
ïï 
currentRole
ïï 
==
ïï 
AppRoles
ïï #
.
ïï# $
Patient
ïï$ +
)
ïï+ ,
{
ññ 	
if
óó 
(
óó 
currentPatientId
óó  
!=
óó! #
appointment
óó$ /
.
óó/ 0
	PatientId
óó0 9
)
óó9 :
{
òò 
throw
ôô 
new
ôô  
ForbiddenException
ôô ,
(
ôô, -
ErrorMessages
ôô- :
.
ôô: ;2
$PatientsCanManageOnlyOwnAppointments
ôô; _
)
ôô_ `
;
ôô` a
}
öö 
if
úú 
(
úú 
!
úú #
IsAtLeast24HoursAhead
úú &
(
úú& '
appointment
úú' 2
.
úú2 3
AppointmentDate
úú3 B
,
úúB C
appointment
úúD O
.
úúO P
AppointmentTime
úúP _
)
úú_ `
)
úú` a
{
ùù 
throw
ûû 
new
ûû #
BusinessRuleException
ûû /
(
ûû/ 0
ErrorMessages
ûû0 =
.
ûû= >7
)AppointmentCannotBeCancelledWithin24Hours
ûû> g
)
ûûg h
;
ûûh i
}
üü 
appointment
°° 
.
°°  
CancellationReason
°° *
=
°°+ ,
reason
°°- 3
+
°°4 5
ErrorMessages
°°6 C
.
°°C D&
CancelledByPatientSuffix
°°D \
;
°°\ ]
}
¢¢ 	
else
££ 
if
££ 
(
££ 
currentRole
££ 
==
££ 
AppRoles
££  (
.
££( )
Doctor
££) /
)
££/ 0
{
§§ 	
if
•• 
(
•• 
currentDoctorId
•• 
!=
••  "
appointment
••# .
.
••. /
DoctorId
••/ 7
)
••7 8
{
¶¶ 
throw
ßß 
new
ßß  
ForbiddenException
ßß ,
(
ßß, -
ErrorMessages
ßß- :
.
ßß: ;1
#DoctorsCanManageOnlyOwnAppointments
ßß; ^
)
ßß^ _
;
ßß_ `
}
®® 
if
™™ 
(
™™ 
!
™™ #
IsAtLeast24HoursAhead
™™ &
(
™™& '
appointment
™™' 2
.
™™2 3
AppointmentDate
™™3 B
,
™™B C
appointment
™™D O
.
™™O P
AppointmentTime
™™P _
)
™™_ `
)
™™` a
{
´´ 
throw
¨¨ 
new
¨¨ #
BusinessRuleException
¨¨ /
(
¨¨/ 0
ErrorMessages
¨¨0 =
.
¨¨= >7
)AppointmentCannotBeCancelledWithin24Hours
¨¨> g
)
¨¨g h
;
¨¨h i
}
≠≠ 
appointment
ØØ 
.
ØØ  
CancellationReason
ØØ *
=
ØØ+ ,
reason
ØØ- 3
+
ØØ4 5
ErrorMessages
ØØ6 C
.
ØØC D%
CancelledByDoctorSuffix
ØØD [
;
ØØ[ \
}
∞∞ 	
else
±± 
if
±± 
(
±± 
currentRole
±± 
==
±± 
AppRoles
±±  (
.
±±( )
Admin
±±) .
)
±±. /
{
≤≤ 	
appointment
≥≥ 
.
≥≥  
CancellationReason
≥≥ *
=
≥≥+ ,
reason
≥≥- 3
+
≥≥4 5
ErrorMessages
≥≥6 C
.
≥≥C D$
CancelledByAdminSuffix
≥≥D Z
;
≥≥Z [
}
¥¥ 	
else
µµ 
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
∏∏ 	
appointment
∫∫ 
.
∫∫ 
Status
∫∫ 
=
∫∫ 
AppointmentStatus
∫∫ .
.
∫∫. /
	Cancelled
∫∫/ 8
;
∫∫8 9
}
ªª 
private
ΩΩ 
async
ΩΩ 
Task
ΩΩ 7
)AutoCancelExpiredPendingAppointmentsAsync
ΩΩ @
(
ΩΩ@ A
)
ΩΩA B
{
ææ 
var
øø 
cutoffDateTime
øø 
=
øø 
DateTime
øø %
.
øø% &
Now
øø& )
.
øø) *
AddHours
øø* 2
(
øø2 3+
MinimumHoursBeforeAppointment
øø3 P
)
øøP Q
;
øøQ R
var
¿¿ (
expiredPendingAppointments
¿¿ &
=
¿¿' (
await
¿¿) .#
appointmentRepository
¿¿/ D
.
¿¿D E0
"GetExpiredPendingAppointmentsAsync
¿¿E g
(
¿¿g h
cutoffDateTime
¿¿h v
)
¿¿v w
;
¿¿w x
foreach
¬¬ 
(
¬¬ 
var
¬¬ 
appointment
¬¬  
in
¬¬! #(
expiredPendingAppointments
¬¬$ >
)
¬¬> ?
{
√√ 	
appointment
ƒƒ 
.
ƒƒ 
Status
ƒƒ 
=
ƒƒ  
AppointmentStatus
ƒƒ! 2
.
ƒƒ2 3
	Cancelled
ƒƒ3 <
;
ƒƒ< =
appointment
≈≈ 
.
≈≈  
CancellationReason
≈≈ *
=
≈≈+ ,
ErrorMessages
≈≈- :
.
≈≈: ;3
%PendingAppointmentAutoCancelledReason
≈≈; `
;
≈≈` a
await
«« #
appointmentRepository
«« '
.
««' (
UpdateAsync
««( 3
(
««3 4
appointment
««4 ?
)
««? @
;
««@ A
}
»» 	
}
…… 
private
ÀÀ 
static
ÀÀ 
bool
ÀÀ #
IsAtLeast24HoursAhead
ÀÀ -
(
ÀÀ- .
DateOnly
ÀÀ. 6
date
ÀÀ7 ;
,
ÀÀ; <
TimeOnly
ÀÀ= E
time
ÀÀF J
)
ÀÀJ K
{
ÃÃ 
var
ÕÕ 
scheduledAt
ÕÕ 
=
ÕÕ 
date
ÕÕ 
.
ÕÕ 

ToDateTime
ÕÕ )
(
ÕÕ) *
time
ÕÕ* .
)
ÕÕ. /
;
ÕÕ/ 0
return
œœ 
scheduledAt
œœ 
>=
œœ 
DateTime
œœ &
.
œœ& '
Now
œœ' *
.
œœ* +
AddHours
œœ+ 3
(
œœ3 4+
MinimumHoursBeforeAppointment
œœ4 Q
)
œœQ R
;
œœR S
}
–– 
private
““ 
PagedResultDto
““ 
<
““ 
TDestination
““ '
>
““' (
MapPagedResult
““) 7
<
““7 8
TSource
““8 ?
,
““? @
TDestination
““A M
>
““M N
(
““N O
PagedResult
““O Z
<
““Z [
TSource
““[ b
>
““b c
pagedResult
““d o
)
““o p
{
”” 
return
‘‘ 
new
‘‘ 
PagedResultDto
‘‘ !
<
‘‘! "
TDestination
‘‘" .
>
‘‘. /
{
’’ 	
Items
÷÷ 
=
÷÷ 
mapper
÷÷ 
.
÷÷ 
Map
÷÷ 
<
÷÷ 
List
÷÷ #
<
÷÷# $
TDestination
÷÷$ 0
>
÷÷0 1
>
÷÷1 2
(
÷÷2 3
pagedResult
÷÷3 >
.
÷÷> ?
Items
÷÷? D
)
÷÷D E
,
÷÷E F

PageNumber
◊◊ 
=
◊◊ 
pagedResult
◊◊ $
.
◊◊$ %

PageNumber
◊◊% /
,
◊◊/ 0
PageSize
ÿÿ 
=
ÿÿ 
pagedResult
ÿÿ "
.
ÿÿ" #
PageSize
ÿÿ# +
,
ÿÿ+ ,

TotalCount
ŸŸ 
=
ŸŸ 
pagedResult
ŸŸ $
.
ŸŸ$ %

TotalCount
ŸŸ% /
,
ŸŸ/ 0

TotalPages
⁄⁄ 
=
⁄⁄ 
pagedResult
⁄⁄ $
.
⁄⁄$ %

TotalPages
⁄⁄% /
}
€€ 	
;
€€	 

}
‹‹ 
}›› ˆ†
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
}ÕÕ ¸
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
;Z [
} ®
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
PaginationQueryDto		= O

pagination		P Z
,		Z [ 
DoctorSpecialisation		\ p
?		p q
specialisation			r Ä
)
		Ä Å
;
		Å Ç
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
< 	
PublicDoctorDto	 
? 
> "
GetDoctorByUserIdAsync 1
(1 2
string2 8
userId9 ?
)? @
;@ A
Task 
< 	!
DoctorAvailabilityDto	 
? 
>   
GetAvailabilityAsync! 5
(5 6
int6 9
id: <
)< =
;= >
Task 
< 	!
DoctorAvailabilityDto	 
> #
UpdateAvailabilityAsync  7
(7 8
int 
id 
, '
UpdateDoctorAvailabilityDto #
dto$ '
,' (
string 
currentRole 
, 
int 
? 
currentDoctorId 
) 
; 
} ˜
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
;		` a
} ≤
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
})) »	
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
} æ+
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
}11 ‹.
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
}22 
private44 

IQueryable44 
<44 
HealthRecord44 #
>44# $'
GetHealthRecordsWithDetails44% @
(44@ A
)44A B
{55 
return66 
_context66 
.66 
HealthRecords66 %
.77 
Include77 
(77 
record77 
=>77 
record77 %
.77% &
Appointment77& 1
)771 2
.88 
ThenInclude88 
(88 
appointment88 (
=>88) +
appointment88, 7
!887 8
.888 9
Patient889 @
)88@ A
.99 
Include99 
(99 
record99 
=>99 
record99 %
.99% &
Appointment99& 1
)991 2
.:: 
ThenInclude:: 
(:: 
appointment:: (
=>::) +
appointment::, 7
!::7 8
.::8 9
Doctor::9 ?
)::? @
;::@ A
};; 
}<< ∏H
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
public 

async 
Task 
< 
PagedResult !
<! "
Doctor" (
>( )
>) *
GetAllDoctorsAsync+ =
(= >
int 

pageNumber 
, 
int 
pageSize 
,  
DoctorSpecialisation 
? 
specialisation ,
), -
{ 
var 
query 
= 
_context 
. 
Doctors $
. 
AsNoTracking 
( 
) 
. 
AsQueryable 
( 
) 
; 
if 

( 
specialisation 
. 
HasValue #
)# $
{ 	
query 
= 
query 
. 
Where 
(  
doctor  &
=>' )
doctor* 0
.0 1
Specialisation1 ?
==@ B
specialisationC Q
.Q R
ValueR W
)W X
;X Y
} 	
query 
= 
query 
. 
OrderBy 
( 
doctor $
=>% '
doctor( .
.. /
Id/ 1
)1 2
;2 3
return 
await 
ToPagedResultAsync '
(' (
query( -
,- .

pageNumber/ 9
,9 :
pageSize; C
)C D
;D E
} 
public 

async 
Task 
< 
Doctor 
? 
> 
GetDoctorByIdAsync 1
(1 2
int2 5
id6 8
)8 9
{ 
return   
await   
_context   
.   
Doctors   %
.!! 
FirstOrDefaultAsync!!  
(!!  !
doctor!!! '
=>!!( *
doctor!!+ 1
.!!1 2
Id!!2 4
==!!5 7
id!!8 :
)!!: ;
;!!; <
}"" 
public$$ 

async$$ 
Task$$ 
<$$ 
PagedResult$$ !
<$$! "
Doctor$$" (
>$$( )
>$$) *&
GetAllDoctorsWithUserAsync$$+ E
($$E F
int%% 

pageNumber%% 
,%% 
int&& 
pageSize&& 
,&& 
string'' 
?'' 
search'' 
='' 
null'' 
,''  
DoctorSpecialisation(( 
?(( 
specialisation(( ,
=((- .
null((/ 3
)((3 4
{)) 
var** 
query** 
=** 
_context** 
.** 
Doctors** $
.++ 
Include++ 
(++ 
doctor++ 
=>++ 
doctor++ %
.++% &
User++& *
)++* +
.,, 
AsQueryable,, 
(,, 
),, 
;,, 
if.. 

(.. 
specialisation.. 
... 
HasValue.. #
)..# $
{// 	
query00 
=00 
query00 
.00 
Where00 
(00  
doctor00  &
=>00' )
doctor00* 0
.000 1
Specialisation001 ?
==00@ B
specialisation00C Q
.00Q R
Value00R W
)00W X
;00X Y
}11 	
if33 

(33 
!33 
string33 
.33 
IsNullOrWhiteSpace33 &
(33& '
search33' -
)33- .
)33. /
{44 	
var55 

searchText55 
=55 
search55 #
.55# $
Trim55$ (
(55( )
)55) *
;55* +
var66 !
specialisationMatched66 %
=66& '
Enum66( ,
.66, -
TryParse66- 5
<665 6 
DoctorSpecialisation666 J
>66J K
(66K L

searchText77 
,77 

ignoreCase88 
:88 
true88  
,88  !
out99 
var99  
parsedSpecialisation99 ,
)99, -
;99- .
query;; 
=;; 
query;; 
.;; 
Where;; 
(;;  
doctor;;  &
=>;;' )
doctor<< 
.<< 
FullName<< 
.<<  
Contains<<  (
(<<( )

searchText<<) 3
)<<3 4
||<<5 7
(== 
doctor== 
.== 
User== 
!=== 
null==  $
&&==% '
doctor==( .
.==. /
User==/ 3
.==3 4
Email==4 9
!===: <
null=== A
&&==B D
doctor==E K
.==K L
User==L P
.==P Q
Email==Q V
.==V W
Contains==W _
(==_ `

searchText==` j
)==j k
)==k l
||==m o
(>> 
doctor>> 
.>> 
User>> 
!=>> 
null>>  $
&&>>% '
doctor>>( .
.>>. /
User>>/ 3
.>>3 4
PhoneNumber>>4 ?
!=>>@ B
null>>C G
&&>>H J
doctor>>K Q
.>>Q R
User>>R V
.>>V W
PhoneNumber>>W b
.>>b c
Contains>>c k
(>>k l

searchText>>l v
)>>v w
)>>w x
||>>y {
(?? !
specialisationMatched?? &
&&??' )
doctor??* 0
.??0 1
Specialisation??1 ?
==??@ B 
parsedSpecialisation??C W
)??W X
)??X Y
;??Y Z
}@@ 	
queryBB 
=BB 
queryBB 
.CC 
OrderByCC 
(CC 
doctorCC 
=>CC 
doctorCC %
.CC% &
FullNameCC& .
)CC. /
.DD 
ThenByDD 
(DD 
doctorDD 
=>DD 
doctorDD $
.DD$ %
IdDD% '
)DD' (
;DD( )
returnFF 
awaitFF 
ToPagedResultAsyncFF '
(FF' (
queryFF( -
,FF- .

pageNumberFF/ 9
,FF9 :
pageSizeFF; C
)FFC D
;FFD E
}GG 
publicII 

asyncII 
TaskII 
<II 
DoctorII 
?II 
>II &
GetDoctorByIdWithUserAsyncII 9
(II9 :
intII: =
idII> @
)II@ A
{JJ 
returnKK 
awaitKK 
_contextKK 
.KK 
DoctorsKK %
.LL 
IncludeLL 
(LL 
doctorLL 
=>LL 
doctorLL %
.LL% &
UserLL& *
)LL* +
.MM 
FirstOrDefaultAsyncMM  
(MM  !
doctorMM! '
=>MM( *
doctorMM+ 1
.MM1 2
IdMM2 4
==MM5 7
idMM8 :
)MM: ;
;MM; <
}NN 
publicPP 

asyncPP 
TaskPP 
<PP 
DoctorPP 
?PP 
>PP "
GetDoctorByUserIdAsyncPP 5
(PP5 6
stringPP6 <
userIdPP= C
)PPC D
{QQ 
returnRR 
awaitRR 
_contextRR 
.RR 
DoctorsRR %
.SS 
IncludeSS 
(SS 
doctorSS 
=>SS 
doctorSS %
.SS% &
UserSS& *
)SS* +
.TT 
FirstOrDefaultAsyncTT  
(TT  !
doctorTT! '
=>TT( *
doctorTT+ 1
.TT1 2
UserIdTT2 8
==TT9 ;
userIdTT< B
)TTB C
;TTC D
}UU 
publicWW 

asyncWW 
TaskWW 
<WW 
boolWW 
?WW 
>WW  
GetAvailabilityAsyncWW 1
(WW1 2
intWW2 5
idWW6 8
)WW8 9
{XX 
returnYY 
awaitYY 
_contextYY 
.YY 
DoctorsYY %
.ZZ 
WhereZZ 
(ZZ 
doctorZZ 
=>ZZ 
doctorZZ #
.ZZ# $
IdZZ$ &
==ZZ' )
idZZ* ,
)ZZ, -
.[[ 
Select[[ 
([[ 
doctor[[ 
=>[[ 
([[ 
bool[[ #
?[[# $
)[[$ %
doctor[[% +
.[[+ ,
IsAvailable[[, 7
)[[7 8
.\\ 
FirstOrDefaultAsync\\  
(\\  !
)\\! "
;\\" #
}]] 
}^^ ¶≠
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
return 
await 
ToPagedResultAsync '
(' (
query( -
,- .

pageNumber/ 9
,9 :
pageSize; C
)C D
;D E
} 
public 

async 
Task 
< 
Appointment !
?! "
>" #.
"GetAppointmentByIdWithDetailsAsync$ F
(F G
intG J
appointmentIdK X
)X Y
{ 
return 
await &
GetAppointmentsWithDetails /
(/ 0
)0 1
. 
FirstOrDefaultAsync  
(  !
appointment! ,
=>- /
appointment0 ;
.; <
Id< >
==? A
appointmentIdB O
)O P
;P Q
} 
public 

async 
Task 
< 
PagedResult !
<! "
Appointment" -
>- .
>. /+
GetAppointmentsByPatientIdAsync0 O
(O P
int 
	patientId 
, 
AppointmentStatus 
? 
status 
, 
int 

pageNumber 
, 
int   
pageSize   
)   
{!! 
var"" 
query"" 
="" &
GetAppointmentsWithDetails"" .
("". /
)""/ 0
.## 
Where## 
(## 
appointment## 
=>## !
appointment##" -
.##- .
	PatientId##. 7
==##8 :
	patientId##; D
)##D E
;##E F
if%% 

(%% 
status%% 
.%% 
HasValue%% 
)%% 
{&& 	
query'' 
='' 
query'' 
.'' 
Where'' 
(''  
appointment''  +
=>'', .
appointment''/ :
.'': ;
Status''; A
==''B D
status''E K
.''K L
Value''L Q
)''Q R
;''R S
}(( 	
query** 
=** 
query** 
.++ 
OrderBy++ 
(++ 
appointment++  
=>++! #
appointment++$ /
.++/ 0
AppointmentDate++0 ?
)++? @
.,, 
ThenBy,, 
(,, 
appointment,, 
=>,,  "
appointment,,# .
.,,. /
AppointmentTime,,/ >
),,> ?
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
return// 
await// 
ToPagedResultAsync// '
(//' (
query//( -
,//- .

pageNumber/// 9
,//9 :
pageSize//; C
)//C D
;//D E
}00 
public22 

async22 
Task22 
<22 
PagedResult22 !
<22! "
Appointment22" -
>22- .
>22. /*
GetAppointmentsByDoctorIdAsync220 N
(22N O
int33 
doctorId33	 
,33 
AppointmentStatus44 
?44 
status44 
,44 
int55 

pageNumber55	 
,55 
int66 
pageSize66	 
)66 
{77 
var88 
query88 
=88 &
GetAppointmentsWithDetails88 .
(88. /
)88/ 0
.99 
Where99 
(99 
appointment99 
=>99 !
appointment99" -
.99- .
DoctorId99. 6
==997 9
doctorId99: B
)99B C
;99C D
if;; 

(;; 
status;; 
.;; 
HasValue;; 
);; 
{<< 	
query== 
=== 
query== 
.== 
Where== 
(==  
appointment==  +
=>==, .
appointment==/ :
.==: ;
Status==; A
====B D
status==E K
.==K L
Value==L Q
)==Q R
;==R S
}>> 	
query@@ 
=@@ 
query@@ 
.AA 
OrderByAA 
(AA 
appointmentAA  
=>AA! #
appointmentAA$ /
.AA/ 0
AppointmentDateAA0 ?
)AA? @
.BB 
ThenByBB 
(BB 
appointmentBB 
=>BB  "
appointmentBB# .
.BB. /
AppointmentTimeBB/ >
)BB> ?
.CC 
ThenByCC 
(CC 
appointmentCC 
=>CC  "
appointmentCC# .
.CC. /
IdCC/ 1
)CC1 2
;CC2 3
returnEE 
awaitEE 
ToPagedResultAsyncEE '
(EE' (
queryEE( -
,EE- .

pageNumberEE/ 9
,EE9 :
pageSizeEE; C
)EEC D
;EED E
}FF 
publicHH 

asyncHH 
TaskHH 
<HH 
PagedResultHH !
<HH! "
AppointmentHH" -
>HH- .
>HH. /1
%GetAppointmentsByDoctorIdAndDateAsyncHH0 U
(HHU V
intII 
doctorIdII 
,II 
DateOnlyJJ 
dateJJ 
,JJ 
intKK 

pageNumberKK 
,KK 
intLL 
pageSizeLL 
)LL 
{MM 
varNN 
queryNN 
=NN &
GetAppointmentsWithDetailsNN .
(NN. /
)NN/ 0
.OO 
WhereOO 
(OO 
appointmentOO 
=>OO !
appointmentPP 
.PP 
DoctorIdPP $
==PP% '
doctorIdPP( 0
&&PP1 3
appointmentQQ 
.QQ 
AppointmentDateQQ +
==QQ, .
dateQQ/ 3
)QQ3 4
.RR 
OrderByRR 
(RR 
appointmentRR  
=>RR! #
appointmentRR$ /
.RR/ 0
AppointmentTimeRR0 ?
)RR? @
.SS 
ThenBySS 
(SS 
appointmentSS 
=>SS  "
appointmentSS# .
.SS. /
IdSS/ 1
)SS1 2
;SS2 3
returnUU 
awaitUU 
ToPagedResultAsyncUU '
(UU' (
queryUU( -
,UU- .

pageNumberUU/ 9
,UU9 :
pageSizeUU; C
)UUC D
;UUD E
}VV 
publicXX 

asyncXX 
TaskXX 
<XX 
PagedResultXX !
<XX! "
AppointmentXX" -
>XX- .
>XX. //
#GetAppointmentsByDateAndStatusAsyncXX0 S
(XXS T
DateOnlyYY 
dateYY 
,YY 
AppointmentStatusZZ 
?ZZ 
statusZZ !
,ZZ! "
int[[ 

pageNumber[[ 
,[[ 
int\\ 
pageSize\\ 
)\\ 
{]] 
var^^ 
query^^ 
=^^ &
GetAppointmentsWithDetails^^ .
(^^. /
)^^/ 0
.__ 
Where__ 
(__ 
appointment__ 
=>__ !
appointment__" -
.__- .
AppointmentDate__. =
==__> @
date__A E
)__E F
;__F G
ifaa 

(aa 
statusaa 
.aa 
HasValueaa 
)aa 
{bb 	
querycc 
=cc 
querycc 
.cc 
Wherecc 
(cc  
appointmentcc  +
=>cc, .
appointmentcc/ :
.cc: ;
Statuscc; A
==ccB D
statusccE K
.ccK L
ValueccL Q
)ccQ R
;ccR S
}dd 	
queryff 
=ff 
queryff 
.gg 
OrderBygg 
(gg 
appointmentgg  
=>gg! #
appointmentgg$ /
.gg/ 0
AppointmentTimegg0 ?
)gg? @
.hh 
ThenByhh 
(hh 
appointmenthh 
=>hh  "
appointmenthh# .
.hh. /
Idhh/ 1
)hh1 2
;hh2 3
returnjj 
awaitjj 
ToPagedResultAsyncjj '
(jj' (
queryjj( -
,jj- .

pageNumberjj/ 9
,jj9 :
pageSizejj; C
)jjC D
;jjD E
}kk 
publicmm 

asyncmm 
Taskmm 
<mm 
Listmm 
<mm 
Appointmentmm &
>mm& '
>mm' (.
"GetExpiredPendingAppointmentsAsyncmm) K
(mmK L
DateTimemmL T
cutoffDateTimemmU c
)mmc d
{nn 
varoo 

cutoffDateoo 
=oo 
DateOnlyoo !
.oo! "
FromDateTimeoo" .
(oo. /
cutoffDateTimeoo/ =
)oo= >
;oo> ?
varpp 

cutoffTimepp 
=pp 
TimeOnlypp !
.pp! "
FromDateTimepp" .
(pp. /
cutoffDateTimepp/ =
)pp= >
;pp> ?
returnrr 
awaitrr 
_contextrr 
.rr 
Appointmentsrr *
.ss 
Wheress 
(ss 
appointmentss 
=>ss !
appointmenttt 
.tt 
Statustt "
==tt# %
AppointmentStatustt& 7
.tt7 8
Pendingtt8 ?
&&tt@ B
(uu 
appointmentuu 
.uu 
AppointmentDateuu ,
<uu- .

cutoffDateuu/ 9
||uu: <
appointmentvv 
.vv 
AppointmentDatevv ,
==vv- /

cutoffDatevv0 :
&&vv; =
appointmentvv> I
.vvI J
AppointmentTimevvJ Y
<=vvZ \

cutoffTimevv] g
)vvg h
)vvh i
.ww 
ToListAsyncww 
(ww 
)ww 
;ww 
}xx 
publiczz 

asynczz 
Taskzz 
<zz 
Listzz 
<zz  
AppointmentReportDtozz /
>zz/ 0
>zz0 1&
GetAppointmentReportsAsynczz2 L
(zzL M
)zzM N
{{{ 
return|| 
await|| 
_context|| 
.|| 
Appointments|| *
.}} 
GroupBy}} 
(}} 
appointment}}  
=>}}! #
appointment}}$ /
.}}/ 0
AppointmentDate}}0 ?
)}}? @
.~~ 
Select~~ 
(~~ 
group~~ 
=>~~ 
new~~   
AppointmentReportDto~~! 5
{ 
Date
ÄÄ 
=
ÄÄ 
group
ÄÄ 
.
ÄÄ 
Key
ÄÄ  
,
ÄÄ  !
ConfirmedCount
ÅÅ 
=
ÅÅ  
group
ÅÅ! &
.
ÅÅ& '
Count
ÅÅ' ,
(
ÅÅ, -
appointment
ÅÅ- 8
=>
ÅÅ9 ;
appointment
ÅÅ< G
.
ÅÅG H
Status
ÅÅH N
==
ÅÅO Q
AppointmentStatus
ÅÅR c
.
ÅÅc d
	Confirmed
ÅÅd m
)
ÅÅm n
,
ÅÅn o
CancelledCount
ÇÇ 
=
ÇÇ  
group
ÇÇ! &
.
ÇÇ& '
Count
ÇÇ' ,
(
ÇÇ, -
appointment
ÇÇ- 8
=>
ÇÇ9 ;
appointment
ÇÇ< G
.
ÇÇG H
Status
ÇÇH N
==
ÇÇO Q
AppointmentStatus
ÇÇR c
.
ÇÇc d
	Cancelled
ÇÇd m
)
ÇÇm n
,
ÇÇn o
CompletedCount
ÉÉ 
=
ÉÉ  
group
ÉÉ! &
.
ÉÉ& '
Count
ÉÉ' ,
(
ÉÉ, -
appointment
ÉÉ- 8
=>
ÉÉ9 ;
appointment
ÉÉ< G
.
ÉÉG H
Status
ÉÉH N
==
ÉÉO Q
AppointmentStatus
ÉÉR c
.
ÉÉc d
	Completed
ÉÉd m
)
ÉÉm n
,
ÉÉn o
PendingCount
ÑÑ 
=
ÑÑ 
group
ÑÑ $
.
ÑÑ$ %
Count
ÑÑ% *
(
ÑÑ* +
appointment
ÑÑ+ 6
=>
ÑÑ7 9
appointment
ÑÑ: E
.
ÑÑE F
Status
ÑÑF L
==
ÑÑM O
AppointmentStatus
ÑÑP a
.
ÑÑa b
Pending
ÑÑb i
)
ÑÑi j
,
ÑÑj k

TotalCount
ÖÖ 
=
ÖÖ 
group
ÖÖ "
.
ÖÖ" #
Count
ÖÖ# (
(
ÖÖ( )
)
ÖÖ) *
}
ÜÜ 
)
ÜÜ 
.
áá 
OrderByDescending
áá 
(
áá 
report
áá %
=>
áá& (
report
áá) /
.
áá/ 0
Date
áá0 4
)
áá4 5
.
àà 
ToListAsync
àà 
(
àà 
)
àà 
;
àà 
}
ââ 
public
ãã 

async
ãã 
Task
ãã 
<
ãã 
bool
ãã 
>
ãã 5
'DoctorHasNonCancelledAppointmentAtAsync
ãã C
(
ããC D
int
ããD G
doctorId
ããH P
,
ããP Q
DateOnly
ããR Z
date
ãã[ _
,
ãã_ `
TimeOnly
ããa i
time
ããj n
)
ããn o
{
åå 
return
çç 
await
çç 
_context
çç 
.
çç 
Appointments
çç *
.
éé 
AnyAsync
éé 
(
éé 
appointment
éé !
=>
éé" $
appointment
èè 
.
èè 
DoctorId
èè $
==
èè% '
doctorId
èè( 0
&&
èè1 3
appointment
êê 
.
êê 
AppointmentDate
êê +
==
êê, .
date
êê/ 3
&&
êê4 6
appointment
ëë 
.
ëë 
AppointmentTime
ëë +
==
ëë, .
time
ëë/ 3
&&
ëë4 6
appointment
íí 
.
íí 
Status
íí "
!=
íí# %
AppointmentStatus
íí& 7
.
íí7 8
	Cancelled
íí8 A
)
ííA B
;
ííB C
}
ìì 
public
ïï 

async
ïï 
Task
ïï 
<
ïï 
bool
ïï 
>
ïï 6
(PatientHasNonCancelledAppointmentAtAsync
ïï D
(
ïïD E
int
ïïE H
	patientId
ïïI R
,
ïïR S
DateOnly
ïïT \
date
ïï] a
,
ïïa b
TimeOnly
ïïc k
time
ïïl p
)
ïïp q
{
ññ 
return
óó 
await
óó 
_context
óó 
.
óó 
Appointments
óó *
.
òò 
AnyAsync
òò 
(
òò 
appointment
òò !
=>
òò" $
appointment
ôô 
.
ôô 
	PatientId
ôô %
==
ôô& (
	patientId
ôô) 2
&&
ôô3 5
appointment
öö 
.
öö 
AppointmentDate
öö +
==
öö, .
date
öö/ 3
&&
öö4 6
appointment
õõ 
.
õõ 
AppointmentTime
õõ +
==
õõ, .
time
õõ/ 3
&&
õõ4 6
appointment
úú 
.
úú 
Status
úú "
!=
úú# %
AppointmentStatus
úú& 7
.
úú7 8
	Cancelled
úú8 A
)
úúA B
;
úúB C
}
ùù 
public
üü 

async
üü 
Task
üü 
<
üü 
bool
üü 
>
üü D
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsync
üü R
(
üüR S
int
üüS V
	patientId
üüW `
,
üü` a
int
üüb e
doctorId
üüf n
,
üün o
DateOnly
üüp x
date
üüy }
)
üü} ~
{
†† 
return
°° 
await
°° 
_context
°° 
.
°° 
Appointments
°° *
.
¢¢ 
AnyAsync
¢¢ 
(
¢¢ 
appointment
¢¢ !
=>
¢¢" $
appointment
££ 
.
££ 
	PatientId
££ %
==
££& (
	patientId
££) 2
&&
££3 5
appointment
§§ 
.
§§ 
DoctorId
§§ $
==
§§% '
doctorId
§§( 0
&&
§§1 3
appointment
•• 
.
•• 
AppointmentDate
•• +
==
••, .
date
••/ 3
&&
••4 6
appointment
¶¶ 
.
¶¶ 
Status
¶¶ "
!=
¶¶# %
AppointmentStatus
¶¶& 7
.
¶¶7 8
	Cancelled
¶¶8 A
)
¶¶A B
;
¶¶B C
}
ßß 
public
©© 

async
©© 
Task
©© 
<
©© 
bool
©© 
>
©© 7
)DoctorHasConfirmedAppointmentsOnDateAsync
©© E
(
©©E F
int
©©F I
doctorId
©©J R
,
©©R S
DateOnly
©©T \
date
©©] a
)
©©a b
{
™™ 
return
´´ 
await
´´ 
_context
´´ 
.
´´ 
Appointments
´´ *
.
¨¨ 
AnyAsync
¨¨ 
(
¨¨ 
appointment
¨¨ !
=>
¨¨" $
appointment
≠≠ 
.
≠≠ 
DoctorId
≠≠ $
==
≠≠% '
doctorId
≠≠( 0
&&
≠≠1 3
appointment
ÆÆ 
.
ÆÆ 
AppointmentDate
ÆÆ +
==
ÆÆ, .
date
ÆÆ/ 3
&&
ÆÆ4 6
appointment
ØØ 
.
ØØ 
Status
ØØ "
==
ØØ# %
AppointmentStatus
ØØ& 7
.
ØØ7 8
	Confirmed
ØØ8 A
)
ØØA B
;
ØØB C
}
∞∞ 
public
≤≤ 

async
≤≤ 
Task
≤≤ 
<
≤≤ 
List
≤≤ 
<
≤≤ 
Appointment
≤≤ &
>
≤≤& '
>
≤≤' (E
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync
≤≤) `
(
≤≤` a
int
≤≤a d
doctorId
≤≤e m
,
≤≤m n
DateOnly
≤≤o w
date
≤≤x |
)
≤≤| }
{
≥≥ 
return
¥¥ 
await
¥¥ 
_context
¥¥ 
.
¥¥ 
Appointments
¥¥ *
.
µµ 
Where
µµ 
(
µµ 
appointment
µµ 
=>
µµ !
appointment
∂∂ 
.
∂∂ 
DoctorId
∂∂ $
==
∂∂% '
doctorId
∂∂( 0
&&
∂∂1 3
appointment
∑∑ 
.
∑∑ 
AppointmentDate
∑∑ +
==
∑∑, .
date
∑∑/ 3
&&
∑∑4 6
(
∏∏ 
appointment
∏∏ 
.
∏∏ 
Status
∏∏ #
==
∏∏$ &
AppointmentStatus
∏∏' 8
.
∏∏8 9
Pending
∏∏9 @
||
∏∏A C
appointment
ππ 
.
ππ 
Status
ππ #
==
ππ$ &
AppointmentStatus
ππ' 8
.
ππ8 9
	Confirmed
ππ9 B
)
ππB C
)
ππC D
.
∫∫ 
ToListAsync
∫∫ 
(
∫∫ 
)
∫∫ 
;
∫∫ 
}
ªª 
public
ΩΩ 

async
ΩΩ 
Task
ΩΩ 
<
ΩΩ 
bool
ΩΩ 
>
ΩΩ ;
-DoctorHasConfirmedAppointmentWithPatientAsync
ΩΩ I
(
ΩΩI J
int
ΩΩJ M
doctorId
ΩΩN V
,
ΩΩV W
int
ΩΩX [
	patientId
ΩΩ\ e
)
ΩΩe f
{
ææ 
return
øø 
await
øø 
_context
øø 
.
øø 
Appointments
øø *
.
¿¿ 
AnyAsync
¿¿ 
(
¿¿ 
appointment
¿¿ !
=>
¿¿" $
appointment
¡¡ 
.
¡¡ 
DoctorId
¡¡ $
==
¡¡% '
doctorId
¡¡( 0
&&
¡¡1 3
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
√√ 
.
√√ 
Status
√√ "
==
√√# %
AppointmentStatus
√√& 7
.
√√7 8
	Confirmed
√√8 A
)
√√A B
;
√√B C
}
ƒƒ 
private
∆∆ 

IQueryable
∆∆ 
<
∆∆ 
Appointment
∆∆ "
>
∆∆" #(
GetAppointmentsWithDetails
∆∆$ >
(
∆∆> ?
)
∆∆? @
{
«« 
return
»» 
_context
»» 
.
»» 
Appointments
»» $
.
…… 
Include
…… 
(
…… 
appointment
……  
=>
……! #
appointment
……$ /
.
……/ 0
Patient
……0 7
)
……7 8
.
   
Include
   
(
   
appointment
    
=>
  ! #
appointment
  $ /
.
  / 0
Doctor
  0 6
)
  6 7
.
ÀÀ 
Include
ÀÀ 
(
ÀÀ 
appointment
ÀÀ  
=>
ÀÀ! #
appointment
ÀÀ$ /
.
ÀÀ/ 0
HealthRecord
ÀÀ0 <
)
ÀÀ< =
;
ÀÀ= >
}
ÃÃ 
}ÕÕ ç
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
;N O
} »
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
int1 4

pageNumber5 ?
,? @
intA D
pageSizeE M
,M N 
DoctorSpecialisationO c
?c d
specialisatione s
)s t
;t u
Task

 
<

 	
Doctor

	 
?

 
>

 
GetDoctorByIdAsync

 $
(

$ %
int

% (
id

) +
)

+ ,
;

, -
Task 
< 	
PagedResult	 
< 
Doctor 
> 
> &
GetAllDoctorsWithUserAsync 8
(8 9
int 

pageNumber 
, 
int 
pageSize 
, 
string 
? 
search 
= 
null 
,  
DoctorSpecialisation 
? 
specialisation ,
=- .
null/ 3
)3 4
;4 5
Task 
< 	
Doctor	 
? 
> &
GetDoctorByIdWithUserAsync ,
(, -
int- 0
id1 3
)3 4
;4 5
Task 
< 	
Doctor	 
? 
> "
GetDoctorByUserIdAsync (
(( )
string) /
userId0 6
)6 7
;7 8
Task 
< 	
bool	 
? 
>  
GetAvailabilityAsync $
($ %
int% (
id) +
)+ ,
;, -
} ¢'
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
int 	
	patientId
 
, 
AppointmentStatus 
? 
status 
,  
int 	

pageNumber
 
, 
int 	
pageSize
 
) 
; 
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
intI L
doctorIdM U
,U V
DateOnlyW _
date` d
,d e
intf i

pageNumberj t
,t u
intv y
pageSize	z Ç
)
Ç É
;
É Ñ
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "/
#GetAppointmentsByDateAndStatusAsync# F
(F G
DateOnly 
date 
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
; 
Task!! 
<!! 	
List!!	 
<!! 
Appointment!! 
>!! 
>!! .
"GetExpiredPendingAppointmentsAsync!! >
(!!> ?
DateTime!!? G
cutoffDateTime!!H V
)!!V W
;!!W X
Task## 
<## 	
List##	 
<##  
AppointmentReportDto## "
>##" #
>### $&
GetAppointmentReportsAsync##% ?
(##? @
)##@ A
;##A B
Task%% 
<%% 	
bool%%	 
>%% 3
'DoctorHasNonCancelledAppointmentAtAsync%% 6
(%%6 7
int%%7 :
doctorId%%; C
,%%C D
DateOnly%%E M
date%%N R
,%%R S
TimeOnly%%T \
time%%] a
)%%a b
;%%b c
Task'' 
<'' 	
bool''	 
>'' 4
(PatientHasNonCancelledAppointmentAtAsync'' 7
(''7 8
int''8 ;
	patientId''< E
,''E F
DateOnly''G O
date''P T
,''T U
TimeOnly''V ^
time''_ c
)''c d
;''d e
Task)) 
<)) 	
bool))	 
>)) B
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsync)) E
())E F
int))F I
	patientId))J S
,))S T
int))U X
doctorId))Y a
,))a b
DateOnly))c k
date))l p
)))p q
;))q r
Task++ 
<++ 	
bool++	 
>++ 5
)DoctorHasConfirmedAppointmentsOnDateAsync++ 8
(++8 9
int++9 <
doctorId++= E
,++E F
DateOnly++G O
date++P T
)++T U
;++U V
Task-- 
<-- 	
List--	 
<-- 
Appointment-- 
>-- 
>-- C
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync-- S
(--S T
int--T W
doctorId--X `
,--` a
DateOnly--b j
date--k o
)--o p
;--p q
Task// 
<// 	
bool//	 
>// 9
-DoctorHasConfirmedAppointmentWithPatientAsync// <
(//< =
int//= @
doctorId//A I
,//I J
int//K N
	patientId//O X
)//X Y
;//Y Z
}00 ﬁè
AC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Program.cs
Log 
. 
Logger 

= 
new 
LoggerConfiguration $
($ %
)% &
. 
MinimumLevel 
. 
Information 
( 
) 
. 
Enrich 
. 
FromLogContext 
( 
) 
. 
WriteTo 
. 
Console 
( 
) 
. !
CreateBootstrapLogger 
( 
) 
; 
try 
{ 
var 
builder 
= 
WebApplication  
.  !
CreateBuilder! .
(. /
args/ 3
)3 4
;4 5
const 	
string
 %
HealthAxisAdminCorsPolicy *
=+ ,
$str- H
;H I
var 
appName 
= 
builder 
. 
Configuration '
[' (
$str( =
]= >
??? A
$strB R
;R S
builder   
.   
Services   
.   

AddSerilog   
(    
(    !
services  ! )
,  ) *
loggerConfiguration  + >
)  > ?
=>  @ B
loggerConfiguration  C V
.!! 	
ReadFrom!!	 
.!! 
Configuration!! 
(!!  
builder!!  '
.!!' (
Configuration!!( 5
)!!5 6
."" 	
ReadFrom""	 
."" 
Services"" 
("" 
services"" #
)""# $
.## 	
Enrich##	 
.## 
FromLogContext## 
(## 
)##  
.$$ 	
Enrich$$	 
.$$ 
WithProperty$$ 
($$ 
$str$$ *
,$$* +
appName$$, 3
)$$3 4
)$$4 5
;$$5 6
builder&& 
.&& 
Services&& 
.&& 
AddCors&& 
(&& 
options&& $
=>&&% '
{'' 
options(( 
.(( 
	AddPolicy(( 
((( %
HealthAxisAdminCorsPolicy(( 3
,((3 4
policy((5 ;
=>((< >
{)) 	
policy** 
.++ 
WithOrigins++ 
(++ 
$str,, ,
,,,, -
$str-- +
)--+ ,
... 
AllowAnyHeader.. 
(..  
)..  !
.// 
AllowAnyMethod// 
(//  
)//  !
;//! "
}00 	
)00	 

;00
 
}11 
)11 
;11 
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
=>44  "
{55 	
options66 
.66 !
JsonSerializerOptions66 )
.66) * 
PropertyNamingPolicy66* >
=66? @
JsonNamingPolicy66A Q
.66Q R
	CamelCase66R [
;66[ \
}77 	
)77	 

;77
 
builder99 
.99 
Services99 
.99 #
AddEndpointsApiExplorer99 ,
(99, -
)99- .
;99. /
builder;; 
.;; 
Services;; 
.;; 
AddSwaggerGen;; "
(;;" #
options;;# *
=>;;+ -
{<< 
options== 
.== 

SwaggerDoc== 
(== 
$str== 
,==  
new==! $
OpenApiInfo==% 0
{>> 	
Title?? 
=?? 
$str?? $
,??$ %
Version@@ 
=@@ 
$str@@ 
}AA 	
)AA	 

;AA
 
optionsCC 
.CC !
AddSecurityDefinitionCC %
(CC% &
$strCC& .
,CC. /
newCC0 3!
OpenApiSecuritySchemeCC4 I
{DD 	
TypeEE 
=EE 
SecuritySchemeTypeEE %
.EE% &
HttpEE& *
,EE* +
SchemeFF 
=FF 
$strFF 
,FF 
BearerFormatGG 
=GG 
$strGG  
,GG  !
DescriptionHH 
=HH 
$strHH M
}II 	
)II	 

;II
 
optionsKK 
.KK "
AddSecurityRequirementKK &
(KK& '
documentKK' /
=>KK0 2
newKK3 6&
OpenApiSecurityRequirementKK7 Q
{LL 	
[MM 
newMM *
OpenApiSecuritySchemeReferenceMM /
(MM/ 0
$strMM0 8
,MM8 9
documentMM: B
)MMB C
]MMC D
=MME F
[MMG H
]MMH I
}NN 	
)NN	 

;NN
 
}OO 
)OO 
;OO 
builderQQ 
.QQ 
ServicesQQ 
.QQ 
AddExceptionHandlerQQ (
<QQ( )"
GlobalExceptionHandlerQQ) ?
>QQ? @
(QQ@ A
)QQA B
;QQB C
builderRR 
.RR 
ServicesRR 
.RR 
AddProblemDetailsRR &
(RR& '
)RR' (
;RR( )
builderTT 
.TT 
ServicesTT 
.TT 
AddDbContextTT !
<TT! "
HealthAxisDbContextTT" 5
>TT5 6
(TT6 7
optionsTT7 >
=>TT? A
optionsUU 
.UU 
UseSqlServerUU 
(UU 
builderUU $
.UU$ %
ConfigurationUU% 2
.UU2 3
GetConnectionStringUU3 F
(UUF G
$strUUG U
)UUU V
)UUV W
)UUW X
;UUX Y
builderWW 
.WW 
ServicesWW 
.WW 
AddIdentityWW  
<WW  !
IdentityUserWW! -
,WW- .
IdentityRoleWW/ ;
>WW; <
(WW< =
optionsWW= D
=>WWE G
{XX 
optionsYY 
.YY 
UserYY 
.YY 
RequireUniqueEmailYY '
=YY( )
trueYY* .
;YY. /
options[[ 
.[[ 
Password[[ 
.[[ 
RequireDigit[[ %
=[[& '
true[[( ,
;[[, -
options\\ 
.\\ 
Password\\ 
.\\ 
RequireUppercase\\ )
=\\* +
true\\, 0
;\\0 1
options]] 
.]] 
Password]] 
.]] 
RequireLowercase]] )
=]]* +
true]], 0
;]]0 1
options^^ 
.^^ 
Password^^ 
.^^ "
RequireNonAlphanumeric^^ /
=^^0 1
true^^2 6
;^^6 7
options__ 
.__ 
Password__ 
.__ 
RequiredLength__ '
=__( )
$num__* +
;__+ ,
}`` 
)`` 
.aa $
AddEntityFrameworkStoresaa 
<aa 
HealthAxisDbContextaa 1
>aa1 2
(aa2 3
)aa3 4
.bb $
AddDefaultTokenProvidersbb 
(bb 
)bb 
;bb  
vardd 
jwtSettingsdd 
=dd 
builderdd 
.dd 
Configurationdd +
.dd+ ,

GetSectiondd, 6
(dd6 7
$strdd7 <
)dd< =
;dd= >
builderff 
.ff 
Servicesff 
.ff 
AddAuthenticationff &
(ff& '
optionsff' .
=>ff/ 1
{gg 
optionshh 
.hh %
DefaultAuthenticateSchemehh )
=hh* +
JwtBearerDefaultshh, =
.hh= > 
AuthenticationSchemehh> R
;hhR S
optionsii 
.ii "
DefaultChallengeSchemeii &
=ii' (
JwtBearerDefaultsii) :
.ii: ; 
AuthenticationSchemeii; O
;iiO P
}jj 
)jj 
.kk 
AddJwtBearerkk 
(kk 
optionskk 
=>kk 
{ll 
optionsmm 
.mm %
TokenValidationParametersmm )
=mm* +
newmm, /%
TokenValidationParametersmm0 I
{nn 	
ValidateIssueroo 
=oo 
trueoo !
,oo! "
ValidIssuerpp 
=pp 
jwtSettingspp %
[pp% &
$strpp& .
]pp. /
,pp/ 0
ValidateAudiencerr 
=rr 
truerr #
,rr# $
ValidAudiencess 
=ss 
jwtSettingsss '
[ss' (
$strss( 2
]ss2 3
,ss3 4
ValidateLifetimeuu 
=uu 
trueuu #
,uu# $$
ValidateIssuerSigningKeyww $
=ww% &
trueww' +
,ww+ ,
IssuerSigningKeyxx 
=xx 
newxx " 
SymmetricSecurityKeyxx# 7
(xx7 8
Encodingyy 
.yy 
UTF8yy 
.yy 
GetBytesyy &
(yy& '
jwtSettingsyy' 2
[yy2 3
$stryy3 8
]yy8 9
!yy9 :
)yy: ;
)zz 
,zz 
	ClockSkew|| 
=|| 
TimeSpan||  
.||  !
Zero||! %
}}} 	
;}}	 

}~~ 
)~~ 
;~~ 
builder
ÄÄ 
.
ÄÄ 
Services
ÄÄ 
.
ÄÄ 
AddAuthorization
ÄÄ %
(
ÄÄ% &
)
ÄÄ& '
;
ÄÄ' (
builder
ÇÇ 
.
ÇÇ 
Services
ÇÇ 
.
ÇÇ 
	AddScoped
ÇÇ 
<
ÇÇ 
IDoctorRepository
ÇÇ 0
,
ÇÇ0 1
DoctorRepository
ÇÇ2 B
>
ÇÇB C
(
ÇÇC D
)
ÇÇD E
;
ÇÇE F
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
ÉÉ  
IPatientRepository
ÉÉ 1
,
ÉÉ1 2
PatientRepository
ÉÉ3 D
>
ÉÉD E
(
ÉÉE F
)
ÉÉF G
;
ÉÉG H
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
ÑÑ $
IAppointmentRepository
ÑÑ 5
,
ÑÑ5 6#
AppointmentRepository
ÑÑ7 L
>
ÑÑL M
(
ÑÑM N
)
ÑÑN O
;
ÑÑO P
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
ÖÖ %
IHealthRecordRepository
ÖÖ 6
,
ÖÖ6 7$
HealthRecordRepository
ÖÖ8 N
>
ÖÖN O
(
ÖÖO P
)
ÖÖP Q
;
ÖÖQ R
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
áá 
IAuthService
áá +
,
áá+ ,
AuthService
áá- 8
>
áá8 9
(
áá9 :
)
áá: ;
;
áá; <
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
àà 
IDoctorService
àà -
,
àà- .
DoctorService
àà/ <
>
àà< =
(
àà= >
)
àà> ?
;
àà? @
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
ââ 
IPatientService
ââ .
,
ââ. /
PatientService
ââ0 >
>
ââ> ?
(
ââ? @
)
ââ@ A
;
ââA B
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
ää !
IAppointmentService
ää 2
,
ää2 3 
AppointmentService
ää4 F
>
ääF G
(
ääG H
)
ääH I
;
ääI J
builder
ãã 
.
ãã 
Services
ãã 
.
ãã 
	AddScoped
ãã 
<
ãã "
IHealthRecordService
ãã 3
,
ãã3 4!
HealthRecordService
ãã5 H
>
ããH I
(
ããI J
)
ããJ K
;
ããK L
builder
åå 
.
åå 
Services
åå 
.
åå 
	AddScoped
åå 
<
åå 
IAdminService
åå ,
,
åå, -
AdminService
åå. :
>
åå: ;
(
åå; <
)
åå< =
;
åå= >
builder
éé 
.
éé 
Services
éé 
.
éé 
AddAutoMapper
éé "
(
éé" #
cfg
éé# &
=>
éé' )
{
èè 
cfg
êê 
.
êê 

AddProfile
êê 
<
êê 
MappingProfile
êê %
>
êê% &
(
êê& '
)
êê' (
;
êê( )
}
ëë 
)
ëë 
;
ëë 
var
ìì 
app
ìì 
=
ìì 
builder
ìì 
.
ìì 
Build
ìì 
(
ìì 
)
ìì 
;
ìì 
app
ïï 
.
ïï !
UseExceptionHandler
ïï 
(
ïï 
)
ïï 
;
ïï 
app
óó 
.
óó &
UseSerilogRequestLogging
óó  
(
óó  !
options
óó! (
=>
óó) +
{
òò 
options
ôô 
.
ôô 
MessageTemplate
ôô 
=
ôô  !
$str
ôô" t
;
ôôt u
options
õõ 
.
õõ %
EnrichDiagnosticContext
õõ '
=
õõ( )
(
õõ* +
diagnosticContext
õõ+ <
,
õõ< =
httpContext
õõ> I
)
õõI J
=>
õõK M
{
úú 	
diagnosticContext
ùù 
.
ùù 
Set
ùù !
(
ùù! "
$str
ùù" /
,
ùù/ 0
httpContext
ùù1 <
.
ùù< =
Request
ùù= D
.
ùùD E
Host
ùùE I
.
ùùI J
Value
ùùJ O
??
ùùP R
string
ùùS Y
.
ùùY Z
Empty
ùùZ _
)
ùù_ `
;
ùù` a
diagnosticContext
ûû 
.
ûû 
Set
ûû !
(
ûû! "
$str
ûû" 1
,
ûû1 2
httpContext
ûû3 >
.
ûû> ?
Request
ûû? F
.
ûûF G
Scheme
ûûG M
)
ûûM N
;
ûûN O
diagnosticContext
üü 
.
üü 
Set
üü !
(
üü! "
$str
üü" ,
,
üü, -
httpContext
üü. 9
.
üü9 :
User
üü: >
.
üü> ?
Identity
üü? G
?
üüG H
.
üüH I
Name
üüI M
??
üüN P
$str
üüQ \
)
üü\ ]
;
üü] ^
}
†† 	
;
††	 

}
°° 
)
°° 
;
°° 
using
££ 	
(
££
 
var
££ 
scope
££ 
=
££ 
app
££ 
.
££ 
Services
££ #
.
££# $
CreateScope
££$ /
(
££/ 0
)
££0 1
)
££1 2
{
§§ 
var
•• 
roleManager
•• 
=
•• 
scope
•• 
.
••  
ServiceProvider
••  /
.
••/ 0 
GetRequiredService
••0 B
<
••B C
RoleManager
••C N
<
••N O
IdentityRole
••O [
>
••[ \
>
••\ ]
(
••] ^
)
••^ _
;
••_ `
var
¶¶ 
userManager
¶¶ 
=
¶¶ 
scope
¶¶ 
.
¶¶  
ServiceProvider
¶¶  /
.
¶¶/ 0 
GetRequiredService
¶¶0 B
<
¶¶B C
UserManager
¶¶C N
<
¶¶N O
IdentityUser
¶¶O [
>
¶¶[ \
>
¶¶\ ]
(
¶¶] ^
)
¶¶^ _
;
¶¶_ `
var
ßß 
context
ßß 
=
ßß 
scope
ßß 
.
ßß 
ServiceProvider
ßß +
.
ßß+ , 
GetRequiredService
ßß, >
<
ßß> ?!
HealthAxisDbContext
ßß? R
>
ßßR S
(
ßßS T
)
ßßT U
;
ßßU V
await
©©  
IdentityDataSeeder
©©  
.
©©  !
	SeedAsync
©©! *
(
©©* +
roleManager
©©+ 6
,
©©6 7
userManager
©©8 C
,
©©C D
context
©©E L
)
©©L M
;
©©M N
}
™™ 
if
¨¨ 
(
¨¨ 
app
¨¨ 
.
¨¨ 
Environment
¨¨ 
.
¨¨ 
IsDevelopment
¨¨ %
(
¨¨% &
)
¨¨& '
)
¨¨' (
{
≠≠ 
app
ÆÆ 
.
ÆÆ 

UseSwagger
ÆÆ 
(
ÆÆ 
)
ÆÆ 
;
ÆÆ 
app
ØØ 
.
ØØ 
UseSwaggerUI
ØØ 
(
ØØ 
)
ØØ 
;
ØØ 
}
∞∞ 
app
≤≤ 
.
≤≤ !
UseHttpsRedirection
≤≤ 
(
≤≤ 
)
≤≤ 
;
≤≤ 
app
¥¥ 
.
¥¥ 
UseCors
¥¥ 
(
¥¥ '
HealthAxisAdminCorsPolicy
¥¥ )
)
¥¥) *
;
¥¥* +
app
∂∂ 
.
∂∂ 
UseAuthentication
∂∂ 
(
∂∂ 
)
∂∂ 
;
∂∂ 
app
∑∑ 
.
∑∑ 
UseAuthorization
∑∑ 
(
∑∑ 
)
∑∑ 
;
∑∑ 
app
ππ 
.
ππ 
MapControllers
ππ 
(
ππ 
)
ππ 
;
ππ 
app
ªª 
.
ªª 
MapGet
ªª 
(
ªª 
$str
ªª 
,
ªª 
(
ªª 
)
ªª 
=>
ªª 
$"
ªª 
{
ªª 
appName
ªª $
}
ªª$ %
$str
ªª% >
"
ªª> ?
)
ªª? @
;
ªª@ A
Log
ΩΩ 
.
ΩΩ 
Information
ΩΩ 
(
ΩΩ 
$str
ΩΩ 0
,
ΩΩ0 1
appName
ΩΩ2 9
)
ΩΩ9 :
;
ΩΩ: ;
await
øø 	
app
øø
 
.
øø 
RunAsync
øø 
(
øø 
)
øø 
;
øø 
}¿¿ 
catch¡¡ 
(
¡¡ 
	Exception
¡¡ 
	exception
¡¡ 
)
¡¡ 
{¬¬ 
Log
√√ 
.
√√ 
Fatal
√√ 
(
√√ 
	exception
√√ 
,
√√ 
$str
√√ B
)
√√B C
;
√√C D
}ƒƒ 
finally≈≈ 
{∆∆ 
await
«« 	
Log
««
 
.
««  
CloseAndFlushAsync
««  
(
««  !
)
««! "
;
««" #
}»» ∞
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
}"" è
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

DateOnly 
	VisitDate 
{ 
get  #
;# $
set% (
;( )
}* +
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
	Diagnosis 
{ 
get !
;! "
set# &
;& '
}( )
=* +
string, 2
.2 3
Empty3 8
;8 9
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
Prescription 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
string/ 5
.5 6
Empty6 ;
;; <
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
? 
Notes 
{ 
get 
; 
set  #
;# $
}% &
[ 

ForeignKey 
( 
nameof 
( 
AppointmentId $
)$ %
)% &
]& '
public 

Appointment 
? 
Appointment #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} õ!
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
}&& ö
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
} î⁄
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
}ÏÏ © 
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
}.. ÌJ
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

DoctorNameOO$ .
,OO. /
optPP 
=>PP 
optPP 
.PP 
MapFromPP "
(PP" #
srcPP# &
=>PP' )
srcQQ 
.QQ 
AppointmentQQ #
!=QQ$ &
nullQQ' +
&&QQ, .
srcQQ/ 2
.QQ2 3
AppointmentQQ3 >
.QQ> ?
DoctorQQ? E
!=QQF H
nullQQI M
?RR 
srcRR 
.RR 
AppointmentRR )
.RR) *
DoctorRR* 0
.RR0 1
FullNameRR1 9
:SS 
stringSS  
.SS  !
EmptySS! &
)SS& '
)SS' (
;SS( )
}TT 
}UU ¥	
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
} àﬁ
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
;8 9
public 

static 
async 
Task 
	SeedAsync &
(& '
RoleManager 
< 
IdentityRole  
>  !
roleManager" -
,- .
UserManager 
< 
IdentityUser  
>  !
userManager" -
,- .
HealthAxisDbContext 
context #
,# $
bool 
seedDemoData 
= 
true  
)  !
{ 
await 
SeedRolesAsync 
( 
roleManager (
)( )
;) *
await 
SeedAdminsAsync 
( 
userManager )
)) *
;* +
if 

( 
! 
seedDemoData 
) 
{ 	
return 
; 
} 	
var 
doctors 
= 
await 
SeedDoctorsAsync ,
(, -
userManager- 8
,8 9
context: A
)A B
;B C
var 
patients 
= 
await 
SeedPatientsAsync .
(. /
userManager/ :
,: ;
context< C
)C D
;D E
await   1
%SeedAppointmentsAndHealthRecordsAsync   3
(  3 4
context  4 ;
,  ; <
doctors  = D
,  D E
patients  F N
)  N O
;  O P
}!! 
private## 
static## 
async## 
Task## 
SeedRolesAsync## ,
(##, -
RoleManager##- 8
<##8 9
IdentityRole##9 E
>##E F
roleManager##G R
)##R S
{$$ 
string%% 
[%% 
]%% 
roles%% 
=%% 
[%% 
AppRoles%% "
.%%" #
Admin%%# (
,%%( )
AppRoles%%* 2
.%%2 3
Doctor%%3 9
,%%9 :
AppRoles%%; C
.%%C D
Patient%%D K
]%%K L
;%%L M
foreach'' 
('' 
var'' 
role'' 
in'' 
roles'' "
)''" #
{(( 	
if)) 
()) 
!)) 
await)) 
roleManager)) "
.))" #
RoleExistsAsync))# 2
())2 3
role))3 7
)))7 8
)))8 9
{** 
await++ 
roleManager++ !
.++! "
CreateAsync++" -
(++- .
new++. 1
IdentityRole++2 >
{,, 
Name-- 
=-- 
role-- 
}.. 
).. 
;.. 
}// 
}00 	
}11 
private33 
static33 
async33 
Task33 
SeedAdminsAsync33 -
(33- .
UserManager33. 9
<339 :
IdentityUser33: F
>33F G
userManager33H S
)33S T
{44 
var55 
admins55 
=55 
new55 
[55 
]55 
{66 	
new77 
SeedUser77 
(77 
$str77 /
,77/ 0
$str771 =
)77= >
,77> ?
new88 
SeedUser88 
(88 
$str88 :
,88: ;
$str88< H
)88H I
,88I J
new99 
SeedUser99 
(99 
$str99 7
,997 8
$str999 E
)99E F
}:: 	
;::	 

foreach<< 
(<< 
var<< 
admin<< 
in<< 
admins<< $
)<<$ %
{== 	
await>> #
EnsureUserWithRoleAsync>> )
(>>) *
userManager>>* 5
,>>5 6
admin>>7 <
.>>< =
Email>>= B
,>>B C
admin>>D I
.>>I J
PhoneNumber>>J U
,>>U V
AdminPassword>>W d
,>>d e
AppRoles>>f n
.>>n o
Admin>>o t
)>>t u
;>>u v
}?? 	
}@@ 
privateBB 
staticBB 
asyncBB 
TaskBB 
<BB 
ListBB "
<BB" #
DoctorBB# )
>BB) *
>BB* +
SeedDoctorsAsyncBB, <
(BB< =
UserManagerCC 
<CC 
IdentityUserCC  
>CC  !
userManagerCC" -
,CC- .
HealthAxisDbContextDD 
contextDD #
)DD# $
{EE 
varFF 
doctorSeedsFF 
=FF 
newFF 
[FF 
]FF 
{GG 	
newHH 

SeedDoctorHH 
(HH 
$strHH )
,HH) *
$strHH+ H
,HHH I
$strHHJ V
,HHV W 
DoctorSpecialisationHHX l
.HHl m

CardiologyHHm w
,HHw x
newHHy |
DateOnly	HH} Ö
(
HHÖ Ü
$num
HHÜ ä
,
HHä ã
$num
HHå ç
,
HHç é
$num
HHè ê
)
HHê ë
,
HHë í
$num
HHì ó
,
HHó ò
true
HHô ù
)
HHù û
,
HHû ü
newII 

SeedDoctorII 
(II 
$strII (
,II( )
$strII* F
,IIF G
$strIIH T
,IIT U 
DoctorSpecialisationIIV j
.IIj k

CardiologyIIk u
,IIu v
newIIw z
DateOnly	II{ É
(
IIÉ Ñ
$num
IIÑ à
,
IIà â
$num
IIä ã
,
IIã å
$num
IIç è
)
IIè ê
,
IIê ë
$num
IIí ñ
,
IIñ ó
false
IIò ù
)
IIù û
,
IIû ü
newKK 

SeedDoctorKK 
(KK 
$strKK '
,KK' (
$strKK) D
,KKD E
$strKKF R
,KKR S 
DoctorSpecialisationKKT h
.KKh i
DermatologyKKi t
,KKt u
newKKv y
DateOnly	KKz Ç
(
KKÇ É
$num
KKÉ á
,
KKá à
$num
KKâ ä
,
KKä ã
$num
KKå ç
)
KKç é
,
KKé è
$num
KKê î
,
KKî ï
true
KKñ ö
)
KKö õ
,
KKõ ú
newLL 

SeedDoctorLL 
(LL 
$strLL )
,LL) *
$strLL+ H
,LLH I
$strLLJ V
,LLV W 
DoctorSpecialisationLLX l
.LLl m
DermatologyLLm x
,LLx y
newLLz }
DateOnly	LL~ Ü
(
LLÜ á
$num
LLá ã
,
LLã å
$num
LLç é
,
LLé è
$num
LLê í
)
LLí ì
,
LLì î
$num
LLï ô
,
LLô ö
true
LLõ ü
)
LLü †
,
LL† °
newNN 

SeedDoctorNN 
(NN 
$strNN (
,NN( )
$strNN* F
,NNF G
$strNNH T
,NNT U 
DoctorSpecialisationNNV j
.NNj k
	NeurologyNNk t
,NNt u
newNNv y
DateOnly	NNz Ç
(
NNÇ É
$num
NNÉ á
,
NNá à
$num
NNâ ä
,
NNä ã
$num
NNå é
)
NNé è
,
NNè ê
$num
NNë ï
,
NNï ñ
true
NNó õ
)
NNõ ú
,
NNú ù
newOO 

SeedDoctorOO 
(OO 
$strOO '
,OO' (
$strOO) D
,OOD E
$strOOF R
,OOR S 
DoctorSpecialisationOOT h
.OOh i
	NeurologyOOi r
,OOr s
newOOt w
DateOnly	OOx Ä
(
OOÄ Å
$num
OOÅ Ö
,
OOÖ Ü
$num
OOá à
,
OOà â
$num
OOä å
)
OOå ç
,
OOç é
$num
OOè ì
,
OOì î
false
OOï ö
)
OOö õ
,
OOõ ú
newQQ 

SeedDoctorQQ 
(QQ 
$strQQ )
,QQ) *
$strQQ+ H
,QQH I
$strQQJ V
,QQV W 
DoctorSpecialisationQQX l
.QQl m
OrthopaedicsQQm y
,QQy z
newQQ{ ~
DateOnly	QQ á
(
QQá à
$num
QQà å
,
QQå ç
$num
QQé è
,
QQè ê
$num
QQë ì
)
QQì î
,
QQî ï
$num
QQñ ö
,
QQö õ
true
QQú †
)
QQ† °
,
QQ° ¢
newRR 

SeedDoctorRR 
(RR 
$strRR )
,RR) *
$strRR+ H
,RRH I
$strRRJ V
,RRV W 
DoctorSpecialisationRRX l
.RRl m
OrthopaedicsRRm y
,RRy z
newRR{ ~
DateOnly	RR á
(
RRá à
$num
RRà å
,
RRå ç
$num
RRé ê
,
RRê ë
$num
RRí ì
)
RRì î
,
RRî ï
$num
RRñ ö
,
RRö õ
true
RRú †
)
RR† °
,
RR° ¢
newTT 

SeedDoctorTT 
(TT 
$strTT *
,TT* +
$strTT, J
,TTJ K
$strTTL X
,TTX Y 
DoctorSpecialisationTTZ n
.TTn o

PediatricsTTo y
,TTy z
newTT{ ~
DateOnly	TT á
(
TTá à
$num
TTà å
,
TTå ç
$num
TTé è
,
TTè ê
$num
TTë í
)
TTí ì
,
TTì î
$num
TTï ô
,
TTô ö
true
TTõ ü
)
TTü †
,
TT† °
newUU 

SeedDoctorUU 
(UU 
$strUU )
,UU) *
$strUU+ H
,UUH I
$strUUJ V
,UUV W 
DoctorSpecialisationUUX l
.UUl m

PediatricsUUm w
,UUw x
newUUy |
DateOnly	UU} Ö
(
UUÖ Ü
$num
UUÜ ä
,
UUä ã
$num
UUå é
,
UUé è
$num
UUê í
)
UUí ì
,
UUì î
$num
UUï ô
,
UUô ö
true
UUõ ü
)
UUü †
,
UU† °
newWW 

SeedDoctorWW 
(WW 
$strWW *
,WW* +
$strWW, J
,WWJ K
$strWWL X
,WWX Y 
DoctorSpecialisationWWZ n
.WWn o
GeneralMedicineWWo ~
,WW~ 
new
WWÄ É
DateOnly
WWÑ å
(
WWå ç
$num
WWç ë
,
WWë í
$num
WWì ï
,
WWï ñ
$num
WWó ò
)
WWò ô
,
WWô ö
$num
WWõ ü
,
WWü †
true
WW° •
)
WW• ¶
,
WW¶ ß
newXX 

SeedDoctorXX 
(XX 
$strXX )
,XX) *
$strXX+ H
,XXH I
$strXXJ V
,XXV W 
DoctorSpecialisationXXX l
.XXl m
GeneralMedicineXXm |
,XX| }
new	XX~ Å
DateOnly
XXÇ ä
(
XXä ã
$num
XXã è
,
XXè ê
$num
XXë í
,
XXí ì
$num
XXî ñ
)
XXñ ó
,
XXó ò
$num
XXô ù
,
XXù û
true
XXü £
)
XX£ §
,
XX§ •
newZZ 

SeedDoctorZZ 
(ZZ 
$strZZ )
,ZZ) *
$strZZ+ H
,ZZH I
$strZZJ V
,ZZV W 
DoctorSpecialisationZZX l
.ZZl m

PsychiatryZZm w
,ZZw x
newZZy |
DateOnly	ZZ} Ö
(
ZZÖ Ü
$num
ZZÜ ä
,
ZZä ã
$num
ZZå ç
,
ZZç é
$num
ZZè ê
)
ZZê ë
,
ZZë í
$num
ZZì ó
,
ZZó ò
true
ZZô ù
)
ZZù û
,
ZZû ü
new[[ 

SeedDoctor[[ 
([[ 
$str[[ )
,[[) *
$str[[+ H
,[[H I
$str[[J V
,[[V W 
DoctorSpecialisation[[X l
.[[l m

Psychiatry[[m w
,[[w x
new[[y |
DateOnly	[[} Ö
(
[[Ö Ü
$num
[[Ü ä
,
[[ä ã
$num
[[å ç
,
[[ç é
$num
[[è ë
)
[[ë í
,
[[í ì
$num
[[î ò
,
[[ò ô
true
[[ö û
)
[[û ü
,
[[ü †
new]] 

SeedDoctor]] 
(]] 
$str]] (
,]]( )
$str]]* F
,]]F G
$str]]H T
,]]T U 
DoctorSpecialisation]]V j
.]]j k
	Radiology]]k t
,]]t u
new]]v y
DateOnly	]]z Ç
(
]]Ç É
$num
]]É á
,
]]á à
$num
]]â ä
,
]]ä ã
$num
]]å ç
)
]]ç é
,
]]é è
$num
]]ê î
,
]]î ï
true
]]ñ ö
)
]]ö õ
,
]]õ ú
new^^ 

SeedDoctor^^ 
(^^ 
$str^^ )
,^^) *
$str^^+ H
,^^H I
$str^^J V
,^^V W 
DoctorSpecialisation^^X l
.^^l m
	Radiology^^m v
,^^v w
new^^x {
DateOnly	^^| Ñ
(
^^Ñ Ö
$num
^^Ö â
,
^^â ä
$num
^^ã å
,
^^å ç
$num
^^é ê
)
^^ê ë
,
^^ë í
$num
^^ì ó
,
^^ó ò
false
^^ô û
)
^^û ü
,
^^ü †
new`` 

SeedDoctor`` 
(`` 
$str`` *
,``* +
$str``, Q
,``Q R
$str``S _
,``_ ` 
DoctorSpecialisation``a u
.``u v

Gynecology	``v Ä
,
``Ä Å
new
``Ç Ö
DateOnly
``Ü é
(
``é è
$num
``è ì
,
``ì î
$num
``ï ñ
,
``ñ ó
$num
``ò ö
)
``ö õ
,
``õ ú
$num
``ù °
,
``° ¢
true
``£ ß
)
``ß ®
,
``® ©
newaa 

SeedDoctoraa 
(aa 
$straa (
,aa( )
$straa* M
,aaM N
$straaO [
,aa[ \ 
DoctorSpecialisationaa] q
.aaq r

Gynecologyaar |
,aa| }
new	aa~ Å
DateOnly
aaÇ ä
(
aaä ã
$num
aaã è
,
aaè ê
$num
aaë ì
,
aaì î
$num
aaï ñ
)
aañ ó
,
aaó ò
$num
aaô ù
,
aaù û
true
aaü £
)
aa£ §
,
aa§ •
newcc 

SeedDoctorcc 
(cc 
$strcc &
,cc& '
$strcc( I
,ccI J
$strccK W
,ccW X 
DoctorSpecialisationccY m
.ccm n
ENTccn q
,ccq r
newccs v
DateOnlyccw 
(	cc Ä
$num
ccÄ Ñ
,
ccÑ Ö
$num
ccÜ á
,
ccá à
$num
ccâ ã
)
ccã å
,
ccå ç
$num
ccé í
,
ccí ì
true
ccî ò
)
ccò ô
,
ccô ö
newdd 

SeedDoctordd 
(dd 
$strdd )
,dd) *
$strdd+ O
,ddO P
$strddQ ]
,dd] ^ 
DoctorSpecialisationdd_ s
.dds t
ENTddt w
,ddw x
newddy |
DateOnly	dd} Ö
(
ddÖ Ü
$num
ddÜ ä
,
ddä ã
$num
ddå ç
,
ddç é
$num
ddè ê
)
ddê ë
,
ddë í
$num
ddì ó
,
ddó ò
true
ddô ù
)
ddù û
}ee 	
;ee	 

foreachgg 
(gg 
vargg 
seedgg 
ingg 
doctorSeedsgg (
)gg( )
{hh 	
varii 
userii 
=ii 
awaitii #
EnsureUserWithRoleAsyncii 4
(ii4 5
userManagerii5 @
,ii@ A
seediiB F
.iiF G
EmailiiG L
,iiL M
seediiN R
.iiR S
PhoneNumberiiS ^
,ii^ _
DoctorPasswordii` n
,iin o
AppRolesiip x
.iix y
Doctoriiy 
)	ii Ä
;
iiÄ Å
varkk 
doctorkk 
=kk 
awaitkk 
contextkk &
.kk& '
Doctorskk' .
.kk. /
FirstOrDefaultAsynckk/ B
(kkB C
existingDoctorkkC Q
=>kkR T
existingDoctorkkU c
.kkc d
UserIdkkd j
==kkk m
userkkn r
.kkr s
Idkks u
)kku v
;kkv w
ifmm 
(mm 
doctormm 
==mm 
nullmm 
)mm 
{nn 
doctoroo 
=oo 
newoo 
Doctoroo #
{pp 
UserIdqq 
=qq 
userqq !
.qq! "
Idqq" $
,qq$ %
FullNamerr 
=rr 
RemoveDoctorTitlerr 0
(rr0 1
seedrr1 5
.rr5 6
FullNamerr6 >
)rr> ?
,rr? @
Specialisationss "
=ss# $
seedss% )
.ss) *
Specialisationss* 8
,ss8 9
PracticeStartDatett %
=tt& '
seedtt( ,
.tt, -
PracticeStartDatett- >
,tt> ?
ConsultationFeeuu #
=uu$ %
seeduu& *
.uu* +
ConsultationFeeuu+ :
,uu: ;
IsAvailablevv 
=vv  !
seedvv" &
.vv& '
IsAvailablevv' 2
}ww 
;ww 
awaityy 
contextyy 
.yy 
Doctorsyy %
.yy% &
AddAsyncyy& .
(yy. /
doctoryy/ 5
)yy5 6
;yy6 7
}zz 
else{{ 
{|| 
doctor}} 
.}} 
FullName}} 
=}}  !
RemoveDoctorTitle}}" 3
(}}3 4
seed}}4 8
.}}8 9
FullName}}9 A
)}}A B
;}}B C
doctor~~ 
.~~ 
Specialisation~~ %
=~~& '
seed~~( ,
.~~, -
Specialisation~~- ;
;~~; <
doctor 
. 
PracticeStartDate (
=) *
seed+ /
./ 0
PracticeStartDate0 A
;A B
doctor
ÄÄ 
.
ÄÄ 
ConsultationFee
ÄÄ &
=
ÄÄ' (
seed
ÄÄ) -
.
ÄÄ- .
ConsultationFee
ÄÄ. =
;
ÄÄ= >
doctor
ÅÅ 
.
ÅÅ 
IsAvailable
ÅÅ "
=
ÅÅ# $
seed
ÅÅ% )
.
ÅÅ) *
IsAvailable
ÅÅ* 5
;
ÅÅ5 6
}
ÇÇ 
}
ÉÉ 	
await
ÖÖ 
context
ÖÖ 
.
ÖÖ 
SaveChangesAsync
ÖÖ &
(
ÖÖ& '
)
ÖÖ' (
;
ÖÖ( )
return
áá 
await
áá 
context
áá 
.
áá 
Doctors
áá $
.
àà 
Include
àà 
(
àà 
doctor
àà 
=>
àà 
doctor
àà %
.
àà% &
User
àà& *
)
àà* +
.
ââ 
OrderBy
ââ 
(
ââ 
doctor
ââ 
=>
ââ 
doctor
ââ %
.
ââ% &
Id
ââ& (
)
ââ( )
.
ää 
ToListAsync
ää 
(
ää 
)
ää 
;
ää 
}
ãã 
private
çç 
static
çç 
async
çç 
Task
çç 
<
çç 
List
çç "
<
çç" #
Patient
çç# *
>
çç* +
>
çç+ ,
SeedPatientsAsync
çç- >
(
çç> ?
UserManager
éé 
<
éé 
IdentityUser
éé  
>
éé  !
userManager
éé" -
,
éé- .!
HealthAxisDbContext
èè 
context
èè #
)
èè# $
{
êê 
var
ëë 
patientSeeds
ëë 
=
ëë 
new
ëë 
[
ëë 
]
ëë  
{
íí 	
new
ìì 
SeedPatient
ìì 
(
ìì 
$str
ìì )
,
ìì) *
$str
ìì+ D
,
ììD E
$str
ììF R
,
ììR S
new
ììT W
DateOnly
ììX `
(
ìì` a
$num
ììa e
,
ììe f
$num
ììg h
,
ììh i
$num
ììj l
)
ììl m
,
ììm n
$str
ììo u
,
ììu v
$strììw ã
)ììã å
,ììå ç
new
îî 
SeedPatient
îî 
(
îî 
$str
îî )
,
îî) *
$str
îî+ D
,
îîD E
$str
îîF R
,
îîR S
new
îîT W
DateOnly
îîX `
(
îî` a
$num
îîa e
,
îîe f
$num
îîg i
,
îîi j
$num
îîk l
)
îîl m
,
îîm n
$str
îîo w
,
îîw x
$strîîy à
)îîà â
,îîâ ä
new
ïï 
SeedPatient
ïï 
(
ïï 
$str
ïï (
,
ïï( )
$str
ïï* B
,
ïïB C
$str
ïïD P
,
ïïP Q
new
ïïR U
DateOnly
ïïV ^
(
ïï^ _
$num
ïï_ c
,
ïïc d
$num
ïïe f
,
ïïf g
$num
ïïh j
)
ïïj k
,
ïïk l
$str
ïïm s
,
ïïs t
$strïïu Ö
)ïïÖ Ü
,ïïÜ á
new
ññ 
SeedPatient
ññ 
(
ññ 
$str
ññ (
,
ññ( )
$str
ññ* B
,
ññB C
$str
ññD P
,
ññP Q
new
ññR U
DateOnly
ññV ^
(
ññ^ _
$num
ññ_ c
,
ññc d
$num
ññe f
,
ññf g
$num
ññh j
)
ññj k
,
ññk l
$str
ññm u
,
ññu v
$strññw â
)ññâ ä
,ññä ã
new
óó 
SeedPatient
óó 
(
óó 
$str
óó *
,
óó* +
$str
óó, F
,
óóF G
$str
óóH T
,
óóT U
new
óóV Y
DateOnly
óóZ b
(
óób c
$num
óóc g
,
óóg h
$num
óói k
,
óók l
$num
óóm n
)
óón o
,
óóo p
$str
óóq w
,
óów x
$stróóy ã
)óóã å
,óóå ç
new
òò 
SeedPatient
òò 
(
òò 
$str
òò (
,
òò( )
$str
òò* B
,
òòB C
$str
òòD P
,
òòP Q
new
òòR U
DateOnly
òòV ^
(
òò^ _
$num
òò_ c
,
òòc d
$num
òòe f
,
òòf g
$num
òòh j
)
òòj k
,
òòk l
$str
òòm u
,
òòu v
$stròòw ä
)òòä ã
,òòã å
new
ôô 
SeedPatient
ôô 
(
ôô 
$str
ôô +
,
ôô+ ,
$str
ôô- H
,
ôôH I
$str
ôôJ V
,
ôôV W
new
ôôX [
DateOnly
ôô\ d
(
ôôd e
$num
ôôe i
,
ôôi j
$num
ôôk l
,
ôôl m
$num
ôôn o
)
ôôo p
,
ôôp q
$str
ôôr z
,
ôôz {
$strôô| é
)ôôé è
,ôôè ê
new
öö 
SeedPatient
öö 
(
öö 
$str
öö )
,
öö) *
$str
öö+ D
,
ööD E
$str
ööF R
,
ööR S
new
ööT W
DateOnly
ööX `
(
öö` a
$num
ööa e
,
ööe f
$num
öög h
,
ööh i
$num
ööj l
)
ööl m
,
ööm n
$str
ööo u
,
ööu v
$strööw á
)ööá à
,ööà â
new
õõ 
SeedPatient
õõ 
(
õõ 
$str
õõ '
,
õõ' (
$str
õõ) @
,
õõ@ A
$str
õõB N
,
õõN O
new
õõP S
DateOnly
õõT \
(
õõ\ ]
$num
õõ] a
,
õõa b
$num
õõc d
,
õõd e
$num
õõf h
)
õõh i
,
õõi j
$str
õõk s
,
õõs t
$strõõu Ü
)õõÜ á
,õõá à
new
úú 
SeedPatient
úú 
(
úú 
$str
úú '
,
úú' (
$str
úú) @
,
úú@ A
$str
úúB N
,
úúN O
new
úúP S
DateOnly
úúT \
(
úú\ ]
$num
úú] a
,
úúa b
$num
úúc e
,
úúe f
$num
úúg h
)
úúh i
,
úúi j
$str
úúk q
,
úúq r
$strúús á
)úúá à
,úúà â
new
ùù 
SeedPatient
ùù 
(
ùù 
$str
ùù )
,
ùù) *
$str
ùù+ D
,
ùùD E
$str
ùùF R
,
ùùR S
new
ùùT W
DateOnly
ùùX `
(
ùù` a
$num
ùùa e
,
ùùe f
$num
ùùg h
,
ùùh i
$num
ùùj l
)
ùùl m
,
ùùm n
$str
ùùo w
,
ùùw x
$strùùy ë
)ùùë í
,ùùí ì
new
ûû 
SeedPatient
ûû 
(
ûû 
$str
ûû )
,
ûû) *
$str
ûû+ D
,
ûûD E
$str
ûûF R
,
ûûR S
new
ûûT W
DateOnly
ûûX `
(
ûû` a
$num
ûûa e
,
ûûe f
$num
ûûg h
,
ûûh i
$num
ûûj l
)
ûûl m
,
ûûm n
$str
ûûo u
,
ûûu v
$strûûw á
)ûûá à
,ûûà â
new
üü 
SeedPatient
üü 
(
üü 
$str
üü .
,
üü. /
$str
üü0 N
,
üüN O
$str
üüP \
,
üü\ ]
new
üü^ a
DateOnly
üüb j
(
üüj k
$num
üük o
,
üüo p
$num
üüq s
,
üüs t
$num
üüu v
)
üüv w
,
üüw x
$strüüy Å
,üüÅ Ç
$strüüÉ î
)üüî ï
,üüï ñ
new
†† 
SeedPatient
†† 
(
†† 
$str
†† ,
,
††, -
$str
††. J
,
††J K
$str
††L X
,
††X Y
new
††Z ]
DateOnly
††^ f
(
††f g
$num
††g k
,
††k l
$num
††m n
,
††n o
$num
††p r
)
††r s
,
††s t
$str
††u {
,
††{ |
$str††} è
)††è ê
,††ê ë
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
°°R S
new
°°T W
DateOnly
°°X `
(
°°` a
$num
°°a e
,
°°e f
$num
°°g h
,
°°h i
$num
°°j l
)
°°l m
,
°°m n
$str
°°o w
,
°°w x
$str°°y å
)°°å ç
,°°ç é
new
¢¢ 
SeedPatient
¢¢ 
(
¢¢ 
$str
¢¢ *
,
¢¢* +
$str
¢¢, F
,
¢¢F G
$str
¢¢H T
,
¢¢T U
new
¢¢V Y
DateOnly
¢¢Z b
(
¢¢b c
$num
¢¢c g
,
¢¢g h
$num
¢¢i j
,
¢¢j k
$num
¢¢l m
)
¢¢m n
,
¢¢n o
$str
¢¢p v
,
¢¢v w
$str¢¢x å
)¢¢å ç
,¢¢ç é
new
££ 
SeedPatient
££ 
(
££ 
$str
££ &
,
££& '
$str
££( >
,
££> ?
$str
££@ L
,
££L M
new
££N Q
DateOnly
££R Z
(
££Z [
$num
££[ _
,
££_ `
$num
££a b
,
££b c
$num
££d e
)
££e f
,
££f g
$str
££h p
,
££p q
$str££r à
)££à â
,££â ä
new
§§ 
SeedPatient
§§ 
(
§§ 
$str
§§ .
,
§§. /
$str
§§0 N
,
§§N O
$str
§§P \
,
§§\ ]
new
§§^ a
DateOnly
§§b j
(
§§j k
$num
§§k o
,
§§o p
$num
§§q s
,
§§s t
$num
§§u w
)
§§w x
,
§§x y
$str§§z Ä
,§§Ä Å
$str§§Ç î
)§§î ï
}
•• 	
;
••	 

foreach
ßß 
(
ßß 
var
ßß 
seed
ßß 
in
ßß 
patientSeeds
ßß )
)
ßß) *
{
®® 	
var
©© 
user
©© 
=
©© 
await
©© %
EnsureUserWithRoleAsync
©© 4
(
©©4 5
userManager
©©5 @
,
©©@ A
seed
©©B F
.
©©F G
Email
©©G L
,
©©L M
seed
©©N R
.
©©R S
PhoneNumber
©©S ^
,
©©^ _
PatientPassword
©©` o
,
©©o p
AppRoles
©©q y
.
©©y z
Patient©©z Å
)©©Å Ç
;©©Ç É
var
´´ 
patient
´´ 
=
´´ 
await
´´ 
context
´´  '
.
´´' (
Patients
´´( 0
.
´´0 1!
FirstOrDefaultAsync
´´1 D
(
´´D E
existingPatient
´´E T
=>
´´U W
existingPatient
´´X g
.
´´g h
UserId
´´h n
==
´´o q
user
´´r v
.
´´v w
Id
´´w y
)
´´y z
;
´´z {
if
≠≠ 
(
≠≠ 
patient
≠≠ 
==
≠≠ 
null
≠≠ 
)
≠≠  
{
ÆÆ 
patient
ØØ 
=
ØØ 
new
ØØ 
Patient
ØØ %
{
∞∞ 
UserId
±± 
=
±± 
user
±± !
.
±±! "
Id
±±" $
,
±±$ %
FullName
≤≤ 
=
≤≤ 
seed
≤≤ #
.
≤≤# $
FullName
≤≤$ ,
,
≤≤, -
DateOfBirth
≥≥ 
=
≥≥  !
seed
≥≥" &
.
≥≥& '
DateOfBirth
≥≥' 2
,
≥≥2 3
Gender
¥¥ 
=
¥¥ 
seed
¥¥ !
.
¥¥! "
Gender
¥¥" (
,
¥¥( )
Address
µµ 
=
µµ 
seed
µµ "
.
µµ" #
Address
µµ# *
}
∂∂ 
;
∂∂ 
await
∏∏ 
context
∏∏ 
.
∏∏ 
Patients
∏∏ &
.
∏∏& '
AddAsync
∏∏' /
(
∏∏/ 0
patient
∏∏0 7
)
∏∏7 8
;
∏∏8 9
}
ππ 
else
∫∫ 
{
ªª 
patient
ºº 
.
ºº 
FullName
ºº  
=
ºº! "
seed
ºº# '
.
ºº' (
FullName
ºº( 0
;
ºº0 1
patient
ΩΩ 
.
ΩΩ 
DateOfBirth
ΩΩ #
=
ΩΩ$ %
seed
ΩΩ& *
.
ΩΩ* +
DateOfBirth
ΩΩ+ 6
;
ΩΩ6 7
patient
ææ 
.
ææ 
Gender
ææ 
=
ææ  
seed
ææ! %
.
ææ% &
Gender
ææ& ,
;
ææ, -
patient
øø 
.
øø 
Address
øø 
=
øø  !
seed
øø" &
.
øø& '
Address
øø' .
;
øø. /
}
¿¿ 
}
¡¡ 	
await
√√ 
context
√√ 
.
√√ 
SaveChangesAsync
√√ &
(
√√& '
)
√√' (
;
√√( )
return
≈≈ 
await
≈≈ 
context
≈≈ 
.
≈≈ 
Patients
≈≈ %
.
∆∆ 
Include
∆∆ 
(
∆∆ 
patient
∆∆ 
=>
∆∆ 
patient
∆∆  '
.
∆∆' (
User
∆∆( ,
)
∆∆, -
.
«« 
OrderBy
«« 
(
«« 
patient
«« 
=>
«« 
patient
««  '
.
««' (
Id
««( *
)
««* +
.
»» 
ToListAsync
»» 
(
»» 
)
»» 
;
»» 
}
…… 
private
ÀÀ 
static
ÀÀ 
async
ÀÀ 
Task
ÀÀ 3
%SeedAppointmentsAndHealthRecordsAsync
ÀÀ C
(
ÀÀC D!
HealthAxisDbContext
ÃÃ 
context
ÃÃ #
,
ÃÃ# $
IReadOnlyList
ÕÕ 
<
ÕÕ 
Doctor
ÕÕ 
>
ÕÕ 
doctors
ÕÕ %
,
ÕÕ% &
IReadOnlyList
ŒŒ 
<
ŒŒ 
Patient
ŒŒ 
>
ŒŒ 
patients
ŒŒ '
)
ŒŒ' (
{
œœ 
if
–– 

(
–– 
doctors
–– 
.
–– 
Count
–– 
==
–– 
$num
–– 
||
–– !
patients
––" *
.
––* +
Count
––+ 0
==
––1 3
$num
––4 5
)
––5 6
{
—— 	
return
““ 
;
““ 
}
”” 	
var
’’ 
today
’’ 
=
’’ 
DateOnly
’’ 
.
’’ 
FromDateTime
’’ )
(
’’) *
DateTime
’’* 2
.
’’2 3
Today
’’3 8
)
’’8 9
;
’’9 :
var
÷÷ 
doctorLookup
÷÷ 
=
÷÷ 
doctors
÷÷ "
.
◊◊ 
GroupBy
◊◊ 
(
◊◊ 
doctor
◊◊ 
=>
◊◊ 
doctor
◊◊ %
.
◊◊% &
Specialisation
◊◊& 4
)
◊◊4 5
.
ÿÿ 
ToDictionary
ÿÿ 
(
ÿÿ 
group
ÿÿ 
=>
ÿÿ  "
group
ÿÿ# (
.
ÿÿ( )
Key
ÿÿ) ,
,
ÿÿ, -
group
ÿÿ. 3
=>
ÿÿ4 6
group
ÿÿ7 <
.
ÿÿ< =
First
ÿÿ= B
(
ÿÿB C
)
ÿÿC D
)
ÿÿD E
;
ÿÿE F
var
ŸŸ 
appointmentSeeds
ŸŸ 
=
ŸŸ #
BuildAppointmentSeeds
ŸŸ 4
(
ŸŸ4 5
today
ŸŸ5 :
,
ŸŸ: ;
doctorLookup
ŸŸ< H
,
ŸŸH I
patients
ŸŸJ R
)
ŸŸR S
;
ŸŸS T
var
⁄⁄ .
 completedAppointmentsWithRecords
⁄⁄ ,
=
⁄⁄- .
new
⁄⁄/ 2
List
⁄⁄3 7
<
⁄⁄7 8
(
⁄⁄8 9
Appointment
⁄⁄9 D
Appointment
⁄⁄E P
,
⁄⁄P Q
SeedHealthRecord
⁄⁄R b
HealthRecord
⁄⁄c o
)
⁄⁄o p
>
⁄⁄p q
(
⁄⁄q r
)
⁄⁄r s
;
⁄⁄s t
foreach
‹‹ 
(
‹‹ 
var
‹‹ 
seed
‹‹ 
in
‹‹ 
appointmentSeeds
‹‹ -
)
‹‹- .
{
›› 	
var
ﬁﬁ 
appointment
ﬁﬁ 
=
ﬁﬁ 
await
ﬁﬁ #
context
ﬁﬁ$ +
.
ﬁﬁ+ ,
Appointments
ﬁﬁ, 8
.
ﬂﬂ 
Include
ﬂﬂ 
(
ﬂﬂ !
existingAppointment
ﬂﬂ ,
=>
ﬂﬂ- /!
existingAppointment
ﬂﬂ0 C
.
ﬂﬂC D
HealthRecord
ﬂﬂD P
)
ﬂﬂP Q
.
‡‡ !
FirstOrDefaultAsync
‡‡ $
(
‡‡$ %!
existingAppointment
‡‡% 8
=>
‡‡9 ;!
existingAppointment
·· '
.
··' (
	PatientId
··( 1
==
··2 4
seed
··5 9
.
··9 :
Patient
··: A
.
··A B
Id
··B D
&&
··E G!
existingAppointment
‚‚ '
.
‚‚' (
DoctorId
‚‚( 0
==
‚‚1 3
seed
‚‚4 8
.
‚‚8 9
Doctor
‚‚9 ?
.
‚‚? @
Id
‚‚@ B
&&
‚‚C E!
existingAppointment
„„ '
.
„„' (
AppointmentDate
„„( 7
==
„„8 :
seed
„„; ?
.
„„? @
Date
„„@ D
&&
„„E G!
existingAppointment
‰‰ '
.
‰‰' (
AppointmentTime
‰‰( 7
==
‰‰8 :
seed
‰‰; ?
.
‰‰? @
Time
‰‰@ D
)
‰‰D E
;
‰‰E F
if
ÊÊ 
(
ÊÊ 
appointment
ÊÊ 
==
ÊÊ 
null
ÊÊ #
)
ÊÊ# $
{
ÁÁ 
appointment
ËË 
=
ËË 
new
ËË !
Appointment
ËË" -
{
ÈÈ 
	PatientId
ÍÍ 
=
ÍÍ 
seed
ÍÍ  $
.
ÍÍ$ %
Patient
ÍÍ% ,
.
ÍÍ, -
Id
ÍÍ- /
,
ÍÍ/ 0
DoctorId
ÎÎ 
=
ÎÎ 
seed
ÎÎ #
.
ÎÎ# $
Doctor
ÎÎ$ *
.
ÎÎ* +
Id
ÎÎ+ -
,
ÎÎ- .
AppointmentDate
ÏÏ #
=
ÏÏ$ %
seed
ÏÏ& *
.
ÏÏ* +
Date
ÏÏ+ /
,
ÏÏ/ 0
AppointmentTime
ÌÌ #
=
ÌÌ$ %
seed
ÌÌ& *
.
ÌÌ* +
Time
ÌÌ+ /
}
ÓÓ 
;
ÓÓ 
await
 
context
 
.
 
Appointments
 *
.
* +
AddAsync
+ 3
(
3 4
appointment
4 ?
)
? @
;
@ A
}
ÒÒ 
appointment
ÛÛ 
.
ÛÛ 
Status
ÛÛ 
=
ÛÛ  
seed
ÛÛ! %
.
ÛÛ% &
Status
ÛÛ& ,
;
ÛÛ, -
appointment
ÙÙ 
.
ÙÙ  
CancellationReason
ÙÙ *
=
ÙÙ+ ,
seed
ÙÙ- 1
.
ÙÙ1 2 
CancellationReason
ÙÙ2 D
;
ÙÙD E
if
ˆˆ 
(
ˆˆ 
seed
ˆˆ 
.
ˆˆ 
HealthRecord
ˆˆ !
!=
ˆˆ" $
null
ˆˆ% )
&&
ˆˆ* ,
seed
ˆˆ- 1
.
ˆˆ1 2
Status
ˆˆ2 8
==
ˆˆ9 ;
AppointmentStatus
ˆˆ< M
.
ˆˆM N
	Completed
ˆˆN W
)
ˆˆW X
{
˜˜ .
 completedAppointmentsWithRecords
¯¯ 0
.
¯¯0 1
Add
¯¯1 4
(
¯¯4 5
(
¯¯5 6
appointment
¯¯6 A
,
¯¯A B
seed
¯¯C G
.
¯¯G H
HealthRecord
¯¯H T
)
¯¯T U
)
¯¯U V
;
¯¯V W
}
˘˘ 
}
˙˙ 	
await
¸¸ 
context
¸¸ 
.
¸¸ 
SaveChangesAsync
¸¸ &
(
¸¸& '
)
¸¸' (
;
¸¸( )
foreach
˛˛ 
(
˛˛ 
var
˛˛ 
(
˛˛ 
appointment
˛˛ !
,
˛˛! "

seedRecord
˛˛# -
)
˛˛- .
in
˛˛/ 1.
 completedAppointmentsWithRecords
˛˛2 R
)
˛˛R S
{
ˇˇ 	
var
ÄÄ 
healthRecord
ÄÄ 
=
ÄÄ 
await
ÄÄ $
context
ÄÄ% ,
.
ÄÄ, -
HealthRecords
ÄÄ- :
.
ÅÅ !
FirstOrDefaultAsync
ÅÅ $
(
ÅÅ$ %
record
ÅÅ% +
=>
ÅÅ, .
record
ÅÅ/ 5
.
ÅÅ5 6
AppointmentId
ÅÅ6 C
==
ÅÅD F
appointment
ÅÅG R
.
ÅÅR S
Id
ÅÅS U
)
ÅÅU V
;
ÅÅV W
if
ÉÉ 
(
ÉÉ 
healthRecord
ÉÉ 
==
ÉÉ 
null
ÉÉ  $
)
ÉÉ$ %
{
ÑÑ 
healthRecord
ÖÖ 
=
ÖÖ 
new
ÖÖ "
HealthRecord
ÖÖ# /
{
ÜÜ 
AppointmentId
áá !
=
áá" #
appointment
áá$ /
.
áá/ 0
Id
áá0 2
}
àà 
;
àà 
await
ää 
context
ää 
.
ää 
HealthRecords
ää +
.
ää+ ,
AddAsync
ää, 4
(
ää4 5
healthRecord
ää5 A
)
ääA B
;
ääB C
}
ãã 
healthRecord
çç 
.
çç 
	VisitDate
çç "
=
çç# $

seedRecord
çç% /
.
çç/ 0
	VisitDate
çç0 9
;
çç9 :
healthRecord
éé 
.
éé 
	Diagnosis
éé "
=
éé# $

seedRecord
éé% /
.
éé/ 0
	Diagnosis
éé0 9
;
éé9 :
healthRecord
èè 
.
èè 
Prescription
èè %
=
èè& '

seedRecord
èè( 2
.
èè2 3
Prescription
èè3 ?
;
èè? @
healthRecord
êê 
.
êê 
Notes
êê 
=
êê  

seedRecord
êê! +
.
êê+ ,
Notes
êê, 1
;
êê1 2
}
ëë 	
await
ìì 
context
ìì 
.
ìì 
SaveChangesAsync
ìì &
(
ìì& '
)
ìì' (
;
ìì( )
}
îî 
private
ññ 
static
ññ 
IReadOnlyList
ññ  
<
ññ  !
SeedAppointment
ññ! 0
>
ññ0 1#
BuildAppointmentSeeds
ññ2 G
(
ññG H
DateOnly
óó 
today
óó 
,
óó !
IReadOnlyDictionary
òò 
<
òò "
DoctorSpecialisation
òò 0
,
òò0 1
Doctor
òò2 8
>
òò8 9
doctorLookup
òò: F
,
òòF G
IReadOnlyList
ôô 
<
ôô 
Patient
ôô 
>
ôô 
patients
ôô '
)
ôô' (
{
öö 
Doctor
õõ 
Doctor
õõ 
(
õõ "
DoctorSpecialisation
õõ *
specialisation
õõ+ 9
)
õõ9 :
=>
õõ; =
doctorLookup
õõ> J
[
õõJ K
specialisation
õõK Y
]
õõY Z
;
õõZ [
Patient
úú 
Patient
úú 
(
úú 
int
úú 
index
úú !
)
úú! "
=>
úú# %
patients
úú& .
[
úú. /
index
úú/ 4
%
úú5 6
patients
úú7 ?
.
úú? @
Count
úú@ E
]
úúE F
;
úúF G
return
ûû 
[
üü 	
new
†† 
(
†† 
Patient
†† 
(
†† 
$num
†† 
)
†† 
,
†† 
Doctor
†† "
(
††" #"
DoctorSpecialisation
††# 7
.
††7 8

Cardiology
††8 B
)
††B C
,
††C D
today
††E J
.
††J K
AddDays
††K R
(
††R S
$num
††S T
)
††T U
,
††U V
new
††W Z
TimeOnly
††[ c
(
††c d
$num
††d e
,
††e f
$num
††g h
)
††h i
,
††i j
AppointmentStatus
††k |
.
††| }
Pending††} Ñ
,††Ñ Ö
null††Ü ä
,††ä ã
null††å ê
)††ê ë
,††ë í
new
°° 
(
°° 
Patient
°° 
(
°° 
$num
°° 
)
°° 
,
°° 
Doctor
°° "
(
°°" #"
DoctorSpecialisation
°°# 7
.
°°7 8
Dermatology
°°8 C
)
°°C D
,
°°D E
today
°°F K
.
°°K L
AddDays
°°L S
(
°°S T
$num
°°T U
)
°°U V
,
°°V W
new
°°X [
TimeOnly
°°\ d
(
°°d e
$num
°°e g
,
°°g h
$num
°°i j
)
°°j k
,
°°k l
AppointmentStatus
°°m ~
.
°°~ 
	Confirmed°° à
,°°à â
null°°ä é
,°°é è
null°°ê î
)°°î ï
,°°ï ñ
new
¢¢ 
(
¢¢ 
Patient
¢¢ 
(
¢¢ 
$num
¢¢ 
)
¢¢ 
,
¢¢ 
Doctor
¢¢ "
(
¢¢" #"
DoctorSpecialisation
¢¢# 7
.
¢¢7 8
	Neurology
¢¢8 A
)
¢¢A B
,
¢¢B C
today
¢¢D I
.
¢¢I J
AddDays
¢¢J Q
(
¢¢Q R
$num
¢¢R S
)
¢¢S T
,
¢¢T U
new
¢¢V Y
TimeOnly
¢¢Z b
(
¢¢b c
$num
¢¢c e
,
¢¢e f
$num
¢¢g h
)
¢¢h i
,
¢¢i j
AppointmentStatus
¢¢k |
.
¢¢| }
	Cancelled¢¢} Ü
,¢¢Ü á
$str¢¢à ª
,¢¢ª º
null¢¢Ω ¡
)¢¢¡ ¬
,¢¢¬ √
new
££ 
(
££ 
Patient
££ 
(
££ 
$num
££ 
)
££ 
,
££ 
Doctor
££ "
(
££" #"
DoctorSpecialisation
££# 7
.
££7 8
Orthopaedics
££8 D
)
££D E
,
££E F
today
££G L
.
££L M
AddDays
££M T
(
££T U
$num
££U V
)
££V W
,
££W X
new
££Y \
TimeOnly
££] e
(
££e f
$num
££f g
,
££g h
$num
££i k
)
££k l
,
££l m
AppointmentStatus
££n 
.££ Ä
Pending££Ä á
,££á à
null££â ç
,££ç é
null££è ì
)££ì î
,££î ï
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
Doctor
§§ "
(
§§" #"
DoctorSpecialisation
§§# 7
.
§§7 8

Pediatrics
§§8 B
)
§§B C
,
§§C D
today
§§E J
.
§§J K
AddDays
§§K R
(
§§R S
$num
§§S T
)
§§T U
,
§§U V
new
§§W Z
TimeOnly
§§[ c
(
§§c d
$num
§§d f
,
§§f g
$num
§§h j
)
§§j k
,
§§k l
AppointmentStatus
§§m ~
.
§§~ 
	Confirmed§§ à
,§§à â
null§§ä é
,§§é è
null§§ê î
)§§î ï
,§§ï ñ
new
•• 
(
•• 
Patient
•• 
(
•• 
$num
•• 
)
•• 
,
•• 
Doctor
•• "
(
••" #"
DoctorSpecialisation
••# 7
.
••7 8
GeneralMedicine
••8 G
)
••G H
,
••H I
today
••J O
.
••O P
AddDays
••P W
(
••W X
$num
••X Y
)
••Y Z
,
••Z [
new
••\ _
TimeOnly
••` h
(
••h i
$num
••i k
,
••k l
$num
••m o
)
••o p
,
••p q 
AppointmentStatus••r É
.••É Ñ
Pending••Ñ ã
,••ã å
null••ç ë
,••ë í
null••ì ó
)••ó ò
,••ò ô
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
Doctor
¶¶ "
(
¶¶" #"
DoctorSpecialisation
¶¶# 7
.
¶¶7 8

Psychiatry
¶¶8 B
)
¶¶B C
,
¶¶C D
today
¶¶E J
.
¶¶J K
AddDays
¶¶K R
(
¶¶R S
$num
¶¶S T
)
¶¶T U
,
¶¶U V
new
¶¶W Z
TimeOnly
¶¶[ c
(
¶¶c d
$num
¶¶d f
,
¶¶f g
$num
¶¶h i
)
¶¶i j
,
¶¶j k
AppointmentStatus
¶¶l }
.
¶¶} ~
	Confirmed¶¶~ á
,¶¶á à
null¶¶â ç
,¶¶ç é
null¶¶è ì
)¶¶ì î
,¶¶î ï
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
Doctor
ßß "
(
ßß" #"
DoctorSpecialisation
ßß# 7
.
ßß7 8
	Radiology
ßß8 A
)
ßßA B
,
ßßB C
today
ßßD I
.
ßßI J
AddDays
ßßJ Q
(
ßßQ R
$num
ßßR S
)
ßßS T
,
ßßT U
new
ßßV Y
TimeOnly
ßßZ b
(
ßßb c
$num
ßßc e
,
ßße f
$num
ßßg h
)
ßßh i
,
ßßi j
AppointmentStatus
ßßk |
.
ßß| }
Pendingßß} Ñ
,ßßÑ Ö
nullßßÜ ä
,ßßä ã
nullßßå ê
)ßßê ë
,ßßë í
new
®® 
(
®® 
Patient
®® 
(
®® 
$num
®® 
)
®® 
,
®® 
Doctor
®® "
(
®®" #"
DoctorSpecialisation
®®# 7
.
®®7 8

Gynecology
®®8 B
)
®®B C
,
®®C D
today
®®E J
.
®®J K
AddDays
®®K R
(
®®R S
$num
®®S T
)
®®T U
,
®®U V
new
®®W Z
TimeOnly
®®[ c
(
®®c d
$num
®®d e
,
®®e f
$num
®®g h
)
®®h i
,
®®i j
AppointmentStatus
®®k |
.
®®| }
	Cancelled®®} Ü
,®®Ü á
$str®®à ±
,®®± ≤
null®®≥ ∑
)®®∑ ∏
,®®∏ π
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
Doctor
©© "
(
©©" #"
DoctorSpecialisation
©©# 7
.
©©7 8
ENT
©©8 ;
)
©©; <
,
©©< =
today
©©> C
.
©©C D
AddDays
©©D K
(
©©K L
$num
©©L M
)
©©M N
,
©©N O
new
©©P S
TimeOnly
©©T \
(
©©\ ]
$num
©©] _
,
©©_ `
$num
©©a b
)
©©b c
,
©©c d
AppointmentStatus
©©e v
.
©©v w
Pending
©©w ~
,
©©~ 
null©©Ä Ñ
,©©Ñ Ö
null©©Ü ä
)©©ä ã
,©©ã å
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
Doctor
´´ "
(
´´" #"
DoctorSpecialisation
´´# 7
.
´´7 8

Cardiology
´´8 B
)
´´B C
,
´´C D
today
´´E J
.
´´J K
AddDays
´´K R
(
´´R S
-
´´S T
$num
´´T U
)
´´U V
,
´´V W
new
´´X [
TimeOnly
´´\ d
(
´´d e
$num
´´e f
,
´´f g
$num
´´h i
)
´´i j
,
´´j k
AppointmentStatus
´´l }
.
´´} ~
	Completed´´~ á
,´´á à
null´´â ç
,´´ç é
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
¨¨4 5
)
¨¨5 6
,
¨¨6 7
$str
¨¨8 P
,
¨¨P Q
$str¨¨R ê
,¨¨ê ë
$str¨¨í —
)¨¨— “
)¨¨“ ”
,¨¨” ‘
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
Doctor
≠≠ "
(
≠≠" #"
DoctorSpecialisation
≠≠# 7
.
≠≠7 8
Dermatology
≠≠8 C
)
≠≠C D
,
≠≠D E
today
≠≠F K
.
≠≠K L
AddDays
≠≠L S
(
≠≠S T
-
≠≠T U
$num
≠≠U V
)
≠≠V W
,
≠≠W X
new
≠≠Y \
TimeOnly
≠≠] e
(
≠≠e f
$num
≠≠f h
,
≠≠h i
$num
≠≠j k
)
≠≠k l
,
≠≠l m
AppointmentStatus
≠≠n 
.≠≠ Ä
	Completed≠≠Ä â
,≠≠â ä
null≠≠ã è
,≠≠è ê
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
ÆÆ4 5
)
ÆÆ5 6
,
ÆÆ6 7
$str
ÆÆ8 Q
,
ÆÆQ R
$strÆÆS à
,ÆÆà â
$strÆÆä º
)ÆÆº Ω
)ÆÆΩ æ
,ÆÆæ ø
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
Doctor
ØØ "
(
ØØ" #"
DoctorSpecialisation
ØØ# 7
.
ØØ7 8
	Neurology
ØØ8 A
)
ØØA B
,
ØØB C
today
ØØD I
.
ØØI J
AddDays
ØØJ Q
(
ØØQ R
-
ØØR S
$num
ØØS T
)
ØØT U
,
ØØU V
new
ØØW Z
TimeOnly
ØØ[ c
(
ØØc d
$num
ØØd f
,
ØØf g
$num
ØØh i
)
ØØi j
,
ØØj k
AppointmentStatus
ØØl }
.
ØØ} ~
	CompletedØØ~ á
,ØØá à
nullØØâ ç
,ØØç é
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
∞∞4 5
)
∞∞5 6
,
∞∞6 7
$str
∞∞8 e
,
∞∞e f
$str∞∞g ä
,∞∞ä ã
$str∞∞å ¡
)∞∞¡ ¬
)∞∞¬ √
,∞∞√ ƒ
new
±± 
(
±± 
Patient
±± 
(
±± 
$num
±± 
)
±± 
,
±± 
Doctor
±± "
(
±±" #"
DoctorSpecialisation
±±# 7
.
±±7 8
Orthopaedics
±±8 D
)
±±D E
,
±±E F
today
±±G L
.
±±L M
AddDays
±±M T
(
±±T U
-
±±U V
$num
±±V W
)
±±W X
,
±±X Y
new
±±Z ]
TimeOnly
±±^ f
(
±±f g
$num
±±g i
,
±±i j
$num
±±k l
)
±±l m
,
±±m n 
AppointmentStatus±±o Ä
.±±Ä Å
	Completed±±Å ä
,±±ä ã
null±±å ê
,±±ê ë
new
≤≤ 
SeedHealthRecord
≤≤ $
(
≤≤$ %
today
≤≤% *
.
≤≤* +
AddDays
≤≤+ 2
(
≤≤2 3
-
≤≤3 4
$num
≤≤4 5
)
≤≤5 6
,
≤≤6 7
$str
≤≤8 T
,
≤≤T U
$str≤≤V ç
,≤≤ç é
$str≤≤è Ω
)≤≤Ω æ
)≤≤æ ø
,≤≤ø ¿
new
≥≥ 
(
≥≥ 
Patient
≥≥ 
(
≥≥ 
$num
≥≥ 
)
≥≥ 
,
≥≥ 
Doctor
≥≥ "
(
≥≥" #"
DoctorSpecialisation
≥≥# 7
.
≥≥7 8

Pediatrics
≥≥8 B
)
≥≥B C
,
≥≥C D
today
≥≥E J
.
≥≥J K
AddDays
≥≥K R
(
≥≥R S
-
≥≥S T
$num
≥≥T U
)
≥≥U V
,
≥≥V W
new
≥≥X [
TimeOnly
≥≥\ d
(
≥≥d e
$num
≥≥e f
,
≥≥f g
$num
≥≥h j
)
≥≥j k
,
≥≥k l
AppointmentStatus
≥≥m ~
.
≥≥~ 
	Completed≥≥ à
,≥≥à â
null≥≥ä é
,≥≥é è
new
¥¥ 
SeedHealthRecord
¥¥ $
(
¥¥$ %
today
¥¥% *
.
¥¥* +
AddDays
¥¥+ 2
(
¥¥2 3
-
¥¥3 4
$num
¥¥4 5
)
¥¥5 6
,
¥¥6 7
$str
¥¥8 [
,
¥¥[ \
$str¥¥] Ç
,¥¥Ç É
$str¥¥Ñ Ω
)¥¥Ω æ
)¥¥æ ø
,¥¥ø ¿
new
µµ 
(
µµ 
Patient
µµ 
(
µµ 
$num
µµ 
)
µµ 
,
µµ 
Doctor
µµ "
(
µµ" #"
DoctorSpecialisation
µµ# 7
.
µµ7 8
GeneralMedicine
µµ8 G
)
µµG H
,
µµH I
today
µµJ O
.
µµO P
AddDays
µµP W
(
µµW X
-
µµX Y
$num
µµY Z
)
µµZ [
,
µµ[ \
new
µµ] `
TimeOnly
µµa i
(
µµi j
$num
µµj l
,
µµl m
$num
µµn p
)
µµp q
,
µµq r 
AppointmentStatusµµs Ñ
.µµÑ Ö
	CompletedµµÖ é
,µµé è
nullµµê î
,µµî ï
new
∂∂ 
SeedHealthRecord
∂∂ $
(
∂∂$ %
today
∂∂% *
.
∂∂* +
AddDays
∂∂+ 2
(
∂∂2 3
-
∂∂3 4
$num
∂∂4 5
)
∂∂5 6
,
∂∂6 7
$str
∂∂8 X
,
∂∂X Y
$str∂∂Z Ü
,∂∂Ü á
$str∂∂à ª
)∂∂ª º
)∂∂º Ω
,∂∂Ω æ
new
∑∑ 
(
∑∑ 
Patient
∑∑ 
(
∑∑ 
$num
∑∑ 
)
∑∑ 
,
∑∑ 
Doctor
∑∑ "
(
∑∑" #"
DoctorSpecialisation
∑∑# 7
.
∑∑7 8

Psychiatry
∑∑8 B
)
∑∑B C
,
∑∑C D
today
∑∑E J
.
∑∑J K
AddDays
∑∑K R
(
∑∑R S
-
∑∑S T
$num
∑∑T U
)
∑∑U V
,
∑∑V W
new
∑∑X [
TimeOnly
∑∑\ d
(
∑∑d e
$num
∑∑e g
,
∑∑g h
$num
∑∑i k
)
∑∑k l
,
∑∑l m
AppointmentStatus
∑∑n 
.∑∑ Ä
	Completed∑∑Ä â
,∑∑â ä
null∑∑ã è
,∑∑è ê
new
∏∏ 
SeedHealthRecord
∏∏ $
(
∏∏$ %
today
∏∏% *
.
∏∏* +
AddDays
∏∏+ 2
(
∏∏2 3
-
∏∏3 4
$num
∏∏4 5
)
∏∏5 6
,
∏∏6 7
$str
∏∏8 V
,
∏∏V W
$str∏∏X ä
,∏∏ä ã
$str∏∏å ¬
)∏∏¬ √
)∏∏√ ƒ
,∏∏ƒ ≈
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
Doctor
ππ "
(
ππ" #"
DoctorSpecialisation
ππ# 7
.
ππ7 8
	Radiology
ππ8 A
)
ππA B
,
ππB C
today
ππD I
.
ππI J
AddDays
ππJ Q
(
ππQ R
-
ππR S
$num
ππS T
)
ππT U
,
ππU V
new
ππW Z
TimeOnly
ππ[ c
(
ππc d
$num
ππd f
,
ππf g
$num
ππh i
)
ππi j
,
ππj k
AppointmentStatus
ππl }
.
ππ} ~
	Completedππ~ á
,ππá à
nullππâ ç
,ππç é
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
∫∫4 5
)
∫∫5 6
,
∫∫6 7
$str
∫∫8 U
,
∫∫U V
$str∫∫W å
,∫∫å ç
$str∫∫é ∆
)∫∫∆ «
)∫∫« »
,∫∫» …
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
Doctor
ªª "
(
ªª" #"
DoctorSpecialisation
ªª# 7
.
ªª7 8

Gynecology
ªª8 B
)
ªªB C
,
ªªC D
today
ªªE J
.
ªªJ K
AddDays
ªªK R
(
ªªR S
-
ªªS T
$num
ªªT U
)
ªªU V
,
ªªV W
new
ªªX [
TimeOnly
ªª\ d
(
ªªd e
$num
ªªe g
,
ªªg h
$num
ªªi j
)
ªªj k
,
ªªk l
AppointmentStatus
ªªm ~
.
ªª~ 
	Completedªª à
,ªªà â
nullªªä é
,ªªé è
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
ºº4 5
)
ºº5 6
,
ºº6 7
$str
ºº8 ^
,
ºº^ _
$strºº` ê
,ººê ë
$strººí …
)ºº…  
)ºº  À
,ººÀ Ã
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
ΩΩ7 8
ENT
ΩΩ8 ;
)
ΩΩ; <
,
ΩΩ< =
today
ΩΩ> C
.
ΩΩC D
AddDays
ΩΩD K
(
ΩΩK L
-
ΩΩL M
$num
ΩΩM N
)
ΩΩN O
,
ΩΩO P
new
ΩΩQ T
TimeOnly
ΩΩU ]
(
ΩΩ] ^
$num
ΩΩ^ `
,
ΩΩ` a
$num
ΩΩb c
)
ΩΩc d
,
ΩΩd e
AppointmentStatus
ΩΩf w
.
ΩΩw x
	CompletedΩΩx Å
,ΩΩÅ Ç
nullΩΩÉ á
,ΩΩá à
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
ææ4 5
)
ææ5 6
,
ææ6 7
$str
ææ8 N
,
ææN O
$str
ææP s
,
ææs t
$strææu ≠
)ææ≠ Æ
)ææÆ Ø
,ææØ ∞
new
¿¿ 
(
¿¿ 
Patient
¿¿ 
(
¿¿ 
$num
¿¿ 
)
¿¿ 
,
¿¿ 
Doctor
¿¿ #
(
¿¿# $"
DoctorSpecialisation
¿¿$ 8
.
¿¿8 9

Cardiology
¿¿9 C
)
¿¿C D
,
¿¿D E
today
¿¿F K
.
¿¿K L
AddDays
¿¿L S
(
¿¿S T
-
¿¿T U
$num
¿¿U V
)
¿¿V W
,
¿¿W X
new
¿¿Y \
TimeOnly
¿¿] e
(
¿¿e f
$num
¿¿f g
,
¿¿g h
$num
¿¿i j
)
¿¿j k
,
¿¿k l
AppointmentStatus
¿¿m ~
.
¿¿~ 
	Cancelled¿¿ à
,¿¿à â
$str¿¿ä ±
,¿¿± ≤
null¿¿≥ ∑
)¿¿∑ ∏
,¿¿∏ π
new
¡¡ 
(
¡¡ 
Patient
¡¡ 
(
¡¡ 
$num
¡¡ 
)
¡¡ 
,
¡¡ 
Doctor
¡¡ #
(
¡¡# $"
DoctorSpecialisation
¡¡$ 8
.
¡¡8 9
Dermatology
¡¡9 D
)
¡¡D E
,
¡¡E F
today
¡¡G L
.
¡¡L M
AddDays
¡¡M T
(
¡¡T U
-
¡¡U V
$num
¡¡V W
)
¡¡W X
,
¡¡X Y
new
¡¡Z ]
TimeOnly
¡¡^ f
(
¡¡f g
$num
¡¡g i
,
¡¡i j
$num
¡¡k l
)
¡¡l m
,
¡¡m n 
AppointmentStatus¡¡o Ä
.¡¡Ä Å
	Cancelled¡¡Å ä
,¡¡ä ã
$str¡¡å ƒ
,¡¡ƒ ≈
null¡¡∆  
)¡¡  À
,¡¡À Ã
new
¬¬ 
(
¬¬ 
Patient
¬¬ 
(
¬¬ 
$num
¬¬ 
)
¬¬ 
,
¬¬ 
Doctor
¬¬ #
(
¬¬# $"
DoctorSpecialisation
¬¬$ 8
.
¬¬8 9
	Neurology
¬¬9 B
)
¬¬B C
,
¬¬C D
today
¬¬E J
.
¬¬J K
AddDays
¬¬K R
(
¬¬R S
-
¬¬S T
$num
¬¬T U
)
¬¬U V
,
¬¬V W
new
¬¬X [
TimeOnly
¬¬\ d
(
¬¬d e
$num
¬¬e g
,
¬¬g h
$num
¬¬i j
)
¬¬j k
,
¬¬k l
AppointmentStatus
¬¬m ~
.
¬¬~ 
	Completed¬¬ à
,¬¬à â
null¬¬ä é
,¬¬é è
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
√√4 5
)
√√5 6
,
√√6 7
$str
√√8 Z
,
√√Z [
$str√√\ ö
,√√ö õ
$str√√ú ﬂ
)√√ﬂ ‡
)√√‡ ·
,√√· ‚
new
ƒƒ 
(
ƒƒ 
Patient
ƒƒ 
(
ƒƒ 
$num
ƒƒ 
)
ƒƒ 
,
ƒƒ 
Doctor
ƒƒ #
(
ƒƒ# $"
DoctorSpecialisation
ƒƒ$ 8
.
ƒƒ8 9
Orthopaedics
ƒƒ9 E
)
ƒƒE F
,
ƒƒF G
today
ƒƒH M
.
ƒƒM N
AddDays
ƒƒN U
(
ƒƒU V
-
ƒƒV W
$num
ƒƒW X
)
ƒƒX Y
,
ƒƒY Z
new
ƒƒ[ ^
TimeOnly
ƒƒ_ g
(
ƒƒg h
$num
ƒƒh j
,
ƒƒj k
$num
ƒƒl m
)
ƒƒm n
,
ƒƒn o 
AppointmentStatusƒƒp Å
.ƒƒÅ Ç
	CompletedƒƒÇ ã
,ƒƒã å
nullƒƒç ë
,ƒƒë í
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
≈≈4 5
)
≈≈5 6
,
≈≈6 7
$str
≈≈8 W
,
≈≈W X
$str≈≈Y ä
,≈≈ä ã
$str≈≈å ©
)≈≈© ™
)≈≈™ ´
,≈≈´ ¨
new
∆∆ 
(
∆∆ 
Patient
∆∆ 
(
∆∆ 
$num
∆∆ 
)
∆∆ 
,
∆∆ 
Doctor
∆∆ #
(
∆∆# $"
DoctorSpecialisation
∆∆$ 8
.
∆∆8 9

Pediatrics
∆∆9 C
)
∆∆C D
,
∆∆D E
today
∆∆F K
.
∆∆K L
AddDays
∆∆L S
(
∆∆S T
-
∆∆T U
$num
∆∆U V
)
∆∆V W
,
∆∆W X
new
∆∆Y \
TimeOnly
∆∆] e
(
∆∆e f
$num
∆∆f h
,
∆∆h i
$num
∆∆j k
)
∆∆k l
,
∆∆l m
AppointmentStatus
∆∆n 
.∆∆ Ä
	Completed∆∆Ä â
,∆∆â ä
null∆∆ã è
,∆∆è ê
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
««8 W
,
««W X
$str««Y Ç
,««Ç É
$str««Ñ ≥
)««≥ ¥
)««¥ µ
,««µ ∂
new
»» 
(
»» 
Patient
»» 
(
»» 
$num
»» 
)
»» 
,
»» 
Doctor
»» #
(
»»# $"
DoctorSpecialisation
»»$ 8
.
»»8 9
GeneralMedicine
»»9 H
)
»»H I
,
»»I J
today
»»K P
.
»»P Q
AddDays
»»Q X
(
»»X Y
-
»»Y Z
$num
»»Z [
)
»»[ \
,
»»\ ]
new
»»^ a
TimeOnly
»»b j
(
»»j k
$num
»»k m
,
»»m n
$num
»»o p
)
»»p q
,
»»q r 
AppointmentStatus»»s Ñ
.»»Ñ Ö
	Completed»»Ö é
,»»é è
null»»ê î
,»»î ï
new
…… 
SeedHealthRecord
…… $
(
……$ %
today
……% *
.
……* +
AddDays
……+ 2
(
……2 3
-
……3 4
$num
……4 5
)
……5 6
,
……6 7
$str
……8 X
,
……X Y
$str
……Z y
,
……y z
$str……{ ©
)……© ™
)……™ ´
,……´ ¨
new
   
(
   
Patient
   
(
   
$num
   
)
   
,
   
Doctor
   #
(
  # $"
DoctorSpecialisation
  $ 8
.
  8 9

Psychiatry
  9 C
)
  C D
,
  D E
today
  F K
.
  K L
AddDays
  L S
(
  S T
-
  T U
$num
  U V
)
  V W
,
  W X
new
  Y \
TimeOnly
  ] e
(
  e f
$num
  f h
,
  h i
$num
  j k
)
  k l
,
  l m
AppointmentStatus
  n 
.   Ä
	Completed  Ä â
,  â ä
null  ã è
,  è ê
new
ÀÀ 
SeedHealthRecord
ÀÀ $
(
ÀÀ$ %
today
ÀÀ% *
.
ÀÀ* +
AddDays
ÀÀ+ 2
(
ÀÀ2 3
-
ÀÀ3 4
$num
ÀÀ4 5
)
ÀÀ5 6
,
ÀÀ6 7
$str
ÀÀ8 W
,
ÀÀW X
$strÀÀY ç
,ÀÀç é
$strÀÀè ∏
)ÀÀ∏ π
)ÀÀπ ∫
,ÀÀ∫ ª
new
ÃÃ 
(
ÃÃ 
Patient
ÃÃ 
(
ÃÃ 
$num
ÃÃ 
)
ÃÃ 
,
ÃÃ 
Doctor
ÃÃ #
(
ÃÃ# $"
DoctorSpecialisation
ÃÃ$ 8
.
ÃÃ8 9
ENT
ÃÃ9 <
)
ÃÃ< =
,
ÃÃ= >
today
ÃÃ? D
.
ÃÃD E
AddDays
ÃÃE L
(
ÃÃL M
-
ÃÃM N
$num
ÃÃN O
)
ÃÃO P
,
ÃÃP Q
new
ÃÃR U
TimeOnly
ÃÃV ^
(
ÃÃ^ _
$num
ÃÃ_ a
,
ÃÃa b
$num
ÃÃc d
)
ÃÃd e
,
ÃÃe f
AppointmentStatus
ÃÃg x
.
ÃÃx y
	CompletedÃÃy Ç
,ÃÃÇ É
nullÃÃÑ à
,ÃÃà â
new
ÕÕ 
SeedHealthRecord
ÕÕ $
(
ÕÕ$ %
today
ÕÕ% *
.
ÕÕ* +
AddDays
ÕÕ+ 2
(
ÕÕ2 3
-
ÕÕ3 4
$num
ÕÕ4 5
)
ÕÕ5 6
,
ÕÕ6 7
$str
ÕÕ8 R
,
ÕÕR S
$str
ÕÕT n
,
ÕÕn o
$strÕÕp †
)ÕÕ† °
)ÕÕ° ¢
,ÕÕ¢ £
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
Doctor
œœ "
(
œœ" #"
DoctorSpecialisation
œœ# 7
.
œœ7 8
	Radiology
œœ8 A
)
œœA B
,
œœB C
today
œœD I
,
œœI J
new
œœK N
TimeOnly
œœO W
(
œœW X
$num
œœX Y
,
œœY Z
$num
œœ[ ]
)
œœ] ^
,
œœ^ _
AppointmentStatus
œœ` q
.
œœq r
	Confirmed
œœr {
,
œœ{ |
nullœœ} Å
,œœÅ Ç
nullœœÉ á
)œœá à
,œœà â
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
Doctor
–– "
(
––" #"
DoctorSpecialisation
––# 7
.
––7 8

Gynecology
––8 B
)
––B C
,
––C D
today
––E J
,
––J K
new
––L O
TimeOnly
––P X
(
––X Y
$num
––Y [
,
––[ \
$num
––] _
)
––_ `
,
––` a
AppointmentStatus
––b s
.
––s t
Pending
––t {
,
––{ |
null––} Å
,––Å Ç
null––É á
)––á à
,––à â
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
Doctor
—— "
(
——" #"
DoctorSpecialisation
——# 7
.
——7 8
ENT
——8 ;
)
——; <
,
——< =
today
——> C
,
——C D
new
——E H
TimeOnly
——I Q
(
——Q R
$num
——R T
,
——T U
$num
——V X
)
——X Y
,
——Y Z
AppointmentStatus
——[ l
.
——l m
	Cancelled
——m v
,
——v w
$str——x ≠
,——≠ Æ
null——Ø ≥
)——≥ ¥
,——¥ µ
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
Doctor
““ "
(
““" #"
DoctorSpecialisation
““# 7
.
““7 8
GeneralMedicine
““8 G
)
““G H
,
““H I
today
““J O
,
““O P
new
““Q T
TimeOnly
““U ]
(
““] ^
$num
““^ `
,
““` a
$num
““b d
)
““d e
,
““e f
AppointmentStatus
““g x
.
““x y
	Completed““y Ç
,““Ç É
null““Ñ à
,““à â
new
”” 
SeedHealthRecord
”” $
(
””$ %
today
””% *
,
””* +
$str
””, C
,
””C D
$str
””E }
,
””} ~
$str”” ¶
)””¶ ß
)””ß ®
]
‘‘ 	
;
‘‘	 

}
’’ 
private
◊◊ 
static
◊◊ 
async
◊◊ 
Task
◊◊ 
<
◊◊ 
IdentityUser
◊◊ *
>
◊◊* +%
EnsureUserWithRoleAsync
◊◊, C
(
◊◊C D
UserManager
ÿÿ 
<
ÿÿ 
IdentityUser
ÿÿ  
>
ÿÿ  !
userManager
ÿÿ" -
,
ÿÿ- .
string
ŸŸ 
email
ŸŸ 
,
ŸŸ 
string
⁄⁄ 
phoneNumber
⁄⁄ 
,
⁄⁄ 
string
€€ 
password
€€ 
,
€€ 
string
‹‹ 
role
‹‹ 
)
‹‹ 
{
›› 
var
ﬁﬁ 
existingUser
ﬁﬁ 
=
ﬁﬁ 
await
ﬁﬁ  
userManager
ﬁﬁ! ,
.
ﬁﬁ, -
FindByEmailAsync
ﬁﬁ- =
(
ﬁﬁ= >
email
ﬁﬁ> C
)
ﬁﬁC D
;
ﬁﬁD E
if
‡‡ 

(
‡‡ 
existingUser
‡‡ 
==
‡‡ 
null
‡‡  
)
‡‡  !
{
·· 	
existingUser
‚‚ 
=
‚‚ 
new
‚‚ 
IdentityUser
‚‚ +
{
„„ 
UserName
‰‰ 
=
‰‰ 
email
‰‰  
,
‰‰  !
Email
ÂÂ 
=
ÂÂ 
email
ÂÂ 
,
ÂÂ 
PhoneNumber
ÊÊ 
=
ÊÊ 
phoneNumber
ÊÊ )
,
ÊÊ) *
EmailConfirmed
ÁÁ 
=
ÁÁ  
true
ÁÁ! %
}
ËË 
;
ËË 
var
ÍÍ 
result
ÍÍ 
=
ÍÍ 
await
ÍÍ 
userManager
ÍÍ *
.
ÍÍ* +
CreateAsync
ÍÍ+ 6
(
ÍÍ6 7
existingUser
ÍÍ7 C
,
ÍÍC D
password
ÍÍE M
)
ÍÍM N
;
ÍÍN O
if
ÏÏ 
(
ÏÏ 
!
ÏÏ 
result
ÏÏ 
.
ÏÏ 
	Succeeded
ÏÏ !
)
ÏÏ! "
{
ÌÌ 
var
ÓÓ 
errors
ÓÓ 
=
ÓÓ 
string
ÓÓ #
.
ÓÓ# $
Join
ÓÓ$ (
(
ÓÓ( )
$str
ÓÓ) ,
,
ÓÓ, -
result
ÓÓ. 4
.
ÓÓ4 5
Errors
ÓÓ5 ;
.
ÓÓ; <
Select
ÓÓ< B
(
ÓÓB C
error
ÓÓC H
=>
ÓÓI K
error
ÓÓL Q
.
ÓÓQ R
Description
ÓÓR ]
)
ÓÓ] ^
)
ÓÓ^ _
;
ÓÓ_ `
throw
ÔÔ 
new
ÔÔ '
InvalidOperationException
ÔÔ 3
(
ÔÔ3 4
$"
ÔÔ4 6
$str
ÔÔ6 J
{
ÔÔJ K
email
ÔÔK P
}
ÔÔP Q
$str
ÔÔQ S
{
ÔÔS T
errors
ÔÔT Z
}
ÔÔZ [
"
ÔÔ[ \
)
ÔÔ\ ]
;
ÔÔ] ^
}
 
}
ÒÒ 	
else
ÚÚ 
{
ÛÛ 	
existingUser
ÙÙ 
.
ÙÙ 
PhoneNumber
ÙÙ $
=
ÙÙ% &
phoneNumber
ÙÙ' 2
;
ÙÙ2 3
existingUser
ıı 
.
ıı 
EmailConfirmed
ıı '
=
ıı( )
true
ıı* .
;
ıı. /
await
ˆˆ 
userManager
ˆˆ 
.
ˆˆ 
UpdateAsync
ˆˆ )
(
ˆˆ) *
existingUser
ˆˆ* 6
)
ˆˆ6 7
;
ˆˆ7 8
}
˜˜ 	
if
˘˘ 

(
˘˘ 
!
˘˘ 
await
˘˘ 
userManager
˘˘ 
.
˘˘ 
IsInRoleAsync
˘˘ ,
(
˘˘, -
existingUser
˘˘- 9
,
˘˘9 :
role
˘˘; ?
)
˘˘? @
)
˘˘@ A
{
˙˙ 	
await
˚˚ 
userManager
˚˚ 
.
˚˚ 
AddToRoleAsync
˚˚ ,
(
˚˚, -
existingUser
˚˚- 9
,
˚˚9 :
role
˚˚; ?
)
˚˚? @
;
˚˚@ A
}
¸¸ 	
return
˛˛ 
existingUser
˛˛ 
;
˛˛ 
}
ˇˇ 
private
ÅÅ 
static
ÅÅ 
string
ÅÅ 
RemoveDoctorTitle
ÅÅ +
(
ÅÅ+ ,
string
ÅÅ, 2
fullName
ÅÅ3 ;
)
ÅÅ; <
{
ÇÇ 
return
ÉÉ 
fullName
ÉÉ 
.
ÉÉ 

StartsWith
ÉÉ "
(
ÉÉ" #
$str
ÉÉ# )
,
ÉÉ) *
StringComparison
ÉÉ+ ;
.
ÉÉ; <
OrdinalIgnoreCase
ÉÉ< M
)
ÉÉM N
?
ÑÑ 
fullName
ÑÑ 
[
ÑÑ 
$num
ÑÑ 
..
ÑÑ 
]
ÑÑ 
:
ÖÖ 
fullName
ÖÖ 
;
ÖÖ 
}
ÜÜ 
private
àà 
sealed
àà 
record
àà 
SeedUser
àà "
(
àà" #
string
àà# )
Email
àà* /
,
àà/ 0
string
àà1 7
PhoneNumber
àà8 C
)
ààC D
;
ààD E
private
ää 
sealed
ää 
record
ää 

SeedDoctor
ää $
(
ää$ %
string
ãã 
FullName
ãã 
,
ãã 
string
åå 
Email
åå 
,
åå 
string
çç 
PhoneNumber
çç 
,
çç "
DoctorSpecialisation
éé 
Specialisation
éé +
,
éé+ ,
DateOnly
èè 
PracticeStartDate
èè "
,
èè" #
decimal
êê 
ConsultationFee
êê 
,
êê  
bool
ëë 
IsAvailable
ëë 
)
ëë 
;
ëë 
private
ìì 
sealed
ìì 
record
ìì 
SeedPatient
ìì %
(
ìì% &
string
îî 
FullName
îî 
,
îî 
string
ïï 
Email
ïï 
,
ïï 
string
ññ 
PhoneNumber
ññ 
,
ññ 
DateOnly
óó 
DateOfBirth
óó 
,
óó 
string
òò 
Gender
òò 
,
òò 
string
ôô 
Address
ôô 
)
ôô 
;
ôô 
private
õõ 
sealed
õõ 
record
õõ 
SeedAppointment
õõ )
(
õõ) *
Patient
úú 
Patient
úú 
,
úú 
Doctor
ùù 
Doctor
ùù 
,
ùù 
DateOnly
ûû 
Date
ûû 
,
ûû 
TimeOnly
üü 
Time
üü 
,
üü 
AppointmentStatus
†† 
Status
††  
,
††  !
string
°° 
?
°°  
CancellationReason
°° "
,
°°" #
SeedHealthRecord
¢¢ 
?
¢¢ 
HealthRecord
¢¢ &
)
¢¢& '
;
¢¢' (
private
§§ 
sealed
§§ 
record
§§ 
SeedHealthRecord
§§ *
(
§§* +
DateOnly
•• 
	VisitDate
•• 
,
•• 
string
¶¶ 
	Diagnosis
¶¶ 
,
¶¶ 
string
ßß 
Prescription
ßß 
,
ßß 
string
®® 
?
®® 
Notes
®® 
)
®® 
;
®® 
}©© ≥9
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
}EE ë"
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
$str 
) 
] 
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
._ `
PatientAdmin` l
)l m
]m n
public 

async 
Task 
< 
IActionResult #
># $
GetPatientById% 3
(3 4
int4 7
id8 :
): ;
{ 
if 

( 
User 
. 
IsInRole 
( 
AppRoles "
." #
Patient# *
)* +
&&, .
!/ 0
IsOwnPatientId0 >
(> ?
id? A
)A B
)B C
{ 	
return 
Forbid 
( 
) 
; 
} 	
var 
patient 
= 
await 
patientService *
.* +
GetPatientByIdAsync+ >
(> ?
id? A
)A B
;B C
return 
Ok 
( 
patient 
) 
; 
} 
[ 
HttpPut 
( 
$str 
) 
] 
[ 
	Authorize 
( !
AuthenticationSchemes $
=% &
JwtBearerDefaults' 8
.8 9 
AuthenticationScheme9 M
,M N
RolesO T
=U V
AppRolesW _
._ `
PatientAdmin` l
)l m
]m n
public   

async   
Task   
<   
IActionResult   #
>  # $
UpdatePatient  % 2
(  2 3
int  3 6
id  7 9
,  9 :
UpdatePatientDto  ; K
request  L S
)  S T
{!! 
if"" 

("" 
User"" 
."" 
IsInRole"" 
("" 
AppRoles"" "
.""" #
Patient""# *
)""* +
&&"", .
!""/ 0
IsOwnPatientId""0 >
(""> ?
id""? A
)""A B
)""B C
{## 	
return$$ 
Forbid$$ 
($$ 
)$$ 
;$$ 
}%% 	
var'' 
patient'' 
='' 
await'' 
patientService'' *
.''* +
UpdatePatientAsync''+ =
(''= >
id''> @
,''@ A
request''B I
)''I J
;''J K
return)) 
Ok)) 
()) 
patient)) 
))) 
;)) 
}** 
private,, 
bool,, 
IsOwnPatientId,, 
(,,  
int,,  #
	patientId,,$ -
),,- .
{-- 
var.. 

claimValue.. 
=.. 
User.. 
... 
FindFirstValue.. ,
(.., -
AppClaimTypes..- :
...: ;
	PatientId..; D
)..D E
;..E F
return00 
int00 
.00 
TryParse00 
(00 

claimValue00 &
,00& '
out00( +
var00, /
loggedInPatientId000 A
)00A B
&&00C E
loggedInPatientId11  
==11! #
	patientId11$ -
;11- .
}22 
}33 ö@
]C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\HealthRecordsController.cs
	namespace

 	

HealthAxis


 
.

 
API

 
.

 
Controllers

 $
;

$ %
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
[ 
	Authorize 

(
 !
AuthenticationSchemes  
=! "
JwtBearerDefaults# 4
.4 5 
AuthenticationScheme5 I
,I J
RolesK P
=Q R
AppRolesS [
.[ \
PatientDoctor\ i
)i j
]j k
public 
class #
HealthRecordsController $
($ % 
IHealthRecordService% 9
healthRecordService: M
)M N
:O P
ControllerBaseQ _
{ 
[ 
HttpGet 
( 
$str &
)& '
]' (
public 

async 
Task 
< 
IActionResult #
># $'
GetHealthRecordsByPatientId% @
(@ A
int 
	patientId 
, 
[ 	
	FromQuery	 
] 
PaginationQueryDto &

pagination' 1
)1 2
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
{ 	
if 
( 
! 
IsOwnPatientId 
(  
	patientId  )
)) *
)* +
{ 
return 
Forbid 
( 
) 
;  
} 
var 
patientRecords 
=  
await! &
healthRecordService' :
.: ;,
 GetHealthRecordsByPatientIdAsync; [
([ \
	patientId\ e
,e f

paginationg q
)q r
;r s
return 
Ok 
( 
patientRecords $
)$ %
;% &
} 	
if!! 

(!! 
User!! 
.!! 
IsInRole!! 
(!! 
AppRoles!! "
.!!" #
Doctor!!# )
)!!) *
)!!* +
{"" 	
var## 
doctorId## 
=##  
GetDoctorIdFromToken## /
(##/ 0
)##0 1
;##1 2
if%% 
(%% 
doctorId%% 
==%% 
null%%  
)%%  !
{&& 
return'' 
Forbid'' 
('' 
)'' 
;''  
}(( 
var** 
doctorRecords** 
=** 
await**  %
healthRecordService**& 9
.**9 :5
)GetHealthRecordsForDoctorPatientViewAsync**: c
(**c d
	patientId++ 
,++ 
doctorId,, 
.,, 
Value,, 
,,, 

pagination-- 
)-- 
;-- 
return// 
Ok// 
(// 
doctorRecords// #
)//# $
;//$ %
}00 	
return22 
Forbid22 
(22 
)22 
;22 
}33 
[55 
HttpGet55 
(55 
$str55 
)55 
]55 
public66 

async66 
Task66 
<66 
IActionResult66 #
>66# $
GetHealthRecordById66% 8
(668 9
int669 <
id66= ?
)66? @
{77 
var88 
record88 
=88 
await88 
healthRecordService88 .
.88. /$
GetHealthRecordByIdAsync88/ G
(88G H
id88H J
)88J K
;88K L
if:: 

(:: 
User:: 
.:: 
IsInRole:: 
(:: 
AppRoles:: "
.::" #
Patient::# *
)::* +
&&::, .
!::/ 0
IsOwnPatientId::0 >
(::> ?
record::? E
.::E F
	PatientId::F O
)::O P
)::P Q
{;; 	
return<< 
Forbid<< 
(<< 
)<< 
;<< 
}== 	
if?? 

(?? 
User?? 
.?? 
IsInRole?? 
(?? 
AppRoles?? "
.??" #
Doctor??# )
)??) *
)??* +
{@@ 	
varAA 
doctorIdAA 
=AA  
GetDoctorIdFromTokenAA /
(AA/ 0
)AA0 1
;AA1 2
ifCC 
(CC 
doctorIdCC 
==CC 
nullCC  
||CC! #
doctorIdCC$ ,
.CC, -
ValueCC- 2
!=CC3 5
recordCC6 <
.CC< =
DoctorIdCC= E
)CCE F
{DD 
returnEE 
ForbidEE 
(EE 
)EE 
;EE  
}FF 
}GG 	
returnII 
OkII 
(II 
recordII 
)II 
;II 
}JJ 
[LL 
HttpPostLL 
]LL 
[MM 
	AuthorizeMM 
(MM !
AuthenticationSchemesMM $
=MM% &
JwtBearerDefaultsMM' 8
.MM8 9 
AuthenticationSchemeMM9 M
,MMM N
RolesMMO T
=MMU V
AppRolesMMW _
.MM_ `
DoctorMM` f
)MMf g
]MMg h
publicNN 

asyncNN 
TaskNN 
<NN 
IActionResultNN #
>NN# $
CreateHealthRecordNN% 7
(NN7 8!
CreateHealthRecordDtoNN8 M
requestNNN U
)NNU V
{OO 
varPP 
doctorIdPP 
=PP  
GetDoctorIdFromTokenPP +
(PP+ ,
)PP, -
;PP- .
ifRR 

(RR 
doctorIdRR 
==RR 
nullRR 
)RR 
{SS 	
returnTT 
ForbidTT 
(TT 
)TT 
;TT 
}UU 	
varWW 
recordWW 
=WW 
awaitWW 
healthRecordServiceWW .
.WW. /#
CreateHealthRecordAsyncWW/ F
(WWF G
requestWWG N
,WWN O
doctorIdWWP X
.WWX Y
ValueWWY ^
)WW^ _
;WW_ `
returnYY 
CreatedAtActionYY 
(YY 
nameofYY %
(YY% &
GetHealthRecordByIdYY& 9
)YY9 :
,YY: ;
newYY< ?
{YY@ A
idYYB D
=YYE F
recordYYG M
.YYM N
IdYYN P
}YYQ R
,YYR S
recordYYT Z
)YYZ [
;YY[ \
}ZZ 
private\\ 
bool\\ 
IsOwnPatientId\\ 
(\\  
int\\  #
	patientId\\$ -
)\\- .
{]] 
var^^ 

claimValue^^ 
=^^ 
User^^ 
.^^ 
FindFirstValue^^ ,
(^^, -
AppClaimTypes^^- :
.^^: ;
	PatientId^^; D
)^^D E
;^^E F
return`` 
int`` 
.`` 
TryParse`` 
(`` 

claimValue`` &
,``& '
out``( +
var``, /
loggedInPatientId``0 A
)``A B
&&``C E
loggedInPatientIdaa  
==aa! #
	patientIdaa$ -
;aa- .
}bb 
privatedd 
intdd 
?dd  
GetDoctorIdFromTokendd %
(dd% &
)dd& '
{ee 
varff 

claimValueff 
=ff 
Userff 
.ff 
FindFirstValueff ,
(ff, -
AppClaimTypesff- :
.ff: ;
DoctorIdff; C
)ffC D
;ffD E
returnhh 
inthh 
.hh 
TryParsehh 
(hh 

claimValuehh &
,hh& '
outhh( +
varhh, /
doctorIdhh0 8
)hh8 9
?ii 
doctorIdii 
:jj 
nulljj 
;jj 
}kk 
}ll ƒ3
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
[ 	
	FromQuery	 
]  
DoctorSpecialisation (
?( )
specialisation* 8
,8 9
[ 	
	FromQuery	 
] 
PaginationQueryDto &

pagination' 1
)1 2
{ 
var 
doctors 
= 
await 
doctorService )
.) *
GetAllDoctorsAsync* <
(< =

pagination= G
,G H
specialisationI W
)W X
;X Y
return 
Ok 
( 
doctors 
) 
; 
} 
[ 
HttpGet 
( 
$str 
) 
] 
[ 
AllowAnonymous 
] 
public   

async   
Task   
<   
IActionResult   #
>  # $
GetDoctorById  % 2
(  2 3
int  3 6
id  7 9
)  9 :
{!! 
var"" 
doctor"" 
="" 
await"" 
doctorService"" (
.""( )
GetDoctorByIdAsync"") ;
(""; <
id""< >
)""> ?
;""? @
if$$ 

($$ 
doctor$$ 
==$$ 
null$$ 
)$$ 
{%% 	
throw&& 
new&& 
NotFoundException&& '
(&&' (
ErrorMessages&&( 5
.&&5 6
DoctorNotFound&&6 D
)&&D E
;&&E F
}'' 	
return)) 
Ok)) 
()) 
doctor)) 
))) 
;)) 
}** 
[,, 
HttpGet,, 
(,, 
$str,, $
),,$ %
],,% &
[-- 
AllowAnonymous-- 
]-- 
public.. 

async.. 
Task.. 
<.. 
IActionResult.. #
>..# $
GetAvailability..% 4
(..4 5
int..5 8
id..9 ;
)..; <
{// 
var00 
availability00 
=00 
await00  
doctorService00! .
.00. / 
GetAvailabilityAsync00/ C
(00C D
id00D F
)00F G
;00G H
if22 

(22 
availability22 
==22 
null22  
)22  !
{33 	
throw44 
new44 
NotFoundException44 '
(44' (
ErrorMessages44( 5
.445 6
DoctorNotFound446 D
)44D E
;44E F
}55 	
return77 
Ok77 
(77 
availability77 
)77 
;77  
}88 
[:: 
HttpPut:: 
(:: 
$str:: $
)::$ %
]::% &
[;; 
	Authorize;; 
(;; !
AuthenticationSchemes;; $
=;;% &
JwtBearerDefaults;;' 8
.;;8 9 
AuthenticationScheme;;9 M
,;;M N
Roles;;O T
=;;U V
AppRoles;;W _
.;;_ `
DoctorAdmin;;` k
);;k l
];;l m
public<< 

async<< 
Task<< 
<<< 
IActionResult<< #
><<# $
UpdateAvailability<<% 7
(<<7 8
int<<8 ;
id<<< >
,<<> ?'
UpdateDoctorAvailabilityDto<<@ [
request<<\ c
)<<c d
{== 
var>> 
currentRole>> 
=>> 
GetCurrentRole>> (
(>>( )
)>>) *
;>>* +
if@@ 

(@@ 
currentRole@@ 
==@@ 
null@@ 
)@@  
{AA 	
returnBB 
ForbidBB 
(BB 
)BB 
;BB 
}CC 	
varEE 
availabilityEE 
=EE 
awaitEE  
doctorServiceEE! .
.EE. /#
UpdateAvailabilityAsyncEE/ F
(EEF G
idFF 
,FF 
requestGG 
,GG 
currentRoleHH 
,HH  
GetDoctorIdFromTokenII  
(II  !
)II! "
)II" #
;II# $
returnKK 
OkKK 
(KK 
availabilityKK 
)KK 
;KK  
}LL 
privateNN 
stringNN 
?NN 
GetCurrentRoleNN "
(NN" #
)NN# $
{OO 
ifPP 

(PP 
UserPP 
.PP 
IsInRolePP 
(PP 
AppRolesPP "
.PP" #
AdminPP# (
)PP( )
)PP) *
{QQ 	
returnRR 
AppRolesRR 
.RR 
AdminRR !
;RR! "
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
{VV 	
returnWW 
AppRolesWW 
.WW 
DoctorWW "
;WW" #
}XX 	
returnZZ 
nullZZ 
;ZZ 
}[[ 
private]] 
int]] 
?]]  
GetDoctorIdFromToken]] %
(]]% &
)]]& '
{^^ 
var__ 

claimValue__ 
=__ 
User__ 
.__ 
FindFirstValue__ ,
(__, -
AppClaimTypes__- :
.__: ;
DoctorId__; C
)__C D
;__D E
returnaa 
intaa 
.aa 
TryParseaa 
(aa 

claimValueaa &
,aa& '
outaa( +
varaa, /
doctorIdaa0 8
)aa8 9
?bb 
doctorIdbb 
:cc 
nullcc 
;cc 
}dd 
}ee ∂/
TC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\AuthController.cs
	namespace

 	

HealthAxis


 
.

 
API

 
.

 
Controllers

 $
;

$ %
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public 
class 
AuthController 
( 
IAuthService 
authService 
, 
UserManager 
< 
IdentityUser 
> 
userManager )
)) *
:+ ,
ControllerBase- ;
{ 
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $
Register% -
(- .
RegisterDto. 9
request: A
)A B
{ 
var 
result 
= 
await 
authService &
.& '
RegisterAsync' 4
(4 5
request5 <
)< =
;= >
if 

( 
! 
result 
. 
Success 
) 
{ 	
return 

BadRequest 
( 
new !
{" #
message$ +
=, -
result. 4
.4 5
Message5 <
}= >
)> ?
;? @
} 	
return 
Created 
( 
string 
. 
Empty #
,# $
new% (
{ 	
message 
= 
result 
. 
Message $
,$ %
userId 
= 
result 
. 
UserId "
}   	
)  	 

;  
 
}!! 
[## 
HttpPost## 
(## 
$str## 
)## 
]## 
public$$ 

async$$ 
Task$$ 
<$$ 
IActionResult$$ #
>$$# $
Login$$% *
($$* +
LoginDto$$+ 3
request$$4 ;
)$$; <
{%% 
var&& 
result&& 
=&& 
await&& 
authService&& &
.&&& '

LoginAsync&&' 1
(&&1 2
request&&2 9
)&&9 :
;&&: ;
if(( 

((( 
!(( 
result(( 
.(( 
Success(( 
||(( 
result(( %
.((% &
Response((& .
==((/ 1
null((2 6
)((6 7
{)) 	
return** 
Unauthorized** 
(**  
new**  #
{**$ %
message**& -
=**. /
ErrorMessages**0 =
.**= >
InvalidCredentials**> P
}**Q R
)**R S
;**S T
}++ 	
return-- 
Ok-- 
(-- 
result-- 
.-- 
Response-- !
)--! "
;--" #
}.. 
[@@ 
HttpPut@@ 
(@@ 
$str@@ 
)@@ 
]@@  
[AA 
	AuthorizeAA 
(AA !
AuthenticationSchemesAA $
=AA% &
JwtBearerDefaultsAA' 8
.AA8 9 
AuthenticationSchemeAA9 M
)AAM N
]AAN O
publicBB 

asyncBB 
TaskBB 
<BB 
IActionResultBB #
>BB# $
ChangePasswordBB% 3
(BB3 4
ChangePasswordDtoBB4 E
requestBBF M
)BBM N
{CC 
varDD 
userIdDD 
=DD 
UserDD 
.DD 
FindFirstValueDD (
(DD( )

ClaimTypesDD) 3
.DD3 4
NameIdentifierDD4 B
)DDB C
;DDC D
ifFF 

(FF 
stringFF 
.FF 
IsNullOrWhiteSpaceFF %
(FF% &
userIdFF& ,
)FF, -
)FF- .
{GG 	
returnHH 
ForbidHH 
(HH 
)HH 
;HH 
}II 	
varKK 
userKK 
=KK 
awaitKK 
userManagerKK $
.KK$ %
FindByIdAsyncKK% 2
(KK2 3
userIdKK3 9
)KK9 :
;KK: ;
ifMM 

(MM 
userMM 
==MM 
nullMM 
)MM 
{NN 	
returnOO 
NotFoundOO 
(OO 
newOO 
{OO  !
messageOO" )
=OO* +
$strOO, E
}OOF G
)OOG H
;OOH I
}PP 	
varRR 
resultRR 
=RR 
awaitRR 
userManagerRR &
.RR& '
ChangePasswordAsyncRR' :
(RR: ;
userSS 
,SS 
requestTT 
.TT 
CurrentPasswordTT #
,TT# $
requestUU 
.UU 
NewPasswordUU 
)UU  
;UU  !
ifWW 

(WW 
!WW 
resultWW 
.WW 
	SucceededWW 
)WW 
{XX 	
varYY 
errorsYY 
=YY 
stringYY 
.YY  
JoinYY  $
(YY$ %
$strYY% (
,YY( )
resultYY* 0
.YY0 1
ErrorsYY1 7
.YY7 8
SelectYY8 >
(YY> ?
errorYY? D
=>YYE G
errorYYH M
.YYM N
DescriptionYYN Y
)YYY Z
)YYZ [
;YY[ \
returnZZ 

BadRequestZZ 
(ZZ 
newZZ !
{ZZ" #
messageZZ$ +
=ZZ, -
errorsZZ. 4
}ZZ5 6
)ZZ6 7
;ZZ7 8
}[[ 	
return]] 
Ok]] 
(]] 
new]] 
{]] 
message]] 
=]]  !
$str]]" B
}]]C D
)]]D E
;]]E F
}^^ 
}__ Èb
\C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\AppointmentsController.cs
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
$str 
) 
] 
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
.[ \
PatientDoctorAdmin\ n
)n o
]o p
public 
class "
AppointmentsController #
(# $
IAppointmentService$ 7
appointmentService8 J
)J K
:L M
ControllerBaseN \
{ 
[ 
HttpGet 
] 
public 

async 
Task 
< 
IActionResult #
># $
GetAppointments% 4
(4 5
[ 	
	FromQuery	 
] 
DateOnly 
? 
date "
," #
[ 	
	FromQuery	 
] 
PaginationQueryDto &

pagination' 1
)1 2
{ 
if 

( 
User 
. 
IsInRole 
( 
AppRoles "
." #
Admin# (
)( )
)) *
{ 	
var 
appointments 
= 
await $
appointmentService% 7
.7 8#
GetAllAppointmentsAsync8 O
(O P

paginationP Z
)Z [
;[ \
return 
Ok 
( 
appointments "
)" #
;# $
} 	
if 

( 
User 
. 
IsInRole 
( 
AppRoles "
." #
Patient# *
)* +
)+ ,
{ 	
var 
	patientId 
= !
GetPatientIdFromToken 1
(1 2
)2 3
;3 4
if!! 
(!! 
	patientId!! 
==!! 
null!! !
)!!! "
{"" 
return## 
Forbid## 
(## 
)## 
;##  
}$$ 
var&& 
appointments&& 
=&& 
await&& $
appointmentService&&% 7
.&&7 8+
GetAppointmentsByPatientIdAsync&&8 W
(&&W X
	patientId&&X a
.&&a b
Value&&b g
,&&g h
null&&i m
,&&m n

pagination&&o y
)&&y z
;&&z {
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
=,,  
GetDoctorIdFromToken,, /
(,,/ 0
),,0 1
;,,1 2
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
(== 
$str== 
)== 
]== 
public>> 

async>> 
Task>> 
<>> 
IActionResult>> #
>>># $
GetAppointmentById>>% 7
(>>7 8
int>>8 ;
id>>< >
)>>> ?
{?? 
var@@ 
appointment@@ 
=@@ 
await@@ 
appointmentService@@  2
.@@2 3#
GetAppointmentByIdAsync@@3 J
(@@J K
id@@K M
)@@M N
;@@N O
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
&&BB, .!
GetPatientIdFromTokenBB/ D
(BBD E
)BBE F
!=BBG I
appointmentBBJ U
.BBU V
	PatientIdBBV _
)BB_ `
{CC 	
returnDD 
ForbidDD 
(DD 
)DD 
;DD 
}EE 	
ifGG 

(GG 
UserGG 
.GG 
IsInRoleGG 
(GG 
AppRolesGG "
.GG" #
DoctorGG# )
)GG) *
&&GG+ - 
GetDoctorIdFromTokenGG. B
(GGB C
)GGC D
!=GGE G
appointmentGGH S
.GGS T
DoctorIdGGT \
)GG\ ]
{HH 	
returnII 
ForbidII 
(II 
)II 
;II 
}JJ 	
returnLL 
OkLL 
(LL 
appointmentLL 
)LL 
;LL 
}MM 
[OO 
HttpPostOO 
]OO 
[PP 
	AuthorizePP 
(PP !
AuthenticationSchemesPP $
=PP% &
JwtBearerDefaultsPP' 8
.PP8 9 
AuthenticationSchemePP9 M
,PPM N
RolesPPO T
=PPU V
AppRolesPPW _
.PP_ `
PatientAdminPP` l
)PPl m
]PPm n
publicQQ 

asyncQQ 
TaskQQ 
<QQ 
IActionResultQQ #
>QQ# $
CreateAppointmentQQ% 6
(QQ6 7 
CreateAppointmentDtoQQ7 K
requestQQL S
)QQS T
{RR 
ifSS 

(SS 
UserSS 
.SS 
IsInRoleSS 
(SS 
AppRolesSS "
.SS" #
PatientSS# *
)SS* +
)SS+ ,
{TT 	
varUU 
	patientIdUU 
=UU !
GetPatientIdFromTokenUU 1
(UU1 2
)UU2 3
;UU3 4
ifWW 
(WW 
	patientIdWW 
==WW 
nullWW !
||WW" $
	patientIdWW% .
.WW. /
ValueWW/ 4
!=WW5 7
requestWW8 ?
.WW? @
	PatientIdWW@ I
)WWI J
{XX 
returnYY 
ForbidYY 
(YY 
)YY 
;YY  
}ZZ 
}[[ 	
var]] 
appointment]] 
=]] 
await]] 
appointmentService]]  2
.]]2 3"
CreateAppointmentAsync]]3 I
(]]I J
request]]J Q
)]]Q R
;]]R S
return__ 
appointment__ 
==__ 
null__ "
?`` 
throw`` 
new`` %
InvalidOperationException`` 1
(``1 2
ErrorMessages``2 ?
.``? @%
UnableToCreateAppointment``@ Y
)``Y Z
:aa 
CreatedAtActionaa 
(aa 
nameofaa $
(aa$ %
GetAppointmentByIdaa% 7
)aa7 8
,aa8 9
newaa: =
{aa> ?
idaa@ B
=aaC D
appointmentaaE P
.aaP Q
IdaaQ S
}aaT U
,aaU V
appointmentaaW b
)aab c
;aac d
}bb 
[dd 
HttpPutdd 
(dd 
$strdd 
)dd 
]dd  
[ee 
	Authorizeee 
(ee !
AuthenticationSchemesee $
=ee% &
JwtBearerDefaultsee' 8
.ee8 9 
AuthenticationSchemeee9 M
,eeM N
RoleseeO T
=eeU V
AppRoleseeW _
.ee_ `
PatientDoctorAdminee` r
)eer s
]ees t
publicff 

asyncff 
Taskff 
<ff 
IActionResultff #
>ff# $#
UpdateAppointmentStatusff% <
(ff< =
intff= @
idffA C
,ffC D&
UpdateAppointmentStatusDtoffE _
requestff` g
)ffg h
{gg 
varhh 
currentRolehh 
=hh 
GetCurrentRolehh (
(hh( )
)hh) *
;hh* +
ifjj 

(jj 
currentRolejj 
==jj 
nulljj 
)jj  
{kk 	
returnll 
Forbidll 
(ll 
)ll 
;ll 
}mm 	
varoo 
appointmentoo 
=oo 
awaitoo 
appointmentServiceoo  2
.oo2 3(
UpdateAppointmentStatusAsyncoo3 O
(ooO P
idpp 
,pp 
requestqq 
,qq 
currentRolerr 
,rr !
GetPatientIdFromTokenss !
(ss! "
)ss" #
,ss# $ 
GetDoctorIdFromTokentt  
(tt  !
)tt! "
)tt" #
;tt# $
returnvv 
Okvv 
(vv 
appointmentvv 
)vv 
;vv 
}ww 
privateyy 
stringyy 
?yy 
GetCurrentRoleyy "
(yy" #
)yy# $
{zz 
if{{ 

({{ 
User{{ 
.{{ 
IsInRole{{ 
({{ 
AppRoles{{ "
.{{" #
Admin{{# (
){{( )
){{) *
{|| 	
return}} 
AppRoles}} 
.}} 
Admin}} !
;}}! "
}~~ 	
if
ÄÄ 

(
ÄÄ 
User
ÄÄ 
.
ÄÄ 
IsInRole
ÄÄ 
(
ÄÄ 
AppRoles
ÄÄ "
.
ÄÄ" #
Doctor
ÄÄ# )
)
ÄÄ) *
)
ÄÄ* +
{
ÅÅ 	
return
ÇÇ 
AppRoles
ÇÇ 
.
ÇÇ 
Doctor
ÇÇ "
;
ÇÇ" #
}
ÉÉ 	
if
ÖÖ 

(
ÖÖ 
User
ÖÖ 
.
ÖÖ 
IsInRole
ÖÖ 
(
ÖÖ 
AppRoles
ÖÖ "
.
ÖÖ" #
Patient
ÖÖ# *
)
ÖÖ* +
)
ÖÖ+ ,
{
ÜÜ 	
return
áá 
AppRoles
áá 
.
áá 
Patient
áá #
;
áá# $
}
àà 	
return
ää 
null
ää 
;
ää 
}
ãã 
private
çç 
int
çç 
?
çç #
GetPatientIdFromToken
çç &
(
çç& '
)
çç' (
{
éé 
var
èè 

claimValue
èè 
=
èè 
User
èè 
.
èè 
FindFirstValue
èè ,
(
èè, -
AppClaimTypes
èè- :
.
èè: ;
	PatientId
èè; D
)
èèD E
;
èèE F
return
ëë 
int
ëë 
.
ëë 
TryParse
ëë 
(
ëë 

claimValue
ëë &
,
ëë& '
out
ëë( +
var
ëë, /
	patientId
ëë0 9
)
ëë9 :
?
íí 
	patientId
íí 
:
ìì 
null
ìì 
;
ìì 
}
îî 
private
ññ 
int
ññ 
?
ññ "
GetDoctorIdFromToken
ññ %
(
ññ% &
)
ññ& '
{
óó 
var
òò 

claimValue
òò 
=
òò 
User
òò 
.
òò 
FindFirstValue
òò ,
(
òò, -
AppClaimTypes
òò- :
.
òò: ;
DoctorId
òò; C
)
òòC D
;
òòD E
return
öö 
int
öö 
.
öö 
TryParse
öö 
(
öö 

claimValue
öö &
,
öö& '
out
öö( +
var
öö, /
doctorId
öö0 8
)
öö8 9
?
õõ 
doctorId
õõ 
:
úú 
null
úú 
;
úú 
}
ùù 
}ûû µY
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
}áá ∂<
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
$str	##O “
;
##“ ”
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
;	'' Ä
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
*AppointmentMustBeBookedAtLeast24HoursAhead// B
=//C D
$str	//E è
;
//è ê
public11 

const11 
string11 #
DoctorSlotAlreadyBooked11 /
=110 1
$str112 t
;11t u
public33 

const33 
string33 $
PatientSlotAlreadyBooked33 0
=331 2
$str333 v
;33v w
public55 

const55 
string55 8
,PatientAlreadyHasAppointmentWithDoctorOnDate55 D
=55E F
$str	55G í
;
55í ì
public77 

const77 
string77 1
%OnlyPendingAppointmentsCanBeConfirmed77 =
=77> ?
$str77@ m
;77m n
public99 

const99 
string99 /
#DoctorsCanManageOnlyOwnAppointments99 ;
=99< =
$str99> o
;99o p
public;; 

const;; 
string;; 0
$PatientsCanManageOnlyOwnAppointments;; <
=;;= >
$str;;? q
;;;q r
public== 

const== 
string== &
CancellationReasonRequired== 2
===3 4
$str==5 W
;==W X
public?? 

const?? 
string?? 2
&CompletedAppointmentsCannotBeCancelled?? >
=??? @
$str??A n
;??n o
publicAA 

constAA 
stringAA 7
+CancelledAppointmentsCannotBeCancelledAgainAA C
=AAD E
$strAAF y
;AAy z
publicCC 

constCC 
stringCC 5
)AppointmentCannotBeCancelledWithin24HoursCC A
=CCB C
$str	CCD å
;
CCå ç
publicEE 

constEE 
stringEE 7
+AppointmentCompletedOnlyThroughHealthRecordEE C
=EED E
$str	EEF á
;
EEá à
publicGG 

constGG 
stringGG 2
&UnsupportedAppointmentStatusTransitionGG >
=GG? @
$strGGA m
;GGm n
publicII 

constII 
stringII 1
%PendingAppointmentAutoCancelledReasonII =
=II> ?
$str	II@ ∞
;
II∞ ±
publicKK 

constKK 
stringKK $
CancelledByPatientSuffixKK 0
=KK1 2
$strKK3 L
;KKL M
publicMM 

constMM 
stringMM #
CancelledByDoctorSuffixMM /
=MM0 1
$strMM2 J
;MMJ K
publicOO 

constOO 
stringOO "
CancelledByAdminSuffixOO .
=OO/ 0
$strOO1 H
;OOH I
publicQQ 

constQQ 
stringQQ ?
3AppointmentCannotBeDeletedBecauseHealthRecordExistsQQ K
=QQL M
$str	QQN ¢
;
QQ¢ £
publicSS 

constSS 
stringSS  
HealthRecordNotFoundSS ,
=SS- .
$strSS/ I
;SSI J
publicUU 

constUU 
stringUU -
!HealthRecordNotFoundAfterCreationUU 9
=UU: ;
$strUU< e
;UUe f
publicWW 

constWW 
stringWW <
0DoctorCanCreateHealthRecordOnlyForOwnAppointmentWW H
=WWI J
$str	WWK é
;
WWé è
publicYY 

constYY 
stringYY 3
'OnlyConfirmedAppointmentsCanBeCompletedYY ?
=YY@ A
$strYYB q
;YYq r
public[[ 

const[[ 
string[[ 9
-HealthRecordCanBeCreatedOnlyOnAppointmentDate[[ E
=[[F G
$str	[[H Ö
;
[[Ö Ü
public]] 

const]] 
string]] -
!VisitDateMustMatchAppointmentDate]] 9
=]]: ;
$str]]< i
;]]i j
public__ 

const__ 
string__ 3
'HealthRecordAlreadyExistsForAppointment__ ?
=__@ A
$str__B x
;__x y
publicaa 

constaa 
stringaa  
UnableToCreateDoctoraa ,
=aa- .
$straa/ I
;aaI J
publiccc 

constcc 
stringcc %
UnableToCreateAppointmentcc 1
=cc2 3
$strcc4 S
;ccS T
publicee 

constee 
stringee &
UnableToCreateHealthRecordee 2
=ee3 4
$stree5 V
;eeV W
}ff 