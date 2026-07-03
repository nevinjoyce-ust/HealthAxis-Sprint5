ù
RC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\ITokenService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
;# $
public 
	interface 
ITokenService 
{ 
Task 
SetAccessTokenAsync	 
( 
string #
token$ )
)) *
;* +
Task 
< 	
string	 
? 
> 
GetAccessTokenAsync %
(% &
)& '
;' (
Task "
RemoveAccessTokenAsync	 
(  
)  !
;! "
Task 
ClearTokensAsync	 
( 
) 
; 
} ±
VC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\Impl\TokenService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
.# $
Impl$ (
;( )
public 
class 
TokenService 
: 
ITokenService )
{ 
private 
readonly 

IJSRuntime 

_jsRuntime  *
;* +
private		 
const		 
string		 
AccessTokenKey		 '
=		( )
$str		* F
;		F G
public 

TokenService 
( 

IJSRuntime "
	jsRuntime# ,
), -
{ 

_jsRuntime 
= 
	jsRuntime 
; 
} 
public 

async 
Task 
SetAccessTokenAsync )
() *
string* 0
token1 6
)6 7
{ 
await 

_jsRuntime 
. 
InvokeVoidAsync (
(( )
$str) ?
,? @
AccessTokenKeyA O
,O P
tokenQ V
)V W
;W X
} 
public 

async 
Task 
< 
string 
? 
> 
GetAccessTokenAsync 2
(2 3
)3 4
{ 
return 
await 

_jsRuntime 
.  
InvokeAsync  +
<+ ,
string, 2
?2 3
>3 4
(4 5
$str5 K
,K L
AccessTokenKeyM [
)[ \
;\ ]
} 
public 

async 
Task "
RemoveAccessTokenAsync ,
(, -
)- .
{ 
await 

_jsRuntime 
. 
InvokeVoidAsync (
(( )
$str) B
,B C
AccessTokenKeyD R
)R S
;S T
}   
public44 

async44 
Task44 
ClearTokensAsync44 &
(44& '
)44' (
{55 
await66 "
RemoveAccessTokenAsync66 $
(66$ %
)66% &
;66& '
}:: 
};; ¶@
\C:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\Impl\DoctorAdminService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
.# $
Impl$ (
;( )
public

 
class

 
DoctorAdminService

 
(

  

HttpClient

  *

httpClient

+ 5
)

5 6
:

7 8
IDoctorAdminService

9 L
{ 
public 

async 
Task 
< 
PagedResultDto $
<$ %
	DoctorDto% .
>. /
>/ 0
GetDoctorsAsync1 @
(@ A
PaginationQueryDto 

pagination %
,% &
string 
? 
search 
= 
null 
,  
DoctorSpecialisation 
? 
specialisation ,
=- .
null/ 3
)3 4
{ 
var 
url 
= 
$" 
$str 1
{1 2

pagination2 <
.< =

PageNumber= G
}G H
$strH R
{R S

paginationS ]
.] ^
PageSize^ f
}f g
"g h
;h i
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
url 
+= 
$" 
$str 
{ 
Uri !
.! "
EscapeDataString" 2
(2 3
search3 9
.9 :
Trim: >
(> ?
)? @
)@ A
}A B
"B C
;C D
} 	
if 

( 
specialisation 
. 
HasValue #
)# $
{ 	
url 
+= 
$" 
$str %
{% &
Uri& )
.) *
EscapeDataString* :
(: ;
specialisation; I
.I J
ValueJ O
.O P
ToStringP X
(X Y
)Y Z
)Z [
}[ \
"\ ]
;] ^
} 	
return 
await 

httpClient 
.  
GetFromJsonAsync  0
<0 1
PagedResultDto1 ?
<? @
	DoctorDto@ I
>I J
>J K
(K L
urlL O
)O P
?? 
new 
PagedResultDto !
<! "
	DoctorDto" +
>+ ,
(, -
)- .
;. /
} 
public!! 

async!! 
Task!! 
<!! 
ApiResponse!! !
<!!! "
	DoctorDto!!" +
>!!+ ,
>!!, -
CreateDoctorAsync!!. ?
(!!? @
CreateDoctorDto!!@ O
request!!P W
)!!W X
{"" 
var## 
response## 
=## 
await## 

httpClient## '
.##' (
PostAsJsonAsync##( 7
(##7 8
$str##8 K
,##K L
request##M T
)##T U
;##U V
return%% 
await%% 
ApiResponseHandler%% '
.%%' (
ReadResponseAsync%%( 9
<%%9 :
	DoctorDto%%: C
>%%C D
(%%D E
response&& 
,&& 
$str'' &
)''& '
;''' (
}(( 
public** 

async** 
Task** 
<** 
ApiResponse** !
<**! "
	DoctorDto**" +
>**+ ,
>**, -
UpdateDoctorAsync**. ?
(**? @
int**@ C
id**D F
,**F G
UpdateDoctorDto**H W
request**X _
)**_ `
{++ 
var,, 
response,, 
=,, 
await,, 

httpClient,, '
.,,' (
PutAsJsonAsync,,( 6
(,,6 7
$",,7 9
$str,,9 K
{,,K L
id,,L N
},,N O
",,O P
,,,P Q
request,,R Y
),,Y Z
;,,Z [
return.. 
await.. 
ApiResponseHandler.. '
...' (
ReadResponseAsync..( 9
<..9 :
	DoctorDto..: C
>..C D
(..D E
response// 
,// 
$str00 &
)00& '
;00' (
}11 
public33 

async33 
Task33 
<33 
ApiResponse33 !
<33! "
string33" (
>33( )
>33) *$
ResetDoctorPasswordAsync33+ C
(33C D
int33D G
id33H J
,33J K!
AdminResetPasswordDto33L a
request33b i
)33i j
{44 
var55 
response55 
=55 
await55 

httpClient55 '
.55' (
PutAsJsonAsync55( 6
(556 7
$"557 9
$str559 K
{55K L
id55L N
}55N O
$str55O X
"55X Y
,55Y Z
request55[ b
)55b c
;55c d
return77 
await77 
ApiResponseHandler77 '
.77' ($
ReadMessageResponseAsync77( @
(77@ A
response88 
,88 
$str99 .
,99. /
$str:: 1
)::1 2
;::2 3
};; 
public== 

async== 
Task== 
<== 
ApiResponse== !
<==! "!
DoctorAvailabilityDto==" 7
>==7 8
>==8 9#
UpdateAvailabilityAsync==: Q
(==Q R
int>> 
id>> 

,>>
 '
UpdateDoctorAvailabilityDto?? 
request??  '
)??' (
{@@ 
varAA 
responseAA 
=AA 
awaitAA 

httpClientAA '
.AA' (
PutAsJsonAsyncAA( 6
(AA6 7
$"BB 
$strBB 
{BB 
idBB 
}BB 
$strBB +
"BB+ ,
,BB, -
requestCC 
)CC 
;CC 
returnEE 
awaitEE 
ApiResponseHandlerEE '
.EE' (
ReadResponseAsyncEE( 9
<EE9 :!
DoctorAvailabilityDtoEE: O
>EEO P
(EEP Q
responseFF 
,FF 
$strGG 3
)GG3 4
;GG4 5
}HH 
publicJJ 

asyncJJ 
TaskJJ 
<JJ 
PagedResultDtoJJ $
<JJ$ %
AppointmentDtoJJ% 3
>JJ3 4
>JJ4 5&
GetDoctorAppointmentsAsyncJJ6 P
(JJP Q
intKK 
doctorIdKK 
,KK 
AppointmentStatusLL 
?LL 
statusLL !
,LL! "
PaginationQueryDtoMM 

paginationMM %
)MM% &
{NN 
varOO 
urlOO 
=OO 
$"OO 
$strOO &
{OO& '
doctorIdOO' /
}OO/ 0
$strOO0 I
{OOI J

paginationOOJ T
.OOT U

PageNumberOOU _
}OO_ `
$strOO` j
{OOj k

paginationOOk u
.OOu v
PageSizeOOv ~
}OO~ 
"	OO Ä
;
OOÄ Å
ifQQ 

(QQ 
statusQQ 
.QQ 
HasValueQQ 
)QQ 
{RR 	
urlSS 
+=SS 
$"SS 
$strSS 
{SS 
UriSS !
.SS! "
EscapeDataStringSS" 2
(SS2 3
statusSS3 9
.SS9 :
ValueSS: ?
.SS? @
ToStringSS@ H
(SSH I
)SSI J
)SSJ K
}SSK L
"SSL M
;SSM N
}TT 	
returnVV 
awaitVV 

httpClientVV 
.VV  
GetFromJsonAsyncVV  0
<VV0 1
PagedResultDtoVV1 ?
<VV? @
AppointmentDtoVV@ N
>VVN O
>VVO P
(VVP Q
urlVVQ T
)VVT U
??WW 
newWW 
PagedResultDtoWW !
<WW! "
AppointmentDtoWW" 0
>WW0 1
(WW1 2
)WW2 3
;WW3 4
}XX 
}YY ï$
\C:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\Impl\AdminReportService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
.# $
Impl$ (
;( )
public 
class 
AdminReportService 
(  

HttpClient  *

httpClient+ 5
)5 6
:7 8
IAdminReportService9 L
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
 
PagedResultDto

 $
<

$ % 
AppointmentReportDto

% 9
>

9 :
>

: ;&
GetAppointmentReportsAsync

< V
(

V W
PaginationQueryDto 

pagination %
)% &
{ 
var 
url 
= 
$" 
$str >
{> ?

pagination? I
.I J

PageNumberJ T
}T U
$strU _
{_ `

pagination` j
.j k
PageSizek s
}s t
"t u
;u v
return 
await 

httpClient 
.  
GetFromJsonAsync  0
<0 1
PagedResultDto1 ?
<? @ 
AppointmentReportDto@ T
>T U
>U V
(V W
urlW Z
)Z [
?? 
new 
PagedResultDto !
<! " 
AppointmentReportDto" 6
>6 7
(7 8
)8 9
;9 :
} 
public 

async 
Task 
< 
PagedResultDto $
<$ %
AppointmentDto% 3
>3 4
>4 5,
 GetAppointmentReportDetailsAsync6 V
(V W
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
{ 
var 
	dateValue 
= 
Uri 
. 
EscapeDataString ,
(, -
date- 1
.1 2
ToString2 :
(: ;
$str; G
)G H
)H I
;I J
var 
url 
= 
$" 
$str @
{@ A
	dateValueA J
}J K
$strK W
{W X

paginationX b
.b c

PageNumberc m
}m n
$strn x
{x y

pagination	y É
.
É Ñ
PageSize
Ñ å
}
å ç
"
ç é
;
é è
if 

( 
status 
. 
HasValue 
) 
{ 	
url 
+= 
$" 
$str 
{ 
Uri !
.! "
EscapeDataString" 2
(2 3
status3 9
.9 :
Value: ?
.? @
ToString@ H
(H I
)I J
)J K
}K L
"L M
;M N
} 	
return   
await   

httpClient   
.    
GetFromJsonAsync    0
<  0 1
PagedResultDto  1 ?
<  ? @
AppointmentDto  @ N
>  N O
>  O P
(  P Q
url  Q T
)  T U
??!! 
new!! 
PagedResultDto!! !
<!!! "
AppointmentDto!!" 0
>!!0 1
(!!1 2
)!!2 3
;!!3 4
}"" 
public$$ 

async$$ 
Task$$ 
<$$ 
ApiResponse$$ !
<$$! "
AppointmentDto$$" 0
>$$0 1
>$$1 2(
UpdateAppointmentStatusAsync$$3 O
($$O P
int%% 
appointmentId%% 
,%% &
UpdateAppointmentStatusDto&& "
request&&# *
)&&* +
{'' 
var(( 
response(( 
=(( 
await(( 

httpClient(( '
.((' (
PutAsJsonAsync((( 6
(((6 7
$")) 
$str)) 
{))  
appointmentId))  -
}))- .
$str)). 5
"))5 6
,))6 7
request** 
)** 
;** 
return,, 
await,, 
ApiResponseHandler,, '
.,,' (
ReadResponseAsync,,( 9
<,,9 :
AppointmentDto,,: H
>,,H I
(,,I J
response-- 
,-- 
$str.. 2
)..2 3
;..3 4
}// 
}00 ·-
UC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\Impl\AuthService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
.# $
Impl$ (
;( )
public 
class 
AuthService 
: 
IAuthService '
{		 
private

 
readonly

 

HttpClient

 
_httpClient

  +
;

+ ,
private 
readonly 
ITokenService "
_tokenService# 0
;0 1
private 
readonly -
!CustomAuthenticationStateProvider 6
_authStateProvider7 I
;I J
public 

AuthService 
( 

HttpClient 

httpClient 
, 
ITokenService 
tokenService "
," #-
!CustomAuthenticationStateProvider )
authStateProvider* ;
); <
{ 
_httpClient 
= 

httpClient  
;  !
_tokenService 
= 
tokenService $
;$ %
_authStateProvider 
= 
authStateProvider .
;. /
} 
public 

async 
Task 
< 
( 
AuthResponseDto &
?& '
Response( 0
,0 1
string2 8
?8 9
ErrorMessage: F
)F G
>G H

LoginAsyncI S
(S T
LoginDtoT \
request] d
)d e
{ 
var 
response 
= 
await 
_httpClient (
.( )
PostAsJsonAsync) 8
(8 9
$str9 I
,I J
requestK R
)R S
;S T
if 

( 
response 
. 

StatusCode 
is  "
HttpStatusCode# 1
.1 2
Unauthorized2 >
or? A
HttpStatusCodeB P
.P Q
	ForbiddenQ Z
)Z [
{ 	
return 
( 
null 
, 
$str 0
)0 1
;1 2
} 	
if!! 

(!! 
!!! 
response!! 
.!! 
IsSuccessStatusCode!! )
)!!) *
{"" 	
return## 
(## 
null## 
,## 
$str## @
)##@ A
;##A B
}$$ 	
var&& 
authResponse&& 
=&& 
await&&  
response&&! )
.&&) *
Content&&* 1
.&&1 2
ReadFromJsonAsync&&2 C
<&&C D
AuthResponseDto&&D S
>&&S T
(&&T U
)&&U V
;&&V W
if(( 

((( 
authResponse(( 
is(( 
null((  
)((  !
{)) 	
return** 
(** 
null** 
,** 
$str** @
)**@ A
;**A B
}++ 	
if-- 

(-- 
!-- 
string-- 
.-- 
Equals-- 
(-- 
authResponse-- '
.--' (
Role--( ,
,--, -
$str--. 5
,--5 6
StringComparison--7 G
.--G H
OrdinalIgnoreCase--H Y
)--Y Z
)--Z [
{.. 	
await// 
_tokenService// 
.//  
ClearTokensAsync//  0
(//0 1
)//1 2
;//2 3
_authStateProvider00 
.00 
NotifyUserLoggedOut00 2
(002 3
)003 4
;004 5
return11 
(11 
null11 
,11 
$str11 0
)110 1
;111 2
}22 	
await44 
_tokenService44 
.44 
SetAccessTokenAsync44 /
(44/ 0
authResponse440 <
.44< =
AccessToken44= H
)44H I
;44I J
_authStateProvider99 
.99 
NotifyUserLoggedIn99 -
(99- .
authResponse99. :
.99: ;
AccessToken99; F
)99F G
;99G H
return;; 
(;; 
authResponse;; 
,;; 
null;; "
);;" #
;;;# $
}<< 
public>> 

async>> 
Task>> 
<>> 
string>> 
?>> 
>>> 
ChangePasswordAsync>> 2
(>>2 3
ChangePasswordDto>>3 D
request>>E L
)>>L M
{?? 
var@@ 
response@@ 
=@@ 
await@@ 
_httpClient@@ (
.@@( )
PutAsJsonAsync@@) 7
(@@7 8
$str@@8 R
,@@R S
request@@T [
)@@[ \
;@@\ ]
varBB 
resultBB 
=BB 
awaitBB 
ApiResponseHandlerBB -
.BB- .$
ReadMessageResponseAsyncBB. F
(BBF G
responseCC 
,CC 
$strDD (
,DD( )
$strEE ,
)EE, -
;EE- .
returnGG 
resultGG 
.GG 
	IsSuccessGG 
?HH 
resultHH 
.HH 
DataHH 
:II 
resultII 
.II 
ErrorMessageII !
;II! "
}JJ 
publicLL 

asyncLL 
TaskLL 
LogoutAsyncLL !
(LL! "
)LL" #
{MM 
awaitNN 
_tokenServiceNN 
.NN 
ClearTokensAsyncNN ,
(NN, -
)NN- .
;NN. /
_authStateProviderOO 
.OO 
NotifyUserLoggedOutOO .
(OO. /
)OO/ 0
;OO0 1
}PP 
}QQ ö-
]C:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\Impl\AdminPatientService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
.# $
Impl$ (
;( )
public

 
class

 
AdminPatientService

  
(

  !

HttpClient

! +

httpClient

, 6
)

6 7
:

8 9 
IAdminPatientService

: N
{ 
public 

async 
Task 
< 
PagedResultDto $
<$ %

PatientDto% /
>/ 0
>0 1
GetPatientsAsync2 B
(B C
PaginationQueryDto 

pagination %
,% &
string 
? 
search 
) 
{ 
var 
url 
= 
$" 
$str 2
{2 3

pagination3 =
.= >

PageNumber> H
}H I
$strI S
{S T

paginationT ^
.^ _
PageSize_ g
}g h
"h i
;i j
if 

( 
! 
string 
. 
IsNullOrWhiteSpace &
(& '
search' -
)- .
). /
{ 	
url 
+= 
$" 
$str 
{ 
Uri !
.! "
EscapeDataString" 2
(2 3
search3 9
.9 :
Trim: >
(> ?
)? @
)@ A
}A B
"B C
;C D
} 	
return 
await 

httpClient 
.  
GetFromJsonAsync  0
<0 1
PagedResultDto1 ?
<? @

PatientDto@ J
>J K
>K L
(L M
urlM P
)P Q
?? 
new 
PagedResultDto !
<! "

PatientDto" ,
>, -
(- .
). /
;/ 0
} 
public 

async 
Task 
< 
ApiResponse !
<! "

PatientDto" ,
>, -
>- .
UpdatePatientAsync/ A
(A B
intB E
idF H
,H I
UpdatePatientDtoJ Z
request[ b
)b c
{ 
var 
response 
= 
await 

httpClient '
.' (
PutAsJsonAsync( 6
(6 7
$"7 9
$str9 L
{L M
idM O
}O P
"P Q
,Q R
requestS Z
)Z [
;[ \
return 
await 
ApiResponseHandler '
.' (
ReadResponseAsync( 9
<9 :

PatientDto: D
>D E
(E F
response   
,   
$str!! '
)!!' (
;!!( )
}"" 
public$$ 

async$$ 
Task$$ 
<$$ 
ApiResponse$$ !
<$$! "
string$$" (
>$$( )
>$$) *%
ResetPatientPasswordAsync$$+ D
($$D E
int$$E H
id$$I K
,$$K L!
AdminResetPasswordDto$$M b
request$$c j
)$$j k
{%% 
var&& 
response&& 
=&& 
await&& 

httpClient&& '
.&&' (
PutAsJsonAsync&&( 6
(&&6 7
$"&&7 9
$str&&9 L
{&&L M
id&&M O
}&&O P
$str&&P Y
"&&Y Z
,&&Z [
request&&\ c
)&&c d
;&&d e
return(( 
await(( 
ApiResponseHandler(( '
.((' ($
ReadMessageResponseAsync((( @
(((@ A
response)) 
,)) 
$str** /
,**/ 0
$str++ 2
)++2 3
;++3 4
},, 
public.. 

async.. 
Task.. 
<.. 
PagedResultDto.. $
<..$ %
AppointmentDto..% 3
>..3 4
>..4 5'
GetPatientAppointmentsAsync..6 Q
(..Q R
int// 
	patientId// 
,// 
AppointmentStatus00 
?00 
status00 !
,00! "
PaginationQueryDto11 

pagination11 %
)11% &
{22 
var33 
url33 
=33 
$"33 
$str33 '
{33' (
	patientId33( 1
}331 2
$str332 K
{33K L

pagination33L V
.33V W

PageNumber33W a
}33a b
$str33b l
{33l m

pagination33m w
.33w x
PageSize	33x Ä
}
33Ä Å
"
33Å Ç
;
33Ç É
if55 

(55 
status55 
.55 
HasValue55 
)55 
{66 	
url77 
+=77 
$"77 
$str77 
{77 
Uri77 !
.77! "
EscapeDataString77" 2
(772 3
status773 9
.779 :
Value77: ?
.77? @
ToString77@ H
(77H I
)77I J
)77J K
}77K L
"77L M
;77M N
}88 	
return:: 
await:: 

httpClient:: 
.::  
GetFromJsonAsync::  0
<::0 1
PagedResultDto::1 ?
<::? @
AppointmentDto::@ N
>::N O
>::O P
(::P Q
url::Q T
)::T U
??;; 
new;; 
PagedResultDto;; !
<;;! "
AppointmentDto;;" 0
>;;0 1
(;;1 2
);;2 3
;;;3 4
}<< 
}== ´

_C:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\Impl\AdminDashboardService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
.# $
Impl$ (
;( )
public 
class !
AdminDashboardService "
:# $"
IAdminDashboardService% ;
{ 
private 
readonly 

HttpClient 
_httpClient  +
;+ ,
public

 
!
AdminDashboardService

  
(

  !

HttpClient

! +

httpClient

, 6
)

6 7
{ 
_httpClient 
= 

httpClient  
;  !
} 
public 

async 
Task 
< $
AdminDashboardSummaryDto .
>. /$
GetDashboardSummaryAsync0 H
(H I
)I J
{ 
return 
await 
_httpClient  
.  !
GetFromJsonAsync! 1
<1 2$
AdminDashboardSummaryDto2 J
>J K
(K L
$strL i
)i j
?? 
new $
AdminDashboardSummaryDto +
(+ ,
), -
;- .
} 
} Í
XC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\IDoctorAdminService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
;# $
public		 
	interface		 
IDoctorAdminService		 $
{

 
Task 
< 	
PagedResultDto	 
< 
	DoctorDto !
>! "
>" #
GetDoctorsAsync$ 3
(3 4
PaginationQueryDto 

pagination %
,% &
string 
? 
search 
= 
null 
,  
DoctorSpecialisation 
? 
specialisation ,
=- .
null/ 3
)3 4
;4 5
Task 
< 	
ApiResponse	 
< 
	DoctorDto 
> 
>  
CreateDoctorAsync! 2
(2 3
CreateDoctorDto3 B
requestC J
)J K
;K L
Task 
< 	
ApiResponse	 
< 
	DoctorDto 
> 
>  
UpdateDoctorAsync! 2
(2 3
int3 6
id7 9
,9 :
UpdateDoctorDto; J
requestK R
)R S
;S T
Task 
< 	
ApiResponse	 
< 
string 
> 
> $
ResetDoctorPasswordAsync 6
(6 7
int7 :
id; =
,= >!
AdminResetPasswordDto? T
requestU \
)\ ]
;] ^
Task 
< 	
ApiResponse	 
< !
DoctorAvailabilityDto *
>* +
>+ ,#
UpdateAvailabilityAsync- D
(D E
intE H
idI K
,K L'
UpdateDoctorAvailabilityDtoM h
requesti p
)p q
;q r
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (&
GetDoctorAppointmentsAsync) C
(C D
int 
doctorId 
, 
AppointmentStatus 
? 
status !
,! "
PaginationQueryDto 

pagination %
)% &
;& '
} ¨
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\IAuthService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
;# $
public 
	interface 
IAuthService 
{ 
Task 
< 	
(	 

AuthResponseDto
 
? 
Response #
,# $
string% +
?+ ,
ErrorMessage- 9
)9 :
>: ;

LoginAsync< F
(F G
LoginDtoG O
requestP W
)W X
;X Y
Task		 
<		 	
string			 
?		 
>		 
ChangePasswordAsync		 %
(		% &
ChangePasswordDto		& 7
request		8 ?
)		? @
;		@ A
Task 
LogoutAsync	 
( 
) 
; 
} Õ

XC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\IAdminReportService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
;# $
public 
	interface 
IAdminReportService $
{ 
Task		 
<		 	
PagedResultDto			 
<		  
AppointmentReportDto		 ,
>		, -
>		- .&
GetAppointmentReportsAsync		/ I
(		I J
PaginationQueryDto		J \

pagination		] g
)		g h
;		h i
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' (,
 GetAppointmentReportDetailsAsync) I
(I J
DateOnly 
date 
, 
AppointmentStatus 
? 
status !
,! "
PaginationQueryDto 

pagination %
)% &
;& '
Task 
< 	
ApiResponse	 
< 
AppointmentDto #
># $
>$ %(
UpdateAppointmentStatusAsync& B
(B C
int 
appointmentId 
, &
UpdateAppointmentStatusDto "
request# *
)* +
;+ ,
} ê
YC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\IAdminPatientService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
;# $
public		 
	interface		  
IAdminPatientService		 %
{

 
Task 
< 	
PagedResultDto	 
< 

PatientDto "
>" #
># $
GetPatientsAsync% 5
(5 6
PaginationQueryDto6 H

paginationI S
,S T
stringU [
?[ \
search] c
)c d
;d e
Task 
< 	
ApiResponse	 
< 

PatientDto 
>  
>  !
UpdatePatientAsync" 4
(4 5
int5 8
id9 ;
,; <
UpdatePatientDto= M
requestN U
)U V
;V W
Task 
< 	
ApiResponse	 
< 
string 
> 
> %
ResetPatientPasswordAsync 7
(7 8
int8 ;
id< >
,> ?!
AdminResetPasswordDto@ U
requestV ]
)] ^
;^ _
Task 
< 	
PagedResultDto	 
< 
AppointmentDto &
>& '
>' ('
GetPatientAppointmentsAsync) D
(D E
int 
	patientId 
, 
AppointmentStatus 
? 
status !
,! "
PaginationQueryDto 

pagination %
)% &
;& '
} 
[C:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\IAdminDashboardService.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
;# $
public 
	interface "
IAdminDashboardService '
{ 
Task 
< 	$
AdminDashboardSummaryDto	 !
>! "$
GetDashboardSummaryAsync# ;
(; <
)< =
;= >
} √
MC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Constants\AppUrls.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
	Constants $
;$ %
public 
static 
class 
AppUrls 
{ 
public 

const 
string 
AngularLoginUrl '
=( )
$str* G
;G H
} ›d
WC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\ApiResponseHandler.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
;# $
public 
static 
class 
ApiResponseHandler &
{ 
public 

static 
async 
Task 
< 
ApiResponse (
<( )
T) *
>* +
>+ ,
ReadResponseAsync- >
<> ?
T? @
>@ A
(A B
HttpResponseMessage		 
response		 $
,		$ %
string

  
fallbackErrorMessage

 #
)

# $
{ 
if 

( 
response 
. 
IsSuccessStatusCode (
)( )
{ 	
var 
data 
= 
await 
response %
.% &
Content& -
.- .
ReadFromJsonAsync. ?
<? @
T@ A
>A B
(B C
)C D
;D E
return 
ApiResponse 
< 
T  
>  !
.! "
Success" )
() *
data* .
). /
;/ 0
} 	
var 
errorMessage 
= 
await  !
ReadErrorMessageAsync! 6
(6 7
response7 ?
,? @ 
fallbackErrorMessageA U
)U V
;V W
return 
ApiResponse 
< 
T 
> 
. 
Failure %
(% &
errorMessage& 2
)2 3
;3 4
} 
public 

static 
async 
Task 
< 
ApiResponse (
<( )
string) /
>/ 0
>0 1$
ReadMessageResponseAsync2 J
(J K
HttpResponseMessage 
response $
,$ %
string  
fallbackErrorMessage #
,# $
string "
fallbackSuccessMessage %
=& '
$str( K
)K L
{ 
if 

( 
response 
. 
IsSuccessStatusCode (
)( )
{ 	
var 
content 
= 
await 
response  (
.( )
Content) 0
.0 1
ReadAsStringAsync1 B
(B C
)C D
;D E
var 
message 
= 
ExtractMessage (
(( )
content) 0
)0 1
??2 4"
fallbackSuccessMessage5 K
;K L
return   
ApiResponse   
<   
string   %
>  % &
.  & '
Success  ' .
(  . /
message  / 6
)  6 7
;  7 8
}!! 	
var## 
errorMessage## 
=## 
await##  !
ReadErrorMessageAsync##! 6
(##6 7
response##7 ?
,##? @ 
fallbackErrorMessage##A U
)##U V
;##V W
return$$ 
ApiResponse$$ 
<$$ 
string$$ !
>$$! "
.$$" #
Failure$$# *
($$* +
errorMessage$$+ 7
)$$7 8
;$$8 9
}%% 
public'' 

static'' 
async'' 
Task'' 
<'' 
string'' #
>''# $!
ReadErrorMessageAsync''% :
('': ;
HttpResponseMessage(( 
response(( $
,(($ %
string))  
fallbackErrorMessage)) #
)))# $
{** 
var++ 
content++ 
=++ 
await++ 
response++ $
.++$ %
Content++% ,
.++, -
ReadAsStringAsync++- >
(++> ?
)++? @
;++@ A
if-- 

(-- 
string-- 
.-- 
IsNullOrWhiteSpace-- %
(--% &
content--& -
)--- .
)--. /
{.. 	
return//  
fallbackErrorMessage// '
;//' (
}00 	
var22 
errorMessage22 
=22 
ExtractMessage22 )
(22) *
content22* 1
)221 2
;222 3
return44 
string44 
.44 
IsNullOrWhiteSpace44 (
(44( )
errorMessage44) 5
)445 6
?55  
fallbackErrorMessage55 "
:66 
errorMessage66 
;66 
}77 
private99 
static99 
string99 
?99 
ExtractMessage99 )
(99) *
string99* 0
?990 1
content992 9
)999 :
{:: 
if;; 

(;; 
string;; 
.;; 
IsNullOrWhiteSpace;; %
(;;% &
content;;& -
);;- .
);;. /
{<< 	
return== 
null== 
;== 
}>> 	
return@@ 2
&TryReadValidationProblemDetailsMessage@@ 5
(@@5 6
content@@6 =
)@@= >
??AA 
TryReadJsonMessageAA !
(AA! "
contentAA" )
)AA) *
??BB 
CleanMessageBB 
(BB 
contentBB #
)BB# $
;BB$ %
}CC 
privateEE 
staticEE 
stringEE 
?EE 
TryReadJsonMessageEE -
(EE- .
stringEE. 4
contentEE5 <
)EE< =
{FF 
tryGG 
{HH 	
usingII 
varII 
documentII 
=II  
JsonDocumentII! -
.II- .
ParseII. 3
(II3 4
contentII4 ;
)II; <
;II< =
varJJ 
rootJJ 
=JJ 
documentJJ 
.JJ  
RootElementJJ  +
;JJ+ ,
ifLL 
(LL 
rootLL 
.LL 
	ValueKindLL 
==LL !
JsonValueKindLL" /
.LL/ 0
StringLL0 6
)LL6 7
{MM 
returnNN 
CleanMessageNN #
(NN# $
rootNN$ (
.NN( )
	GetStringNN) 2
(NN2 3
)NN3 4
)NN4 5
;NN5 6
}OO 
ifQQ 
(QQ 
rootQQ 
.QQ 
	ValueKindQQ 
!=QQ !
JsonValueKindQQ" /
.QQ/ 0
ObjectQQ0 6
)QQ6 7
{RR 
returnSS 
nullSS 
;SS 
}TT 
returnVV !
TryReadStringPropertyVV (
(VV( )
rootVV) -
,VV- .
$strVV/ 8
)VV8 9
??WW !
TryReadStringPropertyWW (
(WW( )
rootWW) -
,WW- .
$strWW/ 7
)WW7 8
??XX !
TryReadStringPropertyXX (
(XX( )
rootXX) -
,XX- .
$strXX/ 6
)XX6 7
;XX7 8
}YY 	
catchZZ 
(ZZ 
JsonExceptionZZ 
)ZZ 
{[[ 	
return\\ 
null\\ 
;\\ 
}]] 	
}^^ 
private`` 
static`` 
string`` 
?`` !
TryReadStringProperty`` 0
(``0 1
JsonElement``1 <
root``= A
,``A B
string``C I
propertyName``J V
)``V W
{aa 
returnbb 
rootbb 
.bb 
TryGetPropertybb "
(bb" #
propertyNamebb# /
,bb/ 0
outbb1 4
varbb5 8
elementbb9 @
)bb@ A
&&bbB D
elementcc 
.cc 
	ValueKindcc 
==cc  
JsonValueKindcc! .
.cc. /
Stringcc/ 5
?dd 
CleanMessagedd 
(dd 
elementdd &
.dd& '
	GetStringdd' 0
(dd0 1
)dd1 2
)dd2 3
:ee 
nullee 
;ee 
}ff 
privatehh 
statichh 
stringhh 
?hh 2
&TryReadValidationProblemDetailsMessagehh A
(hhA B
stringhhB H
contenthhI P
)hhP Q
{ii 
tryjj 
{kk 	
usingll 
varll 
documentll 
=ll  
JsonDocumentll! -
.ll- .
Parsell. 3
(ll3 4
contentll4 ;
)ll; <
;ll< =
varmm 
rootmm 
=mm 
documentmm 
.mm  
RootElementmm  +
;mm+ ,
ifoo 
(oo 
!oo 
TryGetErrorsElementoo $
(oo$ %
rootoo% )
,oo) *
outoo+ .
varoo/ 2
errorsElementoo3 @
)oo@ A
)ooA B
{pp 
returnqq 
nullqq 
;qq 
}rr 
vartt 
messagestt 
=tt 
errorsElementtt (
.uu 
EnumerateObjectuu  
(uu  !
)uu! "
.vv 
Selectvv 
(vv 
errorPropertyvv %
=>vv& (
errorPropertyvv) 6
.vv6 7
Valuevv7 <
)vv< =
.ww 
Whereww 
(ww 

errorValueww !
=>ww" $

errorValueww% /
.ww/ 0
	ValueKindww0 9
==ww: <
JsonValueKindww= J
.wwJ K
ArraywwK P
)wwP Q
.xx 

SelectManyxx 
(xx 

errorValuexx &
=>xx' )

errorValuexx* 4
.xx4 5
EnumerateArrayxx5 C
(xxC D
)xxD E
)xxE F
.yy 
Whereyy 
(yy 
	errorItemyy  
=>yy! #
	errorItemyy$ -
.yy- .
	ValueKindyy. 7
==yy8 :
JsonValueKindyy; H
.yyH I
StringyyI O
)yyO P
.zz 
Selectzz 
(zz 
	errorItemzz !
=>zz" $
CleanMessagezz% 1
(zz1 2
	errorItemzz2 ;
.zz; <
	GetStringzz< E
(zzE F
)zzF G
)zzG H
)zzH I
.{{ 
Where{{ 
({{ 
message{{ 
=>{{ !
!{{" #
string{{# )
.{{) *
IsNullOrWhiteSpace{{* <
({{< =
message{{= D
){{D E
){{E F
.|| 
ToList|| 
(|| 
)|| 
;|| 
return~~ 
messages~~ 
.~~ 
Count~~ !
==~~" $
$num~~% &
? 
null 
:
ÄÄ 
string
ÄÄ 
.
ÄÄ 
Join
ÄÄ 
(
ÄÄ 
$str
ÄÄ !
,
ÄÄ! "
messages
ÄÄ# +
)
ÄÄ+ ,
;
ÄÄ, -
}
ÅÅ 	
catch
ÇÇ 
(
ÇÇ 
JsonException
ÇÇ 
)
ÇÇ 
{
ÉÉ 	
return
ÑÑ 
null
ÑÑ 
;
ÑÑ 
}
ÖÖ 	
}
ÜÜ 
private
àà 
static
àà 
bool
àà !
TryGetErrorsElement
àà +
(
àà+ ,
JsonElement
àà, 7
root
àà8 <
,
àà< =
out
àà> A
JsonElement
ààB M
errorsElement
ààN [
)
àà[ \
{
ââ 
errorsElement
ää 
=
ää 
default
ää 
;
ää  
return
åå 
root
åå 
.
åå 
	ValueKind
åå 
==
åå  
JsonValueKind
åå! .
.
åå. /
Object
åå/ 5
&&
åå6 8
root
çç 
.
çç 
TryGetProperty
çç 
(
çç  
$str
çç  (
,
çç( )
out
çç* -
errorsElement
çç. ;
)
çç; <
&&
çç= ?
errorsElement
éé 
.
éé 
	ValueKind
éé #
==
éé$ &
JsonValueKind
éé' 4
.
éé4 5
Object
éé5 ;
;
éé; <
}
èè 
private
ëë 
static
ëë 
string
ëë 
CleanMessage
ëë &
(
ëë& '
string
ëë' -
?
ëë- .
message
ëë/ 6
)
ëë6 7
{
íí 
if
ìì 

(
ìì 
string
ìì 
.
ìì  
IsNullOrWhiteSpace
ìì %
(
ìì% &
message
ìì& -
)
ìì- .
)
ìì. /
{
îî 	
return
ïï 
string
ïï 
.
ïï 
Empty
ïï 
;
ïï  
}
ññ 	
return
òò 
message
òò 
.
òò 
Trim
òò 
(
òò 
)
òò 
.
òò 
Trim
òò "
(
òò" #
$char
òò# &
)
òò& '
;
òò' (
}
ôô 
}öö ⁄
PC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Services\ApiResponse.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Services #
;# $
public 
class 
ApiResponse 
< 
T 
> 
{ 
public 

bool 
	IsSuccess 
{ 
get 
;  
init! %
;% &
}' (
public 

T 
? 
Data 
{ 
get 
; 
init 
; 
}  !
public		 

string		 
?		 
ErrorMessage		 
{		  !
get		" %
;		% &
init		' +
;		+ ,
}		- .
public 

static 
ApiResponse 
< 
T 
>  
Success! (
(( )
T) *
?* +
data, 0
)0 1
{ 
return 
new 
ApiResponse 
< 
T  
>  !
{ 	
	IsSuccess 
= 
true 
, 
Data 
= 
data 
} 	
;	 

} 
public 

static 
ApiResponse 
< 
T 
>  
Failure! (
(( )
string) /
errorMessage0 <
)< =
{ 
return 
new 
ApiResponse 
< 
T  
>  !
{ 	
	IsSuccess 
= 
false 
, 
ErrorMessage 
= 
errorMessage '
} 	
;	 

} 
} ¿%
CC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Program.cs
var		 
builder		 
=		 "
WebAssemblyHostBuilder		 $
.		$ %
CreateDefault		% 2
(		2 3
args		3 7
)		7 8
;		8 9
builder 
. 
RootComponents 
. 
Add 
< 
App 
> 
(  
$str  &
)& '
;' (
builder 
. 
RootComponents 
. 
Add 
< 

HeadOutlet %
>% &
(& '
$str' 4
)4 5
;5 6
var 

apiBaseUrl 
= 
builder 
. 
Configuration &
[& '
$str' 3
]3 4
;4 5
if 
( 
string 

.
 
IsNullOrWhiteSpace 
( 

apiBaseUrl (
)( )
)) *
{ 
throw 	
new
 %
InvalidOperationException '
(' (
$str( ^
)^ _
;_ `
} 
builder 
. 
Services 
. 
AddTransient 
< 
AuthTokenHandler .
>. /
(/ 0
)0 1
;1 2
builder 
. 
Services 
. 
AddHttpClient 
( 
$str 
, 
client  
=>! #
{ 
client 
. 
BaseAddress 
= 
new  
Uri! $
($ %

apiBaseUrl% /
)/ 0
;0 1
} 
) 
. !
AddHttpMessageHandler 
< 
AuthTokenHandler +
>+ ,
(, -
)- .
;. /
builder 
. 
Services 
. 
	AddScoped 
( 
sp 
=>  
sp 
. 
GetRequiredService 
< 
IHttpClientFactory ,
>, -
(- .
). /
./ 0
CreateClient0 <
(< =
$str= B
)B C
)C D
;D E
builder!! 
.!! 
Services!! 
.!!  
AddAuthorizationCore!! %
(!!% &
)!!& '
;!!' (
builder## 
.## 
Services## 
.## 
	AddScoped## 
<## 
ITokenService## (
,##( )
TokenService##* 6
>##6 7
(##7 8
)##8 9
;##9 :
builder$$ 
.$$ 
Services$$ 
.$$ 
	AddScoped$$ 
<$$ -
!CustomAuthenticationStateProvider$$ <
>$$< =
($$= >
)$$> ?
;$$? @
builder%% 
.%% 
Services%% 
.%% 
	AddScoped%% 
<%% '
AuthenticationStateProvider%% 6
>%%6 7
(%%7 8
sp%%8 :
=>%%; =
sp&& 
.&& 
GetRequiredService&& 
<&& -
!CustomAuthenticationStateProvider&& ;
>&&; <
(&&< =
)&&= >
)&&> ?
;&&? @
builder'' 
.'' 
Services'' 
.'' 
	AddScoped'' 
<'' 
IAuthService'' '
,''' (
AuthService'') 4
>''4 5
(''5 6
)''6 7
;''7 8
builder(( 
.(( 
Services(( 
.(( 
	AddScoped(( 
<(( 
IDoctorAdminService(( .
,((. /
DoctorAdminService((0 B
>((B C
(((C D
)((D E
;((E F
builder)) 
.)) 
Services)) 
.)) 
	AddScoped)) 
<)) 
IAdminReportService)) .
,)). /
AdminReportService))0 B
>))B C
())C D
)))D E
;))E F
builder** 
.** 
Services** 
.** 
	AddScoped** 
<**  
IAdminPatientService** /
,**/ 0
AdminPatientService**1 D
>**D E
(**E F
)**F G
;**G H
builder++ 
.++ 
Services++ 
.++ 
	AddScoped++ 
<++ "
IAdminDashboardService++ 1
,++1 2!
AdminDashboardService++3 H
>++H I
(++I J
)++J K
;++K L
await-- 
builder-- 
.-- 
Build-- 
(-- 
)-- 
.-- 
RunAsync-- 
(-- 
)--  
;--  !∂R
bC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Auth\CustomAuthenticationStateProvider.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Auth 
;  
public		 
class		 -
!CustomAuthenticationStateProvider		 .
:		/ 0'
AuthenticationStateProvider		1 L
{

 
private 
readonly 
ITokenService "
_tokenService# 0
;0 1
private 
ClaimsPrincipal 
_currentUser (
=) *
new+ .
(. /
new/ 2
ClaimsIdentity3 A
(A B
)B C
)C D
;D E
public 
-
!CustomAuthenticationStateProvider ,
(, -
ITokenService- :
tokenService; G
)G H
{ 
_tokenService 
= 
tokenService $
;$ %
} 
public 

override 
async 
Task 
< 
AuthenticationState 2
>2 3'
GetAuthenticationStateAsync4 O
(O P
)P Q
{ 
if 

( 
_currentUser 
. 
Identity !
?! "
." #
IsAuthenticated# 2
==3 5
true6 :
): ;
{ 	
return 
new 
AuthenticationState *
(* +
_currentUser+ 7
)7 8
;8 9
} 	
var 
token 
= 
await 
_tokenService '
.' (
GetAccessTokenAsync( ;
(; <
)< =
;= >
if 

( 
string 
. 
IsNullOrWhiteSpace %
(% &
token& +
)+ ,
), -
{ 	
return 
new 
AuthenticationState *
(* +
new+ .
ClaimsPrincipal/ >
(> ?
new? B
ClaimsIdentityC Q
(Q R
)R S
)S T
)T U
;U V
}   	
var"" 
claims"" 
="" 
ParseClaimsFromJwt"" '
(""' (
token""( -
)""- .
;"". /
var## 
identity## 
=## 
new## 
ClaimsIdentity## )
(##) *
claims##* 0
,##0 1
$str##2 7
)##7 8
;##8 9
_currentUser$$ 
=$$ 
new$$ 
ClaimsPrincipal$$ *
($$* +
identity$$+ 3
)$$3 4
;$$4 5
return&& 
new&& 
AuthenticationState&& &
(&&& '
_currentUser&&' 3
)&&3 4
;&&4 5
}'' 
public)) 

void)) 
NotifyUserLoggedIn)) "
())" #
string))# )
token))* /
)))/ 0
{** 
var++ 
claims++ 
=++ 
ParseClaimsFromJwt++ '
(++' (
token++( -
)++- .
;++. /
var,, 
identity,, 
=,, 
new,, 
ClaimsIdentity,, )
(,,) *
claims,,* 0
,,,0 1
$str,,2 7
),,7 8
;,,8 9
_currentUser-- 
=-- 
new-- 
ClaimsPrincipal-- *
(--* +
identity--+ 3
)--3 4
;--4 5,
 NotifyAuthenticationStateChanged// (
(//( )
Task//) -
.//- .

FromResult//. 8
(//8 9
new//9 <
AuthenticationState//= P
(//P Q
_currentUser//Q ]
)//] ^
)//^ _
)//_ `
;//` a
}00 
public22 

void22 
NotifyUserLoggedOut22 #
(22# $
)22$ %
{33 
_currentUser44 
=44 
new44 
ClaimsPrincipal44 *
(44* +
new44+ .
ClaimsIdentity44/ =
(44= >
)44> ?
)44? @
;44@ A,
 NotifyAuthenticationStateChanged55 (
(55( )
Task55) -
.55- .

FromResult55. 8
(558 9
new559 <
AuthenticationState55= P
(55P Q
_currentUser55Q ]
)55] ^
)55^ _
)55_ `
;55` a
}66 
private88 
static88 
List88 
<88 
Claim88 
>88 
ParseClaimsFromJwt88 1
(881 2
string882 8
jwt889 <
)88< =
{99 
var:: 
claims:: 
=:: 
new:: 
List:: 
<:: 
Claim:: #
>::# $
(::$ %
)::% &
;::& '
var;; 
parts;; 
=;; 
jwt;; 
.;; 
Split;; 
(;; 
$char;; !
);;! "
;;;" #
if== 

(== 
parts== 
.== 
Length== 
<== 
$num== 
)== 
{>> 	
return?? 
claims?? 
;?? 
}@@ 	
varBB 
payloadBB 
=BB 
partsBB 
[BB 
$numBB 
]BB 
.CC 
ReplaceCC 
(CC 
$charCC 
,CC 
$charCC 
)CC 
.DD 
ReplaceDD 
(DD 
$charDD 
,DD 
$charDD 
)DD 
;DD 
switchFF 
(FF 
payloadFF 
.FF 
LengthFF 
%FF  
$numFF! "
)FF" #
{GG 	
caseHH 
$numHH 
:HH 
payloadII 
+=II 
$strII 
;II  
breakJJ 
;JJ 
caseKK 
$numKK 
:KK 
payloadLL 
+=LL 
$strLL 
;LL 
breakMM 
;MM 
}NN 	
varPP 
	jsonBytesPP 
=PP 
ConvertPP 
.PP  
FromBase64StringPP  0
(PP0 1
payloadPP1 8
)PP8 9
;PP9 :
varQQ 
keyValuePairsQQ 
=QQ 
JsonSerializerQQ *
.QQ* +
DeserializeQQ+ 6
<QQ6 7

DictionaryQQ7 A
<QQA B
stringQQB H
,QQH I
JsonElementQQJ U
>QQU V
>QQV W
(QQW X
	jsonBytesQQX a
)QQa b
;QQb c
ifSS 

(SS 
keyValuePairsSS 
isSS 
nullSS !
)SS! "
{TT 	
returnUU 
claimsUU 
;UU 
}VV 	
foreachXX 
(XX 
varXX 
kvpXX 
inXX 
keyValuePairsXX )
)XX) *
{YY 	
ifZZ 
(ZZ 
kvpZZ 
.ZZ 
ValueZZ 
.ZZ 
	ValueKindZZ #
==ZZ$ &
JsonValueKindZZ' 4
.ZZ4 5
ArrayZZ5 :
)ZZ: ;
{[[ 
foreach\\ 
(\\ 
var\\ 
element\\ $
in\\% '
kvp\\( +
.\\+ ,
Value\\, 1
.\\1 2
EnumerateArray\\2 @
(\\@ A
)\\A B
)\\B C
{]] )
AddClaimWithRoleNormalization^^ 1
(^^1 2
claims^^2 8
,^^8 9
kvp^^: =
.^^= >
Key^^> A
,^^A B
element^^C J
.^^J K
ToString^^K S
(^^S T
)^^T U
)^^U V
;^^V W
}__ 
}`` 
elseaa 
{bb )
AddClaimWithRoleNormalizationcc -
(cc- .
claimscc. 4
,cc4 5
kvpcc6 9
.cc9 :
Keycc: =
,cc= >
kvpcc? B
.ccB C
ValueccC H
.ccH I
ToStringccI Q
(ccQ R
)ccR S
)ccS T
;ccT U
}dd 
}ee 	
returngg 
claimsgg 
;gg 
}hh 
privatejj 
staticjj 
voidjj )
AddClaimWithRoleNormalizationjj 5
(jj5 6
Listjj6 :
<jj: ;
Claimjj; @
>jj@ A
claimsjjB H
,jjH I
stringjjJ P
	claimTypejjQ Z
,jjZ [
stringjj\ b

claimValuejjc m
)jjm n
{kk 
claimsll 
.ll 
Addll 
(ll 
newll 
Claimll 
(ll 
	claimTypell &
,ll& '

claimValuell( 2
)ll2 3
)ll3 4
;ll4 5
ifnn 

(nn 
IsRoleClaimnn 
(nn 
	claimTypenn !
)nn! "
&&nn# %
	claimTypenn& /
!=nn0 2

ClaimTypesnn3 =
.nn= >
Rolenn> B
)nnB C
{oo 	
claimspp 
.pp 
Addpp 
(pp 
newpp 
Claimpp  
(pp  !

ClaimTypespp! +
.pp+ ,
Rolepp, 0
,pp0 1

claimValuepp2 <
)pp< =
)pp= >
;pp> ?
}qq 	
}rr 
privatett 
statictt 
booltt 
IsRoleClaimtt #
(tt# $
stringtt$ *
	claimTypett+ 4
)tt4 5
{uu 
returnvv 
stringvv 
.vv 
Equalsvv 
(vv 
	claimTypevv &
,vv& '
AppClaimTypesvv( 5
.vv5 6
Rolevv6 :
,vv: ;
StringComparisonvv< L
.vvL M
OrdinalIgnoreCasevvM ^
)vv^ _
||ww 
stringww 
.ww 
Equalsww 
(ww 
	claimTypeww &
,ww& '
$strww( .
,ww. /
StringComparisonww0 @
.ww@ A
OrdinalIgnoreCasewwA R
)wwR S
||xx 
stringxx 
.xx 
Equalsxx 
(xx 
	claimTypexx &
,xx& '

ClaimTypesxx( 2
.xx2 3
Rolexx3 7
,xx7 8
StringComparisonxx9 I
.xxI J
OrdinalIgnoreCasexxJ [
)xx[ \
||yy 
	claimTypeyy 
.yy 
EndsWithyy !
(yy! "
$stryy" )
,yy) *
StringComparisonyy+ ;
.yy; <
OrdinalIgnoreCaseyy< M
)yyM N
;yyN O
}zz 
}{{ ÿ'
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Auth\AuthTokenHandler.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Auth 
;  
public		 
class		 
AuthTokenHandler		 
:		 
DelegatingHandler		  1
{

 
private 
readonly 
ITokenService "
_tokenService# 0
;0 1
private 
readonly -
!CustomAuthenticationStateProvider 6
_authStateProvider7 I
;I J
private 
readonly 
NavigationManager &
_navigationManager' 9
;9 :
public 

AuthTokenHandler 
( 
ITokenService 
tokenService "
," #-
!CustomAuthenticationStateProvider )
authStateProvider* ;
,; <
NavigationManager 
navigationManager +
)+ ,
{ 
_tokenService 
= 
tokenService $
;$ %
_authStateProvider 
= 
authStateProvider .
;. /
_navigationManager 
= 
navigationManager .
;. /
} 
	protected 
override 
async 
Task !
<! "
HttpResponseMessage" 5
>5 6
	SendAsync7 @
(@ A
HttpRequestMessage 
request "
," #
CancellationToken 
cancellationToken +
)+ ,
{ 
var 
token 
= 
await 
_tokenService '
.' (
GetAccessTokenAsync( ;
(; <
)< =
;= >
if 

( 
! 
string 
. 
IsNullOrWhiteSpace &
(& '
token' ,
), -
)- .
{   	
request!! 
.!! 
Headers!! 
.!! 
Authorization!! )
=!!* +
new"" %
AuthenticationHeaderValue"" -
(""- .
$str"". 6
,""6 7
token""8 =
)""= >
;""> ?
}## 	
var%% 
response%% 
=%% 
await%% 
base%% !
.%%! "
	SendAsync%%" +
(%%+ ,
request%%, 3
,%%3 4
cancellationToken%%5 F
)%%F G
;%%G H
if'' 

('' .
"ShouldHandleSessionExpiredResponse'' .
(''. /
request''/ 6
,''6 7
response''8 @
,''@ A
token''B G
)''G H
)''H I
{(( 	
await)) 
_tokenService)) 
.))  
ClearTokensAsync))  0
())0 1
)))1 2
;))2 3
_authStateProvider** 
.** 
NotifyUserLoggedOut** 2
(**2 3
)**3 4
;**4 5
_navigationManager++ 
.++ 

NavigateTo++ )
(++) *
$",, 
{,, 
AppUrls,, 
.,, 
AngularLoginUrl,, *
},,* +
$str,,+ B
",,B C
,,,C D
	forceLoad-- 
:-- 
true-- 
)--  
;--  !
}.. 	
return00 
response00 
;00 
}11 
private33 
static33 
bool33 .
"ShouldHandleSessionExpiredResponse33 :
(33: ;
HttpRequestMessage44 
request44 "
,44" #
HttpResponseMessage55 
response55 $
,55$ %
string66 
?66 
token66 
)66 
{77 
if88 

(88 
response88 
.88 

StatusCode88 
!=88  "
HttpStatusCode88# 1
.881 2
Unauthorized882 >
)88> ?
{99 	
return:: 
false:: 
;:: 
};; 	
if== 

(== 
string== 
.== 
IsNullOrWhiteSpace== %
(==% &
token==& +
)==+ ,
)==, -
{>> 	
return?? 
false?? 
;?? 
}@@ 	
varBB 
pathBB 
=BB 
requestBB 
.BB 

RequestUriBB %
?BB% &
.BB& '
AbsolutePathBB' 3
??BB4 6
stringBB7 =
.BB= >
EmptyBB> C
;BBC D
returnDD 
!DD 
pathDD 
.DD 
ContainsDD 
(DD 
$strDD /
,DD/ 0
StringComparisonDD1 A
.DDA B
OrdinalIgnoreCaseDDB S
)DDS T
&&DDU W
!EE 
pathEE 
.EE 
ContainsEE 
(EE 
$strEE 2
,EE2 3
StringComparisonEE4 D
.EED E
OrdinalIgnoreCaseEEE V
)EEV W
;EEW X
}FF 
}GG 