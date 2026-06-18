÷
_C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Validation\PracticeStartDateAttribute.cs
	namespace 	

HealthAxis
 
. 
API 
. 

Validation #
;# $
[ 
AttributeUsage 
( 
AttributeTargets  
.  !
Property! )
,) *
AllowMultiple+ 8
=9 :
false; @
)@ A
]A B
public 
class &
PracticeStartDateAttribute '
:( )
ValidationAttribute* =
{ 
private 
readonly 
int 
_maxYearsInPast (
;( )
public

 
&
PracticeStartDateAttribute

 %
(

% &
int

& )
maxYearsInPast

* 8
=

9 :
$num

; =
)

= >
{ 
_maxYearsInPast 
= 
maxYearsInPast (
;( )
} 
	protected 
override 
ValidationResult '
?' (
IsValid) 0
(0 1
object1 7
?7 8
value9 >
,> ?
ValidationContext@ Q
validationContextR c
)c d
{ 
if 

( 
value 
== 
null 
) 
{ 	
return 
ValidationResult #
.# $
Success$ +
;+ ,
} 	
if 

( 
value 
is 
not 
DateOnly !
practiceStartDate" 3
)3 4
{ 	
return 
new 
ValidationResult '
(' (
$str( S
)S T
;T U
} 	
var 
today 
= 
DateOnly 
. 
FromDateTime )
() *
DateTime* 2
.2 3
Today3 8
)8 9
;9 :
var 
earliestAllowedDate 
=  !
today" '
.' (
AddYears( 0
(0 1
-1 2
_maxYearsInPast2 A
)A B
;B C
if 

( 
practiceStartDate 
> 
today  %
)% &
{ 	
return   
new   
ValidationResult   '
(  ' (
$str  ( V
)  V W
;  W X
}!! 	
if## 

(## 
practiceStartDate## 
<## 
earliestAllowedDate##  3
)##3 4
{$$ 	
return%% 
new%% 
ValidationResult%% '
(%%' (
$"%%( *
$str%%* R
{%%R S
_maxYearsInPast%%S b
}%%b c
$str%%c v
"%%v w
)%%w x
;%%x y
}&& 	
return(( 
ValidationResult(( 
.((  
Success((  '
;((' (
})) 
}** íM
VC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\PatientService.cs
	namespace		 	

HealthAxis		
 
.		 
API		 
.		 
Services		 !
.		! "
Impl		" &
;		& '
public 
class 
PatientService 
( 
IPatientRepository 
patientRepository (
,( )#
IHealthRecordRepository "
healthRecordRepository 2
,2 3
UserManager 
< 
IdentityUser 
> 
userManager )
,) *
IMapper 
mapper 
) 
: 
IPatientService %
{ 
public 

async 
Task 
< 

PatientDto  
>  !
GetPatientByIdAsync" 5
(5 6
int6 9
id: <
)< =
{ 
var 
patient 
= 
await 
patientRepository -
.- .'
GetPatientByIdWithUserAsync. I
(I J
idJ L
)L M
;M N
if 

( 
patient 
== 
null 
) 
{ 	
throw 
new 
NotFoundException '
(' (
ErrorMessages( 5
.5 6
PatientNotFound6 E
)E F
;F G
} 	
return 
mapper 
. 
Map 
< 

PatientDto $
>$ %
(% &
patient& -
)- .
;. /
} 
public 

async 
Task 
< 

PatientDto  
>  !#
GetPatientByUserIdAsync" 9
(9 :
string: @
userIdA G
)G H
{ 
var 
patient 
= 
await 
patientRepository -
.- .#
GetPatientByUserIdAsync. E
(E F
userIdF L
)L M
;M N
if!! 

(!! 
patient!! 
==!! 
null!! 
)!! 
{"" 	
throw## 
new## 
NotFoundException## '
(##' (
ErrorMessages##( 5
.##5 6
PatientNotFound##6 E
)##E F
;##F G
}$$ 	
var&& 
patientWithUser&& 
=&& 
await&& #
patientRepository&&$ 5
.&&5 6'
GetPatientByIdWithUserAsync&&6 Q
(&&Q R
patient&&R Y
.&&Y Z
Id&&Z \
)&&\ ]
;&&] ^
if(( 

((( 
patientWithUser(( 
==(( 
null(( #
)((# $
{)) 	
throw** 
new** 
NotFoundException** '
(**' (
ErrorMessages**( 5
.**5 6
PatientNotFound**6 E
)**E F
;**F G
}++ 	
return-- 
mapper-- 
.-- 
Map-- 
<-- 

PatientDto-- $
>--$ %
(--% &
patientWithUser--& 5
)--5 6
;--6 7
}.. 
public00 

async00 
Task00 
<00 

PatientDto00  
>00  !
UpdatePatientAsync00" 4
(004 5
int005 8
id009 ;
,00; <
UpdatePatientDto00= M
dto00N Q
)00Q R
{11 
var22 
patient22 
=22 
await22 
patientRepository22 -
.22- .'
GetPatientByIdWithUserAsync22. I
(22I J
id22J L
)22L M
;22M N
if44 

(44 
patient44 
==44 
null44 
)44 
{55 	
throw66 
new66 
NotFoundException66 '
(66' (
ErrorMessages66( 5
.665 6
PatientNotFound666 E
)66E F
;66F G
}77 	
if99 

(99 
patient99 
.99 
User99 
==99 
null99  
)99  !
{:: 	
throw;; 
new;; 
NotFoundException;; '
(;;' (
ErrorMessages;;( 5
.;;5 6"
PatientAccountNotFound;;6 L
);;L M
;;;M N
}<< 	
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
.BB 
PhoneNumberBB  
=BB! "
dtoBB# &
.BB& '
PhoneNumberBB' 2
;BB2 3
varDD 
updateUserResultDD 
=DD 
awaitDD $
userManagerDD% 0
.DD0 1
UpdateAsyncDD1 <
(DD< =
patientDD= D
.DDD E
UserDDE I
)DDI J
;DDJ K
ifFF 

(FF 
!FF 
updateUserResultFF 
.FF 
	SucceededFF '
)FF' (
{GG 	
varHH 
errorsHH 
=HH 
stringHH 
.HH  
JoinHH  $
(HH$ %
$strHH% (
,HH( )
updateUserResultHH* :
.HH: ;
ErrorsHH; A
.HHA B
SelectHHB H
(HHH I
errorHHI N
=>HHO Q
errorHHR W
.HHW X
DescriptionHHX c
)HHc d
)HHd e
;HHe f
throwII 
newII 
BadRequestExceptionII )
(II) *
errorsII* 0
)II0 1
;II1 2
}JJ 	
awaitLL 
patientRepositoryLL 
.LL  
UpdateAsyncLL  +
(LL+ ,
patientLL, 3
)LL3 4
;LL4 5
varNN 
updatedPatientNN 
=NN 
awaitNN "
patientRepositoryNN# 4
.NN4 5'
GetPatientByIdWithUserAsyncNN5 P
(NNP Q
idNNQ S
)NNS T
;NNT U
ifPP 

(PP 
updatedPatientPP 
==PP 
nullPP "
)PP" #
{QQ 	
throwRR 
newRR 
NotFoundExceptionRR '
(RR' (
ErrorMessagesRR( 5
.RR5 6
PatientNotFoundRR6 E
)RRE F
;RRF G
}SS 	
returnUU 
mapperUU 
.UU 
MapUU 
<UU 

PatientDtoUU $
>UU$ %
(UU% &
updatedPatientUU& 4
)UU4 5
;UU5 6
}VV 
publicXX 

asyncXX 
TaskXX 
<XX 
PagedResultDtoXX $
<XX$ %
HealthRecordDtoXX% 4
>XX4 5
>XX5 6(
GetPatientHealthRecordsAsyncXX7 S
(XXS T
intYY 
	patientIdYY 
,YY 
PaginationQueryDtoZZ 

paginationZZ %
)ZZ% &
{[[ 
var\\ 
patient\\ 
=\\ 
await\\ 
patientRepository\\ -
.\\- .
GetByIdAsync\\. :
(\\: ;
	patientId\\; D
)\\D E
;\\E F
if^^ 

(^^ 
patient^^ 
==^^ 
null^^ 
)^^ 
{__ 	
throw`` 
new`` 
NotFoundException`` '
(``' (
ErrorMessages``( 5
.``5 6
PatientNotFound``6 E
)``E F
;``F G
}aa 	
varcc 
recordscc 
=cc 
awaitcc "
healthRecordRepositorycc 2
.cc2 3,
 GetHealthRecordsByPatientIdAsynccc3 S
(ccS T
	patientIddd 
,dd 

paginationee 
.ee 

PageNumberee !
,ee! "

paginationff 
.ff 
PageSizeff 
)ff  
;ff  !
returnhh 
MapPagedResulthh 
<hh 
HealthRecordhh *
,hh* +
HealthRecordDtohh, ;
>hh; <
(hh< =
recordshh= D
)hhD E
;hhE F
}ii 
privatekk 
PagedResultDtokk 
<kk 
TDestinationkk '
>kk' (
MapPagedResultkk) 7
<kk7 8
TSourcekk8 ?
,kk? @
TDestinationkkA M
>kkM N
(kkN O
PagedResultkkO Z
<kkZ [
TSourcekk[ b
>kkb c
pagedResultkkd o
)kko p
{ll 
returnmm 
newmm 
PagedResultDtomm !
<mm! "
TDestinationmm" .
>mm. /
{nn 	
Itemsoo 
=oo 
mapperoo 
.oo 
Mapoo 
<oo 
Listoo #
<oo# $
TDestinationoo$ 0
>oo0 1
>oo1 2
(oo2 3
pagedResultoo3 >
.oo> ?
Itemsoo? D
)ooD E
,ooE F

PageNumberpp 
=pp 
pagedResultpp $
.pp$ %

PageNumberpp% /
,pp/ 0
PageSizeqq 
=qq 
pagedResultqq "
.qq" #
PageSizeqq# +
,qq+ ,

TotalCountrr 
=rr 
pagedResultrr $
.rr$ %

TotalCountrr% /
,rr/ 0

TotalPagesss 
=ss 
pagedResultss $
.ss$ %

TotalPagesss% /
}tt 	
;tt	 

}uu 
}vv Ô	
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
;E F
Task 
< 	
PagedResultDto	 
< 
HealthRecordDto '
>' (
>( )(
GetPatientHealthRecordsAsync* F
(F G
int 
	patientId 
, 
PaginationQueryDto 

pagination %
)% &
;& '
} àX
[C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\HealthRecordService.cs
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
class 
HealthRecordService  
(  !
HealthAxisDbContext 
context 
,  #
IHealthRecordRepository "
healthRecordRepository 2
,2 3"
IAppointmentRepository !
appointmentRepository 0
,0 1
IMapper 
mapper 
) 
:  
IHealthRecordService *
{ 
public 

async 
Task 
< 
PagedResultDto $
<$ %
HealthRecordDto% 4
>4 5
>5 6,
 GetHealthRecordsByPatientIdAsync7 W
(W X
int 
	patientId 
, 
PaginationQueryDto 

pagination %
)% &
{ 
var 
records 
= 
await "
healthRecordRepository 2
.2 3,
 GetHealthRecordsByPatientIdAsync3 S
(S T
	patientId 
, 

pagination 
. 

PageNumber !
,! "

pagination 
. 
PageSize 
)  
;  !
return 
MapPagedResult 
< 
HealthRecord *
,* +
HealthRecordDto, ;
>; <
(< =
records= D
)D E
;E F
} 
public 

async 
Task 
< 
PagedResultDto $
<$ %
HealthRecordDto% 4
>4 5
>5 67
+GetHealthRecordsByPatientIdAndDoctorIdAsync7 b
(b c
int 
	patientId 
, 
int   
doctorId   
,   
PaginationQueryDto!! 

pagination!! %
)!!% &
{"" 
var## 
records## 
=## 
await## "
healthRecordRepository## 2
.##2 37
+GetHealthRecordsByPatientIdAndDoctorIdAsync##3 ^
(##^ _
	patientId$$ 
,$$ 
doctorId%% 
,%% 

pagination&& 
.&& 

PageNumber&& !
,&&! "

pagination'' 
.'' 
PageSize'' 
)''  
;''  !
return)) 
MapPagedResult)) 
<)) 
HealthRecord)) *
,))* +
HealthRecordDto)), ;
>)); <
())< =
records))= D
)))D E
;))E F
}** 
public,, 

async,, 
Task,, 
<,, 
HealthRecordDto,, %
>,,% &$
GetHealthRecordByIdAsync,,' ?
(,,? @
int,,@ C
id,,D F
),,F G
{-- 
var.. 
record.. 
=.. 
await.. "
healthRecordRepository.. 1
...1 2/
#GetHealthRecordByIdWithDetailsAsync..2 U
(..U V
id..V X
)..X Y
;..Y Z
if00 

(00 
record00 
==00 
null00 
)00 
{11 	
throw22 
new22 
NotFoundException22 '
(22' (
ErrorMessages22( 5
.225 6 
HealthRecordNotFound226 J
)22J K
;22K L
}33 	
return55 
mapper55 
.55 
Map55 
<55 
HealthRecordDto55 )
>55) *
(55* +
record55+ 1
)551 2
;552 3
}66 
public88 

async88 
Task88 
<88 
HealthRecordDto88 %
>88% &#
CreateHealthRecordAsync88' >
(88> ?!
CreateHealthRecordDto88? T
dto88U X
,88X Y
int88Z ]
doctorId88^ f
)88f g
{99 
var:: 
appointment:: 
=:: 
await:: !
appointmentRepository::  5
.::5 6.
"GetAppointmentByIdWithDetailsAsync::6 X
(::X Y
dto::Y \
.::\ ]
AppointmentId::] j
)::j k
;::k l
if<< 

(<< 
appointment<< 
==<< 
null<< 
)<<  
{== 	
throw>> 
new>> 
NotFoundException>> '
(>>' (
ErrorMessages>>( 5
.>>5 6
AppointmentNotFound>>6 I
)>>I J
;>>J K
}?? 	
ifAA 

(AA 
appointmentAA 
.AA 
DoctorIdAA  
!=AA! #
doctorIdAA$ ,
)AA, -
{BB 	
throwCC 
newCC 
ForbiddenExceptionCC (
(CC( )
ErrorMessagesCC) 6
.CC6 7<
0DoctorCanCreateHealthRecordOnlyForOwnAppointmentCC7 g
)CCg h
;CCh i
}DD 	
ifFF 

(FF 
appointmentFF 
.FF 
StatusFF 
!=FF !
AppointmentStatusFF" 3
.FF3 4
	ConfirmedFF4 =
)FF= >
{GG 	
throwHH 
newHH !
BusinessRuleExceptionHH +
(HH+ ,
ErrorMessagesHH, 9
.HH9 :3
'OnlyConfirmedAppointmentsCanBeCompletedHH: a
)HHa b
;HHb c
}II 	
varKK 
todayKK 
=KK 
DateOnlyKK 
.KK 
FromDateTimeKK )
(KK) *
DateTimeKK* 2
.KK2 3
TodayKK3 8
)KK8 9
;KK9 :
ifMM 

(MM 
appointmentMM 
.MM 
AppointmentDateMM '
!=MM( *
todayMM+ 0
)MM0 1
{NN 	
throwOO 
newOO !
BusinessRuleExceptionOO +
(OO+ ,
ErrorMessagesOO, 9
.OO9 :9
-HealthRecordCanBeCreatedOnlyOnAppointmentDateOO: g
)OOg h
;OOh i
}PP 	
ifRR 

(RR 
dtoRR 
.RR 
	VisitDateRR 
!=RR 
appointmentRR (
.RR( )
AppointmentDateRR) 8
)RR8 9
{SS 	
throwTT 
newTT !
BusinessRuleExceptionTT +
(TT+ ,
ErrorMessagesTT, 9
.TT9 :-
!VisitDateMustMatchAppointmentDateTT: [
)TT[ \
;TT\ ]
}UU 	
varWW 
existingRecordWW 
=WW 
awaitWW ""
healthRecordRepositoryWW# 9
.WW9 :/
#GetHealthRecordByAppointmentIdAsyncWW: ]
(WW] ^
dtoWW^ a
.WWa b
AppointmentIdWWb o
)WWo p
;WWp q
ifYY 

(YY 
existingRecordYY 
!=YY 
nullYY "
)YY" #
{ZZ 	
throw[[ 
new[[ 
ConflictException[[ '
([[' (
ErrorMessages[[( 5
.[[5 63
'HealthRecordAlreadyExistsForAppointment[[6 ]
)[[] ^
;[[^ _
}\\ 	
await^^ 
using^^ 
var^^ 
transaction^^ #
=^^$ %
await^^& +
context^^, 3
.^^3 4
Database^^4 <
.^^< =!
BeginTransactionAsync^^= R
(^^R S
)^^S T
;^^T U
try`` 
{aa 	
varbb 
healthRecordbb 
=bb 
newbb "
HealthRecordbb# /
{cc 
AppointmentIddd 
=dd 
dtodd  #
.dd# $
AppointmentIddd$ 1
,dd1 2
	VisitDateee 
=ee 
dtoee 
.ee  
	VisitDateee  )
,ee) *
	Diagnosisff 
=ff 
dtoff 
.ff  
	Diagnosisff  )
,ff) *
Prescriptiongg 
=gg 
dtogg "
.gg" #
Prescriptiongg# /
,gg/ 0
Noteshh 
=hh 
dtohh 
.hh 
Noteshh !
}ii 
;ii 
varkk 
createdRecordkk 
=kk 
awaitkk  %"
healthRecordRepositorykk& <
.kk< =
AddAsynckk= E
(kkE F
healthRecordkkF R
)kkR S
;kkS T
appointmentmm 
.mm 
Statusmm 
=mm  
AppointmentStatusmm! 2
.mm2 3
	Completedmm3 <
;mm< =
awaitnn !
appointmentRepositorynn '
.nn' (
UpdateAsyncnn( 3
(nn3 4
appointmentnn4 ?
)nn? @
;nn@ A
awaitpp 
transactionpp 
.pp 
CommitAsyncpp )
(pp) *
)pp* +
;pp+ ,
varrr 
recordWithDetailsrr !
=rr" #
awaitrr$ )"
healthRecordRepositoryrr* @
.rr@ A/
#GetHealthRecordByIdWithDetailsAsyncrrA d
(rrd e
createdRecordrre r
.rrr s
Idrrs u
)rru v
;rrv w
returntt 
recordWithDetailstt $
==tt% '
nulltt( ,
?uu 
throwuu 
newuu 
NotFoundExceptionuu -
(uu- .
ErrorMessagesuu. ;
.uu; <-
!HealthRecordNotFoundAfterCreationuu< ]
)uu] ^
:vv 
mappervv 
.vv 
Mapvv 
<vv 
HealthRecordDtovv ,
>vv, -
(vv- .
recordWithDetailsvv. ?
)vv? @
;vv@ A
}ww 	
catchxx 
{yy 	
awaitzz 
transactionzz 
.zz 
RollbackAsynczz +
(zz+ ,
)zz, -
;zz- .
throw{{ 
;{{ 
}|| 	
}}} 
private 
PagedResultDto 
< 
TDestination '
>' (
MapPagedResult) 7
<7 8
TSource8 ?
,? @
TDestinationA M
>M N
(N O
PagedResultO Z
<Z [
TSource[ b
>b c
pagedResultd o
)o p
{
ÄÄ 
return
ÅÅ 
new
ÅÅ 
PagedResultDto
ÅÅ !
<
ÅÅ! "
TDestination
ÅÅ" .
>
ÅÅ. /
{
ÇÇ 	
Items
ÉÉ 
=
ÉÉ 
mapper
ÉÉ 
.
ÉÉ 
Map
ÉÉ 
<
ÉÉ 
List
ÉÉ #
<
ÉÉ# $
TDestination
ÉÉ$ 0
>
ÉÉ0 1
>
ÉÉ1 2
(
ÉÉ2 3
pagedResult
ÉÉ3 >
.
ÉÉ> ?
Items
ÉÉ? D
)
ÉÉD E
,
ÉÉE F

PageNumber
ÑÑ 
=
ÑÑ 
pagedResult
ÑÑ $
.
ÑÑ$ %

PageNumber
ÑÑ% /
,
ÑÑ/ 0
PageSize
ÖÖ 
=
ÖÖ 
pagedResult
ÖÖ "
.
ÖÖ" #
PageSize
ÖÖ# +
,
ÖÖ+ ,

TotalCount
ÜÜ 
=
ÜÜ 
pagedResult
ÜÜ $
.
ÜÜ$ %

TotalCount
ÜÜ% /
,
ÜÜ/ 0

TotalPages
áá 
=
áá 
pagedResult
áá $
.
áá$ %

TotalPages
áá% /
}
àà 	
;
àà	 

}
ââ 
}ää îx
UC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\DoctorService.cs
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
 
DoctorService

 
(

 
IDoctorRepository 
doctorRepository &
,& '
IMapper 
mapper 
, "
IAppointmentRepository 
? !
appointmentRepository 1
=2 3
null4 8
)8 9
:: ;
IDoctorService< J
{ 
public 

async 
Task 
< 
PagedResultDto $
<$ %
PublicDoctorDto% 4
>4 5
>5 6
GetAllDoctorsAsync7 I
(I J
PaginationQueryDto 

pagination %
,% & 
DoctorSpecialisation 
? 
specialisation ,
), -
{ 
var 
doctors 
= 
await 
doctorRepository ,
., -
GetAllDoctorsAsync- ?
(? @

pagination 
. 

PageNumber !
,! "

pagination 
. 
PageSize 
,  
specialisation 
) 
; 
return 
MapPagedResult 
< 

HealthAxis (
.( )
API) ,
., -
Models- 3
.3 4
Doctor4 :
,: ;
PublicDoctorDto< K
>K L
(L M
doctorsM T
)T U
;U V
} 
public 

async 
Task 
< 
PublicDoctorDto %
?% &
>& '
GetDoctorByIdAsync( :
(: ;
int; >
id? A
)A B
{ 
var 
doctor 
= 
await 
doctorRepository +
.+ ,
GetDoctorByIdAsync, >
(> ?
id? A
)A B
;B C
if 

( 
doctor 
== 
null 
) 
{   	
return!! 
null!! 
;!! 
}"" 	
return$$ 
mapper$$ 
.$$ 
Map$$ 
<$$ 
PublicDoctorDto$$ )
>$$) *
($$* +
doctor$$+ 1
)$$1 2
;$$2 3
}%% 
public'' 

async'' 
Task'' 
<'' 
PublicDoctorDto'' %
?''% &
>''& '"
GetDoctorByUserIdAsync''( >
(''> ?
string''? E
userId''F L
)''L M
{(( 
var)) 
doctor)) 
=)) 
await)) 
doctorRepository)) +
.))+ ,"
GetDoctorByUserIdAsync)), B
())B C
userId))C I
)))I J
;))J K
if++ 

(++ 
doctor++ 
==++ 
null++ 
)++ 
{,, 	
return-- 
null-- 
;-- 
}.. 	
return00 
mapper00 
.00 
Map00 
<00 
PublicDoctorDto00 )
>00) *
(00* +
doctor00+ 1
)001 2
;002 3
}11 
public33 

async33 
Task33 
<33 !
DoctorAvailabilityDto33 +
?33+ ,
>33, - 
GetAvailabilityAsync33. B
(33B C
int33C F
id33G I
)33I J
{44 
var55 
availability55 
=55 
await55  
doctorRepository55! 1
.551 2 
GetAvailabilityAsync552 F
(55F G
id55G I
)55I J
;55J K
if77 

(77 
availability77 
==77 
null77  
)77  !
{88 	
return99 
null99 
;99 
}:: 	
return<< 
new<< !
DoctorAvailabilityDto<< (
{== 	
DoctorId>> 
=>> 
id>> 
,>> 
IsAvailable?? 
=?? 
availability?? &
.??& '
Value??' ,
,??, -
Message@@ 
=@@ 
availability@@ "
.@@" #
Value@@# (
?AA 
ErrorMessagesAA 
.AA  "
DoctorAvailableMessageAA  6
:BB 
ErrorMessagesBB 
.BB  $
DoctorUnavailableMessageBB  8
}CC 	
;CC	 

}DD 
publicFF 

asyncFF 
TaskFF 
<FF !
DoctorAvailabilityDtoFF +
>FF+ ,#
UpdateAvailabilityAsyncFF- D
(FFD E
intGG 
idGG 

,GG
 '
UpdateDoctorAvailabilityDtoHH 
dtoHH  #
,HH# $
stringII 

currentRoleII 
,II 
intJJ 
?JJ 
currentDoctorIdJJ	 
)JJ 
{KK 
varLL )
appointmentRepositoryInstanceLL )
=LL* +!
appointmentRepositoryLL, A
??MM 
throwMM 
newMM %
InvalidOperationExceptionMM 2
(MM2 3
$strMM3 v
)MMv w
;MMw x
varOO 
doctorOO 
=OO 
awaitOO 
doctorRepositoryOO +
.OO+ ,
GetDoctorByIdAsyncOO, >
(OO> ?
idOO? A
)OOA B
;OOB C
ifQQ 

(QQ 
doctorQQ 
==QQ 
nullQQ 
)QQ 
{RR 	
throwSS 
newSS 
NotFoundExceptionSS '
(SS' (
ErrorMessagesSS( 5
.SS5 6
DoctorNotFoundSS6 D
)SSD E
;SSE F
}TT 	0
$ValidateAvailabilityUpdatePermissionVV ,
(VV, -
idVV- /
,VV/ 0
currentRoleVV1 <
,VV< =
currentDoctorIdVV> M
)VVM N
;VVN O
varXX 
isDeactivationXX 
=XX 
doctorXX #
.XX# $
IsAvailableXX$ /
&&XX0 2
!XX3 4
dtoXX4 7
.XX7 8
IsAvailableXX8 C
;XXC D
ifZZ 

(ZZ 
isDeactivationZZ 
)ZZ 
{[[ 	
await\\ #
HandleDeactivationAsync\\ )
(\\) *
id]] 
,]] 
currentRole^^ 
,^^ )
appointmentRepositoryInstance__ -
)__- .
;__. /
}`` 	
doctorbb 
.bb 
IsAvailablebb 
=bb 
dtobb  
.bb  !
IsAvailablebb! ,
;bb, -
vardd 
updatedDoctordd 
=dd 
awaitdd !
doctorRepositorydd" 2
.dd2 3
UpdateAsyncdd3 >
(dd> ?
doctordd? E
)ddE F
;ddF G
ifff 

(ff 
updatedDoctorff 
==ff 
nullff !
)ff! "
{gg 	
throwhh 
newhh 
NotFoundExceptionhh '
(hh' (
ErrorMessageshh( 5
.hh5 6
DoctorNotFoundhh6 D
)hhD E
;hhE F
}ii 	
returnkk !
CreateAvailabilityDtokk $
(kk$ %
updatedDoctorkk% 2
.kk2 3
Idkk3 5
,kk5 6
updatedDoctorkk7 D
.kkD E
IsAvailablekkE P
)kkP Q
;kkQ R
}ll 
privatenn 
PagedResultDtonn 
<nn 
TDestinationnn '
>nn' (
MapPagedResultnn) 7
<nn7 8
TSourcenn8 ?
,nn? @
TDestinationnnA M
>nnM N
(nnN O
PagedResultnnO Z
<nnZ [
TSourcenn[ b
>nnb c
pagedResultnnd o
)nno p
{oo 
returnpp 
newpp 
PagedResultDtopp !
<pp! "
TDestinationpp" .
>pp. /
{qq 	
Itemsrr 
=rr 
mapperrr 
.rr 
Maprr 
<rr 
Listrr #
<rr# $
TDestinationrr$ 0
>rr0 1
>rr1 2
(rr2 3
pagedResultrr3 >
.rr> ?
Itemsrr? D
)rrD E
,rrE F

PageNumberss 
=ss 
pagedResultss $
.ss$ %

PageNumberss% /
,ss/ 0
PageSizett 
=tt 
pagedResulttt "
.tt" #
PageSizett# +
,tt+ ,

TotalCountuu 
=uu 
pagedResultuu $
.uu$ %

TotalCountuu% /
,uu/ 0

TotalPagesvv 
=vv 
pagedResultvv $
.vv$ %

TotalPagesvv% /
}ww 	
;ww	 

}xx 
privateyy 
staticyy 
voidyy 0
$ValidateAvailabilityUpdatePermissionyy <
(yy< =
intzz 
doctorIdzz 
,zz 
string{{ 

currentRole{{ 
,{{ 
int|| 
?|| 
currentDoctorId||	 
)|| 
{}} 
if~~ 

(~~ 
currentRole~~ 
==~~ 
AppRoles~~ #
.~~# $
Doctor~~$ *
&&~~+ -
currentDoctorId~~. =
!=~~> @
doctorId~~A I
)~~I J
{ 	
throw
ÄÄ 
new
ÄÄ  
ForbiddenException
ÄÄ (
(
ÄÄ( )
ErrorMessages
ÄÄ) 6
.
ÄÄ6 71
#DoctorsCanUpdateOnlyOwnAvailability
ÄÄ7 Z
)
ÄÄZ [
;
ÄÄ[ \
}
ÅÅ 	
if
ÉÉ 

(
ÉÉ 
currentRole
ÉÉ 
!=
ÉÉ 
AppRoles
ÉÉ #
.
ÉÉ# $
Doctor
ÉÉ$ *
&&
ÉÉ+ -
currentRole
ÉÉ. 9
!=
ÉÉ: <
AppRoles
ÉÉ= E
.
ÉÉE F
Admin
ÉÉF K
)
ÉÉK L
{
ÑÑ 	
throw
ÖÖ 
new
ÖÖ  
ForbiddenException
ÖÖ (
(
ÖÖ( )
ErrorMessages
ÖÖ) 6
.
ÖÖ6 74
&UnsupportedAppointmentStatusTransition
ÖÖ7 ]
)
ÖÖ] ^
;
ÖÖ^ _
}
ÜÜ 	
}
áá 
private
ââ 
static
ââ #
DoctorAvailabilityDto
ââ (#
CreateAvailabilityDto
ââ) >
(
ââ> ?
int
ââ? B
doctorId
ââC K
,
ââK L
bool
ââM Q
isAvailable
ââR ]
)
ââ] ^
{
ää 
return
ãã 
new
ãã #
DoctorAvailabilityDto
ãã (
{
åå 	
DoctorId
çç 
=
çç 
doctorId
çç 
,
çç  
IsAvailable
éé 
=
éé 
isAvailable
éé %
,
éé% &
Message
èè 
=
èè 
isAvailable
èè !
?
êê 
ErrorMessages
êê 
.
êê  $
DoctorAvailableMessage
êê  6
:
ëë 
ErrorMessages
ëë 
.
ëë  &
DoctorUnavailableMessage
ëë  8
}
íí 	
;
íí	 

}
ìì 
private
îî 
static
îî 
async
îî 
Task
îî %
HandleDeactivationAsync
îî 5
(
îî5 6
int
ïï 
doctorId
ïï 
,
ïï 
string
ññ 

currentRole
ññ 
,
ññ $
IAppointmentRepository
óó +
appointmentRepositoryInstance
óó 8
)
óó8 9
{
òò 
var
ôô 
today
ôô 
=
ôô 
DateOnly
ôô 
.
ôô 
FromDateTime
ôô )
(
ôô) *
DateTime
ôô* 2
.
ôô2 3
Today
ôô3 8
)
ôô8 9
;
ôô9 :
if
õõ 

(
õõ 
currentRole
õõ 
==
õõ 
AppRoles
õõ #
.
õõ# $
Doctor
õõ$ *
)
õõ* +
{
úú 	
await
ùù 0
"EnsureDoctorCanDeactivateSelfAsync
ùù 4
(
ùù4 5
doctorId
ûû 
,
ûû 
today
üü 
,
üü +
appointmentRepositoryInstance
†† -
)
††- .
;
††. /
return
¢¢ 
;
¢¢ 
}
££ 	
if
•• 

(
•• 
currentRole
•• 
==
•• 
AppRoles
•• #
.
••# $
Admin
••$ )
)
••) *
{
¶¶ 	
await
ßß ?
1CancelTodaysAppointmentsForAdminDeactivationAsync
ßß C
(
ßßC D
doctorId
®® 
,
®® 
today
©© 
,
©© +
appointmentRepositoryInstance
™™ -
)
™™- .
;
™™. /
}
´´ 	
}
¨¨ 
private
ÆÆ 
static
ÆÆ 
async
ÆÆ 
Task
ÆÆ 0
"EnsureDoctorCanDeactivateSelfAsync
ÆÆ @
(
ÆÆ@ A
int
ØØ 
doctorId
ØØ 
,
ØØ 
DateOnly
∞∞ 
today
∞∞ 
,
∞∞ $
IAppointmentRepository
±± +
appointmentRepositoryInstance
±± <
)
±±< =
{
≤≤ 
var
≥≥ +
hasConfirmedAppointmentsToday
≥≥ )
=
≥≥* +
await
≥≥, 1+
appointmentRepositoryInstance
≥≥2 O
.
¥¥ 7
)DoctorHasConfirmedAppointmentsOnDateAsync
¥¥ 6
(
¥¥6 7
doctorId
¥¥7 ?
,
¥¥? @
today
¥¥A F
)
¥¥F G
;
¥¥G H
if
∂∂ 

(
∂∂ +
hasConfirmedAppointmentsToday
∂∂ )
)
∂∂) *
{
∑∑ 	
throw
∏∏ 
new
∏∏ #
BusinessRuleException
∏∏ +
(
∏∏+ ,
ErrorMessages
∏∏, 9
.
∏∏9 :B
4DoctorCannotDeactivateWithConfirmedAppointmentsToday
∏∏: n
)
∏∏n o
;
∏∏o p
}
ππ 	
}
∫∫ 
private
ºº 
static
ºº 
async
ºº 
Task
ºº ?
1CancelTodaysAppointmentsForAdminDeactivationAsync
ºº O
(
ººO P
int
ΩΩ 
doctorId
ΩΩ 
,
ΩΩ 
DateOnly
ææ 
today
ææ 
,
ææ $
IAppointmentRepository
øø +
appointmentRepositoryInstance
øø <
)
øø< =
{
¿¿ 
var
¡¡ "
appointmentsToCancel
¡¡  
=
¡¡! "
await
¡¡# (+
appointmentRepositoryInstance
¡¡) F
.
¬¬ E
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync
¬¬ D
(
¬¬D E
doctorId
¬¬E M
,
¬¬M N
today
¬¬O T
)
¬¬T U
;
¬¬U V
foreach
ƒƒ 
(
ƒƒ 
var
ƒƒ 
appointment
ƒƒ  
in
ƒƒ! #"
appointmentsToCancel
ƒƒ$ 8
)
ƒƒ8 9
{
≈≈ 	
appointment
∆∆ 
.
∆∆ 
Status
∆∆ 
=
∆∆  
AppointmentStatus
∆∆! 2
.
∆∆2 3
	Cancelled
∆∆3 <
;
∆∆< =
appointment
«« 
.
««  
CancellationReason
«« *
=
««+ ,
ErrorMessages
««- :
.
««: ;/
!DoctorEmergencyCancellationReason
««; \
;
««\ ]
await
…… +
appointmentRepositoryInstance
…… /
.
……/ 0
UpdateAsync
……0 ;
(
……; <
appointment
……< G
)
……G H
;
……H I
}
   	
}
ÀÀ 
}ÃÃ «ä
SC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\AuthService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
.! "
Impl" &
;& '
public 
class 
AuthService 
( 
UserManager 
< 
IdentityUser 
> 
userManager )
,) *
HealthAxisDbContext 
context 
,  
IPatientRepository 
patientRepository (
,( )
IDoctorRepository 
doctorRepository &
,& '
IConfiguration 
configuration  
)  !
:" #
IAuthService$ 0
{ 
private 
const 
string  
RefreshTokenProvider -
=. /
$str0 <
;< =
private 
const 
string 
RefreshTokenName )
=* +
$str, :
;: ;
private 
const 
string "
RefreshTokenExpiryName /
=0 1
$str2 I
;I J
public 

async 
Task 
< 
( 
bool 
Success #
,# $
string% +
Message, 3
,3 4
string5 ;
UserId< B
)B C
>C D
RegisterAsyncE R
(R S
RegisterDtoS ^
request_ f
)f g
{ 
if 

( 
request 
. 
Password 
!= 
request  '
.' (
ConfirmPassword( 7
)7 8
{   	
return!! 
(!! 
false!! 
,!! 
ErrorMessages!! (
.!!( )
PasswordsDoNotMatch!!) <
,!!< =
string!!> D
.!!D E
Empty!!E J
)!!J K
;!!K L
}"" 	
if$$ 

($$ 
!$$ 
string$$ 
.$$ 
Equals$$ 
($$ 
request$$ "
.$$" #
Role$$# '
,$$' (
AppRoles$$) 1
.$$1 2
Patient$$2 9
,$$9 :
StringComparison$$; K
.$$K L
OrdinalIgnoreCase$$L ]
)$$] ^
)$$^ _
{%% 	
return&& 
(&& 
false&& 
,&& 
ErrorMessages&& (
.&&( )*
OnlyPatientRegistrationAllowed&&) G
,&&G H
string&&I O
.&&O P
Empty&&P U
)&&U V
;&&V W
}'' 	
var)) 
existingUser)) 
=)) 
await))  
userManager))! ,
.)), -
FindByEmailAsync))- =
())= >
request))> E
.))E F
Email))F K
)))K L
;))L M
if++ 

(++ 
existingUser++ 
!=++ 
null++  
)++  !
{,, 	
return-- 
(-- 
false-- 
,-- 
ErrorMessages-- (
.--( )"
EmailAlreadyRegistered--) ?
,--? @
string--A G
.--G H
Empty--H M
)--M N
;--N O
}.. 	
await00 
using00 
var00 
transaction00 #
=00$ %
await00& +
context00, 3
.003 4
Database004 <
.00< =!
BeginTransactionAsync00= R
(00R S
)00S T
;00T U
try22 
{33 	
var44 
user44 
=44 
new44 
IdentityUser44 '
{55 
UserName66 
=66 
request66 "
.66" #
Email66# (
,66( )
Email77 
=77 
request77 
.77  
Email77  %
,77% &
EmailConfirmed88 
=88  
true88! %
,88% &
PhoneNumber99 
=99 
request99 %
.99% &
PhoneNumber99& 1
}:: 
;:: 
var<< 
createResult<< 
=<< 
await<< $
userManager<<% 0
.<<0 1
CreateAsync<<1 <
(<<< =
user<<= A
,<<A B
request<<C J
.<<J K
Password<<K S
)<<S T
;<<T U
if>> 
(>> 
!>> 
createResult>> 
.>> 
	Succeeded>> '
)>>' (
{?? 
var@@ 
errors@@ 
=@@ 
string@@ #
.@@# $
Join@@$ (
(@@( )
$str@@) -
,@@- .
createResult@@/ ;
.@@; <
Errors@@< B
.@@B C
Select@@C I
(@@I J
error@@J O
=>@@P R
error@@S X
.@@X Y
Description@@Y d
)@@d e
)@@e f
;@@f g
awaitAA 
transactionAA !
.AA! "
RollbackAsyncAA" /
(AA/ 0
)AA0 1
;AA1 2
returnBB 
(BB 
falseBB 
,BB 
errorsBB %
,BB% &
stringBB' -
.BB- .
EmptyBB. 3
)BB3 4
;BB4 5
}CC 
varEE 

roleResultEE 
=EE 
awaitEE "
userManagerEE# .
.EE. /
AddToRoleAsyncEE/ =
(EE= >
userEE> B
,EEB C
AppRolesEED L
.EEL M
PatientEEM T
)EET U
;EEU V
ifGG 
(GG 
!GG 

roleResultGG 
.GG 
	SucceededGG %
)GG% &
{HH 
varII 
errorsII 
=II 
stringII #
.II# $
JoinII$ (
(II( )
$strII) -
,II- .

roleResultII/ 9
.II9 :
ErrorsII: @
.II@ A
SelectIIA G
(IIG H
errorIIH M
=>IIN P
errorIIQ V
.IIV W
DescriptionIIW b
)IIb c
)IIc d
;IId e
awaitJJ 
transactionJJ !
.JJ! "
RollbackAsyncJJ" /
(JJ/ 0
)JJ0 1
;JJ1 2
returnKK 
(KK 
falseKK 
,KK 
errorsKK %
,KK% &
stringKK' -
.KK- .
EmptyKK. 3
)KK3 4
;KK4 5
}LL 
varNN 
patientNN 
=NN 
newNN 
PatientNN %
{OO 
UserIdPP 
=PP 
userPP 
.PP 
IdPP  
,PP  !
FullNameQQ 
=QQ 
requestQQ "
.QQ" #
FullNameQQ# +
,QQ+ ,
DateOfBirthRR 
=RR 
requestRR %
.RR% &
DateOfBirthRR& 1
,RR1 2
GenderSS 
=SS 
requestSS  
.SS  !
GenderSS! '
,SS' (
AddressTT 
=TT 
requestTT !
.TT! "
AddressTT" )
}UU 
;UU 
awaitWW 
contextWW 
.WW 
PatientsWW "
.WW" #
AddAsyncWW# +
(WW+ ,
patientWW, 3
)WW3 4
;WW4 5
awaitXX 
contextXX 
.XX 
SaveChangesAsyncXX *
(XX* +
)XX+ ,
;XX, -
awaitZZ 
transactionZZ 
.ZZ 
CommitAsyncZZ )
(ZZ) *
)ZZ* +
;ZZ+ ,
return\\ 
(\\ 
true\\ 
,\\ 
$str\\ 9
,\\9 :
user\\; ?
.\\? @
Id\\@ B
)\\B C
;\\C D
}]] 	
catch^^ 
{__ 	
await`` 
transaction`` 
.`` 
RollbackAsync`` +
(``+ ,
)``, -
;``- .
throwaa 
;aa 
}bb 	
}cc 
publicee 

asyncee 
Taskee 
<ee 
(ee 
boolee 
Successee #
,ee# $
stringee% +
Messageee, 3
,ee3 4
AuthResponseDtoee5 D
?eeD E
ResponseeeF N
)eeN O
>eeO P

LoginAsynceeQ [
(ee[ \
LoginDtoee\ d
requesteee l
)eel m
{ff 
vargg 
usergg 
=gg 
awaitgg 
userManagergg $
.gg$ %
FindByEmailAsyncgg% 5
(gg5 6
requestgg6 =
.gg= >
Emailgg> C
)ggC D
;ggD E
ifii 

(ii 
userii 
==ii 
nullii 
)ii 
{jj 	
returnkk 
(kk 
falsekk 
,kk 
ErrorMessageskk (
.kk( )
InvalidCredentialskk) ;
,kk; <
nullkk= A
)kkA B
;kkB C
}ll 	
varnn 
isPasswordValidnn 
=nn 
awaitnn #
userManagernn$ /
.nn/ 0
CheckPasswordAsyncnn0 B
(nnB C
usernnC G
,nnG H
requestnnI P
.nnP Q
PasswordnnQ Y
)nnY Z
;nnZ [
ifpp 

(pp 
!pp 
isPasswordValidpp 
)pp 
{qq 	
returnrr 
(rr 
falserr 
,rr 
ErrorMessagesrr (
.rr( )
InvalidCredentialsrr) ;
,rr; <
nullrr= A
)rrA B
;rrB C
}ss 	
varuu 
profileResultuu 
=uu 
awaituu !!
BuildUserProfileAsyncuu" 7
(uu7 8
useruu8 <
)uu< =
;uu= >
ifww 

(ww 
!ww 
profileResultww 
.ww 
Successww "
)ww" #
{xx 	
returnyy 
(yy 
falseyy 
,yy 
profileResultyy (
.yy( )
Messageyy) 0
,yy0 1
nullyy2 6
)yy6 7
;yy7 8
}zz 	
var|| 
response|| 
=|| 
await|| %
GenerateAuthResponseAsync|| 6
(||6 7
user}} 
,}} 
profileResult~~ 
.~~ 
Roles~~ 
,~~  
profileResult 
. 
Role 
, 
profileResult
ÄÄ 
.
ÄÄ 
	PatientId
ÄÄ #
,
ÄÄ# $
profileResult
ÅÅ 
.
ÅÅ 
DoctorId
ÅÅ "
,
ÅÅ" #
$str
ÇÇ *
)
ÇÇ* +
;
ÇÇ+ ,
return
ÑÑ 
(
ÑÑ 
true
ÑÑ 
,
ÑÑ 
response
ÑÑ 
.
ÑÑ 
Message
ÑÑ &
,
ÑÑ& '
response
ÑÑ( 0
)
ÑÑ0 1
;
ÑÑ1 2
}
ÖÖ 
public
áá 

async
áá 
Task
áá 
<
áá 
(
áá 
bool
áá 
Success
áá #
,
áá# $
string
áá% +
Message
áá, 3
,
áá3 4
AuthResponseDto
áá5 D
?
ááD E
Response
ááF N
)
ááN O
>
ááO P
RefreshTokenAsync
ááQ b
(
ááb c$
RefreshTokenRequestDto
áác y
requestááz Å
)ááÅ Ç
{
àà 
var
ââ 
user
ââ 
=
ââ 
await
ââ 
userManager
ââ $
.
ââ$ %
FindByIdAsync
ââ% 2
(
ââ2 3
request
ââ3 :
.
ââ: ;
UserId
ââ; A
)
ââA B
;
ââB C
if
ãã 

(
ãã 
user
ãã 
==
ãã 
null
ãã 
)
ãã 
{
åå 	
return
çç 
(
çç 
false
çç 
,
çç 
ErrorMessages
çç (
.
çç( )!
InvalidRefreshToken
çç) <
,
çç< =
null
çç> B
)
ççB C
;
ççC D
}
éé 	
var
êê $
storedRefreshTokenHash
êê "
=
êê# $
await
êê% *
userManager
êê+ 6
.
êê6 7)
GetAuthenticationTokenAsync
êê7 R
(
êêR S
user
ëë 
,
ëë "
RefreshTokenProvider
íí  
,
íí  !
RefreshTokenName
ìì 
)
ìì 
;
ìì 
var
ïï 
storedExpiryValue
ïï 
=
ïï 
await
ïï  %
userManager
ïï& 1
.
ïï1 2)
GetAuthenticationTokenAsync
ïï2 M
(
ïïM N
user
ññ 
,
ññ "
RefreshTokenProvider
óó  
,
óó  !$
RefreshTokenExpiryName
òò "
)
òò" #
;
òò# $
if
öö 

(
öö 
string
öö 
.
öö  
IsNullOrWhiteSpace
öö %
(
öö% &$
storedRefreshTokenHash
öö& <
)
öö< =
||
öö> @
string
ööA G
.
ööG H 
IsNullOrWhiteSpace
ööH Z
(
ööZ [
storedExpiryValue
öö[ l
)
ööl m
)
ööm n
{
õõ 	
return
úú 
(
úú 
false
úú 
,
úú 
ErrorMessages
úú (
.
úú( )!
InvalidRefreshToken
úú) <
,
úú< =
null
úú> B
)
úúB C
;
úúC D
}
ùù 	
if
üü 

(
üü 
!
üü 
DateTime
üü 
.
üü 
TryParse
üü 
(
üü 
storedExpiryValue
†† 
,
†† 
CultureInfo
°° 
.
°° 
InvariantCulture
°° $
,
°°$ %
DateTimeStyles
¢¢ 
.
¢¢ 
RoundtripKind
¢¢ $
,
¢¢$ %
out
££ 
var
££ 
expiresAtUtc
££ 
)
££ 
)
££ 
{
§§ 	
return
•• 
(
•• 
false
•• 
,
•• 
ErrorMessages
•• (
.
••( )!
InvalidRefreshToken
••) <
,
••< =
null
••> B
)
••B C
;
••C D
}
¶¶ 	
if
©© 

(
©© 
DateTime
©© 
.
©© 
UtcNow
©© 
>=
©© 
expiresAtUtc
©© +
)
©©+ ,
{
™™ 	
await
´´ %
RemoveRefreshTokenAsync
´´ )
(
´´) *
user
´´* .
)
´´. /
;
´´/ 0
return
¨¨ 
(
¨¨ 
false
¨¨ 
,
¨¨ 
ErrorMessages
¨¨ (
.
¨¨( )!
RefreshTokenExpired
¨¨) <
,
¨¨< =
null
¨¨> B
)
¨¨B C
;
¨¨C D
}
≠≠ 	
var
ØØ &
incomingRefreshTokenHash
ØØ $
=
ØØ% &
	HashToken
ØØ' 0
(
ØØ0 1
request
ØØ1 8
.
ØØ8 9
RefreshToken
ØØ9 E
)
ØØE F
;
ØØF G
if
±± 

(
±± 
!
±± 
string
±± 
.
±± 
Equals
±± 
(
±± $
storedRefreshTokenHash
±± 1
,
±±1 2&
incomingRefreshTokenHash
±±3 K
,
±±K L
StringComparison
±±M ]
.
±±] ^
Ordinal
±±^ e
)
±±e f
)
±±f g
{
≤≤ 	
return
≥≥ 
(
≥≥ 
false
≥≥ 
,
≥≥ 
ErrorMessages
≥≥ (
.
≥≥( )!
InvalidRefreshToken
≥≥) <
,
≥≥< =
null
≥≥> B
)
≥≥B C
;
≥≥C D
}
¥¥ 	
var
∂∂ 
profileResult
∂∂ 
=
∂∂ 
await
∂∂ !#
BuildUserProfileAsync
∂∂" 7
(
∂∂7 8
user
∂∂8 <
)
∂∂< =
;
∂∂= >
if
∏∏ 

(
∏∏ 
!
∏∏ 
profileResult
∏∏ 
.
∏∏ 
Success
∏∏ "
)
∏∏" #
{
ππ 	
return
∫∫ 
(
∫∫ 
false
∫∫ 
,
∫∫ 
profileResult
∫∫ (
.
∫∫( )
Message
∫∫) 0
,
∫∫0 1
null
∫∫2 6
)
∫∫6 7
;
∫∫7 8
}
ªª 	
var
ΩΩ 
response
ΩΩ 
=
ΩΩ 
await
ΩΩ '
GenerateAuthResponseAsync
ΩΩ 6
(
ΩΩ6 7
user
ææ 
,
ææ 
profileResult
øø 
.
øø 
Roles
øø 
,
øø  
profileResult
¿¿ 
.
¿¿ 
Role
¿¿ 
,
¿¿ 
profileResult
¡¡ 
.
¡¡ 
	PatientId
¡¡ #
,
¡¡# $
profileResult
¬¬ 
.
¬¬ 
DoctorId
¬¬ "
,
¬¬" #
$str
√√ +
)
√√+ ,
;
√√, -
return
≈≈ 
(
≈≈ 
true
≈≈ 
,
≈≈ 
response
≈≈ 
.
≈≈ 
Message
≈≈ &
,
≈≈& '
response
≈≈( 0
)
≈≈0 1
;
≈≈1 2
}
∆∆ 
private
»» 
async
»» 
Task
»» 
<
»» 
(
»» 
bool
»» 
Success
»» $
,
»»$ %
string
»»& ,
Message
»»- 4
,
»»4 5
IList
»»6 ;
<
»»; <
string
»»< B
>
»»B C
Roles
»»D I
,
»»I J
string
»»K Q
Role
»»R V
,
»»V W
int
»»X [
?
»»[ \
	PatientId
»»] f
,
»»f g
int
»»h k
?
»»k l
DoctorId
»»m u
)
»»u v
>
»»v w$
BuildUserProfileAsync»»x ç
(»»ç é
IdentityUser»»é ö
user»»õ ü
)»»ü †
{
…… 
var
   
roles
   
=
   
await
   
userManager
   %
.
  % &
GetRolesAsync
  & 3
(
  3 4
user
  4 8
)
  8 9
;
  9 :
var
ÀÀ 
role
ÀÀ 
=
ÀÀ 
roles
ÀÀ 
.
ÀÀ 
FirstOrDefault
ÀÀ '
(
ÀÀ' (
)
ÀÀ( )
??
ÀÀ* ,
string
ÀÀ- 3
.
ÀÀ3 4
Empty
ÀÀ4 9
;
ÀÀ9 :
int
ÕÕ 
?
ÕÕ 
	patientId
ÕÕ 
=
ÕÕ 
null
ÕÕ 
;
ÕÕ 
int
ŒŒ 
?
ŒŒ 
doctorId
ŒŒ 
=
ŒŒ 
null
ŒŒ 
;
ŒŒ 
if
–– 

(
–– 
string
–– 
.
–– 
Equals
–– 
(
–– 
role
–– 
,
–– 
AppRoles
––  (
.
––( )
Patient
––) 0
,
––0 1
StringComparison
––2 B
.
––B C
OrdinalIgnoreCase
––C T
)
––T U
)
––U V
{
—— 	
var
““ 
patient
““ 
=
““ 
await
““ 
patientRepository
““  1
.
““1 2%
GetPatientByUserIdAsync
““2 I
(
““I J
user
““J N
.
““N O
Id
““O Q
)
““Q R
;
““R S
if
‘‘ 
(
‘‘ 
patient
‘‘ 
==
‘‘ 
null
‘‘ 
)
‘‘  
{
’’ 
return
÷÷ 
(
÷÷ 
false
÷÷ 
,
÷÷ 
ErrorMessages
÷÷ ,
.
÷÷, -$
PatientProfileNotFound
÷÷- C
,
÷÷C D
roles
÷÷E J
,
÷÷J K
role
÷÷L P
,
÷÷P Q
null
÷÷R V
,
÷÷V W
null
÷÷X \
)
÷÷\ ]
;
÷÷] ^
}
◊◊ 
	patientId
ŸŸ 
=
ŸŸ 
patient
ŸŸ 
.
ŸŸ  
Id
ŸŸ  "
;
ŸŸ" #
}
⁄⁄ 	
if
‹‹ 

(
‹‹ 
string
‹‹ 
.
‹‹ 
Equals
‹‹ 
(
‹‹ 
role
‹‹ 
,
‹‹ 
AppRoles
‹‹  (
.
‹‹( )
Doctor
‹‹) /
,
‹‹/ 0
StringComparison
‹‹1 A
.
‹‹A B
OrdinalIgnoreCase
‹‹B S
)
‹‹S T
)
‹‹T U
{
›› 	
var
ﬁﬁ 
doctor
ﬁﬁ 
=
ﬁﬁ 
await
ﬁﬁ 
doctorRepository
ﬁﬁ /
.
ﬁﬁ/ 0$
GetDoctorByUserIdAsync
ﬁﬁ0 F
(
ﬁﬁF G
user
ﬁﬁG K
.
ﬁﬁK L
Id
ﬁﬁL N
)
ﬁﬁN O
;
ﬁﬁO P
if
‡‡ 
(
‡‡ 
doctor
‡‡ 
==
‡‡ 
null
‡‡ 
)
‡‡ 
{
·· 
return
‚‚ 
(
‚‚ 
false
‚‚ 
,
‚‚ 
ErrorMessages
‚‚ ,
.
‚‚, -#
DoctorProfileNotFound
‚‚- B
,
‚‚B C
roles
‚‚D I
,
‚‚I J
role
‚‚K O
,
‚‚O P
null
‚‚Q U
,
‚‚U V
null
‚‚W [
)
‚‚[ \
;
‚‚\ ]
}
„„ 
doctorId
ÂÂ 
=
ÂÂ 
doctor
ÂÂ 
.
ÂÂ 
Id
ÂÂ  
;
ÂÂ  !
}
ÊÊ 	
return
ËË 
(
ËË 
true
ËË 
,
ËË 
string
ËË 
.
ËË 
Empty
ËË "
,
ËË" #
roles
ËË$ )
,
ËË) *
role
ËË+ /
,
ËË/ 0
	patientId
ËË1 :
,
ËË: ;
doctorId
ËË< D
)
ËËD E
;
ËËE F
}
ÈÈ 
private
ÎÎ 
async
ÎÎ 
Task
ÎÎ 
<
ÎÎ 
AuthResponseDto
ÎÎ &
>
ÎÎ& ''
GenerateAuthResponseAsync
ÎÎ( A
(
ÎÎA B
IdentityUser
ÏÏ 
user
ÏÏ 
,
ÏÏ 
IList
ÌÌ 
<
ÌÌ 
string
ÌÌ 
>
ÌÌ 
roles
ÌÌ 
,
ÌÌ 
string
ÓÓ 
role
ÓÓ 
,
ÓÓ 
int
ÔÔ 
?
ÔÔ 
	patientId
ÔÔ 
,
ÔÔ 
int
 
?
 
doctorId
 
,
 
string
ÒÒ 
message
ÒÒ 
)
ÒÒ 
{
ÚÚ 
var
ÛÛ 
	expiresIn
ÛÛ 
=
ÛÛ 
int
ÛÛ 
.
ÛÛ 
Parse
ÛÛ !
(
ÛÛ! "
configuration
ÛÛ" /
.
ÛÛ/ 0

GetSection
ÛÛ0 :
(
ÛÛ: ;
$str
ÛÛ; @
)
ÛÛ@ A
[
ÛÛA B
$str
ÛÛB `
]
ÛÛ` a
!
ÛÛa b
)
ÛÛb c
;
ÛÛc d
var
ÙÙ 
token
ÙÙ 
=
ÙÙ 
GenerateToken
ÙÙ !
(
ÙÙ! "
user
ÙÙ" &
,
ÙÙ& '
roles
ÙÙ( -
,
ÙÙ- .
	expiresIn
ÙÙ/ 8
,
ÙÙ8 9
	patientId
ÙÙ: C
,
ÙÙC D
doctorId
ÙÙE M
)
ÙÙM N
;
ÙÙN O
var
ıı 
refreshToken
ıı 
=
ıı "
GenerateRefreshToken
ıı /
(
ıı/ 0
)
ıı0 1
;
ıı1 2
await
˜˜ $
StoreRefreshTokenAsync
˜˜ $
(
˜˜$ %
user
˜˜% )
,
˜˜) *
refreshToken
˜˜+ 7
)
˜˜7 8
;
˜˜8 9
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
˚˚  
RefreshToken
¸¸ 
=
¸¸ 
refreshToken
¸¸ '
,
¸¸' (
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
áá 
async
áá 
Task
áá $
StoreRefreshTokenAsync
áá -
(
áá- .
IdentityUser
áá. :
user
áá; ?
,
áá? @
string
ááA G
refreshToken
ááH T
)
ááT U
{
àà 
var
ââ (
refreshTokenExpirationDays
ââ &
=
ââ' (
int
ââ) ,
.
ââ, -
TryParse
ââ- 5
(
ââ5 6
configuration
ää 
.
ää 

GetSection
ää $
(
ää$ %
$str
ää% *
)
ää* +
[
ää+ ,
$str
ää, H
]
ääH I
,
ääI J
out
ãã 
var
ãã 
configuredDays
ãã "
)
ãã" #
?
åå 
configuredDays
åå 
:
çç 
$num
çç 
;
çç 
var
èè 
refreshTokenHash
èè 
=
èè 
	HashToken
èè (
(
èè( )
refreshToken
èè) 5
)
èè5 6
;
èè6 7
var
êê 
expiresAtUtc
êê 
=
êê 
DateTime
êê #
.
êê# $
UtcNow
êê$ *
.
êê* +
AddDays
êê+ 2
(
êê2 3(
refreshTokenExpirationDays
êê3 M
)
êêM N
;
êêN O
await
íí 
userManager
íí 
.
íí )
SetAuthenticationTokenAsync
íí 5
(
íí5 6
user
ìì 
,
ìì "
RefreshTokenProvider
îî  
,
îî  !
RefreshTokenName
ïï 
,
ïï 
refreshTokenHash
ññ 
)
ññ 
;
ññ 
await
òò 
userManager
òò 
.
òò )
SetAuthenticationTokenAsync
òò 5
(
òò5 6
user
ôô 
,
ôô "
RefreshTokenProvider
öö  
,
öö  !$
RefreshTokenExpiryName
õõ "
,
õõ" #
expiresAtUtc
úú 
.
úú 
ToString
úú !
(
úú! "
$str
úú" %
,
úú% &
CultureInfo
úú' 2
.
úú2 3
InvariantCulture
úú3 C
)
úúC D
)
úúD E
;
úúE F
}
ùù 
private
üü 
async
üü 
Task
üü %
RemoveRefreshTokenAsync
üü .
(
üü. /
IdentityUser
üü/ ;
user
üü< @
)
üü@ A
{
†† 
await
°° 
userManager
°° 
.
°° ,
RemoveAuthenticationTokenAsync
°° 8
(
°°8 9
user
°°9 =
,
°°= >"
RefreshTokenProvider
°°? S
,
°°S T
RefreshTokenName
°°U e
)
°°e f
;
°°f g
await
¢¢ 
userManager
¢¢ 
.
¢¢ ,
RemoveAuthenticationTokenAsync
¢¢ 8
(
¢¢8 9
user
¢¢9 =
,
¢¢= >"
RefreshTokenProvider
¢¢? S
,
¢¢S T$
RefreshTokenExpiryName
¢¢U k
)
¢¢k l
;
¢¢l m
}
££ 
private
•• 
string
•• 
GenerateToken
••  
(
••  !
IdentityUser
¶¶ 
user
¶¶ 
,
¶¶ 
IList
ßß 
<
ßß 
string
ßß 
>
ßß 
roles
ßß 
,
ßß 
int
®® 
	expiresIn
®® 
,
®® 
int
©© 
?
©© 
	patientId
©© 
,
©© 
int
™™ 
?
™™ 
doctorId
™™ 
)
™™ 
{
´´ 
var
¨¨ 
jwtSettings
¨¨ 
=
¨¨ 
configuration
¨¨ '
.
¨¨' (

GetSection
¨¨( 2
(
¨¨2 3
$str
¨¨3 8
)
¨¨8 9
;
¨¨9 :
var
ÆÆ 
key
ÆÆ 
=
ÆÆ 
new
ÆÆ "
SymmetricSecurityKey
ÆÆ *
(
ÆÆ* +
Encoding
ØØ 
.
ØØ 
UTF8
ØØ 
.
ØØ 
GetBytes
ØØ "
(
ØØ" #
jwtSettings
ØØ# .
[
ØØ. /
$str
ØØ/ 4
]
ØØ4 5
!
ØØ5 6
)
ØØ6 7
)
∞∞ 	
;
∞∞	 

var
≤≤ 
credentials
≤≤ 
=
≤≤ 
new
≤≤  
SigningCredentials
≤≤ 0
(
≤≤0 1
key
≤≤1 4
,
≤≤4 5 
SecurityAlgorithms
≤≤6 H
.
≤≤H I

HmacSha256
≤≤I S
)
≤≤S T
;
≤≤T U
var
¥¥ 
claims
¥¥ 
=
¥¥ 
new
¥¥ 
List
¥¥ 
<
¥¥ 
Claim
¥¥ #
>
¥¥# $
{
µµ 	
new
∂∂ 
Claim
∂∂ 
(
∂∂ 
AppClaimTypes
∂∂ #
.
∂∂# $
UserId
∂∂$ *
,
∂∂* +
user
∂∂, 0
.
∂∂0 1
Id
∂∂1 3
)
∂∂3 4
,
∂∂4 5
new
∑∑ 
Claim
∑∑ 
(
∑∑ %
JwtRegisteredClaimNames
∑∑ -
.
∑∑- .
Sub
∑∑. 1
,
∑∑1 2
user
∑∑3 7
.
∑∑7 8
Id
∑∑8 :
)
∑∑: ;
,
∑∑; <
new
∏∏ 
Claim
∏∏ 
(
∏∏ %
JwtRegisteredClaimNames
∏∏ -
.
∏∏- .
Email
∏∏. 3
,
∏∏3 4
user
∏∏5 9
.
∏∏9 :
Email
∏∏: ?
??
∏∏@ B
string
∏∏C I
.
∏∏I J
Empty
∏∏J O
)
∏∏O P
,
∏∏P Q
new
ππ 
Claim
ππ 
(
ππ 

ClaimTypes
ππ  
.
ππ  !
NameIdentifier
ππ! /
,
ππ/ 0
user
ππ1 5
.
ππ5 6
Id
ππ6 8
)
ππ8 9
,
ππ9 :
new
∫∫ 
Claim
∫∫ 
(
∫∫ 

ClaimTypes
∫∫  
.
∫∫  !
Email
∫∫! &
,
∫∫& '
user
∫∫( ,
.
∫∫, -
Email
∫∫- 2
??
∫∫3 5
string
∫∫6 <
.
∫∫< =
Empty
∫∫= B
)
∫∫B C
,
∫∫C D
new
ªª 
Claim
ªª 
(
ªª %
JwtRegisteredClaimNames
ªª -
.
ªª- .
Jti
ªª. 1
,
ªª1 2
Guid
ªª3 7
.
ªª7 8
NewGuid
ªª8 ?
(
ªª? @
)
ªª@ A
.
ªªA B
ToString
ªªB J
(
ªªJ K
)
ªªK L
)
ªªL M
}
ºº 	
;
ºº	 

foreach
ææ 
(
ææ 
var
ææ 
role
ææ 
in
ææ 
roles
ææ "
)
ææ" #
{
øø 	
claims
¿¿ 
.
¿¿ 
Add
¿¿ 
(
¿¿ 
new
¿¿ 
Claim
¿¿  
(
¿¿  !
AppClaimTypes
¿¿! .
.
¿¿. /
Role
¿¿/ 3
,
¿¿3 4
role
¿¿5 9
)
¿¿9 :
)
¿¿: ;
;
¿¿; <
claims
¡¡ 
.
¡¡ 
Add
¡¡ 
(
¡¡ 
new
¡¡ 
Claim
¡¡  
(
¡¡  !

ClaimTypes
¡¡! +
.
¡¡+ ,
Role
¡¡, 0
,
¡¡0 1
role
¡¡2 6
)
¡¡6 7
)
¡¡7 8
;
¡¡8 9
}
¬¬ 	
if
ƒƒ 

(
ƒƒ 
	patientId
ƒƒ 
.
ƒƒ 
HasValue
ƒƒ 
)
ƒƒ 
{
≈≈ 	
claims
∆∆ 
.
∆∆ 
Add
∆∆ 
(
∆∆ 
new
∆∆ 
Claim
∆∆  
(
∆∆  !
AppClaimTypes
∆∆! .
.
∆∆. /
	PatientId
∆∆/ 8
,
∆∆8 9
	patientId
∆∆: C
.
∆∆C D
Value
∆∆D I
.
∆∆I J
ToString
∆∆J R
(
∆∆R S
)
∆∆S T
)
∆∆T U
)
∆∆U V
;
∆∆V W
}
«« 	
if
…… 

(
…… 
doctorId
…… 
.
…… 
HasValue
…… 
)
…… 
{
   	
claims
ÀÀ 
.
ÀÀ 
Add
ÀÀ 
(
ÀÀ 
new
ÀÀ 
Claim
ÀÀ  
(
ÀÀ  !
AppClaimTypes
ÀÀ! .
.
ÀÀ. /
DoctorId
ÀÀ/ 7
,
ÀÀ7 8
doctorId
ÀÀ9 A
.
ÀÀA B
Value
ÀÀB G
.
ÀÀG H
ToString
ÀÀH P
(
ÀÀP Q
)
ÀÀQ R
)
ÀÀR S
)
ÀÀS T
;
ÀÀT U
}
ÃÃ 	
var
ŒŒ 
token
ŒŒ 
=
ŒŒ 
new
ŒŒ 
JwtSecurityToken
ŒŒ (
(
ŒŒ( )
issuer
œœ 
:
œœ 
jwtSettings
œœ 
[
œœ  
$str
œœ  (
]
œœ( )
,
œœ) *
audience
–– 
:
–– 
jwtSettings
–– !
[
––! "
$str
––" ,
]
––, -
,
––- .
claims
—— 
:
—— 
claims
—— 
,
—— 
expires
““ 
:
““ 
DateTime
““ 
.
““ 
UtcNow
““ $
.
““$ %

AddMinutes
““% /
(
““/ 0
	expiresIn
““0 9
)
““9 :
,
““: ; 
signingCredentials
”” 
:
”” 
credentials
””  +
)
‘‘ 	
;
‘‘	 

return
÷÷ 
new
÷÷ %
JwtSecurityTokenHandler
÷÷ *
(
÷÷* +
)
÷÷+ ,
.
÷÷, -

WriteToken
÷÷- 7
(
÷÷7 8
token
÷÷8 =
)
÷÷= >
;
÷÷> ?
}
◊◊ 
private
ŸŸ 
static
ŸŸ 
string
ŸŸ "
GenerateRefreshToken
ŸŸ .
(
ŸŸ. /
)
ŸŸ/ 0
{
⁄⁄ 
var
€€ 
randomBytes
€€ 
=
€€ #
RandomNumberGenerator
€€ /
.
€€/ 0
GetBytes
€€0 8
(
€€8 9
$num
€€9 ;
)
€€; <
;
€€< =
return
›› 
Convert
›› 
.
›› 
ToBase64String
›› %
(
››% &
randomBytes
››& 1
)
››1 2
;
››2 3
}
ﬁﬁ 
private
‡‡ 
static
‡‡ 
string
‡‡ 
	HashToken
‡‡ #
(
‡‡# $
string
‡‡$ *
token
‡‡+ 0
)
‡‡0 1
{
·· 
var
‚‚ 
	hashBytes
‚‚ 
=
‚‚ 
SHA256
‚‚ 
.
‚‚ 
HashData
‚‚ '
(
‚‚' (
Encoding
‚‚( 0
.
‚‚0 1
UTF8
‚‚1 5
.
‚‚5 6
GetBytes
‚‚6 >
(
‚‚> ?
token
‚‚? D
)
‚‚D E
)
‚‚E F
;
‚‚F G
return
‰‰ 
Convert
‰‰ 
.
‰‰ 
ToBase64String
‰‰ %
(
‰‰% &
	hashBytes
‰‰& /
)
‰‰/ 0
;
‰‰0 1
}
ÂÂ 
}ÊÊ „á
ZC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\AppointmentService.cs
	namespace		 	

HealthAxis		
 
.		 
API		 
.		 
Services		 !
.		! "
Impl		" &
;		& '
public 
class 
AppointmentService 
(  "
IAppointmentRepository !
appointmentRepository 0
,0 1
IPatientRepository 
patientRepository (
,( )
IDoctorRepository 
doctorRepository &
,& '
IMapper 
mapper 
) 
: 
IAppointmentService )
{ 
private 
const 
int )
MinimumHoursBeforeAppointment 3
=4 5
$num6 8
;8 9
public 

async 
Task 
< 
PagedResultDto $
<$ %
AppointmentDto% 3
>3 4
>4 5#
GetAllAppointmentsAsync6 M
(M N
PaginationQueryDtoN `

paginationa k
)k l
{ 
await 5
)AutoCancelExpiredPendingAppointmentsAsync 7
(7 8
)8 9
;9 :
var 
appointments 
= 
await  !
appointmentRepository! 6
.6 7#
GetAllAppointmentsAsync7 N
(N O

pagination 
. 

PageNumber !
,! "

pagination 
. 
PageSize 
)  
;  !
return 
MapPagedResult 
< 
Appointment )
,) *
AppointmentDto+ 9
>9 :
(: ;
appointments; G
)G H
;H I
} 
public 

async 
Task 
< 
AppointmentDto $
>$ %#
GetAppointmentByIdAsync& =
(= >
int> A
idB D
)D E
{ 
await   5
)AutoCancelExpiredPendingAppointmentsAsync   7
(  7 8
)  8 9
;  9 :
var"" 
appointment"" 
="" 
await"" !
appointmentRepository""  5
.""5 6.
"GetAppointmentByIdWithDetailsAsync""6 X
(""X Y
id""Y [
)""[ \
;""\ ]
if$$ 

($$ 
appointment$$ 
==$$ 
null$$ 
)$$  
{%% 	
throw&& 
new&& 
NotFoundException&& '
(&&' (
ErrorMessages&&( 5
.&&5 6
AppointmentNotFound&&6 I
)&&I J
;&&J K
}'' 	
return)) 
mapper)) 
.)) 
Map)) 
<)) 
AppointmentDto)) (
>))( )
())) *
appointment))* 5
)))5 6
;))6 7
}** 
public,, 

async,, 
Task,, 
<,, 
AppointmentDto,, $
?,,$ %
>,,% &"
CreateAppointmentAsync,,' =
(,,= > 
CreateAppointmentDto,,> R
dto,,S V
),,V W
{-- 
await.. 0
$ValidateAppointmentCanBeCreatedAsync.. 2
(..2 3
dto..3 6
)..6 7
;..7 8
var00 
appointment00 
=00 
new00 
Appointment00 )
{11 	
	PatientId22 
=22 
dto22 
.22 
	PatientId22 %
,22% &
DoctorId33 
=33 
dto33 
.33 
DoctorId33 #
,33# $
AppointmentDate44 
=44 
dto44 !
.44! "
AppointmentDate44" 1
,441 2
AppointmentTime55 
=55 
dto55 !
.55! "
AppointmentTime55" 1
,551 2
Status66 
=66 
AppointmentStatus66 &
.66& '
Pending66' .
}77 	
;77	 

var99 
createdAppointment99 
=99  
await99! &!
appointmentRepository99' <
.99< =
AddAsync99= E
(99E F
appointment99F Q
)99Q R
;99R S
var;; "
appointmentWithDetails;; "
=;;# $
await;;% *!
appointmentRepository;;+ @
.;;@ A.
"GetAppointmentByIdWithDetailsAsync;;A c
(;;c d
createdAppointment;;d v
.;;v w
Id;;w y
);;y z
;;;z {
return== "
appointmentWithDetails== %
====& (
null==) -
?>> 
throw>> 
new>> 
NotFoundException>> )
(>>) *
ErrorMessages>>* 7
.>>7 8,
 AppointmentNotFoundAfterCreation>>8 X
)>>X Y
:?? 
mapper?? 
.?? 
Map?? 
<?? 
AppointmentDto?? '
>??' (
(??( )"
appointmentWithDetails??) ?
)??? @
;??@ A
}@@ 
publicBB 

asyncBB 
TaskBB 
<BB 
PagedResultDtoBB $
<BB$ %
AppointmentDtoBB% 3
>BB3 4
>BB4 5*
GetAppointmentsByDoctorIdAsyncBB6 T
(BBT U
intCC 
doctorIdCC 
,CC 
PaginationQueryDtoDD 

paginationDD %
)DD% &
{EE 
awaitFF 5
)AutoCancelExpiredPendingAppointmentsAsyncFF 7
(FF7 8
)FF8 9
;FF9 :
varHH 
appointmentsHH 
=HH 
awaitHH  !
appointmentRepositoryHH! 6
.HH6 7*
GetAppointmentsByDoctorIdAsyncHH7 U
(HHU V
doctorIdII 
,II 

paginationJJ 
.JJ 

PageNumberJJ !
,JJ! "

paginationKK 
.KK 
PageSizeKK 
)KK  
;KK  !
returnMM 
MapPagedResultMM 
<MM 
AppointmentMM )
,MM) *
AppointmentDtoMM+ 9
>MM9 :
(MM: ;
appointmentsMM; G
)MMG H
;MMH I
}NN 
publicPP 

asyncPP 
TaskPP 
<PP 
PagedResultDtoPP $
<PP$ %
AppointmentDtoPP% 3
>PP3 4
>PP4 5+
GetAppointmentsByPatientIdAsyncPP6 U
(PPU V
intQQ 
	patientIdQQ 
,QQ 
PaginationQueryDtoRR 

paginationRR %
)RR% &
{SS 
awaitTT 5
)AutoCancelExpiredPendingAppointmentsAsyncTT 7
(TT7 8
)TT8 9
;TT9 :
varVV 
appointmentsVV 
=VV 
awaitVV  !
appointmentRepositoryVV! 6
.VV6 7+
GetAppointmentsByPatientIdAsyncVV7 V
(VVV W
	patientIdWW 
,WW 

paginationXX 
.XX 

PageNumberXX !
,XX! "

paginationYY 
.YY 
PageSizeYY 
)YY  
;YY  !
return[[ 
MapPagedResult[[ 
<[[ 
Appointment[[ )
,[[) *
AppointmentDto[[+ 9
>[[9 :
([[: ;
appointments[[; G
)[[G H
;[[H I
}\\ 
public^^ 

async^^ 
Task^^ 
<^^ 
PagedResultDto^^ $
<^^$ %
AppointmentDto^^% 3
>^^3 4
>^^4 51
%GetAppointmentsByDoctorIdAndDateAsync^^6 [
(^^[ \
int__ 
doctorId__ 
,__ 
DateOnly`` 
date`` 
,`` 
PaginationQueryDtoaa 

paginationaa %
)aa% &
{bb 
awaitcc 5
)AutoCancelExpiredPendingAppointmentsAsynccc 7
(cc7 8
)cc8 9
;cc9 :
varee 
appointmentsee 
=ee 
awaitee  !
appointmentRepositoryee! 6
.ee6 71
%GetAppointmentsByDoctorIdAndDateAsyncee7 \
(ee\ ]
doctorIdff 
,ff 
dategg 
,gg 

paginationhh 
.hh 

PageNumberhh !
,hh! "

paginationii 
.ii 
PageSizeii 
)ii  
;ii  !
returnkk 
MapPagedResultkk 
<kk 
Appointmentkk )
,kk) *
AppointmentDtokk+ 9
>kk9 :
(kk: ;
appointmentskk; G
)kkG H
;kkH I
}ll 
publicnn 

asyncnn 
Tasknn 
<nn 
AppointmentDtonn $
?nn$ %
>nn% &(
UpdateAppointmentStatusAsyncnn' C
(nnC D
intoo 
idoo 
,oo &
UpdateAppointmentStatusDtopp "
dtopp# &
,pp& '
stringqq 
currentRoleqq 
,qq 
intrr 
?rr 
currentPatientIdrr 
,rr 
intss 
?ss 
currentDoctorIdss 
)ss 
{tt 
awaituu 5
)AutoCancelExpiredPendingAppointmentsAsyncuu 7
(uu7 8
)uu8 9
;uu9 :
varww 
appointmentww 
=ww 
awaitww !
appointmentRepositoryww  5
.ww5 6.
"GetAppointmentByIdWithDetailsAsyncww6 X
(wwX Y
idwwY [
)ww[ \
;ww\ ]
ifyy 

(yy 
appointmentyy 
==yy 
nullyy 
)yy  
{zz 	
throw{{ 
new{{ 
NotFoundException{{ '
({{' (
ErrorMessages{{( 5
.{{5 6
AppointmentNotFound{{6 I
){{I J
;{{J K
}|| 	
switch~~ 
(~~ 
dto~~ 
.~~ 
Status~~ 
)~~ 
{ 	
case
ÄÄ 
AppointmentStatus
ÄÄ "
.
ÄÄ" #
	Confirmed
ÄÄ# ,
:
ÄÄ, - 
ConfirmAppointment
ÅÅ "
(
ÅÅ" #
appointment
ÅÅ# .
,
ÅÅ. /
currentRole
ÅÅ0 ;
,
ÅÅ; <
currentDoctorId
ÅÅ= L
)
ÅÅL M
;
ÅÅM N
break
ÇÇ 
;
ÇÇ 
case
ÑÑ 
AppointmentStatus
ÑÑ "
.
ÑÑ" #
	Cancelled
ÑÑ# ,
:
ÑÑ, -
CancelAppointment
ÖÖ !
(
ÖÖ! "
appointment
ÖÖ" -
,
ÖÖ- .
dto
ÖÖ/ 2
,
ÖÖ2 3
currentRole
ÖÖ4 ?
,
ÖÖ? @
currentPatientId
ÖÖA Q
,
ÖÖQ R
currentDoctorId
ÖÖS b
)
ÖÖb c
;
ÖÖc d
break
ÜÜ 
;
ÜÜ 
case
àà 
AppointmentStatus
àà "
.
àà" #
	Completed
àà# ,
:
àà, -
throw
ââ 
new
ââ #
BusinessRuleException
ââ /
(
ââ/ 0
ErrorMessages
ââ0 =
.
ââ= >9
+AppointmentCompletedOnlyThroughHealthRecord
ââ> i
)
ââi j
;
ââj k
default
ãã 
:
ãã 
throw
åå 
new
åå #
BusinessRuleException
åå /
(
åå/ 0
ErrorMessages
åå0 =
.
åå= >4
&UnsupportedAppointmentStatusTransition
åå> d
)
ååd e
;
ååe f
}
çç 	
await
èè #
appointmentRepository
èè #
.
èè# $
UpdateAsync
èè$ /
(
èè/ 0
appointment
èè0 ;
)
èè; <
;
èè< =
var
ëë $
appointmentWithDetails
ëë "
=
ëë# $
await
ëë% *#
appointmentRepository
ëë+ @
.
ëë@ A0
"GetAppointmentByIdWithDetailsAsync
ëëA c
(
ëëc d
id
ëëd f
)
ëëf g
;
ëëg h
return
ìì $
appointmentWithDetails
ìì %
==
ìì& (
null
ìì) -
?
îî 
throw
îî 
new
îî 
NotFoundException
îî )
(
îî) *
ErrorMessages
îî* 7
.
îî7 8!
AppointmentNotFound
îî8 K
)
îîK L
:
ïï 
mapper
ïï 
.
ïï 
Map
ïï 
<
ïï 
AppointmentDto
ïï '
>
ïï' (
(
ïï( )$
appointmentWithDetails
ïï) ?
)
ïï? @
;
ïï@ A
}
ññ 
public
òò 

async
òò 
Task
òò 
<
òò 
AppointmentDto
òò $
?
òò$ %
>
òò% &$
DeleteAppointmentAsync
òò' =
(
òò= >
int
òò> A
id
òòB D
)
òòD E
{
ôô 
var
öö 
appointment
öö 
=
öö 
await
öö #
appointmentRepository
öö  5
.
öö5 60
"GetAppointmentByIdWithDetailsAsync
öö6 X
(
ööX Y
id
ööY [
)
öö[ \
;
öö\ ]
if
úú 

(
úú 
appointment
úú 
==
úú 
null
úú 
)
úú  
{
ùù 	
throw
ûû 
new
ûû 
NotFoundException
ûû '
(
ûû' (
ErrorMessages
ûû( 5
.
ûû5 6!
AppointmentNotFound
ûû6 I
)
ûûI J
;
ûûJ K
}
üü 	
if
°° 

(
°° 
appointment
°° 
.
°° 
HealthRecord
°° $
!=
°°% '
null
°°( ,
)
°°, -
{
¢¢ 	
throw
££ 
new
££ #
BusinessRuleException
££ +
(
££+ ,
ErrorMessages
££, 9
.
££9 :A
3AppointmentCannotBeDeletedBecauseHealthRecordExists
££: m
)
££m n
;
££n o
}
§§ 	
var
¶¶  
deletedAppointment
¶¶ 
=
¶¶  
await
¶¶! &#
appointmentRepository
¶¶' <
.
¶¶< =$
DeleteAppointmentAsync
¶¶= S
(
¶¶S T
id
¶¶T V
)
¶¶V W
;
¶¶W X
return
®®  
deletedAppointment
®® !
==
®®" $
null
®®% )
?
©© 
throw
©© 
new
©© 
NotFoundException
©© )
(
©©) *
ErrorMessages
©©* 7
.
©©7 8!
AppointmentNotFound
©©8 K
)
©©K L
:
™™ 
mapper
™™ 
.
™™ 
Map
™™ 
<
™™ 
AppointmentDto
™™ '
>
™™' (
(
™™( ) 
deletedAppointment
™™) ;
)
™™; <
;
™™< =
}
´´ 
public
≠≠ 

async
≠≠ 
Task
≠≠ 
<
≠≠ 
List
≠≠ 
<
≠≠ "
AppointmentReportDto
≠≠ /
>
≠≠/ 0
>
≠≠0 1(
GetAppointmentReportsAsync
≠≠2 L
(
≠≠L M
)
≠≠M N
{
ÆÆ 
await
ØØ 7
)AutoCancelExpiredPendingAppointmentsAsync
ØØ 7
(
ØØ7 8
)
ØØ8 9
;
ØØ9 :
var
±± 
appointments
±± 
=
±± 
await
±±  #
appointmentRepository
±±! 6
.
±±6 7
GetAllAsync
±±7 B
(
±±B C
)
±±C D
;
±±D E
return
≥≥ 
appointments
≥≥ 
.
¥¥ 
GroupBy
¥¥ 
(
¥¥ 
appointment
¥¥  
=>
¥¥! #
appointment
¥¥$ /
.
¥¥/ 0
AppointmentDate
¥¥0 ?
)
¥¥? @
.
µµ 
Select
µµ 
(
µµ 
group
µµ 
=>
µµ 
new
µµ  "
AppointmentReportDto
µµ! 5
{
∂∂ 
Date
∑∑ 
=
∑∑ 
group
∑∑ 
.
∑∑ 
Key
∑∑  
,
∑∑  !
ConfirmedCount
∏∏ 
=
∏∏  
group
∏∏! &
.
∏∏& '
Count
∏∏' ,
(
∏∏, -
appointment
∏∏- 8
=>
∏∏9 ;
appointment
∏∏< G
.
∏∏G H
Status
∏∏H N
==
∏∏O Q
AppointmentStatus
∏∏R c
.
∏∏c d
	Confirmed
∏∏d m
)
∏∏m n
,
∏∏n o
CancelledCount
ππ 
=
ππ  
group
ππ! &
.
ππ& '
Count
ππ' ,
(
ππ, -
appointment
ππ- 8
=>
ππ9 ;
appointment
ππ< G
.
ππG H
Status
ππH N
==
ππO Q
AppointmentStatus
ππR c
.
ππc d
	Cancelled
ππd m
)
ππm n
,
ππn o
CompletedCount
∫∫ 
=
∫∫  
group
∫∫! &
.
∫∫& '
Count
∫∫' ,
(
∫∫, -
appointment
∫∫- 8
=>
∫∫9 ;
appointment
∫∫< G
.
∫∫G H
Status
∫∫H N
==
∫∫O Q
AppointmentStatus
∫∫R c
.
∫∫c d
	Completed
∫∫d m
)
∫∫m n
,
∫∫n o
PendingCount
ªª 
=
ªª 
group
ªª $
.
ªª$ %
Count
ªª% *
(
ªª* +
appointment
ªª+ 6
=>
ªª7 9
appointment
ªª: E
.
ªªE F
Status
ªªF L
==
ªªM O
AppointmentStatus
ªªP a
.
ªªa b
Pending
ªªb i
)
ªªi j
,
ªªj k

TotalCount
ºº 
=
ºº 
group
ºº "
.
ºº" #
Count
ºº# (
(
ºº( )
)
ºº) *
}
ΩΩ 
)
ΩΩ 
.
ææ 
OrderBy
ææ 
(
ææ 
report
ææ 
=>
ææ 
report
ææ %
.
ææ% &
Date
ææ& *
)
ææ* +
.
øø 
ToList
øø 
(
øø 
)
øø 
;
øø 
}
¿¿ 
private
¬¬ 
async
¬¬ 
Task
¬¬ 2
$ValidateAppointmentCanBeCreatedAsync
¬¬ ;
(
¬¬; <"
CreateAppointmentDto
¬¬< P
dto
¬¬Q T
)
¬¬T U
{
√√ 
var
ƒƒ 
patient
ƒƒ 
=
ƒƒ 
await
ƒƒ 
patientRepository
ƒƒ -
.
ƒƒ- .
GetByIdAsync
ƒƒ. :
(
ƒƒ: ;
dto
ƒƒ; >
.
ƒƒ> ?
	PatientId
ƒƒ? H
)
ƒƒH I
;
ƒƒI J
if
∆∆ 

(
∆∆ 
patient
∆∆ 
==
∆∆ 
null
∆∆ 
)
∆∆ 
{
«« 	
throw
»» 
new
»» 
NotFoundException
»» '
(
»»' (
ErrorMessages
»»( 5
.
»»5 6
PatientNotFound
»»6 E
)
»»E F
;
»»F G
}
…… 	
var
ÀÀ 
doctor
ÀÀ 
=
ÀÀ 
await
ÀÀ 
doctorRepository
ÀÀ +
.
ÀÀ+ , 
GetDoctorByIdAsync
ÀÀ, >
(
ÀÀ> ?
dto
ÀÀ? B
.
ÀÀB C
DoctorId
ÀÀC K
)
ÀÀK L
;
ÀÀL M
if
ÕÕ 

(
ÕÕ 
doctor
ÕÕ 
==
ÕÕ 
null
ÕÕ 
)
ÕÕ 
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
DoctorNotFound
œœ6 D
)
œœD E
;
œœE F
}
–– 	
if
““ 

(
““ 
!
““ 
doctor
““ 
.
““ 
IsAvailable
““ 
)
““  
{
”” 	
throw
‘‘ 
new
‘‘ #
BusinessRuleException
‘‘ +
(
‘‘+ ,
ErrorMessages
‘‘, 9
.
‘‘9 :
DoctorUnavailable
‘‘: K
)
‘‘K L
;
‘‘L M
}
’’ 	
if
◊◊ 

(
◊◊ 
!
◊◊ #
IsAtLeast24HoursAhead
◊◊ "
(
◊◊" #
dto
◊◊# &
.
◊◊& '
AppointmentDate
◊◊' 6
,
◊◊6 7
dto
◊◊8 ;
.
◊◊; <
AppointmentTime
◊◊< K
)
◊◊K L
)
◊◊L M
{
ÿÿ 	
throw
ŸŸ 
new
ŸŸ #
BusinessRuleException
ŸŸ +
(
ŸŸ+ ,
ErrorMessages
ŸŸ, 9
.
ŸŸ9 :8
*AppointmentMustBeBookedAtLeast24HoursAhead
ŸŸ: d
)
ŸŸd e
;
ŸŸe f
}
⁄⁄ 	
if
‹‹ 

(
‹‹ 
await
‹‹ #
appointmentRepository
‹‹ '
.
‹‹' (5
'DoctorHasNonCancelledAppointmentAtAsync
‹‹( O
(
‹‹O P
dto
›› 
.
›› 
DoctorId
›› 
,
›› 
dto
ﬁﬁ 
.
ﬁﬁ 
AppointmentDate
ﬁﬁ #
,
ﬁﬁ# $
dto
ﬂﬂ 
.
ﬂﬂ 
AppointmentTime
ﬂﬂ #
)
ﬂﬂ# $
)
ﬂﬂ$ %
{
‡‡ 	
throw
·· 
new
·· 
ConflictException
·· '
(
··' (
ErrorMessages
··( 5
.
··5 6%
DoctorSlotAlreadyBooked
··6 M
)
··M N
;
··N O
}
‚‚ 	
if
‰‰ 

(
‰‰ 
await
‰‰ #
appointmentRepository
‰‰ '
.
‰‰' (6
(PatientHasNonCancelledAppointmentAtAsync
‰‰( P
(
‰‰P Q
dto
ÂÂ 
.
ÂÂ 
	PatientId
ÂÂ 
,
ÂÂ 
dto
ÊÊ 
.
ÊÊ 
AppointmentDate
ÊÊ #
,
ÊÊ# $
dto
ÁÁ 
.
ÁÁ 
AppointmentTime
ÁÁ #
)
ÁÁ# $
)
ÁÁ$ %
{
ËË 	
throw
ÈÈ 
new
ÈÈ 
ConflictException
ÈÈ '
(
ÈÈ' (
ErrorMessages
ÈÈ( 5
.
ÈÈ5 6&
PatientSlotAlreadyBooked
ÈÈ6 N
)
ÈÈN O
;
ÈÈO P
}
ÍÍ 	
if
ÏÏ 

(
ÏÏ 
await
ÏÏ #
appointmentRepository
ÏÏ '
.
ÏÏ' (D
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsync
ÏÏ( ^
(
ÏÏ^ _
dto
ÌÌ 
.
ÌÌ 
	PatientId
ÌÌ 
,
ÌÌ 
dto
ÓÓ 
.
ÓÓ 
DoctorId
ÓÓ 
,
ÓÓ 
dto
ÔÔ 
.
ÔÔ 
AppointmentDate
ÔÔ #
)
ÔÔ# $
)
ÔÔ$ %
{
 	
throw
ÒÒ 
new
ÒÒ 
ConflictException
ÒÒ '
(
ÒÒ' (
ErrorMessages
ÒÒ( 5
.
ÒÒ5 6:
,PatientAlreadyHasAppointmentWithDoctorOnDate
ÒÒ6 b
)
ÒÒb c
;
ÒÒc d
}
ÚÚ 	
}
ÛÛ 
private
ıı 
static
ıı 
void
ıı  
ConfirmAppointment
ıı *
(
ıı* +
Appointment
ıı+ 6
appointment
ıı7 B
,
ııB C
string
ııD J
currentRole
ııK V
,
ııV W
int
ııX [
?
ıı[ \
currentDoctorId
ıı] l
)
ııl m
{
ˆˆ 
if
˜˜ 

(
˜˜ 
appointment
˜˜ 
.
˜˜ 
Status
˜˜ 
!=
˜˜ !
AppointmentStatus
˜˜" 3
.
˜˜3 4
Pending
˜˜4 ;
)
˜˜; <
{
¯¯ 	
throw
˘˘ 
new
˘˘ #
BusinessRuleException
˘˘ +
(
˘˘+ ,
ErrorMessages
˘˘, 9
.
˘˘9 :3
%OnlyPendingAppointmentsCanBeConfirmed
˘˘: _
)
˘˘_ `
;
˘˘` a
}
˙˙ 	
if
¸¸ 

(
¸¸ 
currentRole
¸¸ 
==
¸¸ 
AppRoles
¸¸ #
.
¸¸# $
Patient
¸¸$ +
)
¸¸+ ,
{
˝˝ 	
throw
˛˛ 
new
˛˛  
ForbiddenException
˛˛ (
(
˛˛( )
ErrorMessages
˛˛) 6
.
˛˛6 74
&UnsupportedAppointmentStatusTransition
˛˛7 ]
)
˛˛] ^
;
˛˛^ _
}
ˇˇ 	
if
ÅÅ 

(
ÅÅ 
currentRole
ÅÅ 
==
ÅÅ 
AppRoles
ÅÅ #
.
ÅÅ# $
Doctor
ÅÅ$ *
&&
ÅÅ+ -
currentDoctorId
ÅÅ. =
!=
ÅÅ> @
appointment
ÅÅA L
.
ÅÅL M
DoctorId
ÅÅM U
)
ÅÅU V
{
ÇÇ 	
throw
ÉÉ 
new
ÉÉ  
ForbiddenException
ÉÉ (
(
ÉÉ( )
ErrorMessages
ÉÉ) 6
.
ÉÉ6 71
#DoctorsCanManageOnlyOwnAppointments
ÉÉ7 Z
)
ÉÉZ [
;
ÉÉ[ \
}
ÑÑ 	
appointment
ÜÜ 
.
ÜÜ 
Status
ÜÜ 
=
ÜÜ 
AppointmentStatus
ÜÜ .
.
ÜÜ. /
	Confirmed
ÜÜ/ 8
;
ÜÜ8 9
appointment
áá 
.
áá  
CancellationReason
áá &
=
áá' (
null
áá) -
;
áá- .
}
àà 
private
ää 
static
ää 
void
ää 
CancelAppointment
ää )
(
ää) *
Appointment
ãã 
appointment
ãã 
,
ãã  (
UpdateAppointmentStatusDto
åå "
dto
åå# &
,
åå& '
string
çç 
currentRole
çç 
,
çç 
int
éé 
?
éé 
currentPatientId
éé 
,
éé 
int
èè 
?
èè 
currentDoctorId
èè 
)
èè 
{
êê 
if
ëë 

(
ëë 
string
ëë 
.
ëë  
IsNullOrWhiteSpace
ëë %
(
ëë% &
dto
ëë& )
.
ëë) * 
CancellationReason
ëë* <
)
ëë< =
)
ëë= >
{
íí 	
throw
ìì 
new
ìì #
BusinessRuleException
ìì +
(
ìì+ ,
ErrorMessages
ìì, 9
.
ìì9 :(
CancellationReasonRequired
ìì: T
)
ììT U
;
ììU V
}
îî 	
if
ññ 

(
ññ 
appointment
ññ 
.
ññ 
Status
ññ 
==
ññ !
AppointmentStatus
ññ" 3
.
ññ3 4
	Completed
ññ4 =
)
ññ= >
{
óó 	
throw
òò 
new
òò #
BusinessRuleException
òò +
(
òò+ ,
ErrorMessages
òò, 9
.
òò9 :4
&CompletedAppointmentsCannotBeCancelled
òò: `
)
òò` a
;
òòa b
}
ôô 	
if
õõ 

(
õõ 
appointment
õõ 
.
õõ 
Status
õõ 
==
õõ !
AppointmentStatus
õõ" 3
.
õõ3 4
	Cancelled
õõ4 =
)
õõ= >
{
úú 	
throw
ùù 
new
ùù #
BusinessRuleException
ùù +
(
ùù+ ,
ErrorMessages
ùù, 9
.
ùù9 :9
+CancelledAppointmentsCannotBeCancelledAgain
ùù: e
)
ùùe f
;
ùùf g
}
ûû 	
var
†† 
reason
†† 
=
†† 
dto
†† 
.
††  
CancellationReason
†† +
.
††+ ,
Trim
††, 0
(
††0 1
)
††1 2
;
††2 3
if
¢¢ 

(
¢¢ 
currentRole
¢¢ 
==
¢¢ 
AppRoles
¢¢ #
.
¢¢# $
Patient
¢¢$ +
)
¢¢+ ,
{
££ 	
if
§§ 
(
§§ 
currentPatientId
§§  
!=
§§! #
appointment
§§$ /
.
§§/ 0
	PatientId
§§0 9
)
§§9 :
{
•• 
throw
¶¶ 
new
¶¶  
ForbiddenException
¶¶ ,
(
¶¶, -
ErrorMessages
¶¶- :
.
¶¶: ;2
$PatientsCanManageOnlyOwnAppointments
¶¶; _
)
¶¶_ `
;
¶¶` a
}
ßß 
if
©© 
(
©© 
!
©© #
IsAtLeast24HoursAhead
©© &
(
©©& '
appointment
©©' 2
.
©©2 3
AppointmentDate
©©3 B
,
©©B C
appointment
©©D O
.
©©O P
AppointmentTime
©©P _
)
©©_ `
)
©©` a
{
™™ 
throw
´´ 
new
´´ #
BusinessRuleException
´´ /
(
´´/ 0
ErrorMessages
´´0 =
.
´´= >7
)AppointmentCannotBeCancelledWithin24Hours
´´> g
)
´´g h
;
´´h i
}
¨¨ 
appointment
ÆÆ 
.
ÆÆ  
CancellationReason
ÆÆ *
=
ÆÆ+ ,
reason
ÆÆ- 3
+
ÆÆ4 5
ErrorMessages
ÆÆ6 C
.
ÆÆC D&
CancelledByPatientSuffix
ÆÆD \
;
ÆÆ\ ]
}
ØØ 	
else
∞∞ 
if
∞∞ 
(
∞∞ 
currentRole
∞∞ 
==
∞∞ 
AppRoles
∞∞  (
.
∞∞( )
Doctor
∞∞) /
)
∞∞/ 0
{
±± 	
if
≤≤ 
(
≤≤ 
currentDoctorId
≤≤ 
!=
≤≤  "
appointment
≤≤# .
.
≤≤. /
DoctorId
≤≤/ 7
)
≤≤7 8
{
≥≥ 
throw
¥¥ 
new
¥¥  
ForbiddenException
¥¥ ,
(
¥¥, -
ErrorMessages
¥¥- :
.
¥¥: ;1
#DoctorsCanManageOnlyOwnAppointments
¥¥; ^
)
¥¥^ _
;
¥¥_ `
}
µµ 
if
∑∑ 
(
∑∑ 
!
∑∑ #
IsAtLeast24HoursAhead
∑∑ &
(
∑∑& '
appointment
∑∑' 2
.
∑∑2 3
AppointmentDate
∑∑3 B
,
∑∑B C
appointment
∑∑D O
.
∑∑O P
AppointmentTime
∑∑P _
)
∑∑_ `
)
∑∑` a
{
∏∏ 
throw
ππ 
new
ππ #
BusinessRuleException
ππ /
(
ππ/ 0
ErrorMessages
ππ0 =
.
ππ= >7
)AppointmentCannotBeCancelledWithin24Hours
ππ> g
)
ππg h
;
ππh i
}
∫∫ 
appointment
ºº 
.
ºº  
CancellationReason
ºº *
=
ºº+ ,
reason
ºº- 3
+
ºº4 5
ErrorMessages
ºº6 C
.
ººC D%
CancelledByDoctorSuffix
ººD [
;
ºº[ \
}
ΩΩ 	
else
ææ 
if
ææ 
(
ææ 
currentRole
ææ 
==
ææ 
AppRoles
ææ  (
.
ææ( )
Admin
ææ) .
)
ææ. /
{
øø 	
appointment
¿¿ 
.
¿¿  
CancellationReason
¿¿ *
=
¿¿+ ,
reason
¿¿- 3
+
¿¿4 5
ErrorMessages
¿¿6 C
.
¿¿C D$
CancelledByAdminSuffix
¿¿D Z
;
¿¿Z [
}
¡¡ 	
else
¬¬ 
{
√√ 	
throw
ƒƒ 
new
ƒƒ  
ForbiddenException
ƒƒ (
(
ƒƒ( )
ErrorMessages
ƒƒ) 6
.
ƒƒ6 74
&UnsupportedAppointmentStatusTransition
ƒƒ7 ]
)
ƒƒ] ^
;
ƒƒ^ _
}
≈≈ 	
appointment
«« 
.
«« 
Status
«« 
=
«« 
AppointmentStatus
«« .
.
««. /
	Cancelled
««/ 8
;
««8 9
}
»» 
private
   
async
   
Task
   7
)AutoCancelExpiredPendingAppointmentsAsync
   @
(
  @ A
)
  A B
{
ÀÀ 
var
ÃÃ !
pendingAppointments
ÃÃ 
=
ÃÃ  !
await
ÃÃ" '#
appointmentRepository
ÃÃ( =
.
ÃÃ= >)
GetPendingAppointmentsAsync
ÃÃ> Y
(
ÃÃY Z
)
ÃÃZ [
;
ÃÃ[ \
foreach
ŒŒ 
(
ŒŒ 
var
ŒŒ 
appointment
ŒŒ  
in
ŒŒ! #!
pendingAppointments
ŒŒ$ 7
)
ŒŒ7 8
{
œœ 	
if
–– 
(
–– #
IsAtLeast24HoursAhead
–– %
(
––% &
appointment
––& 1
.
––1 2
AppointmentDate
––2 A
,
––A B
appointment
––C N
.
––N O
AppointmentTime
––O ^
)
––^ _
)
––_ `
{
—— 
continue
““ 
;
““ 
}
”” 
appointment
’’ 
.
’’ 
Status
’’ 
=
’’  
AppointmentStatus
’’! 2
.
’’2 3
	Cancelled
’’3 <
;
’’< =
appointment
÷÷ 
.
÷÷  
CancellationReason
÷÷ *
=
÷÷+ ,
ErrorMessages
÷÷- :
.
÷÷: ;3
%PendingAppointmentAutoCancelledReason
÷÷; `
;
÷÷` a
await
ÿÿ #
appointmentRepository
ÿÿ '
.
ÿÿ' (
UpdateAsync
ÿÿ( 3
(
ÿÿ3 4
appointment
ÿÿ4 ?
)
ÿÿ? @
;
ÿÿ@ A
}
ŸŸ 	
}
⁄⁄ 
private
‹‹ 
static
‹‹ 
bool
‹‹ #
IsAtLeast24HoursAhead
‹‹ -
(
‹‹- .
DateOnly
‹‹. 6
date
‹‹7 ;
,
‹‹; <
TimeOnly
‹‹= E
time
‹‹F J
)
‹‹J K
{
›› 
var
ﬁﬁ 
scheduledAt
ﬁﬁ 
=
ﬁﬁ 
date
ﬁﬁ 
.
ﬁﬁ 

ToDateTime
ﬁﬁ )
(
ﬁﬁ) *
time
ﬁﬁ* .
)
ﬁﬁ. /
;
ﬁﬁ/ 0
return
‡‡ 
scheduledAt
‡‡ 
>=
‡‡ 
DateTime
‡‡ &
.
‡‡& '
Now
‡‡' *
.
‡‡* +
AddHours
‡‡+ 3
(
‡‡3 4+
MinimumHoursBeforeAppointment
‡‡4 Q
)
‡‡Q R
;
‡‡R S
}
·· 
private
„„ 
PagedResultDto
„„ 
<
„„ 
TDestination
„„ '
>
„„' (
MapPagedResult
„„) 7
<
„„7 8
TSource
„„8 ?
,
„„? @
TDestination
„„A M
>
„„M N
(
„„N O
PagedResult
„„O Z
<
„„Z [
TSource
„„[ b
>
„„b c
pagedResult
„„d o
)
„„o p
{
‰‰ 
return
ÂÂ 
new
ÂÂ 
PagedResultDto
ÂÂ !
<
ÂÂ! "
TDestination
ÂÂ" .
>
ÂÂ. /
{
ÊÊ 	
Items
ÁÁ 
=
ÁÁ 
mapper
ÁÁ 
.
ÁÁ 
Map
ÁÁ 
<
ÁÁ 
List
ÁÁ #
<
ÁÁ# $
TDestination
ÁÁ$ 0
>
ÁÁ0 1
>
ÁÁ1 2
(
ÁÁ2 3
pagedResult
ÁÁ3 >
.
ÁÁ> ?
Items
ÁÁ? D
)
ÁÁD E
,
ÁÁE F

PageNumber
ËË 
=
ËË 
pagedResult
ËË $
.
ËË$ %

PageNumber
ËË% /
,
ËË/ 0
PageSize
ÈÈ 
=
ÈÈ 
pagedResult
ÈÈ "
.
ÈÈ" #
PageSize
ÈÈ# +
,
ÈÈ+ ,

TotalCount
ÍÍ 
=
ÍÍ 
pagedResult
ÍÍ $
.
ÍÍ$ %

TotalCount
ÍÍ% /
,
ÍÍ/ 0

TotalPages
ÎÎ 
=
ÎÎ 
pagedResult
ÎÎ $
.
ÎÎ$ %

TotalPages
ÎÎ% /
}
ÏÏ 	
;
ÏÏ	 

}
ÌÌ 
}ÓÓ ÷|
TC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\Impl\AdminService.cs
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
class 
AdminService 
( 
HealthAxisDbContext 
context 
,  
IDoctorRepository 
doctorRepository &
,& '
IAppointmentService 
appointmentService *
,* +
IMapper 
mapper 
, 
UserManager 
< 
IdentityUser 
> 
userManager )
)) *
:+ ,
IAdminService- :
{ 
public 

async 
Task 
< 
PagedResultDto $
<$ %
	DoctorDto% .
>. /
>/ 0
GetDoctorsAsync1 @
(@ A
PaginationQueryDtoA S

paginationT ^
)^ _
{ 
var 
doctors 
= 
await 
doctorRepository ,
., -&
GetAllDoctorsWithUserAsync- G
(G H

pagination 
. 

PageNumber !
,! "

pagination 
. 
PageSize 
)  
;  !
return 
MapPagedResult 
< 
Doctor $
,$ %
	DoctorDto& /
>/ 0
(0 1
doctors1 8
)8 9
;9 :
} 
public 

async 
Task 
< 
	DoctorDto 
?  
>  !
CreateDoctorAsync" 3
(3 4
CreateDoctorDto4 C
dtoD G
)G H
{ 
var 
existingUser 
= 
await  
userManager! ,
., -
FindByEmailAsync- =
(= >
dto> A
.A B
EmailB G
)G H
;H I
if!! 

(!! 
existingUser!! 
!=!! 
null!!  
)!!  !
{"" 	
throw## 
new## 
ConflictException## '
(##' (
ErrorMessages##( 5
.##5 6
EmailAlreadyExists##6 H
)##H I
;##I J
}$$ 	
await&& 
using&& 
var&& 
transaction&& #
=&&$ %
await&&& +
context&&, 3
.&&3 4
Database&&4 <
.&&< =!
BeginTransactionAsync&&= R
(&&R S
)&&S T
;&&T U
try(( 
{)) 	
var** 
user** 
=** 
new** 
IdentityUser** '
{++ 
UserName,, 
=,, 
dto,, 
.,, 
Email,, $
,,,$ %
Email-- 
=-- 
dto-- 
.-- 
Email-- !
,--! "
PhoneNumber.. 
=.. 
dto.. !
...! "
PhoneNumber.." -
,..- .
EmailConfirmed// 
=//  
true//! %
}00 
;00 
var22 
createUserResult22  
=22! "
await22# (
userManager22) 4
.224 5
CreateAsync225 @
(22@ A
user22A E
,22E F
dto22G J
.22J K
Password22K S
)22S T
;22T U
if44 
(44 
!44 
createUserResult44 !
.44! "
	Succeeded44" +
)44+ ,
{55 
var66 
errors66 
=66 
string66 #
.66# $
Join66$ (
(66( )
$str66) ,
,66, -
createUserResult66. >
.66> ?
Errors66? E
.66E F
Select66F L
(66L M
error66M R
=>66S U
error66V [
.66[ \
Description66\ g
)66g h
)66h i
;66i j
throw77 
new77 
BadRequestException77 -
(77- .
errors77. 4
)774 5
;775 6
}88 
var:: 
addRoleResult:: 
=:: 
await::  %
userManager::& 1
.::1 2
AddToRoleAsync::2 @
(::@ A
user::A E
,::E F
AppRoles::G O
.::O P
Doctor::P V
)::V W
;::W X
if<< 
(<< 
!<< 
addRoleResult<< 
.<< 
	Succeeded<< (
)<<( )
{== 
var>> 
errors>> 
=>> 
string>> #
.>># $
Join>>$ (
(>>( )
$str>>) ,
,>>, -
addRoleResult>>. ;
.>>; <
Errors>>< B
.>>B C
Select>>C I
(>>I J
error>>J O
=>>>P R
error>>S X
.>>X Y
Description>>Y d
)>>d e
)>>e f
;>>f g
throw?? 
new?? 
BadRequestException?? -
(??- .
errors??. 4
)??4 5
;??5 6
}@@ 
varBB 
doctorBB 
=BB 
newBB 
DoctorBB #
{CC 
UserIdDD 
=DD 
userDD 
.DD 
IdDD  
,DD  !
FullNameEE 
=EE 
dtoEE 
.EE 
FullNameEE '
,EE' (
SpecialisationFF 
=FF  
dtoFF! $
.FF$ %
SpecialisationFF% 3
,FF3 4
PracticeStartDateGG !
=GG" #
dtoGG$ '
.GG' (
PracticeStartDateGG( 9
,GG9 :
ConsultationFeeHH 
=HH  !
dtoHH" %
.HH% &
ConsultationFeeHH& 5
,HH5 6
IsAvailableII 
=II 
dtoII !
.II! "
IsAvailableII" -
}JJ 
;JJ 
varLL 
createdDoctorLL 
=LL 
awaitLL  %
doctorRepositoryLL& 6
.LL6 7
AddAsyncLL7 ?
(LL? @
doctorLL@ F
)LLF G
;LLG H
awaitNN 
transactionNN 
.NN 
CommitAsyncNN )
(NN) *
)NN* +
;NN+ ,
varPP 
doctorWithUserPP 
=PP  
awaitPP! &
doctorRepositoryPP' 7
.PP7 8&
GetDoctorByIdWithUserAsyncPP8 R
(PPR S
createdDoctorPPS `
.PP` a
IdPPa c
)PPc d
;PPd e
returnRR 
doctorWithUserRR !
==RR" $
nullRR% )
?SS 
throwSS 
newSS 
NotFoundExceptionSS -
(SS- .
ErrorMessagesSS. ;
.SS; <'
DoctorNotFoundAfterCreationSS< W
)SSW X
:TT 
mapperTT 
.TT 
MapTT 
<TT 
	DoctorDtoTT &
>TT& '
(TT' (
doctorWithUserTT( 6
)TT6 7
;TT7 8
}UU 	
catchVV 
{WW 	
awaitXX 
transactionXX 
.XX 
RollbackAsyncXX +
(XX+ ,
)XX, -
;XX- .
throwYY 
;YY 
}ZZ 	
}[[ 
public]] 

async]] 
Task]] 
<]] 
	DoctorDto]] 
?]]  
>]]  !
UpdateDoctorAsync]]" 3
(]]3 4
int]]4 7
id]]8 :
,]]: ;
UpdateDoctorDto]]< K
dto]]L O
)]]O P
{^^ 
var__ 
doctor__ 
=__ 
await__ 
doctorRepository__ +
.__+ ,
GetDoctorByIdAsync__, >
(__> ?
id__? A
)__A B
;__B C
ifaa 

(aa 
doctoraa 
==aa 
nullaa 
)aa 
{bb 	
throwcc 
newcc 
NotFoundExceptioncc '
(cc' (
ErrorMessagescc( 5
.cc5 6
DoctorNotFoundcc6 D
)ccD E
;ccE F
}dd 	
doctorff 
.ff 
FullNameff 
=ff 
dtoff 
.ff 
FullNameff &
;ff& '
doctorgg 
.gg 
Specialisationgg 
=gg 
dtogg  #
.gg# $
Specialisationgg$ 2
;gg2 3
doctorhh 
.hh 
PracticeStartDatehh  
=hh! "
dtohh# &
.hh& '
PracticeStartDatehh' 8
;hh8 9
doctorii 
.ii 
ConsultationFeeii 
=ii  
dtoii! $
.ii$ %
ConsultationFeeii% 4
;ii4 5
varkk 
updatedDoctorkk 
=kk 
awaitkk !
doctorRepositorykk" 2
.kk2 3
UpdateAsynckk3 >
(kk> ?
doctorkk? E
)kkE F
;kkF G
ifmm 

(mm 
updatedDoctormm 
==mm 
nullmm !
)mm! "
{nn 	
throwoo 
newoo 
NotFoundExceptionoo '
(oo' (
ErrorMessagesoo( 5
.oo5 6
DoctorNotFoundoo6 D
)ooD E
;ooE F
}pp 	
varrr 
doctorWithUserrr 
=rr 
awaitrr "
doctorRepositoryrr# 3
.rr3 4&
GetDoctorByIdWithUserAsyncrr4 N
(rrN O
updatedDoctorrrO \
.rr\ ]
Idrr] _
)rr_ `
;rr` a
returntt 
doctorWithUsertt 
==tt  
nulltt! %
?uu 
throwuu 
newuu 
NotFoundExceptionuu )
(uu) *
ErrorMessagesuu* 7
.uu7 8
DoctorNotFounduu8 F
)uuF G
:vv 
mappervv 
.vv 
Mapvv 
<vv 
	DoctorDtovv "
>vv" #
(vv# $
doctorWithUservv$ 2
)vv2 3
;vv3 4
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
await{{ 
appointmentService{{ '
.{{' (&
GetAppointmentReportsAsync{{( B
({{B C
){{C D
;{{D E
}|| 
public~~ 

async~~ 
Task~~ 
<~~ 
List~~ 
<~~ ,
 AppointmentHealthRecordReportDto~~ ;
>~~; <
>~~< =2
&GetAppointmentHealthRecordReportsAsync~~> d
(~~d e
)~~e f
{ 
return
ÄÄ 
await
ÄÄ 
context
ÄÄ 
.
ÄÄ 
Appointments
ÄÄ )
.
ÅÅ 
Include
ÅÅ 
(
ÅÅ 
appointment
ÅÅ  
=>
ÅÅ! #
appointment
ÅÅ$ /
.
ÅÅ/ 0
Patient
ÅÅ0 7
)
ÅÅ7 8
.
ÇÇ 
Include
ÇÇ 
(
ÇÇ 
appointment
ÇÇ  
=>
ÇÇ! #
appointment
ÇÇ$ /
.
ÇÇ/ 0
Doctor
ÇÇ0 6
)
ÇÇ6 7
.
ÉÉ 
Include
ÉÉ 
(
ÉÉ 
appointment
ÉÉ  
=>
ÉÉ! #
appointment
ÉÉ$ /
.
ÉÉ/ 0
HealthRecord
ÉÉ0 <
)
ÉÉ< =
.
ÑÑ 
OrderBy
ÑÑ 
(
ÑÑ 
appointment
ÑÑ  
=>
ÑÑ! #
appointment
ÑÑ$ /
.
ÑÑ/ 0
AppointmentDate
ÑÑ0 ?
)
ÑÑ? @
.
ÖÖ 
ThenBy
ÖÖ 
(
ÖÖ 
appointment
ÖÖ 
=>
ÖÖ  "
appointment
ÖÖ# .
.
ÖÖ. /
AppointmentTime
ÖÖ/ >
)
ÖÖ> ?
.
ÜÜ 
Select
ÜÜ 
(
ÜÜ 
appointment
ÜÜ 
=>
ÜÜ  "
new
ÜÜ# &.
 AppointmentHealthRecordReportDto
ÜÜ' G
{
áá 
AppointmentId
àà 
=
àà 
appointment
àà  +
.
àà+ ,
Id
àà, .
,
àà. /
	PatientId
ââ 
=
ââ 
appointment
ââ '
.
ââ' (
	PatientId
ââ( 1
,
ââ1 2
DoctorId
ää 
=
ää 
appointment
ää &
.
ää& '
DoctorId
ää' /
,
ää/ 0
PatientName
ãã 
=
ãã 
appointment
ãã )
.
ãã) *
Patient
ãã* 1
!=
ãã2 4
null
ãã5 9
?
ãã: ;
appointment
ãã< G
.
ããG H
Patient
ããH O
.
ããO P
FullName
ããP X
:
ããY Z
string
ãã[ a
.
ããa b
Empty
ããb g
,
ããg h

DoctorName
åå 
=
åå 
appointment
åå (
.
åå( )
Doctor
åå) /
!=
åå0 2
null
åå3 7
?
åå8 9
appointment
åå: E
.
ååE F
Doctor
ååF L
.
ååL M
FullName
ååM U
:
ååV W
string
ååX ^
.
åå^ _
Empty
åå_ d
,
ååd e
AppointmentDate
çç 
=
çç  !
appointment
çç" -
.
çç- .
AppointmentDate
çç. =
,
çç= >
AppointmentTime
éé 
=
éé  !
appointment
éé" -
.
éé- .
AppointmentTime
éé. =
,
éé= >
AppointmentStatus
èè !
=
èè" #
appointment
èè$ /
.
èè/ 0
Status
èè0 6
,
èè6 7
HasHealthRecord
êê 
=
êê  !
appointment
êê" -
.
êê- .
HealthRecord
êê. :
!=
êê; =
null
êê> B
,
êêB C
HealthRecordId
ëë 
=
ëë  
appointment
ëë! ,
.
ëë, -
HealthRecord
ëë- 9
!=
ëë: <
null
ëë= A
?
ëëB C
appointment
ëëD O
.
ëëO P
HealthRecord
ëëP \
.
ëë\ ]
Id
ëë] _
:
ëë` a
null
ëëb f
,
ëëf g#
HealthRecordVisitDate
íí %
=
íí& '
appointment
íí( 3
.
íí3 4
HealthRecord
íí4 @
!=
ííA C
null
ííD H
?
ííI J
appointment
ííK V
.
ííV W
HealthRecord
ííW c
.
ííc d
	VisitDate
ííd m
:
íín o
null
ííp t
}
ìì 
)
ìì 
.
îî 
ToListAsync
îî 
(
îî 
)
îî 
;
îî 
}
ïï 
private
óó 
PagedResultDto
óó 
<
óó 
TDestination
óó '
>
óó' (
MapPagedResult
óó) 7
<
óó7 8
TSource
óó8 ?
,
óó? @
TDestination
óóA M
>
óóM N
(
óóN O
PagedResult
óóO Z
<
óóZ [
TSource
óó[ b
>
óób c
pagedResult
óód o
)
óóo p
{
òò 
return
ôô 
new
ôô 
PagedResultDto
ôô !
<
ôô! "
TDestination
ôô" .
>
ôô. /
{
öö 	
Items
õõ 
=
õõ 
mapper
õõ 
.
õõ 
Map
õõ 
<
õõ 
List
õõ #
<
õõ# $
TDestination
õõ$ 0
>
õõ0 1
>
õõ1 2
(
õõ2 3
pagedResult
õõ3 >
.
õõ> ?
Items
õõ? D
)
õõD E
,
õõE F

PageNumber
úú 
=
úú 
pagedResult
úú $
.
úú$ %

PageNumber
úú% /
,
úú/ 0
PageSize
ùù 
=
ùù 
pagedResult
ùù "
.
ùù" #
PageSize
ùù# +
,
ùù+ ,

TotalCount
ûû 
=
ûû 
pagedResult
ûû $
.
ûû$ %

TotalCount
ûû% /
,
ûû/ 0

TotalPages
üü 
=
üü 
pagedResult
üü $
.
üü$ %

TotalPages
üü% /
}
†† 	
;
††	 

}
°° 
}¢¢ Ï
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
>( )7
+GetHealthRecordsByPatientIdAndDoctorIdAsync* U
(U V
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
Task 
< 	
HealthRecordDto	 
> $
GetHealthRecordByIdAsync 2
(2 3
int3 6
id7 9
)9 :
;: ;
Task 
< 	
HealthRecordDto	 
> #
CreateHealthRecordAsync 1
(1 2!
CreateHealthRecordDto2 G
dtoH K
,K L
intM P
doctorIdQ Y
)Y Z
;Z [
} ®
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IDoctorService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
;! "
public 
	interface 
IDoctorService 
{ 
Task 
< 	
PagedResultDto	 
< 
PublicDoctorDto '
>' (
>( )
GetAllDoctorsAsync* <
(< =
PaginationQueryDto= O

paginationP Z
,Z [ 
DoctorSpecialisation\ p
?p q
specialisation	r Ä
)
Ä Å
;
Å Ç
Task

 
<

 	
PublicDoctorDto

	 
?

 
>

 
GetDoctorByIdAsync

 -
(

- .
int

. 1
id

2 4
)

4 5
;

5 6
Task 
< 	
PublicDoctorDto	 
? 
> "
GetDoctorByUserIdAsync 1
(1 2
string2 8
userId9 ?
)? @
;@ A
Task 
< 	!
DoctorAvailabilityDto	 
? 
>   
GetAvailabilityAsync! 5
(5 6
int6 9
id: <
)< =
;= >
Task 
< 	!
DoctorAvailabilityDto	 
> #
UpdateAvailabilityAsync  7
(7 8
int 
id 
, '
UpdateDoctorAvailabilityDto #
dto$ '
,' (
string 
currentRole 
, 
int 
? 
currentDoctorId 
) 
; 
} ˙

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
>B C
RefreshTokenAsyncD U
(U V"
RefreshTokenRequestDtoV l
requestm t
)t u
;u v
} ´
VC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IAppointmentService.cs
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
IAppointmentService $
{ 
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (#
GetAllAppointmentsAsync) @
(@ A
PaginationQueryDtoA S

paginationT ^
)^ _
;_ `
Task		 
<		 	
AppointmentDto			 
>		 #
GetAppointmentByIdAsync		 0
(		0 1
int		1 4
id		5 7
)		7 8
;		8 9
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (+
GetAppointmentsByPatientIdAsync) H
(H I
intI L
	patientIdM V
,V W
PaginationQueryDtoX j

paginationk u
)u v
;v w
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (*
GetAppointmentsByDoctorIdAsync) G
(G H
intH K
doctorIdL T
,T U
PaginationQueryDtoV h

paginationi s
)s t
;t u
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (1
%GetAppointmentsByDoctorIdAndDateAsync) N
(N O
intO R
doctorIdS [
,[ \
DateOnly] e
datef j
,j k
PaginationQueryDtol ~

pagination	 â
)
â ä
;
ä ã
Task 
< 	
AppointmentDto	 
? 
> "
CreateAppointmentAsync 0
(0 1 
CreateAppointmentDto1 E
dtoF I
)I J
;J K
Task 
< 	
AppointmentDto	 
? 
> (
UpdateAppointmentStatusAsync 6
(6 7
int 
id 
, &
UpdateAppointmentStatusDto "
dto# &
,& '
string 
currentRole 
, 
int 
? 
currentPatientId 
, 
int 
? 
currentDoctorId 
) 
; 
Task 
< 	
AppointmentDto	 
? 
> "
DeleteAppointmentAsync 0
(0 1
int1 4
id5 7
)7 8
;8 9
Task 
< 	
List	 
<  
AppointmentReportDto "
>" #
># $&
GetAppointmentReportsAsync% ?
(? @
)@ A
;A B
}  
PC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Services\IAdminService.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Services !
;! "
public 
	interface 
IAdminService 
{ 
Task 
< 	
PagedResultDto	 
< 
	DoctorDto !
>! "
>" #
GetDoctorsAsync$ 3
(3 4
PaginationQueryDto4 F

paginationG Q
)Q R
;R S
Task		 
<		 	
	DoctorDto			 
?		 
>		 
CreateDoctorAsync		 &
(		& '
CreateDoctorDto		' 6
dto		7 :
)		: ;
;		; <
Task 
< 	
	DoctorDto	 
? 
> 
UpdateDoctorAsync &
(& '
int' *
id+ -
,- .
UpdateDoctorDto/ >
dto? B
)B C
;C D
Task 
< 	
List	 
<  
AppointmentReportDto "
>" #
># $&
GetAppointmentReportsAsync% ?
(? @
)@ A
;A B
Task 
< 	
List	 
< ,
 AppointmentHealthRecordReportDto .
>. /
>/ 02
&GetAppointmentHealthRecordReportsAsync1 W
(W X
)X Y
;Y Z
} »	
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
} ∑
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
< 	
Patient	 
? 
> '
GetPatientByIdWithUserAsync .
(. /
int/ 2
id3 5
)5 6
;6 7
Task		 
<		 	
Patient			 
?		 
>		 #
GetPatientByUserIdAsync		 *
(		* +
string		+ 1
userId		2 8
)		8 9
;		9 :
}

 ‹+
VC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\Impl\Repository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
.% &
Impl& *
;* +
public 
class 

Repository 
< 
T 
> 
: 
IRepository (
<( )
T) *
>* +
where, 1
T2 3
:4 5
class6 ;
{ 
	protected 
readonly 
HealthAxisDbContext *
_context+ 3
;3 4
	protected		 
readonly		 
DbSet		 
<		 
T		 
>		 
_dbSet		  &
;		& '
public 


Repository 
( 
HealthAxisDbContext )
context* 1
)1 2
{ 
_context 
= 
context 
; 
_dbSet 
= 
context 
. 
Set 
< 
T 
> 
(  
)  !
;! "
} 
public 

async 
Task 
< 
List 
< 
T 
> 
> 
GetAllAsync *
(* +
)+ ,
{ 
return 
await 
_dbSet 
. 
ToListAsync '
(' (
)( )
;) *
} 
public 

async 
Task 
< 
T 
? 
> 
GetByIdAsync &
(& '
int' *
id+ -
)- .
{ 
return 
await 
_dbSet 
. 
	FindAsync %
(% &
id& (
)( )
;) *
} 
public 

async 
Task 
< 
T 
> 
AddAsync !
(! "
T" #
entity$ *
)* +
{ 
await 
_dbSet 
. 
AddAsync 
( 
entity $
)$ %
;% &
await 
_context 
. 
SaveChangesAsync '
(' (
)( )
;) *
return 
entity 
; 
}   
public"" 

async"" 
Task"" 
<"" 
T"" 
?"" 
>"" 
UpdateAsync"" %
(""% &
T""& '
entity""( .
)"". /
{## 
var$$ 
exists$$ 
=$$ 
await$$ 
_dbSet$$ !
.$$! "
	FindAsync$$" +
($$+ ,
entity%% 
.%% 
GetType%% 
(%% 
)%% 
.%% 
GetProperty%% (
(%%( )
$str%%) -
)%%- .
?%%. /
.%%/ 0
GetValue%%0 8
(%%8 9
entity%%9 ?
)%%? @
)&& 	
;&&	 

if(( 

((( 
exists(( 
==(( 
null(( 
)(( 
{)) 	
return** 
null** 
;** 
}++ 	
_dbSet-- 
.-- 
Update-- 
(-- 
entity-- 
)-- 
;-- 
await.. 
_context.. 
... 
SaveChangesAsync.. '
(..' (
)..( )
;..) *
return// 
entity// 
;// 
}00 
	protected22 
static22 
async22 
Task22 
<22  
PagedResult22  +
<22+ ,
TEntity22, 3
>223 4
>224 5
ToPagedResultAsync226 H
<22H I
TEntity22I P
>22P Q
(22Q R

IQueryable33 
<33 
TEntity33 
>33 
query33 !
,33! "
int44 

pageNumber44 
,44 
int55 
pageSize55 
)55 
{66 
var77 

totalCount77 
=77 
await77 
query77 $
.77$ %

CountAsync77% /
(77/ 0
)770 1
;771 2
var99 
items99 
=99 
await99 
query99 
.:: 
Skip:: 
(:: 
(:: 

pageNumber:: 
-:: 
$num::  !
)::! "
*::# $
pageSize::% -
)::- .
.;; 
Take;; 
(;; 
pageSize;; 
);; 
.<< 
ToListAsync<< 
(<< 
)<< 
;<< 
return>> 
new>> 
PagedResult>> 
<>> 
TEntity>> &
>>>& '
{?? 	
Items@@ 
=@@ 
items@@ 
,@@ 

PageNumberAA 
=AA 

pageNumberAA #
,AA# $
PageSizeBB 
=BB 
pageSizeBB 
,BB  

TotalCountCC 
=CC 

totalCountCC #
,CC# $

TotalPagesDD 
=DD 
(DD 
intDD 
)DD 
MathDD "
.DD" #
CeilingDD# *
(DD* +

totalCountDD+ 5
/DD6 7
(DD8 9
doubleDD9 ?
)DD? @
pageSizeDD@ H
)DDH I
}EE 	
;EE	 

}FF 
}GG ˇ
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
:  

Repository! +
<+ ,
Patient, 3
>3 4
,4 5
IPatientRepository6 H
{ 
public		 

PatientRepository		 
(		 
HealthAxisDbContext		 0
context		1 8
)		8 9
:		: ;
base		< @
(		@ A
context		A H
)		H I
{

 
} 
public 

async 
Task 
< 
Patient 
? 
> '
GetPatientByIdWithUserAsync  ;
(; <
int< ?
id@ B
)B C
{ 
return 
await 
_context 
. 
Patients &
. 
Include 
( 
patient 
=> 
patient  '
.' (
User( ,
), -
. 
FirstOrDefaultAsync  
(  !
patient! (
=>) +
patient, 3
.3 4
Id4 6
==7 9
id: <
)< =
;= >
} 
public 

async 
Task 
< 
Patient 
? 
> #
GetPatientByUserIdAsync  7
(7 8
string8 >
userId? E
)E F
{ 
return 
await 
_context 
. 
Patients &
. 
FirstOrDefaultAsync  
(  !
patient! (
=>) +
patient, 3
.3 4
UserId4 :
==; =
userId> D
)D E
;E F
} 
} ”/
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
:$ %

Repository& 0
<0 1
HealthRecord1 =
>= >
,> ?#
IHealthRecordRepository@ W
{ 
public		 
"
HealthRecordRepository		 !
(		! "
HealthAxisDbContext		" 5
context		6 =
)		= >
:		? @
base		A E
(		E F
context		F M
)		M N
{

 
} 
public 

async 
Task 
< 
PagedResult !
<! "
HealthRecord" .
>. /
>/ 0,
 GetHealthRecordsByPatientIdAsync1 Q
(Q R
int 
	patientId 
, 
int 

pageNumber 
, 
int 
pageSize 
) 
{ 
var 
query 
= '
GetHealthRecordsWithDetails /
(/ 0
)0 1
. 
Where 
( 
record 
=> 
record #
.# $
Appointment$ /
!=0 2
null3 7
&&8 :
record; A
.A B
AppointmentB M
.M N
	PatientIdN W
==X Z
	patientId[ d
)d e
. 
OrderByDescending 
( 
record %
=>& (
record) /
./ 0
	VisitDate0 9
)9 :
. 
ThenByDescending 
( 
record $
=>% '
record( .
.. /
Id/ 1
)1 2
;2 3
return 
await 
ToPagedResultAsync '
(' (
query( -
,- .

pageNumber/ 9
,9 :
pageSize; C
)C D
;D E
} 
public 

async 
Task 
< 
PagedResult !
<! "
HealthRecord" .
>. /
>/ 07
+GetHealthRecordsByPatientIdAndDoctorIdAsync1 \
(\ ]
int 
	patientId 
, 
int 
doctorId 
, 
int 

pageNumber 
, 
int 
pageSize 
) 
{ 
var   
query   
=   '
GetHealthRecordsWithDetails   /
(  / 0
)  0 1
.!! 
Where!! 
(!! 
record!! 
=>!! 
record"" 
."" 
Appointment"" "
!=""# %
null""& *
&&""+ -
record## 
.## 
Appointment## "
.##" #
	PatientId### ,
==##- /
	patientId##0 9
&&##: <
record$$ 
.$$ 
Appointment$$ "
.$$" #
DoctorId$$# +
==$$, .
doctorId$$/ 7
)$$7 8
.%% 
OrderByDescending%% 
(%% 
record%% %
=>%%& (
record%%) /
.%%/ 0
	VisitDate%%0 9
)%%9 :
.&& 
ThenByDescending&& 
(&& 
record&& $
=>&&% '
record&&( .
.&&. /
Id&&/ 1
)&&1 2
;&&2 3
return(( 
await(( 
ToPagedResultAsync(( '
(((' (
query((( -
,((- .

pageNumber((/ 9
,((9 :
pageSize((; C
)((C D
;((D E
})) 
public++ 

async++ 
Task++ 
<++ 
HealthRecord++ "
?++" #
>++# $/
#GetHealthRecordByIdWithDetailsAsync++% H
(++H I
int++I L
id++M O
)++O P
{,, 
return-- 
await-- '
GetHealthRecordsWithDetails-- 0
(--0 1
)--1 2
... 
FirstOrDefaultAsync..  
(..  !
record..! '
=>..( *
record..+ 1
...1 2
Id..2 4
==..5 7
id..8 :
)..: ;
;..; <
}// 
public11 

async11 
Task11 
<11 
HealthRecord11 "
?11" #
>11# $/
#GetHealthRecordByAppointmentIdAsync11% H
(11H I
int11I L
appointmentId11M Z
)11Z [
{22 
return33 
await33 '
GetHealthRecordsWithDetails33 0
(330 1
)331 2
.44 
FirstOrDefaultAsync44  
(44  !
record44! '
=>44( *
record44+ 1
.441 2
AppointmentId442 ?
==44@ B
appointmentId44C P
)44P Q
;44Q R
}55 
private77 

IQueryable77 
<77 
HealthRecord77 #
>77# $'
GetHealthRecordsWithDetails77% @
(77@ A
)77A B
{88 
return99 
_context99 
.99 
HealthRecords99 %
.:: 
Include:: 
(:: 
record:: 
=>:: 
record:: %
.::% &
Appointment::& 1
)::1 2
.;; 
ThenInclude;; 
(;; 
appointment;; (
=>;;) +
appointment;;, 7
!;;7 8
.;;8 9
Patient;;9 @
);;@ A
.<< 
Include<< 
(<< 
record<< 
=><< 
record<< %
.<<% &
Appointment<<& 1
)<<1 2
.== 
ThenInclude== 
(== 
appointment== (
=>==) +
appointment==, 7
!==7 8
.==8 9
Doctor==9 ?
)==? @
;==@ A
}>> 
}?? »/
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
: 

Repository  *
<* +
Doctor+ 1
>1 2
,2 3
IDoctorRepository4 E
{		 
public

 

DoctorRepository

 
(

 
HealthAxisDbContext

 /
context

0 7
)

7 8
:

9 :
base

; ?
(

? @
context

@ G
)

G H
{ 
} 
public 

async 
Task 
< 
PagedResult !
<! "
Doctor" (
>( )
>) *
GetAllDoctorsAsync+ =
(= >
int 

pageNumber 
, 
int 
pageSize 
,  
DoctorSpecialisation 
? 
specialisation ,
), -
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
( 
specialisation 
. 
HasValue #
)# $
{ 	
query 
= 
query 
. 
Where 
(  
doctor  &
=>' )
doctor* 0
.0 1
Specialisation1 ?
==@ B
specialisationC Q
.Q R
ValueR W
)W X
;X Y
} 	
query 
= 
query 
. 
OrderBy 
( 
doctor $
=>% '
doctor( .
.. /
Id/ 1
)1 2
;2 3
return 
await 
ToPagedResultAsync '
(' (
query( -
,- .

pageNumber/ 9
,9 :
pageSize; C
)C D
;D E
} 
public!! 

async!! 
Task!! 
<!! 
Doctor!! 
?!! 
>!! 
GetDoctorByIdAsync!! 1
(!!1 2
int!!2 5
id!!6 8
)!!8 9
{"" 
return## 
await## 
_context## 
.## 
Doctors## %
.$$ 
FirstOrDefaultAsync$$  
($$  !
doctor$$! '
=>$$( *
doctor$$+ 1
.$$1 2
Id$$2 4
==$$5 7
id$$8 :
)$$: ;
;$$; <
}%% 
public'' 

async'' 
Task'' 
<'' 
PagedResult'' !
<''! "
Doctor''" (
>''( )
>'') *&
GetAllDoctorsWithUserAsync''+ E
(''E F
int''F I

pageNumber''J T
,''T U
int''V Y
pageSize''Z b
)''b c
{(( 
var)) 
query)) 
=)) 
_context)) 
.)) 
Doctors)) $
.** 
Include** 
(** 
doctor** 
=>** 
doctor** %
.**% &
User**& *
)*** +
.++ 
OrderBy++ 
(++ 
doctor++ 
=>++ 
doctor++ %
.++% &
Id++& (
)++( )
.,, 
AsQueryable,, 
(,, 
),, 
;,, 
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
<11 
Doctor11 
?11 
>11 &
GetDoctorByIdWithUserAsync11 9
(119 :
int11: =
id11> @
)11@ A
{22 
return33 
await33 
_context33 
.33 
Doctors33 %
.44 
Include44 
(44 
doctor44 
=>44 
doctor44 %
.44% &
User44& *
)44* +
.55 
FirstOrDefaultAsync55  
(55  !
doctor55! '
=>55( *
doctor55+ 1
.551 2
Id552 4
==555 7
id558 :
)55: ;
;55; <
}66 
public88 

async88 
Task88 
<88 
Doctor88 
?88 
>88 "
GetDoctorByUserIdAsync88 5
(885 6
string886 <
userId88= C
)88C D
{99 
return:: 
await:: 
_context:: 
.:: 
Doctors:: %
.;; 
FirstOrDefaultAsync;;  
(;;  !
doctor;;! '
=>;;( *
doctor;;+ 1
.;;1 2
UserId;;2 8
==;;9 ;
userId;;< B
);;B C
;;;C D
}<< 
public>> 

async>> 
Task>> 
<>> 
bool>> 
?>> 
>>>  
GetAvailabilityAsync>> 1
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
.AA 
WhereAA 
(AA 
doctorAA 
=>AA 
doctorAA #
.AA# $
IdAA$ &
==AA' )
idAA* ,
)AA, -
.BB 
SelectBB 
(BB 
doctorBB 
=>BB 
(BB 
boolBB #
?BB# $
)BB$ %
doctorBB% +
.BB+ ,
IsAvailableBB, 7
)BB7 8
.CC 
FirstOrDefaultAsyncCC  
(CC  !
)CC! "
;CC" #
}DD 
}EE ’v
aC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\Impl\AppointmentRepository.cs
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
class !
AppointmentRepository "
:# $

Repository% /
</ 0
Appointment0 ;
>; <
,< ="
IAppointmentRepository> T
{		 
public

 
!
AppointmentRepository

  
(

  !
HealthAxisDbContext

! 4
context

5 <
)

< =
:

> ?
base

@ D
(

D E
context

E L
)

L M
{ 
} 
public 

async 
Task 
< 
PagedResult !
<! "
Appointment" -
>- .
>. /#
GetAllAppointmentsAsync0 G
(G H
intH K

pageNumberL V
,V W
intX [
pageSize\ d
)d e
{ 
var 
query 
= &
GetAppointmentsWithDetails .
(. /
)/ 0
. 
OrderBy 
( 
appointment  
=>! #
appointment$ /
./ 0
AppointmentDate0 ?
)? @
. 
ThenBy 
( 
appointment 
=>  "
appointment# .
.. /
AppointmentTime/ >
)> ?
. 
ThenBy 
( 
appointment 
=>  "
appointment# .
.. /
Id/ 1
)1 2
;2 3
return 
await 
ToPagedResultAsync '
(' (
query( -
,- .

pageNumber/ 9
,9 :
pageSize; C
)C D
;D E
} 
public 

async 
Task 
< 
Appointment !
?! "
>" #.
"GetAppointmentByIdWithDetailsAsync$ F
(F G
intG J
appointmentIdK X
)X Y
{ 
return 
await &
GetAppointmentsWithDetails /
(/ 0
)0 1
. 
FirstOrDefaultAsync  
(  !
appointment! ,
=>- /
appointment0 ;
.; <
Id< >
==? A
appointmentIdB O
)O P
;P Q
} 
public 

async 
Task 
< 
PagedResult !
<! "
Appointment" -
>- .
>. /+
GetAppointmentsByPatientIdAsync0 O
(O P
int 
	patientId 
, 
int   

pageNumber   
,   
int!! 
pageSize!! 
)!! 
{"" 
var## 
query## 
=## &
GetAppointmentsWithDetails## .
(##. /
)##/ 0
.$$ 
Where$$ 
($$ 
appointment$$ 
=>$$ !
appointment$$" -
.$$- .
	PatientId$$. 7
==$$8 :
	patientId$$; D
)$$D E
.%% 
OrderBy%% 
(%% 
appointment%%  
=>%%! #
appointment%%$ /
.%%/ 0
AppointmentDate%%0 ?
)%%? @
.&& 
ThenBy&& 
(&& 
appointment&& 
=>&&  "
appointment&&# .
.&&. /
AppointmentTime&&/ >
)&&> ?
.'' 
ThenBy'' 
('' 
appointment'' 
=>''  "
appointment''# .
.''. /
Id''/ 1
)''1 2
;''2 3
return)) 
await)) 
ToPagedResultAsync)) '
())' (
query))( -
,))- .

pageNumber))/ 9
,))9 :
pageSize)); C
)))C D
;))D E
}** 
public,, 

async,, 
Task,, 
<,, 
PagedResult,, !
<,,! "
Appointment,," -
>,,- .
>,,. /*
GetAppointmentsByDoctorIdAsync,,0 N
(,,N O
int-- 
doctorId-- 
,-- 
int.. 

pageNumber.. 
,.. 
int// 
pageSize// 
)// 
{00 
var11 
query11 
=11 &
GetAppointmentsWithDetails11 .
(11. /
)11/ 0
.22 
Where22 
(22 
appointment22 
=>22 !
appointment22" -
.22- .
DoctorId22. 6
==227 9
doctorId22: B
)22B C
.33 
OrderBy33 
(33 
appointment33  
=>33! #
appointment33$ /
.33/ 0
AppointmentDate330 ?
)33? @
.44 
ThenBy44 
(44 
appointment44 
=>44  "
appointment44# .
.44. /
AppointmentTime44/ >
)44> ?
.55 
ThenBy55 
(55 
appointment55 
=>55  "
appointment55# .
.55. /
Id55/ 1
)551 2
;552 3
return77 
await77 
ToPagedResultAsync77 '
(77' (
query77( -
,77- .

pageNumber77/ 9
,779 :
pageSize77; C
)77C D
;77D E
}88 
public:: 

async:: 
Task:: 
<:: 
PagedResult:: !
<::! "
Appointment::" -
>::- .
>::. /1
%GetAppointmentsByDoctorIdAndDateAsync::0 U
(::U V
int;; 
doctorId;; 
,;; 
DateOnly<< 
date<< 
,<< 
int== 

pageNumber== 
,== 
int>> 
pageSize>> 
)>> 
{?? 
var@@ 
query@@ 
=@@ &
GetAppointmentsWithDetails@@ .
(@@. /
)@@/ 0
.AA 
WhereAA 
(AA 
appointmentAA 
=>AA !
appointmentBB 
.BB 
DoctorIdBB $
==BB% '
doctorIdBB( 0
&&BB1 3
appointmentCC 
.CC 
AppointmentDateCC +
==CC, .
dateCC/ 3
)CC3 4
.DD 
OrderByDD 
(DD 
appointmentDD  
=>DD! #
appointmentDD$ /
.DD/ 0
AppointmentTimeDD0 ?
)DD? @
.EE 
ThenByEE 
(EE 
appointmentEE 
=>EE  "
appointmentEE# .
.EE. /
IdEE/ 1
)EE1 2
;EE2 3
returnGG 
awaitGG 
ToPagedResultAsyncGG '
(GG' (
queryGG( -
,GG- .

pageNumberGG/ 9
,GG9 :
pageSizeGG; C
)GGC D
;GGD E
}HH 
publicJJ 

asyncJJ 
TaskJJ 
<JJ 
ListJJ 
<JJ 
AppointmentJJ &
>JJ& '
>JJ' ('
GetPendingAppointmentsAsyncJJ) D
(JJD E
)JJE F
{KK 
returnLL 
awaitLL 
_contextLL 
.LL 
AppointmentsLL *
.MM 
WhereMM 
(MM 
appointmentMM 
=>MM !
appointmentMM" -
.MM- .
StatusMM. 4
==MM5 7
AppointmentStatusMM8 I
.MMI J
PendingMMJ Q
)MMQ R
.NN 
ToListAsyncNN 
(NN 
)NN 
;NN 
}OO 
publicQQ 

asyncQQ 
TaskQQ 
<QQ 
boolQQ 
>QQ 3
'DoctorHasNonCancelledAppointmentAtAsyncQQ C
(QQC D
intQQD G
doctorIdQQH P
,QQP Q
DateOnlyQQR Z
dateQQ[ _
,QQ_ `
TimeOnlyQQa i
timeQQj n
)QQn o
{RR 
returnSS 
awaitSS 
_contextSS 
.SS 
AppointmentsSS *
.TT 
AnyAsyncTT 
(TT 
appointmentTT !
=>TT" $
appointmentUU 
.UU 
DoctorIdUU $
==UU% '
doctorIdUU( 0
&&UU1 3
appointmentVV 
.VV 
AppointmentDateVV +
==VV, .
dateVV/ 3
&&VV4 6
appointmentWW 
.WW 
AppointmentTimeWW +
==WW, .
timeWW/ 3
&&WW4 6
appointmentXX 
.XX 
StatusXX "
!=XX# %
AppointmentStatusXX& 7
.XX7 8
	CancelledXX8 A
)XXA B
;XXB C
}YY 
public[[ 

async[[ 
Task[[ 
<[[ 
bool[[ 
>[[ 4
(PatientHasNonCancelledAppointmentAtAsync[[ D
([[D E
int[[E H
	patientId[[I R
,[[R S
DateOnly[[T \
date[[] a
,[[a b
TimeOnly[[c k
time[[l p
)[[p q
{\\ 
return]] 
await]] 
_context]] 
.]] 
Appointments]] *
.^^ 
AnyAsync^^ 
(^^ 
appointment^^ !
=>^^" $
appointment__ 
.__ 
	PatientId__ %
==__& (
	patientId__) 2
&&__3 5
appointment`` 
.`` 
AppointmentDate`` +
==``, .
date``/ 3
&&``4 6
appointmentaa 
.aa 
AppointmentTimeaa +
==aa, .
timeaa/ 3
&&aa4 6
appointmentbb 
.bb 
Statusbb "
!=bb# %
AppointmentStatusbb& 7
.bb7 8
	Cancelledbb8 A
)bbA B
;bbB C
}cc 
publicee 

asyncee 
Taskee 
<ee 
boolee 
>ee B
6PatientHasNonCancelledAppointmentWithDoctorOnDateAsyncee R
(eeR S
inteeS V
	patientIdeeW `
,ee` a
inteeb e
doctorIdeef n
,een o
DateOnlyeep x
dateeey }
)ee} ~
{ff 
returngg 
awaitgg 
_contextgg 
.gg 
Appointmentsgg *
.hh 
AnyAsynchh 
(hh 
appointmenthh !
=>hh" $
appointmentii 
.ii 
	PatientIdii %
==ii& (
	patientIdii) 2
&&ii3 5
appointmentjj 
.jj 
DoctorIdjj $
==jj% '
doctorIdjj( 0
&&jj1 3
appointmentkk 
.kk 
AppointmentDatekk +
==kk, .
datekk/ 3
&&kk4 6
appointmentll 
.ll 
Statusll "
!=ll# %
AppointmentStatusll& 7
.ll7 8
	Cancelledll8 A
)llA B
;llB C
}mm 
publicoo 

asyncoo 
Taskoo 
<oo 
booloo 
>oo 5
)DoctorHasConfirmedAppointmentsOnDateAsyncoo E
(ooE F
intooF I
doctorIdooJ R
,ooR S
DateOnlyooT \
dateoo] a
)ooa b
{pp 
returnqq 
awaitqq 
_contextqq 
.qq 
Appointmentsqq *
.rr 
AnyAsyncrr 
(rr 
appointmentrr !
=>rr" $
appointmentss 
.ss 
DoctorIdss $
==ss% '
doctorIdss( 0
&&ss1 3
appointmenttt 
.tt 
AppointmentDatett +
==tt, .
datett/ 3
&&tt4 6
appointmentuu 
.uu 
Statusuu "
==uu# %
AppointmentStatusuu& 7
.uu7 8
	Confirmeduu8 A
)uuA B
;uuB C
}vv 
publicxx 

asyncxx 
Taskxx 
<xx 
Listxx 
<xx 
Appointmentxx &
>xx& '
>xx' (C
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsyncxx) `
(xx` a
intxxa d
doctorIdxxe m
,xxm n
DateOnlyxxo w
datexxx |
)xx| }
{yy 
returnzz 
awaitzz 
_contextzz 
.zz 
Appointmentszz *
.{{ 
Where{{ 
({{ 
appointment{{ 
=>{{ !
appointment|| 
.|| 
DoctorId|| $
==||% '
doctorId||( 0
&&||1 3
appointment}} 
.}} 
AppointmentDate}} +
==}}, .
date}}/ 3
&&}}4 6
(~~ 
appointment~~ 
.~~ 
Status~~ #
==~~$ &
AppointmentStatus~~' 8
.~~8 9
Pending~~9 @
||~~A C
appointment 
. 
Status #
==$ &
AppointmentStatus' 8
.8 9
	Confirmed9 B
)B C
)C D
.
ÄÄ 
ToListAsync
ÄÄ 
(
ÄÄ 
)
ÄÄ 
;
ÄÄ 
}
ÅÅ 
public
ÉÉ 

async
ÉÉ 
Task
ÉÉ 
<
ÉÉ 
Appointment
ÉÉ !
?
ÉÉ! "
>
ÉÉ" #$
DeleteAppointmentAsync
ÉÉ$ :
(
ÉÉ: ;
int
ÉÉ; >
appointmentId
ÉÉ? L
)
ÉÉL M
{
ÑÑ 
var
ÖÖ 
appointment
ÖÖ 
=
ÖÖ 
await
ÖÖ 0
"GetAppointmentByIdWithDetailsAsync
ÖÖ  B
(
ÖÖB C
appointmentId
ÖÖC P
)
ÖÖP Q
;
ÖÖQ R
if
áá 

(
áá 
appointment
áá 
==
áá 
null
áá 
)
áá  
{
àà 	
return
ââ 
null
ââ 
;
ââ 
}
ää 	
_dbSet
åå 
.
åå 
Remove
åå 
(
åå 
appointment
åå !
)
åå! "
;
åå" #
await
çç 
_context
çç 
.
çç 
SaveChangesAsync
çç '
(
çç' (
)
çç( )
;
çç) *
return
èè 
appointment
èè 
;
èè 
}
êê 
private
íí 

IQueryable
íí 
<
íí 
Appointment
íí "
>
íí" #(
GetAppointmentsWithDetails
íí$ >
(
íí> ?
)
íí? @
{
ìì 
return
îî 
_context
îî 
.
îî 
Appointments
îî $
.
ïï 
Include
ïï 
(
ïï 
appointment
ïï  
=>
ïï! #
appointment
ïï$ /
.
ïï/ 0
Patient
ïï0 7
)
ïï7 8
.
ññ 
Include
ññ 
(
ññ 
appointment
ññ  
=>
ññ! #
appointment
ññ$ /
.
ññ/ 0
Doctor
ññ0 6
)
ññ6 7
.
óó 
Include
óó 
(
óó 
appointment
óó  
=>
óó! #
appointment
óó$ /
.
óó/ 0
HealthRecord
óó0 <
)
óó< =
;
óó= >
}
òò 
}ôô ç
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
} ‰
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
int9 <

pageNumber= G
,G H
intI L
pageSizeM U
)U V
;V W
Task 
< 	
Doctor	 
? 
> &
GetDoctorByIdWithUserAsync ,
(, -
int- 0
id1 3
)3 4
;4 5
Task 
< 	
Doctor	 
? 
> "
GetDoctorByUserIdAsync (
(( )
string) /
userId0 6
)6 7
;7 8
Task 
< 	
bool	 
? 
>  
GetAvailabilityAsync $
($ %
int% (
id) +
)+ ,
;, -
} ¯
]C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Repositories\IAppointmentRepository.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Repositories %
;% &
public 
	interface "
IAppointmentRepository '
:( )
IRepository* 5
<5 6
Appointment6 A
>A B
{ 
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "#
GetAllAppointmentsAsync# :
(: ;
int; >

pageNumber? I
,I J
intK N
pageSizeO W
)W X
;X Y
Task		 
<		 	
Appointment			 
?		 
>		 .
"GetAppointmentByIdWithDetailsAsync		 9
(		9 :
int		: =
appointmentId		> K
)		K L
;		L M
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
,P Q
intR U

pageNumberV `
,` a
intb e
pageSizef n
)n o
;o p
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "*
GetAppointmentsByDoctorIdAsync# A
(A B
intB E
doctorIdF N
,N O
intP S

pageNumberT ^
,^ _
int` c
pageSized l
)l m
;m n
Task 
< 	
PagedResult	 
< 
Appointment  
>  !
>! "1
%GetAppointmentsByDoctorIdAndDateAsync# H
(H I
intI L
doctorIdM U
,U V
DateOnlyW _
date` d
,d e
intf i

pageNumberj t
,t u
intv y
pageSize	z Ç
)
Ç É
;
É Ñ
Task 
< 	
List	 
< 
Appointment 
> 
> '
GetPendingAppointmentsAsync 7
(7 8
)8 9
;9 :
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
Task 
< 	
bool	 
> 4
(PatientHasNonCancelledAppointmentAtAsync 7
(7 8
int8 ;
	patientId< E
,E F
DateOnlyG O
dateP T
,T U
TimeOnlyV ^
time_ c
)c d
;d e
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
Task 
< 	
bool	 
> 5
)DoctorHasConfirmedAppointmentsOnDateAsync 8
(8 9
int9 <
doctorId= E
,E F
DateOnlyG O
dateP T
)T U
;U V
Task 
< 	
List	 
< 
Appointment 
> 
> C
7GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync S
(S T
intT W
doctorIdX `
,` a
DateOnlyb j
datek o
)o p
;p q
Task 
< 	
Appointment	 
? 
> "
DeleteAppointmentAsync -
(- .
int. 1
appointmentId2 ?
)? @
;@ A
} Îv
AC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Program.cs
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1
builder 
. 
Services 
. 
AddControllers 
(  
)  !
. 
AddJsonOptions 
( 
options 
=> 
{ 
options 
. !
JsonSerializerOptions %
.% & 
PropertyNamingPolicy& :
=; <
JsonNamingPolicy= M
.M N
	CamelCaseN W
;W X
} 
) 
; 
builder 
. 
Services 
. #
AddEndpointsApiExplorer (
(( )
)) *
;* +
builder 
. 
Services 
. 
AddSwaggerGen 
( 
options &
=>' )
{ 
options 
. 

SwaggerDoc 
( 
$str 
, 
new  
OpenApiInfo! ,
{ 
Title 
= 
$str  
,  !
Version   
=   
$str   
}!! 
)!! 
;!! 
options## 
.## !
AddSecurityDefinition## !
(##! "
$str##" *
,##* +
new##, /!
OpenApiSecurityScheme##0 E
{$$ 
Type%% 
=%% 
SecuritySchemeType%% !
.%%! "
Http%%" &
,%%& '
Scheme&& 
=&& 
$str&& 
,&& 
BearerFormat'' 
='' 
$str'' 
,'' 
Description(( 
=(( 
$str(( I
})) 
))) 
;)) 
options++ 
.++ "
AddSecurityRequirement++ "
(++" #
document++# +
=>++, .
new++/ 2&
OpenApiSecurityRequirement++3 M
{,, 
[-- 	
new--	 *
OpenApiSecuritySchemeReference-- +
(--+ ,
$str--, 4
,--4 5
document--6 >
)--> ?
]--? @
=--A B
[--C D
]--D E
}.. 
).. 
;.. 
}// 
)// 
;// 
builder11 
.11 
Services11 
.11 
AddExceptionHandler11 $
<11$ %"
GlobalExceptionHandler11% ;
>11; <
(11< =
)11= >
;11> ?
builder22 
.22 
Services22 
.22 
AddProblemDetails22 "
(22" #
)22# $
;22$ %
builder44 
.44 
Services44 
.44 
AddDbContext44 
<44 
HealthAxisDbContext44 1
>441 2
(442 3
options443 :
=>44; =
options55 
.55 
UseSqlServer55 
(55 
builder55  
.55  !
Configuration55! .
.55. /
GetConnectionString55/ B
(55B C
$str55C Q
)55Q R
)55R S
)55S T
;55T U
builder77 
.77 
Services77 
.77 
AddIdentity77 
<77 
IdentityUser77 )
,77) *
IdentityRole77+ 7
>777 8
(778 9
options779 @
=>77A C
{88 
options99 
.99 
User99 
.99 
RequireUniqueEmail99 #
=99$ %
true99& *
;99* +
options;; 
.;; 
Password;; 
.;; 
RequireDigit;; !
=;;" #
true;;$ (
;;;( )
options<< 
.<< 
Password<< 
.<< 
RequireUppercase<< %
=<<& '
true<<( ,
;<<, -
options== 
.== 
Password== 
.== 
RequireLowercase== %
===& '
true==( ,
;==, -
options>> 
.>> 
Password>> 
.>> "
RequireNonAlphanumeric>> +
=>>, -
true>>. 2
;>>2 3
options?? 
.?? 
Password?? 
.?? 
RequiredLength?? #
=??$ %
$num??& '
;??' (
}@@ 
)@@ 
.AA $
AddEntityFrameworkStoresAA 
<AA 
HealthAxisDbContextAA -
>AA- .
(AA. /
)AA/ 0
.BB $
AddDefaultTokenProvidersBB 
(BB 
)BB 
;BB 
varDD 
jwtSettingsDD 
=DD 
builderDD 
.DD 
ConfigurationDD '
.DD' (

GetSectionDD( 2
(DD2 3
$strDD3 8
)DD8 9
;DD9 :
builderFF 
.FF 
ServicesFF 
.FF 
AddAuthenticationFF "
(FF" #
optionsFF# *
=>FF+ -
{GG 
optionsHH 
.HH %
DefaultAuthenticateSchemeHH %
=HH& '
JwtBearerDefaultsHH( 9
.HH9 : 
AuthenticationSchemeHH: N
;HHN O
optionsII 
.II "
DefaultChallengeSchemeII "
=II# $
JwtBearerDefaultsII% 6
.II6 7 
AuthenticationSchemeII7 K
;IIK L
}JJ 
)JJ 
.KK 
AddJwtBearerKK 
(KK 
optionsKK 
=>KK 
{LL 
optionsMM 
.MM %
TokenValidationParametersMM %
=MM& '
newMM( +%
TokenValidationParametersMM, E
{NN 
ValidateIssuerOO 
=OO 
trueOO 
,OO 
ValidIssuerPP 
=PP 
jwtSettingsPP !
[PP! "
$strPP" *
]PP* +
,PP+ ,
ValidateAudienceRR 
=RR 
trueRR 
,RR  
ValidAudienceSS 
=SS 
jwtSettingsSS #
[SS# $
$strSS$ .
]SS. /
,SS/ 0
ValidateLifetimeUU 
=UU 
trueUU 
,UU  $
ValidateIssuerSigningKeyWW  
=WW! "
trueWW# '
,WW' (
IssuerSigningKeyXX 
=XX 
newXX  
SymmetricSecurityKeyXX 3
(XX3 4
EncodingYY 
.YY 
UTF8YY 
.YY 
GetBytesYY "
(YY" #
jwtSettingsYY# .
[YY. /
$strYY/ 4
]YY4 5
!YY5 6
)YY6 7
)ZZ 	
,ZZ	 

	ClockSkew\\ 
=\\ 
TimeSpan\\ 
.\\ 
Zero\\ !
}]] 
;]] 
}^^ 
)^^ 
;^^ 
builder`` 
.`` 
Services`` 
.`` 
AddAuthorization`` !
(``! "
)``" #
;``# $
builderbb 
.bb 
Servicesbb 
.bb 
	AddScopedbb 
<bb 
IDoctorRepositorybb ,
,bb, -
DoctorRepositorybb. >
>bb> ?
(bb? @
)bb@ A
;bbA B
buildercc 
.cc 
Servicescc 
.cc 
	AddScopedcc 
<cc 
IPatientRepositorycc -
,cc- .
PatientRepositorycc/ @
>cc@ A
(ccA B
)ccB C
;ccC D
builderdd 
.dd 
Servicesdd 
.dd 
	AddScopeddd 
<dd "
IAppointmentRepositorydd 1
,dd1 2!
AppointmentRepositorydd3 H
>ddH I
(ddI J
)ddJ K
;ddK L
builderee 
.ee 
Servicesee 
.ee 
	AddScopedee 
<ee #
IHealthRecordRepositoryee 2
,ee2 3"
HealthRecordRepositoryee4 J
>eeJ K
(eeK L
)eeL M
;eeM N
buildergg 
.gg 
Servicesgg 
.gg 
	AddScopedgg 
<gg 
IAuthServicegg '
,gg' (
AuthServicegg) 4
>gg4 5
(gg5 6
)gg6 7
;gg7 8
builderhh 
.hh 
Serviceshh 
.hh 
	AddScopedhh 
<hh 
IDoctorServicehh )
,hh) *
DoctorServicehh+ 8
>hh8 9
(hh9 :
)hh: ;
;hh; <
builderii 
.ii 
Servicesii 
.ii 
	AddScopedii 
<ii 
IPatientServiceii *
,ii* +
PatientServiceii, :
>ii: ;
(ii; <
)ii< =
;ii= >
builderjj 
.jj 
Servicesjj 
.jj 
	AddScopedjj 
<jj 
IAppointmentServicejj .
,jj. /
AppointmentServicejj0 B
>jjB C
(jjC D
)jjD E
;jjE F
builderkk 
.kk 
Serviceskk 
.kk 
	AddScopedkk 
<kk  
IHealthRecordServicekk /
,kk/ 0
HealthRecordServicekk1 D
>kkD E
(kkE F
)kkF G
;kkG H
builderll 
.ll 
Servicesll 
.ll 
	AddScopedll 
<ll 
IAdminServicell (
,ll( )
AdminServicell* 6
>ll6 7
(ll7 8
)ll8 9
;ll9 :
buildernn 
.nn 
Servicesnn 
.nn 
AddAutoMappernn 
(nn 
cfgnn "
=>nn# %
{oo 
cfgpp 
.pp 

AddProfilepp 
<pp 
MappingProfilepp !
>pp! "
(pp" #
)pp# $
;pp$ %
}qq 
)qq 
;qq 
varss 
appss 
=ss 	
builderss
 
.ss 
Buildss 
(ss 
)ss 
;ss 
appuu 
.uu 
UseExceptionHandleruu 
(uu 
)uu 
;uu 
usingww 
(ww 
varww 

scopeww 
=ww 
appww 
.ww 
Servicesww 
.ww  
CreateScopeww  +
(ww+ ,
)ww, -
)ww- .
{xx 
varyy 
roleManageryy 
=yy 
scopeyy 
.yy 
ServiceProvideryy +
.yy+ ,
GetRequiredServiceyy, >
<yy> ?
RoleManageryy? J
<yyJ K
IdentityRoleyyK W
>yyW X
>yyX Y
(yyY Z
)yyZ [
;yy[ \
varzz 
userManagerzz 
=zz 
scopezz 
.zz 
ServiceProviderzz +
.zz+ ,
GetRequiredServicezz, >
<zz> ?
UserManagerzz? J
<zzJ K
IdentityUserzzK W
>zzW X
>zzX Y
(zzY Z
)zzZ [
;zz[ \
var{{ 
context{{ 
={{ 
scope{{ 
.{{ 
ServiceProvider{{ '
.{{' (
GetRequiredService{{( :
<{{: ;
HealthAxisDbContext{{; N
>{{N O
({{O P
){{P Q
;{{Q R
await}} 	
IdentityDataSeeder}}
 
.}} 
	SeedAsync}} &
(}}& '
roleManager}}' 2
,}}2 3
userManager}}4 ?
,}}? @
context}}A H
)}}H I
;}}I J
}~~ 
varÄÄ 
appName
ÄÄ 
=
ÄÄ 
builder
ÄÄ 
.
ÄÄ 
Configuration
ÄÄ #
[
ÄÄ# $
$str
ÄÄ$ 9
]
ÄÄ9 :
??
ÄÄ; =
$str
ÄÄ> N
;
ÄÄN O
appÇÇ 
.
ÇÇ 
Use
ÇÇ 
(
ÇÇ 
async
ÇÇ 
(
ÇÇ 
context
ÇÇ 
,
ÇÇ 
next
ÇÇ 
)
ÇÇ 
=>
ÇÇ  
{ÉÉ 
var
ÑÑ 
logger
ÑÑ 
=
ÑÑ 
context
ÑÑ 
.
ÑÑ 
RequestServices
ÑÑ (
.
ÑÑ( ) 
GetRequiredService
ÑÑ) ;
<
ÑÑ; <
ILogger
ÑÑ< C
<
ÑÑC D
Program
ÑÑD K
>
ÑÑK L
>
ÑÑL M
(
ÑÑM N
)
ÑÑN O
;
ÑÑO P
if
ÜÜ 
(
ÜÜ 
logger
ÜÜ 
.
ÜÜ 
	IsEnabled
ÜÜ 
(
ÜÜ 
LogLevel
ÜÜ !
.
ÜÜ! "
Information
ÜÜ" -
)
ÜÜ- .
)
ÜÜ. /
{
áá 
logger
àà 
.
àà 
LogInformation
àà 
(
àà 
$str
ââ <
,
ââ< =
context
ää 
.
ää 
Request
ää 
.
ää 
Method
ää "
,
ää" #
context
ãã 
.
ãã 
Request
ãã 
.
ãã 
Path
ãã  
,
ãã  !
appName
åå 
)
çç 	
;
çç	 

}
éé 
await
êê 	
next
êê
 
(
êê 
)
êê 
;
êê 
if
íí 
(
íí 
logger
íí 
.
íí 
	IsEnabled
íí 
(
íí 
LogLevel
íí !
.
íí! "
Information
íí" -
)
íí- .
)
íí. /
{
ìì 
logger
îî 
.
îî 
LogInformation
îî 
(
îî 
$str
ïï N
,
ïïN O
context
ññ 
.
ññ 
Request
ññ 
.
ññ 
Method
ññ "
,
ññ" #
context
óó 
.
óó 
Request
óó 
.
óó 
Path
óó  
,
óó  !
context
òò 
.
òò 
Response
òò 
.
òò 

StatusCode
òò '
)
ôô 	
;
ôô	 

}
öö 
}úú 
)
úú 
;
úú 
ifûû 
(
ûû 
app
ûû 
.
ûû 
Environment
ûû 
.
ûû 
IsDevelopment
ûû !
(
ûû! "
)
ûû" #
)
ûû# $
{üü 
app
†† 
.
†† 

UseSwagger
†† 
(
†† 
)
†† 
;
†† 
app
°° 
.
°° 
UseSwaggerUI
°° 
(
°° 
)
°° 
;
°° 
}¢¢ 
app§§ 
.
§§ !
UseHttpsRedirection
§§ 
(
§§ 
)
§§ 
;
§§ 
app¶¶ 
.
¶¶ 
UseAuthentication
¶¶ 
(
¶¶ 
)
¶¶ 
;
¶¶ 
appßß 
.
ßß 
UseAuthorization
ßß 
(
ßß 
)
ßß 
;
ßß 
app©© 
.
©© 
MapControllers
©© 
(
©© 
)
©© 
;
©© 
app´´ 
.
´´ 
MapGet
´´ 

(
´´
 
$str
´´ 
,
´´ 
(
´´ 
)
´´ 
=>
´´ 
$"
´´ 
{
´´ 
appName
´´  
}
´´  !
$str
´´! :
"
´´: ;
)
´´; <
;
´´< =
await≠≠ 
app
≠≠ 	
.
≠≠	 

RunAsync
≠≠
 
(
≠≠ 
)
≠≠ 
;
≠≠ ∞
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
}.. √@
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Mappings\MappingProfile.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Mappings !
;! "
public 
class 
MappingProfile 
: 
Profile %
{ 
public		 

MappingProfile		 
(		 
)		 
{

 
	CreateMap 
< 
Doctor 
, 
PublicDoctorDto )
>) *
(* +
)+ ,
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
YearsOfExperience$ 5
,5 6
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src* -
.- .&
CalculateYearsOfExperience. H
(H I
)I J
)J K
)K L
;L M
	CreateMap 
< 
Doctor 
, 
	DoctorDto #
># $
($ %
)% &
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
YearsOfExperience$ 5
,5 6
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src* -
.- .&
CalculateYearsOfExperience. H
(H I
)I J
)J K
)K L
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
Email$ )
,) *
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src 
. 
User 
!= 
null  $
&&% '
src( +
.+ ,
User, 0
.0 1
Email1 6
!=7 9
null: >
? 
src 
. 
User "
." #
Email# (
: 
string  
.  !
Empty! &
)& '
)' (
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
PhoneNumber$ /
,/ 0
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src 
. 
User 
!= 
null  $
&&% '
src( +
.+ ,
User, 0
.0 1
PhoneNumber1 <
!== ?
null@ D
? 
src 
. 
User "
." #
PhoneNumber# .
: 
string  
.  !
Empty! &
)& '
)' (
;( )
	CreateMap 
< 
Patient 
, 

PatientDto %
>% &
(& '
)' (
. 
	ForMember 
( 
dest 
=> 
dest #
.# $
PhoneNumber$ /
,/ 0
opt 
=> 
opt 
. 
MapFrom "
(" #
src# &
=>' )
src   
.   
User   
!=   
null    $
&&  % '
src  ( +
.  + ,
User  , 0
.  0 1
PhoneNumber  1 <
!=  = ?
null  @ D
?!! 
src!! 
.!! 
User!! "
.!!" #
PhoneNumber!!# .
:"" 
string""  
.""  !
Empty""! &
)""& '
)""' (
;""( )
	CreateMap$$ 
<$$ 
Appointment$$ 
,$$ 
AppointmentDto$$ -
>$$- .
($$. /
)$$/ 0
.%% 
	ForMember%% 
(%% 
dest%% 
=>%% 
dest%% #
.%%# $
PatientName%%$ /
,%%/ 0
opt&& 
=>&& 
opt&& 
.&& 
MapFrom&& "
(&&" #
src&&# &
=>&&' )
src'' 
.'' 
Patient'' 
!=''  "
null''# '
?(( 
src(( 
.(( 
Patient(( %
.((% &
FullName((& .
:)) 
string))  
.))  !
Empty))! &
)))& '
)))' (
.** 
	ForMember** 
(** 
dest** 
=>** 
dest** #
.**# $

DoctorName**$ .
,**. /
opt++ 
=>++ 
opt++ 
.++ 
MapFrom++ "
(++" #
src++# &
=>++' )
src,, 
.,, 
Doctor,, 
!=,, !
null,," &
?-- 
src-- 
.-- 
Doctor-- $
.--$ %
FullName--% -
:.. 
string..  
...  !
Empty..! &
)..& '
)..' (
;..( )
	CreateMap00 
<00  
CreateAppointmentDto00 &
,00& '
Appointment00( 3
>003 4
(004 5
)005 6
;006 7
	CreateMap22 
<22 
HealthRecord22 
,22 
HealthRecordDto22  /
>22/ 0
(220 1
)221 2
.33 
	ForMember33 
(33 
dest33 
=>33 
dest33 #
.33# $
	PatientId33$ -
,33- .
opt44 
=>44 
opt44 
.44 
MapFrom44 "
(44" #
src44# &
=>44' )
src55 
.55 
Appointment55 #
!=55$ &
null55' +
?66 
src66 
.66 
Appointment66 )
.66) *
	PatientId66* 3
:77 
$num77 
)77 
)77 
.88 
	ForMember88 
(88 
dest88 
=>88 
dest88 #
.88# $
DoctorId88$ ,
,88, -
opt99 
=>99 
opt99 
.99 
MapFrom99 "
(99" #
src99# &
=>99' )
src:: 
.:: 
Appointment:: #
!=::$ &
null::' +
?;; 
src;; 
.;; 
Appointment;; )
.;;) *
DoctorId;;* 2
:<< 
$num<< 
)<< 
)<< 
.== 
	ForMember== 
(== 
dest== 
=>== 
dest== #
.==# $
PatientName==$ /
,==/ 0
opt>> 
=>>> 
opt>> 
.>> 
MapFrom>> "
(>>" #
src>># &
=>>>' )
src?? 
.?? 
Appointment?? #
!=??$ &
null??' +
&&??, .
src??/ 2
.??2 3
Appointment??3 >
.??> ?
Patient??? F
!=??G I
null??J N
?@@ 
src@@ 
.@@ 
Appointment@@ )
.@@) *
Patient@@* 1
.@@1 2
FullName@@2 :
:AA 
stringAA  
.AA  !
EmptyAA! &
)AA& '
)AA' (
.BB 
	ForMemberBB 
(BB 
destBB 
=>BB 
destBB #
.BB# $

DoctorNameBB$ .
,BB. /
optCC 
=>CC 
optCC 
.CC 
MapFromCC "
(CC" #
srcCC# &
=>CC' )
srcDD 
.DD 
AppointmentDD #
!=DD$ &
nullDD' +
&&DD, .
srcDD/ 2
.DD2 3
AppointmentDD3 >
.DD> ?
DoctorDD? E
!=DDF H
nullDDI M
?EE 
srcEE 
.EE 
AppointmentEE )
.EE) *
DoctorEE* 0
.EE0 1
FullNameEE1 9
:FF 
stringFF  
.FF  !
EmptyFF! &
)FF& '
)FF' (
;FF( )
}GG 
}HH ¥	
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
} ˆ
HC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Enums\UserRole.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Enums 
; 
public 
enum 
UserRole 
{ 
Admin 	
,	 

Doctor 

,
 
Patient 
} ©
TC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Enums\DoctorSpecialisation.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Enums 
; 
public 
enum  
DoctorSpecialisation  
{ 

Cardiology 
, 
Dermatology 
, 
	Neurology 
, 
Orthopedics 
, 

Pediatrics		 
,		 
GeneralMedicine

 
,

 

Psychiatry 
, 
	Radiology 
, 

Gynecology 
, 
ENT 
} µ
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Enums\AppointmentStatus.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Enums 
; 
public 
enum 
AppointmentStatus 
{ 
Pending 
, 
	Confirmed 
, 
	Cancelled 
, 
	Completed 
}		 °
WC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Patient\UpdatePatientDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 
UpdatePatientDto 
{ 
[ 
Required 
] 
[		 
StringLength		 
(		 
$num		 
)		 
]		 
public

 

string

 
FullName

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
=

) *
string

+ 1
.

1 2
Empty

2 7
;

7 8
[ 
JsonRequired 
] 
[ 
Required 
] 
public 

DateOnly 
DateOfBirth 
{  !
get" %
;% &
set' *
;* +
}, -
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
Gender 
{ 
get 
; 
set  #
;# $
}% &
=' (
string) /
./ 0
Empty0 5
;5 6
[ 
Required 
] 
[ 
Phone 

]
 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
PhoneNumber 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
Address 
{ 
get 
;  
set! $
;$ %
}& '
=( )
string* 0
.0 1
Empty1 6
;6 7
} â
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Patient\PatientDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 

PatientDto 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
UserId 
{ 
get 
; 
set  #
;# $
}% &
=' (
string) /
./ 0
Empty0 5
;5 6
public		 

string		 
FullName		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
=		) *
string		+ 1
.		1 2
Empty		2 7
;		7 8
public 

DateOnly 
DateOfBirth 
{  !
get" %
;% &
set' *
;* +
}, -
public 

string 
Gender 
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
;5 6
public 

string 
PhoneNumber 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
public 

string 
Address 
{ 
get 
;  
set! $
;$ %
}& '
=( )
string* 0
.0 1
Empty1 6
;6 7
} Î
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\PaginationQueryDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 
PaginationQueryDto 
{ 
[ 
Range 

(
 
$num 
, 
int 
. 
MaxValue 
) 
] 
public 

int 

PageNumber 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$num* +
;+ ,
[

 
Range

 

(


 
$num

 
,

 
$num

 
)

 
]

 
public 

int 
PageSize 
{ 
get 
; 
set "
;" #
}$ %
=& '
$num( *
;* +
} ˆ
MC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\PagedResultDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 
PagedResultDto 
< 
T 
> 
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
}& '
public 

bool 
HasPreviousPage 
=>  "

PageNumber# -
>. /
$num0 1
;1 2
public 

bool 
HasNextPage 
=> 

PageNumber )
<* +

TotalPages, 6
;6 7
} ´
[C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\HealthRecord\HealthRecordDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 
HealthRecordDto 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
AppointmentId 
{ 
get "
;" #
set$ '
;' (
}) *
public		 

int		 
	PatientId		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public 

int 
DoctorId 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
PatientName 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
public 

string 

DoctorName 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
string- 3
.3 4
Empty4 9
;9 :
public 

DateOnly 
	VisitDate 
{ 
get  #
;# $
set% (
;( )
}* +
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
;8 9
public 

string 
Prescription 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
string/ 5
.5 6
Empty6 ;
;; <
public 

string 
? 
Notes 
{ 
get 
; 
set  #
;# $
}% &
} Ñ
aC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\HealthRecord\CreateHealthRecordDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class !
CreateHealthRecordDto "
{ 
[ 
JsonRequired 
] 
[		 
Required		 
]		 
public

 

int

 
AppointmentId

 
{

 
get

 "
;

" #
set

$ '
;

' (
}

) *
[ 
JsonRequired 
] 
[ 
Required 
] 
public 

DateOnly 
	VisitDate 
{ 
get  #
;# $
set% (
;( )
}* +
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
	Diagnosis 
{ 
get !
;! "
set# &
;& '
}( )
=* +
string, 2
.2 3
Empty3 8
;8 9
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
string 
Prescription 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
string/ 5
.5 6
Empty6 ;
;; <
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
? 
Notes 
{ 
get 
; 
set  #
;# $
}% &
} Ø

OC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\ErrorResponseDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 
ErrorResponseDto 
{ 
public 

int 

StatusCode 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
Message 
{ 
get 
;  
set! $
;$ %
}& '
=( )
string* 0
.0 1
Empty1 6
;6 7
public		 

string		 
Details		 
{		 
get		 
;		  
set		! $
;		$ %
}		& '
=		( )
string		* 0
.		0 1
Empty		1 6
;		6 7
public 

DateTime 
	Timestamp 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
Path 
{ 
get 
; 
set !
;! "
}# $
=% &
string' -
.- .
Empty. 3
;3 4
} ∂
UC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Doctor\UpdateDoctorDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 
UpdateDoctorDto 
{		 
[

 
Required

 
]

 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
FullName 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
[ 
JsonRequired 
] 
[ 
Required 
] 
public 
 
DoctorSpecialisation 
Specialisation  .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
[ 
JsonRequired 
] 
[ 
Required 
] 
[ 
PracticeStartDate 
( 
$num 
) 
] 
public 

DateOnly 
PracticeStartDate %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
[ 
JsonRequired 
] 
[ 
Range 

(
 
$num 
, 
$num 
) 
] 
public 

decimal 
ConsultationFee "
{# $
get% (
;( )
set* -
;- .
}/ 0
} ù
aC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Doctor\UpdateDoctorAvailabilityDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class '
UpdateDoctorAvailabilityDto (
{ 
[ 
JsonRequired 
] 
public 

bool 
IsAvailable 
{ 
get !
;! "
set# &
;& '
}( )
}		 ∆

UC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Doctor\PublicDoctorDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 
PublicDoctorDto 
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
string		 
FullName		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
=		) *
string		+ 1
.		1 2
Empty		2 7
;		7 8
public 
 
DoctorSpecialisation 
Specialisation  .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
public 

int 
YearsOfExperience  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

decimal 
ConsultationFee "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

bool 
IsAvailable 
{ 
get !
;! "
set# &
;& '
}( )
} à
OC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Doctor\DoctorDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 
	DoctorDto 
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
string 
FullName 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
public 

string 
Email 
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
string 
PhoneNumber 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
public 
 
DoctorSpecialisation 
Specialisation  .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
public 

int 
YearsOfExperience  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

decimal 
ConsultationFee "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

bool 
IsAvailable 
{ 
get !
;! "
set# &
;& '
}( )
} ·
[C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Doctor\DoctorAvailabilityDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class !
DoctorAvailabilityDto "
{ 
public 

int 
DoctorId 
{ 
get 
; 
set "
;" #
}$ %
public 

bool 
IsAvailable 
{ 
get !
;! "
set# &
;& '
}( )
public		 

string		 
Message		 
{		 
get		 
;		  
set		! $
;		$ %
}		& '
=		( )
string		* 0
.		0 1
Empty		1 6
;		6 7
}

 €
UC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Doctor\CreateDoctorDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 
CreateDoctorDto 
{ 
[		 
Required		 
]		 
[

 
StringLength

 
(

 
$num

 
)

 
]

 
public 

string 
FullName 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
[ 
Required 
] 
[ 
EmailAddress 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
=& '
string( .
.. /
Empty/ 4
;4 5
[ 
Required 
] 
[ 
Phone 

]
 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
PhoneNumber 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
[ 
Required 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
[ 
JsonRequired 
] 
[ 
Required 
] 
public 
 
DoctorSpecialisation 
Specialisation  .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
[ 
JsonRequired 
] 
[   
Required   
]   
public!! 

DateOnly!! 
PracticeStartDate!! %
{!!& '
get!!( +
;!!+ ,
set!!- 0
;!!0 1
}!!2 3
[## 
JsonRequired## 
]## 
[$$ 
Range$$ 

($$
 
$num$$ 
,$$ 
$num$$ 
)$$ 
]$$ 
public%% 

decimal%% 
ConsultationFee%% "
{%%# $
get%%% (
;%%( )
set%%* -
;%%- .
}%%/ 0
['' 
JsonRequired'' 
]'' 
public(( 

bool(( 
IsAvailable(( 
{(( 
get(( !
;((! "
set((# &
;((& '
}((( )
=((* +
true((, 0
;((0 1
})) £
OC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Auth\RegisterDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
. 
Auth "
;" #
public 
class 
RegisterDto 
{ 
[ 
Required 
] 
[		 
StringLength		 
(		 
$num		 
)		 
]		 
public

 

string

 
FullName

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
=

) *
string

+ 1
.

1 2
Empty

2 7
;

7 8
[ 
Required 
] 
[ 
EmailAddress 
] 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
=& '
string( .
.. /
Empty/ 4
;4 5
[ 
Required 
] 
[ 
Phone 

]
 
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
PhoneNumber 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
[ 
Required 
] 
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
)( )
]) *
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
[ 
Required 
] 
[ 
Compare 
( 
nameof 
( 
Password 
) 
, 
ErrorMessage +
=, -
$str. G
)G H
]H I
public 

string 
ConfirmPassword !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
string2 8
.8 9
Empty9 >
;> ?
public 

string 
Role 
{ 
get 
; 
set !
;! "
}# $
=% &
$str' 0
;0 1
[   
JsonRequired   
]   
[!! 
Required!! 
]!! 
public"" 

DateOnly"" 
DateOfBirth"" 
{""  !
get""" %
;""% &
set""' *
;""* +
}"", -
[$$ 
Required$$ 
]$$ 
[%% 
StringLength%% 
(%% 
$num%% 
)%% 
]%% 
public&& 

string&& 
Gender&& 
{&& 
get&& 
;&& 
set&&  #
;&&# $
}&&% &
=&&' (
string&&) /
.&&/ 0
Empty&&0 5
;&&5 6
[(( 
Required(( 
](( 
[)) 
StringLength)) 
()) 
$num)) 
))) 
])) 
public** 

string** 
Address** 
{** 
get** 
;**  
set**! $
;**$ %
}**& '
=**( )
string*** 0
.**0 1
Empty**1 6
;**6 7
}++ ß
ZC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Auth\RefreshTokenRequestDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
. 
Auth "
;" #
public 
class "
RefreshTokenRequestDto #
{ 
[ 
Required 
] 
public 

string 
UserId 
{ 
get 
; 
set  #
;# $
}% &
=' (
string) /
./ 0
Empty0 5
;5 6
[

 
Required

 
]

 
public 

string 
RefreshToken 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
string/ 5
.5 6
Empty6 ;
;; <
} æ
LC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Auth\LoginDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
. 
Auth "
;" #
public 
class 
LoginDto 
{ 
[ 
Required 
] 
[ 
EmailAddress 
] 
public		 

string		 
Email		 
{		 
get		 
;		 
set		 "
;		" #
}		$ %
=		& '
string		( .
.		. /
Empty		/ 4
;		4 5
[ 
Required 
] 
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
} ◊
SC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Auth\AuthResponseDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
. 
Auth "
;" #
public 
class 
AuthResponseDto 
{ 
public 

string 
AccessToken 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
public 

string 
RefreshToken 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
string/ 5
.5 6
Empty6 ;
;; <
public		 

string		 
Message		 
{		 
get		 
;		  
set		! $
;		$ %
}		& '
=		( )
string		* 0
.		0 1
Empty		1 6
;		6 7
public 

int 
	ExpiresIn 
{ 
get 
; 
set  #
;# $
}% &
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
;5 6
public 

int 
? 
	PatientId 
{ 
get 
;  
set! $
;$ %
}& '
public 

int 
? 
DoctorId 
{ 
get 
; 
set  #
;# $
}% &
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
=& '
string( .
.. /
Empty/ 4
;4 5
public 

string 
Role 
{ 
get 
; 
set !
;! "
}# $
=% &
string' -
.- .
Empty. 3
;3 4
} ˘
eC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Appointment\UpdateAppointmentStatusDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class &
UpdateAppointmentStatusDto '
{ 
[		 
JsonRequired		 
]		 
[

 
Required

 
]

 
public 

AppointmentStatus 
Status #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 
StringLength 
( 
$num 
) 
] 
public 

string 
? 
CancellationReason %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
} Ï

_C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Appointment\CreateAppointmentDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class  
CreateAppointmentDto !
{ 
[ 
JsonRequired 
] 
[		 
Required		 
]		 
public

 

int

 
	PatientId

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
[ 
JsonRequired 
] 
[ 
Required 
] 
public 

int 
DoctorId 
{ 
get 
; 
set "
;" #
}$ %
[ 
JsonRequired 
] 
[ 
Required 
] 
public 

DateOnly 
AppointmentDate #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 
JsonRequired 
] 
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
} Ó	
_C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Appointment\AppointmentReportDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class  
AppointmentReportDto !
{ 
public 

DateOnly 
Date 
{ 
get 
; 
set  #
;# $
}% &
public 

int 
ConfirmedCount 
{ 
get  #
;# $
set% (
;( )
}* +
public		 

int		 
CancelledCount		 
{		 
get		  #
;		# $
set		% (
;		( )
}		* +
public 

int 
CompletedCount 
{ 
get  #
;# $
set% (
;( )
}* +
public 

int 
PendingCount 
{ 
get !
;! "
set# &
;& '
}( )
public 

int 

TotalCount 
{ 
get 
;  
set! $
;$ %
}& '
} ê
kC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Appointment\AppointmentHealthRecordReportDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class ,
 AppointmentHealthRecordReportDto -
{ 
public 

int 
AppointmentId 
{ 
get "
;" #
set$ '
;' (
}) *
public		 

int		 
	PatientId		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public 

int 
DoctorId 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
PatientName 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
public 

string 

DoctorName 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
string- 3
.3 4
Empty4 9
;9 :
public 

DateOnly 
AppointmentDate #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

TimeOnly 
AppointmentTime #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

AppointmentStatus 
AppointmentStatus .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
public 

bool 
HasHealthRecord 
{  !
get" %
;% &
set' *
;* +
}, -
public 

int 
? 
HealthRecordId 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

DateOnly 
? !
HealthRecordVisitDate *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
} Ç
YC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Dtos\Appointment\AppointmentDto.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Dtos 
; 
public 
class 
AppointmentDto 
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

int		 
	PatientId		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public 

int 
DoctorId 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
PatientName 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
string. 4
.4 5
Empty5 :
;: ;
public 

string 

DoctorName 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
string- 3
.3 4
Empty4 9
;9 :
public 

DateOnly 
AppointmentDate #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

TimeOnly 
AppointmentTime #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

AppointmentStatus 
Status #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

string 
? 
CancellationReason %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
} µ=
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Data\IdentityDataSeeder.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Data 
; 
public 
static 
class 
IdentityDataSeeder &
{		 
public

 

static

 
async

 
Task

 
	SeedAsync

 &
(

& '
RoleManager 
< 
IdentityRole  
>  !
roleManager" -
,- .
UserManager 
< 
IdentityUser  
>  !
userManager" -
,- .
HealthAxisDbContext 
context #
)# $
{ 
string 
[ 
] 
roles 
= 
[ 
$str !
,! "
$str# +
,+ ,
$str- 6
]6 7
;7 8
foreach 
( 
var 
role 
in 
roles "
)" #
{ 	
if 
( 
! 
await 
roleManager "
." #
RoleExistsAsync# 2
(2 3
role3 7
)7 8
)8 9
{ 
await 
roleManager !
.! "
CreateAsync" -
(- .
new. 1
IdentityRole2 >
{ 
Name 
= 
role 
} 
) 
; 
} 
} 	
await 
SeedAdminAsync 
( 
userManager (
)( )
;) *
await 
SeedDoctorAsync 
( 
userManager 
, 
context   
,   
$str!! 
,!! 
$str"" )
,"") * 
DoctorSpecialisation##  
.##  !

Cardiology##! +
,##+ ,
new$$ 
DateOnly$$ 
($$ 
$num$$ 
,$$ 
$num$$  
,$$  !
$num$$" #
)$$# $
,$$$ %
$num%% 
)%% 
;%% 
await'' 
SeedDoctorAsync'' 
('' 
userManager(( 
,(( 
context)) 
,)) 
$str** 
,** 
$str++ '
,++' ( 
DoctorSpecialisation,,  
.,,  !
Dermatology,,! ,
,,,, -
new-- 
DateOnly-- 
(-- 
$num-- 
,-- 
$num--  
,--  !
$num--" #
)--# $
,--$ %
$num.. 
).. 
;.. 
}// 
private11 
static11 
async11 
Task11 
SeedAdminAsync11 ,
(11, -
UserManager11- 8
<118 9
IdentityUser119 E
>11E F
userManager11G R
)11R S
{22 
const33 
string33 

adminEmail33 
=33  !
$str33" 8
;338 9
var55 
existingAdmin55 
=55 
await55 !
userManager55" -
.55- .
FindByEmailAsync55. >
(55> ?

adminEmail55? I
)55I J
;55J K
if77 

(77 
existingAdmin77 
!=77 
null77 !
)77! "
{88 	
return99 
;99 
}:: 	
var<< 
	adminUser<< 
=<< 
new<< 
IdentityUser<< (
{== 	
UserName>> 
=>> 

adminEmail>> !
,>>! "
Email?? 
=?? 

adminEmail?? 
,?? 
EmailConfirmed@@ 
=@@ 
true@@ !
}AA 	
;AA	 

varCC 
resultCC 
=CC 
awaitCC 
userManagerCC &
.CC& '
CreateAsyncCC' 2
(CC2 3
	adminUserCC3 <
,CC< =
$strCC> I
)CCI J
;CCJ K
ifEE 

(EE 
resultEE 
.EE 
	SucceededEE 
)EE 
{FF 	
awaitGG 
userManagerGG 
.GG 
AddToRoleAsyncGG ,
(GG, -
	adminUserGG- 6
,GG6 7
$strGG8 ?
)GG? @
;GG@ A
}HH 	
}II 
privateKK 
staticKK 
asyncKK 
TaskKK 
SeedDoctorAsyncKK -
(KK- .
UserManagerLL 
<LL 
IdentityUserLL  
>LL  !
userManagerLL" -
,LL- .
HealthAxisDbContextMM 
contextMM #
,MM# $
stringNN 
fullNameNN 
,NN 
stringOO 
emailOO 
,OO  
DoctorSpecialisationPP 
specialisationPP +
,PP+ ,
DateOnlyQQ 
practiceStartDateQQ "
,QQ" #
decimalRR 
consultationFeeRR 
)RR  
{SS 
varTT 
existingUserTT 
=TT 
awaitTT  
userManagerTT! ,
.TT, -
FindByEmailAsyncTT- =
(TT= >
emailTT> C
)TTC D
;TTD E
ifVV 

(VV 
existingUserVV 
==VV 
nullVV  
)VV  !
{WW 	
existingUserXX 
=XX 
newXX 
IdentityUserXX +
{YY 
UserNameZZ 
=ZZ 
emailZZ  
,ZZ  !
Email[[ 
=[[ 
email[[ 
,[[ 
EmailConfirmed\\ 
=\\  
true\\! %
}]] 
;]] 
var__ 
result__ 
=__ 
await__ 
userManager__ *
.__* +
CreateAsync__+ 6
(__6 7
existingUser__7 C
,__C D
$str__E Q
)__Q R
;__R S
ifaa 
(aa 
!aa 
resultaa 
.aa 
	Succeededaa !
)aa! "
{bb 
returncc 
;cc 
}dd 
awaitff 
userManagerff 
.ff 
AddToRoleAsyncff ,
(ff, -
existingUserff- 9
,ff9 :
$strff; C
)ffC D
;ffD E
}gg 	
varii 
doctorExistsii 
=ii 
awaitii  
contextii! (
.ii( )
Doctorsii) 0
.jj 
AnyAsyncjj 
(jj 
doctorjj 
=>jj 
doctorjj  &
.jj& '
UserIdjj' -
==jj. 0
existingUserjj1 =
.jj= >
Idjj> @
)jj@ A
;jjA B
ifll 

(ll 
doctorExistsll 
)ll 
{mm 	
returnnn 
;nn 
}oo 	
varqq 
doctorqq 
=qq 
newqq 
Doctorqq 
{rr 	
UserIdss 
=ss 
existingUserss !
.ss! "
Idss" $
,ss$ %
FullNamett 
=tt 
fullNamett 
,tt  
Specialisationuu 
=uu 
specialisationuu +
,uu+ ,
PracticeStartDatevv 
=vv 
practiceStartDatevv  1
,vv1 2
ConsultationFeeww 
=ww 
consultationFeeww -
,ww- .
IsAvailablexx 
=xx 
truexx 
}yy 	
;yy	 

await{{ 
context{{ 
.{{ 
Doctors{{ 
.{{ 
AddAsync{{ &
({{& '
doctor{{' -
){{- .
;{{. /
await|| 
context|| 
.|| 
SaveChangesAsync|| &
(||& '
)||' (
;||( )
}}} 
}~~ ß:
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
:! "
IdentityDbContext# 4
<4 5
IdentityUser5 A
>A B
{		 
public

 

HealthAxisDbContext

 
(

 
DbContextOptions

 /
<

/ 0
HealthAxisDbContext

0 C
>

C D
options

E L
)

L M
: 	
base
 
( 
options 
) 
{ 
} 
public 

DbSet 
< 
Doctor 
> 
Doctors  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

DbSet 
< 
Patient 
> 
Patients "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

DbSet 
< 
Appointment 
> 
Appointments *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
public 

DbSet 
< 
HealthRecord 
> 
HealthRecords ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
	protected 
override 
void 
OnModelCreating +
(+ ,
ModelBuilder, 8
builder9 @
)@ A
{ 
base 
. 
OnModelCreating 
( 
builder $
)$ %
;% &
builder 
. 
Entity 
< 
IdentityUser #
># $
($ %
)% &
. 
HasOne 
< 
Doctor 
> 
( 
) 
. 
WithOne 
( 
doctor 
=> 
doctor %
.% &
User& *
)* +
. 
HasForeignKey 
< 
Doctor !
>! "
(" #
doctor# )
=>* ,
doctor- 3
.3 4
UserId4 :
): ;
. 
OnDelete 
( 
DeleteBehavior $
.$ %
Restrict% -
)- .
;. /
builder!! 
.!! 
Entity!! 
<!! 
IdentityUser!! #
>!!# $
(!!$ %
)!!% &
."" 
HasOne"" 
<"" 
Patient"" 
>"" 
("" 
)"" 
.## 
WithOne## 
(## 
patient## 
=>## 
patient##  '
.##' (
User##( ,
)##, -
.$$ 
HasForeignKey$$ 
<$$ 
Patient$$ "
>$$" #
($$# $
patient$$$ +
=>$$, .
patient$$/ 6
.$$6 7
UserId$$7 =
)$$= >
.%% 
OnDelete%% 
(%% 
DeleteBehavior%% $
.%%$ %
Restrict%%% -
)%%- .
;%%. /
builder'' 
.'' 
Entity'' 
<'' 
Appointment'' "
>''" #
(''# $
)''$ %
.(( 
HasOne(( 
((( 
appointment(( 
=>((  "
appointment((# .
.((. /
Patient((/ 6
)((6 7
.)) 
WithMany)) 
()) 
patient)) 
=>))  
patient))! (
.))( )
Appointments))) 5
)))5 6
.** 
HasForeignKey** 
(** 
appointment** &
=>**' )
appointment*** 5
.**5 6
	PatientId**6 ?
)**? @
.++ 
OnDelete++ 
(++ 
DeleteBehavior++ $
.++$ %
Restrict++% -
)++- .
;++. /
builder-- 
.-- 
Entity-- 
<-- 
Appointment-- "
>--" #
(--# $
)--$ %
... 
HasOne.. 
(.. 
appointment.. 
=>..  "
appointment..# .
.... /
Doctor../ 5
)..5 6
.// 
WithMany// 
(// 
doctor// 
=>// 
doctor//  &
.//& '
Appointments//' 3
)//3 4
.00 
HasForeignKey00 
(00 
appointment00 &
=>00' )
appointment00* 5
.005 6
DoctorId006 >
)00> ?
.11 
OnDelete11 
(11 
DeleteBehavior11 $
.11$ %
Restrict11% -
)11- .
;11. /
builder33 
.33 
Entity33 
<33 
Appointment33 "
>33" #
(33# $
)33$ %
.44 
Property44 
(44 
appointment44 !
=>44" $
appointment44% 0
.440 1
Status441 7
)447 8
.55 
HasConversion55 
<55 
string55 !
>55! "
(55" #
)55# $
.66 
HasMaxLength66 
(66 
$num66 
)66 
.77 

IsRequired77 
(77 
)77 
;77 
builder99 
.99 
Entity99 
<99 
Appointment99 "
>99" #
(99# $
)99$ %
.:: 
HasOne:: 
(:: 
appointment:: 
=>::  "
appointment::# .
.::. /
HealthRecord::/ ;
)::; <
.;; 
WithOne;; 
(;; 
record;; 
=>;; 
record;; %
.;;% &
Appointment;;& 1
);;1 2
.<< 
HasForeignKey<< 
<<< 
HealthRecord<< '
><<' (
(<<( )
record<<) /
=><<0 2
record<<3 9
.<<9 :
AppointmentId<<: G
)<<G H
.== 
OnDelete== 
(== 
DeleteBehavior== $
.==$ %
Restrict==% -
)==- .
;==. /
builder?? 
.?? 
Entity?? 
<?? 
HealthRecord?? #
>??# $
(??$ %
)??% &
.@@ 
HasIndex@@ 
(@@ 
record@@ 
=>@@ 
record@@  &
.@@& '
AppointmentId@@' 4
)@@4 5
.AA 
IsUniqueAA 
(AA 
)AA 
;AA 
builderCC 
.CC 
EntityCC 
<CC 
DoctorCC 
>CC 
(CC 
)CC  
.DD 
PropertyDD 
(DD 
doctorDD 
=>DD 
doctorDD  &
.DD& '
SpecialisationDD' 5
)DD5 6
.EE 
HasConversionEE 
<EE 
stringEE !
>EE! "
(EE" #
)EE# $
.FF 
HasMaxLengthFF 
(FF 
$numFF 
)FF 
.GG 

IsRequiredGG 
(GG 
)GG 
;GG 
}HH 
}II ™.
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
}** 
[,, 
HttpGet,, 
(,, 
$str,, &
),,& '
],,' (
[-- 
	Authorize-- 
(-- !
AuthenticationSchemes-- $
=--% &
JwtBearerDefaults--' 8
.--8 9 
AuthenticationScheme--9 M
,--M N
Roles--O T
=--U V
AppRoles--W _
.--_ `
PatientDoctor--` m
)--m n
]--n o
public.. 

async.. 
Task.. 
<.. 
IActionResult.. #
>..# $#
GetPatientHealthRecords..% <
(..< =
int// 
id// 
,// 
[00 	
	FromQuery00	 
]00 
PaginationQueryDto00 &

pagination00' 1
)001 2
{11 
if22 

(22 
User22 
.22 
IsInRole22 
(22 
AppRoles22 "
.22" #
Patient22# *
)22* +
&&22, .
!22/ 0
IsOwnPatientId220 >
(22> ?
id22? A
)22A B
)22B C
{33 	
return44 
Forbid44 
(44 
)44 
;44 
}55 	
var77 
records77 
=77 
await77 
patientService77 *
.77* +(
GetPatientHealthRecordsAsync77+ G
(77G H
id77H J
,77J K

pagination77L V
)77V W
;77W X
return99 
Ok99 
(99 
records99 
)99 
;99 
}:: 
private<< 
bool<< 
IsOwnPatientId<< 
(<<  
int<<  #
	patientId<<$ -
)<<- .
{== 
var>> 

claimValue>> 
=>> 
User>> 
.>> 
FindFirstValue>> ,
(>>, -
AppClaimTypes>>- :
.>>: ;
	PatientId>>; D
)>>D E
;>>E F
return@@ 
int@@ 
.@@ 
TryParse@@ 
(@@ 

claimValue@@ &
,@@& '
out@@( +
var@@, /
loggedInPatientId@@0 A
)@@A B
&&@@C E
loggedInPatientIdAA  
==AA! #
	patientIdAA$ -
;AA- .
}BB 
}CC ú@
]C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\HealthRecordsController.cs
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
$str 
) 
] 
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
,I J
RolesK P
=Q R
AppRolesS [
.[ \
PatientDoctor\ i
)i j
]j k
public 
class #
HealthRecordsController $
($ % 
IHealthRecordService% 9
healthRecordService: M
)M N
:O P
ControllerBaseQ _
{ 
[ 
HttpGet 
( 
$str &
)& '
]' (
public 

async 
Task 
< 
IActionResult #
># $'
GetHealthRecordsByPatientId% @
(@ A
int 
	patientId 
, 
[ 	
	FromQuery	 
] 
PaginationQueryDto &

pagination' 1
)1 2
{ 
if 

( 
User 
. 
IsInRole 
( 
AppRoles "
." #
Patient# *
)* +
)+ ,
{ 	
if 
( 
! 
IsOwnPatientId 
(  
	patientId  )
)) *
)* +
{ 
return 
Forbid 
( 
) 
;  
} 
var 
patientRecords 
=  
await! &
healthRecordService' :
.: ;,
 GetHealthRecordsByPatientIdAsync; [
([ \
	patientId\ e
,e f

paginationg q
)q r
;r s
return 
Ok 
( 
patientRecords $
)$ %
;% &
} 	
if   

(   
User   
.   
IsInRole   
(   
AppRoles   "
.  " #
Doctor  # )
)  ) *
)  * +
{!! 	
var"" 
doctorId"" 
=""  
GetDoctorIdFromToken"" /
(""/ 0
)""0 1
;""1 2
if$$ 
($$ 
doctorId$$ 
==$$ 
null$$  
)$$  !
{%% 
return&& 
Forbid&& 
(&& 
)&& 
;&&  
}'' 
var)) 
doctorRecords)) 
=)) 
await))  %
healthRecordService))& 9
.))9 :7
+GetHealthRecordsByPatientIdAndDoctorIdAsync)): e
())e f
	patientId** 
,** 
doctorId++ 
.++ 
Value++ 
,++ 

pagination,, 
)-- 
;-- 
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
$str 
) 
] 
public 
class 
DoctorsController 
( 
IDoctorService -
doctorService. ;
); <
:= >
ControllerBase? M
{ 
[ 
HttpGet 
] 
[ 
AllowAnonymous 
] 
public 

async 
Task 
< 
IActionResult #
># $

GetDoctors% /
(/ 0
[ 	
	FromQuery	 
]  
DoctorSpecialisation (
?( )
specialisation* 8
,8 9
[ 	
	FromQuery	 
] 
PaginationQueryDto &

pagination' 1
)1 2
{ 
var 
doctors 
= 
await 
doctorService )
.) *
GetAllDoctorsAsync* <
(< =

pagination= G
,G H
specialisationI W
)W X
;X Y
return 
Ok 
( 
doctors 
) 
; 
} 
[ 
HttpGet 
( 
$str 
) 
] 
[ 
AllowAnonymous 
] 
public 

async 
Task 
< 
IActionResult #
># $
GetDoctorById% 2
(2 3
int3 6
id7 9
)9 :
{ 
var   
doctor   
=   
await   
doctorService   (
.  ( )
GetDoctorByIdAsync  ) ;
(  ; <
id  < >
)  > ?
;  ? @
if"" 

("" 
doctor"" 
=="" 
null"" 
)"" 
{## 	
throw$$ 
new$$ 
NotFoundException$$ '
($$' (
ErrorMessages$$( 5
.$$5 6
DoctorNotFound$$6 D
)$$D E
;$$E F
}%% 	
return'' 
Ok'' 
('' 
doctor'' 
)'' 
;'' 
}(( 
[** 
HttpGet** 
(** 
$str** $
)**$ %
]**% &
[++ 
AllowAnonymous++ 
]++ 
public,, 

async,, 
Task,, 
<,, 
IActionResult,, #
>,,# $
GetAvailability,,% 4
(,,4 5
int,,5 8
id,,9 ;
),,; <
{-- 
var.. 
availability.. 
=.. 
await..  
doctorService..! .
.... / 
GetAvailabilityAsync../ C
(..C D
id..D F
)..F G
;..G H
if00 

(00 
availability00 
==00 
null00  
)00  !
{11 	
throw22 
new22 
NotFoundException22 '
(22' (
ErrorMessages22( 5
.225 6
DoctorNotFound226 D
)22D E
;22E F
}33 	
return55 
Ok55 
(55 
availability55 
)55 
;55  
}66 
[88 
HttpPut88 
(88 
$str88 $
)88$ %
]88% &
[99 
	Authorize99 
(99 !
AuthenticationSchemes99 $
=99% &
JwtBearerDefaults99' 8
.998 9 
AuthenticationScheme999 M
,99M N
Roles99O T
=99U V
AppRoles99W _
.99_ `
DoctorAdmin99` k
)99k l
]99l m
public:: 

async:: 
Task:: 
<:: 
IActionResult:: #
>::# $
UpdateAvailability::% 7
(::7 8
int::8 ;
id::< >
,::> ?'
UpdateDoctorAvailabilityDto::@ [
request::\ c
)::c d
{;; 
var<< 
currentRole<< 
=<< 
GetCurrentRole<< (
(<<( )
)<<) *
;<<* +
if>> 

(>> 
currentRole>> 
==>> 
null>> 
)>>  
{?? 	
return@@ 
Forbid@@ 
(@@ 
)@@ 
;@@ 
}AA 	
varCC 
availabilityCC 
=CC 
awaitCC  
doctorServiceCC! .
.CC. /#
UpdateAvailabilityAsyncCC/ F
(CCF G
idDD 
,DD 
requestEE 
,EE 
currentRoleFF 
,FF  
GetDoctorIdFromTokenGG  
(GG  !
)GG! "
)GG" #
;GG# $
returnII 
OkII 
(II 
availabilityII 
)II 
;II  
}JJ 
privateLL 
stringLL 
?LL 
GetCurrentRoleLL "
(LL" #
)LL# $
{MM 
ifNN 

(NN 
UserNN 
.NN 
IsInRoleNN 
(NN 
AppRolesNN "
.NN" #
AdminNN# (
)NN( )
)NN) *
{OO 	
returnPP 
AppRolesPP 
.PP 
AdminPP !
;PP! "
}QQ 	
ifSS 

(SS 
UserSS 
.SS 
IsInRoleSS 
(SS 
AppRolesSS "
.SS" #
DoctorSS# )
)SS) *
)SS* +
{TT 	
returnUU 
AppRolesUU 
.UU 
DoctorUU "
;UU" #
}VV 	
returnXX 
nullXX 
;XX 
}YY 
private[[ 
int[[ 
?[[  
GetDoctorIdFromToken[[ %
([[% &
)[[& '
{\\ 
var]] 

claimValue]] 
=]] 
User]] 
.]] 
FindFirstValue]] ,
(]], -
AppClaimTypes]]- :
.]]: ;
DoctorId]]; C
)]]C D
;]]D E
return__ 
int__ 
.__ 
TryParse__ 
(__ 

claimValue__ &
,__& '
out__( +
var__, /
doctorId__0 8
)__8 9
?`` 
doctorId`` 
:aa 
nullaa 
;aa 
}bb 
}cc ô!
TC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\AuthController.cs
	namespace 	

HealthAxis
 
. 
API 
. 
Controllers $
;$ %
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public		 
class		 
AuthController		 
(		 
IAuthService		 (
authService		) 4
)		4 5
:		6 7
ControllerBase		8 F
{

 
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $
Register% -
(- .
RegisterDto. 9
request: A
)A B
{ 
var 
result 
= 
await 
authService &
.& '
RegisterAsync' 4
(4 5
request5 <
)< =
;= >
if 

( 
! 
result 
. 
Success 
) 
{ 	
return 

BadRequest 
( 
new !
{" #
message$ +
=, -
result. 4
.4 5
Message5 <
}= >
)> ?
;? @
} 	
return 
Created 
( 
string 
. 
Empty #
,# $
new% (
{ 	
message 
= 
result 
. 
Message $
,$ %
userId 
= 
result 
. 
UserId "
} 	
)	 

;
 
} 
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $
Login% *
(* +
LoginDto+ 3
request4 ;
); <
{ 
var 
result 
= 
await 
authService &
.& '

LoginAsync' 1
(1 2
request2 9
)9 :
;: ;
if!! 

(!! 
!!! 
result!! 
.!! 
Success!! 
||!! 
result!! %
.!!% &
Response!!& .
==!!/ 1
null!!2 6
)!!6 7
{"" 	
return## 
Unauthorized## 
(##  
new##  #
{##$ %
message##& -
=##. /
result##0 6
.##6 7
Message##7 >
}##? @
)##@ A
;##A B
}$$ 	
return&& 
Ok&& 
(&& 
result&& 
.&& 
Response&& !
)&&! "
;&&" #
}'' 
[)) 
HttpPost)) 
()) 
$str)) 
))) 
])) 
public** 

async** 
Task** 
<** 
IActionResult** #
>**# $
RefreshToken**% 1
(**1 2"
RefreshTokenRequestDto**2 H
request**I P
)**P Q
{++ 
var,, 
result,, 
=,, 
await,, 
authService,, &
.,,& '
RefreshTokenAsync,,' 8
(,,8 9
request,,9 @
),,@ A
;,,A B
if.. 

(.. 
!.. 
result.. 
... 
Success.. 
||.. 
result.. %
...% &
Response..& .
==../ 1
null..2 6
)..6 7
{// 	
return00 
Unauthorized00 
(00  
new00  #
{00$ %
message00& -
=00. /
result000 6
.006 7
Message007 >
}00? @
)00@ A
;00A B
}11 	
return33 
Ok33 
(33 
result33 
.33 
Response33 !
)33! "
;33" #
}44 
}55 ±j
\C:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\AppointmentsController.cs
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
$str 
) 
] 
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
,I J
RolesK P
=Q R
AppRolesS [
.[ \
PatientDoctorAdmin\ n
)n o
]o p
public 
class "
AppointmentsController #
(# $
IAppointmentService$ 7
appointmentService8 J
)J K
:L M
ControllerBaseN \
{ 
[ 
HttpGet 
] 
public 

async 
Task 
< 
IActionResult #
># $
GetAppointments% 4
(4 5
[ 	
	FromQuery	 
] 
DateOnly 
? 
date "
," #
[ 	
	FromQuery	 
] 
PaginationQueryDto &

pagination' 1
)1 2
{ 
if 

( 
User 
. 
IsInRole 
( 
AppRoles "
." #
Admin# (
)( )
)) *
{ 	
var 
appointments 
= 
await $
appointmentService% 7
.7 8#
GetAllAppointmentsAsync8 O
(O P

paginationP Z
)Z [
;[ \
return 
Ok 
( 
appointments "
)" #
;# $
} 	
if 

( 
User 
. 
IsInRole 
( 
AppRoles "
." #
Patient# *
)* +
)+ ,
{ 	
var 
	patientId 
= !
GetPatientIdFromToken 1
(1 2
)2 3
;3 4
if 
( 
	patientId 
== 
null !
)! "
{   
return!! 
Forbid!! 
(!! 
)!! 
;!!  
}"" 
var$$ 
appointments$$ 
=$$ 
await$$ $
appointmentService$$% 7
.$$7 8+
GetAppointmentsByPatientIdAsync$$8 W
($$W X
	patientId$$X a
.$$a b
Value$$b g
,$$g h

pagination$$i s
)$$s t
;$$t u
return%% 
Ok%% 
(%% 
appointments%% "
)%%" #
;%%# $
}&& 	
if(( 

((( 
User(( 
.(( 
IsInRole(( 
((( 
AppRoles(( "
.((" #
Doctor((# )
)(() *
)((* +
{)) 	
var** 
doctorId** 
=**  
GetDoctorIdFromToken** /
(**/ 0
)**0 1
;**1 2
if,, 
(,, 
doctorId,, 
==,, 
null,,  
),,  !
{-- 
return.. 
Forbid.. 
(.. 
).. 
;..  
}// 
var11 
appointments11 
=11 
date11 #
.11# $
HasValue11$ ,
?22 
await22 
appointmentService22 *
.22* +1
%GetAppointmentsByDoctorIdAndDateAsync22+ P
(22P Q
doctorId22Q Y
.22Y Z
Value22Z _
,22_ `
date22a e
.22e f
Value22f k
,22k l

pagination22m w
)22w x
:33 
await33 
appointmentService33 *
.33* +*
GetAppointmentsByDoctorIdAsync33+ I
(33I J
doctorId33J R
.33R S
Value33S X
,33X Y

pagination33Z d
)33d e
;33e f
return55 
Ok55 
(55 
appointments55 "
)55" #
;55# $
}66 	
return88 
Forbid88 
(88 
)88 
;88 
}99 
[;; 
HttpGet;; 
(;; 
$str;; 
);; 
];; 
public<< 

async<< 
Task<< 
<<< 
IActionResult<< #
><<# $
GetAppointmentById<<% 7
(<<7 8
int<<8 ;
id<<< >
)<<> ?
{== 
var>> 
appointment>> 
=>> 
await>> 
appointmentService>>  2
.>>2 3#
GetAppointmentByIdAsync>>3 J
(>>J K
id>>K M
)>>M N
;>>N O
if@@ 

(@@ 
User@@ 
.@@ 
IsInRole@@ 
(@@ 
AppRoles@@ "
.@@" #
Patient@@# *
)@@* +
&&@@, .!
GetPatientIdFromToken@@/ D
(@@D E
)@@E F
!=@@G I
appointment@@J U
.@@U V
	PatientId@@V _
)@@_ `
{AA 	
returnBB 
ForbidBB 
(BB 
)BB 
;BB 
}CC 	
ifEE 

(EE 
UserEE 
.EE 
IsInRoleEE 
(EE 
AppRolesEE "
.EE" #
DoctorEE# )
)EE) *
&&EE+ - 
GetDoctorIdFromTokenEE. B
(EEB C
)EEC D
!=EEE G
appointmentEEH S
.EES T
DoctorIdEET \
)EE\ ]
{FF 	
returnGG 
ForbidGG 
(GG 
)GG 
;GG 
}HH 	
returnJJ 
OkJJ 
(JJ 
appointmentJJ 
)JJ 
;JJ 
}KK 
[MM 
HttpPostMM 
]MM 
[NN 
	AuthorizeNN 
(NN !
AuthenticationSchemesNN $
=NN% &
JwtBearerDefaultsNN' 8
.NN8 9 
AuthenticationSchemeNN9 M
,NNM N
RolesNNO T
=NNU V
AppRolesNNW _
.NN_ `
PatientAdminNN` l
)NNl m
]NNm n
publicOO 

asyncOO 
TaskOO 
<OO 
IActionResultOO #
>OO# $
CreateAppointmentOO% 6
(OO6 7 
CreateAppointmentDtoOO7 K
requestOOL S
)OOS T
{PP 
ifQQ 

(QQ 
UserQQ 
.QQ 
IsInRoleQQ 
(QQ 
AppRolesQQ "
.QQ" #
PatientQQ# *
)QQ* +
)QQ+ ,
{RR 	
varSS 
	patientIdSS 
=SS !
GetPatientIdFromTokenSS 1
(SS1 2
)SS2 3
;SS3 4
ifUU 
(UU 
	patientIdUU 
==UU 
nullUU !
||UU" $
	patientIdUU% .
.UU. /
ValueUU/ 4
!=UU5 7
requestUU8 ?
.UU? @
	PatientIdUU@ I
)UUI J
{VV 
returnWW 
ForbidWW 
(WW 
)WW 
;WW  
}XX 
}YY 	
var[[ 
appointment[[ 
=[[ 
await[[ 
appointmentService[[  2
.[[2 3"
CreateAppointmentAsync[[3 I
([[I J
request[[J Q
)[[Q R
;[[R S
return]] 
appointment]] 
==]] 
null]] "
?^^ 
throw^^ 
new^^ %
InvalidOperationException^^ 1
(^^1 2
ErrorMessages^^2 ?
.^^? @%
UnableToCreateAppointment^^@ Y
)^^Y Z
:__ 
CreatedAtAction__ 
(__ 
nameof__ $
(__$ %
GetAppointmentById__% 7
)__7 8
,__8 9
new__: =
{__> ?
id__@ B
=__C D
appointment__E P
.__P Q
Id__Q S
}__T U
,__U V
appointment__W b
)__b c
;__c d
}`` 
[bb 
HttpPutbb 
(bb 
$strbb 
)bb 
]bb  
[cc 
	Authorizecc 
(cc !
AuthenticationSchemescc $
=cc% &
JwtBearerDefaultscc' 8
.cc8 9 
AuthenticationSchemecc9 M
,ccM N
RolesccO T
=ccU V
AppRolesccW _
.cc_ `
PatientDoctorAdmincc` r
)ccr s
]ccs t
publicdd 

asyncdd 
Taskdd 
<dd 
IActionResultdd #
>dd# $#
UpdateAppointmentStatusdd% <
(dd< =
intdd= @
idddA C
,ddC D&
UpdateAppointmentStatusDtoddE _
requestdd` g
)ddg h
{ee 
varff 
currentRoleff 
=ff 
GetCurrentRoleff (
(ff( )
)ff) *
;ff* +
ifhh 

(hh 
currentRolehh 
==hh 
nullhh 
)hh  
{ii 	
returnjj 
Forbidjj 
(jj 
)jj 
;jj 
}kk 	
varmm 
appointmentmm 
=mm 
awaitmm 
appointmentServicemm  2
.mm2 3(
UpdateAppointmentStatusAsyncmm3 O
(mmO P
idnn 
,nn 
requestoo 
,oo 
currentRolepp 
,pp !
GetPatientIdFromTokenqq !
(qq! "
)qq" #
,qq# $ 
GetDoctorIdFromTokenrr  
(rr  !
)rr! "
)rr" #
;rr# $
returntt 
Oktt 
(tt 
appointmenttt 
)tt 
;tt 
}uu 
[ww 

HttpDeleteww 
(ww 
$strww 
)ww 
]ww 
[xx 
	Authorizexx 
(xx !
AuthenticationSchemesxx $
=xx% &
JwtBearerDefaultsxx' 8
.xx8 9 
AuthenticationSchemexx9 M
,xxM N
RolesxxO T
=xxU V
AppRolesxxW _
.xx_ `
Adminxx` e
)xxe f
]xxf g
publicyy 

asyncyy 
Taskyy 
<yy 
IActionResultyy #
>yy# $
DeleteAppointmentyy% 6
(yy6 7
intyy7 :
idyy; =
)yy= >
{zz 
var{{ 
appointment{{ 
={{ 
await{{ 
appointmentService{{  2
.{{2 3"
DeleteAppointmentAsync{{3 I
({{I J
id{{J L
){{L M
;{{M N
return}} 
Ok}} 
(}} 
appointment}} 
)}} 
;}} 
}~~ 
private
ÄÄ 
string
ÄÄ 
?
ÄÄ 
GetCurrentRole
ÄÄ "
(
ÄÄ" #
)
ÄÄ# $
{
ÅÅ 
if
ÇÇ 

(
ÇÇ 
User
ÇÇ 
.
ÇÇ 
IsInRole
ÇÇ 
(
ÇÇ 
AppRoles
ÇÇ "
.
ÇÇ" #
Admin
ÇÇ# (
)
ÇÇ( )
)
ÇÇ) *
{
ÉÉ 	
return
ÑÑ 
AppRoles
ÑÑ 
.
ÑÑ 
Admin
ÑÑ !
;
ÑÑ! "
}
ÖÖ 	
if
áá 

(
áá 
User
áá 
.
áá 
IsInRole
áá 
(
áá 
AppRoles
áá "
.
áá" #
Doctor
áá# )
)
áá) *
)
áá* +
{
àà 	
return
ââ 
AppRoles
ââ 
.
ââ 
Doctor
ââ "
;
ââ" #
}
ää 	
if
åå 

(
åå 
User
åå 
.
åå 
IsInRole
åå 
(
åå 
AppRoles
åå "
.
åå" #
Patient
åå# *
)
åå* +
)
åå+ ,
{
çç 	
return
éé 
AppRoles
éé 
.
éé 
Patient
éé #
;
éé# $
}
èè 	
return
ëë 
null
ëë 
;
ëë 
}
íí 
private
îî 
int
îî 
?
îî #
GetPatientIdFromToken
îî &
(
îî& '
)
îî' (
{
ïï 
var
ññ 

claimValue
ññ 
=
ññ 
User
ññ 
.
ññ 
FindFirstValue
ññ ,
(
ññ, -
AppClaimTypes
ññ- :
.
ññ: ;
	PatientId
ññ; D
)
ññD E
;
ññE F
return
òò 
int
òò 
.
òò 
TryParse
òò 
(
òò 

claimValue
òò &
,
òò& '
out
òò( +
var
òò, /
	patientId
òò0 9
)
òò9 :
?
ôô 
	patientId
ôô 
:
öö 
null
öö 
;
öö 
}
õõ 
private
ùù 
int
ùù 
?
ùù "
GetDoctorIdFromToken
ùù %
(
ùù% &
)
ùù& '
{
ûû 
var
üü 

claimValue
üü 
=
üü 
User
üü 
.
üü 
FindFirstValue
üü ,
(
üü, -
AppClaimTypes
üü- :
.
üü: ;
DoctorId
üü; C
)
üüC D
;
üüD E
return
°° 
int
°° 
.
°° 
TryParse
°° 
(
°° 

claimValue
°° &
,
°°& '
out
°°( +
var
°°, /
doctorId
°°0 8
)
°°8 9
?
¢¢ 
doctorId
¢¢ 
:
££ 
null
££ 
;
££ 
}
§§ 
}•• √$
UC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Controllers\AdminController.cs
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
$str 
) 
] 
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
,I J
RolesK P
=Q R
AppRolesS [
.[ \
Admin\ a
)a b
]b c
public 
class 
AdminController 
( 
IAdminService *
adminService+ 7
)7 8
:9 :
ControllerBase; I
{ 
[ 
HttpGet 
( 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $

GetDoctors% /
(/ 0
[0 1
	FromQuery1 :
]: ;
PaginationQueryDto< N

paginationO Y
)Y Z
{ 
var 
doctors 
= 
await 
adminService (
.( )
GetDoctorsAsync) 8
(8 9

pagination9 C
)C D
;D E
return 
Ok 
( 
doctors 
) 
; 
} 
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $
CreateDoctor% 1
(1 2
CreateDoctorDto2 A
requestB I
)I J
{ 
var 
doctor 
= 
await 
adminService '
.' (
CreateDoctorAsync( 9
(9 :
request: A
)A B
;B C
return 
doctor 
== 
null 
? 
throw 
new %
InvalidOperationException 1
(1 2
ErrorMessages2 ?
.? @ 
UnableToCreateDoctor@ T
)T U
: 
Created 
( 
$" 
$str +
{+ ,
doctor, 2
.2 3
Id3 5
}5 6
"6 7
,7 8
doctor9 ?
)? @
;@ A
} 
[!! 
HttpPut!! 
(!! 
$str!! 
)!!  
]!!  !
public"" 

async"" 
Task"" 
<"" 
IActionResult"" #
>""# $
UpdateDoctor""% 1
(""1 2
int""2 5
id""6 8
,""8 9
UpdateDoctorDto"": I
request""J Q
)""Q R
{## 
var$$ 
doctor$$ 
=$$ 
await$$ 
adminService$$ '
.$$' (
UpdateDoctorAsync$$( 9
($$9 :
id$$: <
,$$< =
request$$> E
)$$E F
;$$F G
return&& 
Ok&& 
(&& 
doctor&& 
)&& 
;&& 
}'' 
[)) 
HttpGet)) 
()) 
$str)) #
)))# $
]))$ %
public** 

async** 
Task** 
<** 
IActionResult** #
>**# $!
GetAppointmentReports**% :
(**: ;
)**; <
{++ 
var,, 
reports,, 
=,, 
await,, 
adminService,, (
.,,( )&
GetAppointmentReportsAsync,,) C
(,,C D
),,D E
;,,E F
return.. 
Ok.. 
(.. 
reports.. 
).. 
;.. 
}// 
[11 
HttpGet11 
(11 
$str11 2
)112 3
]113 4
public22 

async22 
Task22 
<22 
IActionResult22 #
>22# $-
!GetAppointmentHealthRecordReports22% F
(22F G
)22G H
{33 
var44 
reports44 
=44 
await44 
adminService44 (
.44( )2
&GetAppointmentHealthRecordReportsAsync44) O
(44O P
)44P Q
;44Q R
return66 
Ok66 
(66 
reports66 
)66 
;66 
}77 
}88 Õ=
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
string *
OnlyPatientRegistrationAllowed 6
=7 8
$str9 s
;s t
public 

const 
string "
EmailAlreadyRegistered .
=/ 0
$str1 O
;O P
public 

const 
string 
EmailAlreadyExists *
=+ ,
$str- U
;U V
public 

const 
string 
PatientNotFound '
=( )
$str* >
;> ?
public 

const 
string "
PatientAccountNotFound .
=/ 0
$str1 M
;M N
public 

const 
string "
PatientProfileNotFound .
=/ 0
$str1 _
;_ `
public 

const 
string 
DoctorNotFound &
=' (
$str) <
;< =
public 

const 
string '
DoctorNotFoundAfterCreation 3
=4 5
$str6 X
;X Y
public 

const 
string !
DoctorProfileNotFound -
=. /
$str0 ]
;] ^
public 

const 
string 
DoctorUnavailable )
=* +
$str, W
;W X
public!! 

const!! 
string!! "
DoctorAvailableMessage!! .
=!!/ 0
$str!!1 G
;!!G H
public## 

const## 
string## $
DoctorUnavailableMessage## 0
=##1 2
$str##3 M
;##M N
public%% 

const%% 
string%% @
4DoctorCannotDeactivateWithConfirmedAppointmentsToday%% L
=%%M N
$str	%%O “
;
%%“ ”
public'' 

const'' 
string'' /
#DoctorsCanUpdateOnlyOwnAvailability'' ;
=''< =
$str''> o
;''o p
public)) 

const)) 
string)) -
!DoctorEmergencyCancellationReason)) 9
=)): ;
$str))< 
;	)) Ä
public++ 

const++ 
string++ 
AppointmentNotFound++ +
=++, -
$str++. F
;++F G
public-- 

const-- 
string-- ,
 AppointmentNotFoundAfterCreation-- 8
=--9 :
$str--; b
;--b c
public// 

const// 
string// )
AppointmentDateCannotBeInPast// 5
=//6 7
$str//8 a
;//a b
public11 

const11 
string11 6
*AppointmentMustBeBookedAtLeast24HoursAhead11 B
=11C D
$str	11E è
;
11è ê
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
$str	77G í
;
77í ì
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
$strCCF y
;CCy z
publicEE 

constEE 
stringEE 5
)AppointmentCannotBeCancelledWithin24HoursEE A
=EEB C
$str	EED å
;
EEå ç
publicGG 

constGG 
stringGG 7
+AppointmentCompletedOnlyThroughHealthRecordGG C
=GGD E
$str	GGF á
;
GGá à
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
$str	KK@ ∞
;
KK∞ ±
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
$str	SSN ¢
;
SS¢ £
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
$str	YYK é
;
YYé è
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
$str	]]H Ö
;
]]Ö Ü
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
;ggV W
}hh –	
LC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Constants\AppRoles.cs
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
class 
AppRoles 
{ 
public 

const 
string 
Admin 
= 
$str  '
;' (
public 

const 
string 
Doctor 
=  
$str! )
;) *
public		 

const		 
string		 
Patient		 
=		  !
$str		" +
;		+ ,
public 

const 
string 
DoctorAdmin #
=$ %
$str& 4
;4 5
public 

const 
string 
PatientDoctor %
=& '
$str( 8
;8 9
public 

const 
string 
PatientAdmin $
=% &
$str' 6
;6 7
public 

const 
string 
PatientDoctorAdmin *
=+ ,
$str- C
;C D
} ¬
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.API\Constants\AppClaimTypes.cs
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
AppClaimTypes !
{ 
public 

const 
string 
UserId 
=  
$str! )
;) *
public 

const 
string 
Role 
= 
$str %
;% &
public		 

const		 
string		 
	PatientId		 !
=		" #
$str		$ /
;		/ 0
public 

const 
string 
DoctorId  
=! "
$str# -
;- .
} 