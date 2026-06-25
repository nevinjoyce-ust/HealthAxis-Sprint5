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
}YY ™4
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
;@@\ ]
ifBB 

(BB 
!BB 
responseBB 
.BB 
IsSuccessStatusCodeBB )
)BB) *
{CC 	
varDD 
errorDD 
=DD 
awaitDD 
responseDD &
.DD& '
ContentDD' .
.DD. /
ReadFromJsonAsyncDD/ @
<DD@ A
AuthMessageResponseDDA T
>DDT U
(DDU V
)DDV W
;DDW X
returnEE 
errorEE 
?EE 
.EE 
MessageEE !
??EE" $
$strEE% A
;EEA B
}FF 	
varHH 
resultHH 
=HH 
awaitHH 
responseHH #
.HH# $
ContentHH$ +
.HH+ ,
ReadFromJsonAsyncHH, =
<HH= >
AuthMessageResponseHH> Q
>HHQ R
(HHR S
)HHS T
;HHT U
returnJJ 
resultJJ 
?JJ 
.JJ 
MessageJJ 
??JJ !
$strJJ" B
;JJB C
}KK 
publicMM 

asyncMM 
TaskMM 
LogoutAsyncMM !
(MM! "
)MM" #
{NN 
awaitOO 
_tokenServiceOO 
.OO 
ClearTokensAsyncOO ,
(OO, -
)OO- .
;OO. /
_authStateProviderPP 
.PP 
NotifyUserLoggedOutPP .
(PP. /
)PP/ 0
;PP0 1
}QQ 
privateSS 
sealedSS 
classSS 
AuthMessageResponseSS ,
{TT 
publicUU 
stringUU 
MessageUU 
{UU 
getUU  #
;UU# $
setUU% (
;UU( )
}UU* +
=UU, -
stringUU. 4
.UU4 5
EmptyUU5 :
;UU: ;
}VV 
}WW ï$
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
}00 ö-
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
} ∑g
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
return@@ 
TryReadJsonMessage@@ !
(@@! "
content@@" )
)@@) *
??AA 2
&TryReadValidationProblemDetailsMessageAA 5
(AA5 6
contentAA6 =
)AA= >
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
}TT 
ifVV 
(VV 
rootVV 
.VV 
TryGetPropertyVV #
(VV# $
$strVV$ -
,VV- .
outVV/ 2
varVV3 6
messageElementVV7 E
)VVE F
&&VVG I
messageElementWW 
.WW 
	ValueKindWW (
==WW) +
JsonValueKindWW, 9
.WW9 :
StringWW: @
)WW@ A
{XX 
returnYY 
CleanMessageYY #
(YY# $
messageElementYY$ 2
.YY2 3
	GetStringYY3 <
(YY< =
)YY= >
)YY> ?
;YY? @
}ZZ 
if\\ 
(\\ 
root\\ 
.\\ 
TryGetProperty\\ #
(\\# $
$str\\$ ,
,\\, -
out\\. 1
var\\2 5
detailElement\\6 C
)\\C D
&&\\E G
detailElement]] 
.]] 
	ValueKind]] '
==]]( *
JsonValueKind]]+ 8
.]]8 9
String]]9 ?
)]]? @
{^^ 
return__ 
CleanMessage__ #
(__# $
detailElement__$ 1
.__1 2
	GetString__2 ;
(__; <
)__< =
)__= >
;__> ?
}`` 
ifbb 
(bb 
rootbb 
.bb 
TryGetPropertybb #
(bb# $
$strbb$ +
,bb+ ,
outbb- 0
varbb1 4
titleElementbb5 A
)bbA B
&&bbC E
titleElementcc 
.cc 
	ValueKindcc &
==cc' )
JsonValueKindcc* 7
.cc7 8
Stringcc8 >
)cc> ?
{dd 
returnee 
CleanMessageee #
(ee# $
titleElementee$ 0
.ee0 1
	GetStringee1 :
(ee: ;
)ee; <
)ee< =
;ee= >
}ff 
returnhh 
nullhh 
;hh 
}ii 	
catchjj 
(jj 
JsonExceptionjj 
)jj 
{kk 	
returnll 
nullll 
;ll 
}mm 	
}nn 
privatepp 
staticpp 
stringpp 
?pp 2
&TryReadValidationProblemDetailsMessagepp A
(ppA B
stringppB H
contentppI P
)ppP Q
{qq 
tryrr 
{ss 	
usingtt 
vartt 
documenttt 
=tt  
JsonDocumenttt! -
.tt- .
Parsett. 3
(tt3 4
contenttt4 ;
)tt; <
;tt< =
varuu 
rootuu 
=uu 
documentuu 
.uu  
RootElementuu  +
;uu+ ,
ifww 
(ww 
rootww 
.ww 
	ValueKindww 
!=ww !
JsonValueKindww" /
.ww/ 0
Objectww0 6
||ww7 9
!xx 
rootxx 
.xx 
TryGetPropertyxx $
(xx$ %
$strxx% -
,xx- .
outxx/ 2
varxx3 6
errorsElementxx7 D
)xxD E
||xxF H
errorsElementyy 
.yy 
	ValueKindyy '
!=yy( *
JsonValueKindyy+ 8
.yy8 9
Objectyy9 ?
)yy? @
{zz 
return{{ 
null{{ 
;{{ 
}|| 
var~~ 
messages~~ 
=~~ 
new~~ 
List~~ #
<~~# $
string~~$ *
>~~* +
(~~+ ,
)~~, -
;~~- .
foreach
ÄÄ 
(
ÄÄ 
var
ÄÄ 
errorProperty
ÄÄ &
in
ÄÄ' )
errorsElement
ÄÄ* 7
.
ÄÄ7 8
EnumerateObject
ÄÄ8 G
(
ÄÄG H
)
ÄÄH I
)
ÄÄI J
{
ÅÅ 
if
ÇÇ 
(
ÇÇ 
errorProperty
ÇÇ !
.
ÇÇ! "
Value
ÇÇ" '
.
ÇÇ' (
	ValueKind
ÇÇ( 1
!=
ÇÇ2 4
JsonValueKind
ÇÇ5 B
.
ÇÇB C
Array
ÇÇC H
)
ÇÇH I
{
ÉÉ 
continue
ÑÑ 
;
ÑÑ 
}
ÖÖ 
foreach
áá 
(
áá 
var
áá 
	errorItem
áá &
in
áá' )
errorProperty
áá* 7
.
áá7 8
Value
áá8 =
.
áá= >
EnumerateArray
áá> L
(
ááL M
)
ááM N
)
ááN O
{
àà 
if
ââ 
(
ââ 
	errorItem
ââ !
.
ââ! "
	ValueKind
ââ" +
==
ââ, .
JsonValueKind
ââ/ <
.
ââ< =
String
ââ= C
)
ââC D
{
ää 
var
ãã 
message
ãã #
=
ãã$ %
CleanMessage
ãã& 2
(
ãã2 3
	errorItem
ãã3 <
.
ãã< =
	GetString
ãã= F
(
ããF G
)
ããG H
)
ããH I
;
ããI J
if
çç 
(
çç 
!
çç 
string
çç #
.
çç# $ 
IsNullOrWhiteSpace
çç$ 6
(
çç6 7
message
çç7 >
)
çç> ?
)
çç? @
{
éé 
messages
èè $
.
èè$ %
Add
èè% (
(
èè( )
message
èè) 0
)
èè0 1
;
èè1 2
}
êê 
}
ëë 
}
íí 
}
ìì 
return
ïï 
messages
ïï 
.
ïï 
Count
ïï !
==
ïï" $
$num
ïï% &
?
ññ 
null
ññ 
:
óó 
string
óó 
.
óó 
Join
óó 
(
óó 
$str
óó !
,
óó! "
messages
óó# +
)
óó+ ,
;
óó, -
}
òò 	
catch
ôô 
(
ôô 
JsonException
ôô 
)
ôô 
{
öö 	
return
õõ 
null
õõ 
;
õõ 
}
úú 	
}
ùù 
private
üü 
static
üü 
string
üü 
CleanMessage
üü &
(
üü& '
string
üü' -
?
üü- .
message
üü/ 6
)
üü6 7
{
†† 
if
°° 

(
°° 
string
°° 
.
°°  
IsNullOrWhiteSpace
°° %
(
°°% &
message
°°& -
)
°°- .
)
°°. /
{
¢¢ 	
return
££ 
string
££ 
.
££ 
Empty
££ 
;
££  
}
§§ 	
return
¶¶ 
message
¶¶ 
.
¶¶ 
Trim
¶¶ 
(
¶¶ 
)
¶¶ 
.
¶¶ 
Trim
¶¶ "
(
¶¶" #
$char
¶¶# &
)
¶¶& '
;
¶¶' (
}
ßß 
}®® ⁄
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
;--  !œP
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
static88 
IEnumerable88 
<88 
Claim88 $
>88$ %
ParseClaimsFromJwt88& 8
(888 9
string889 ?
jwt88@ C
)88C D
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
;BB 
switchDD 
(DD 
payloadDD 
.DD 
LengthDD 
%DD  
$numDD! "
)DD" #
{EE 	
caseFF 
$numFF 
:FF 
payloadGG 
+=GG 
$strGG 
;GG  
breakHH 
;HH 
caseII 
$numII 
:II 
payloadJJ 
+=JJ 
$strJJ 
;JJ 
breakKK 
;KK 
}LL 	
varNN 
	jsonBytesNN 
=NN 
ConvertNN 
.NN  
FromBase64StringNN  0
(NN0 1
payloadNN1 8
)NN8 9
;NN9 :
varOO 
keyValuePairsOO 
=OO 
JsonSerializerOO *
.OO* +
DeserializeOO+ 6
<OO6 7

DictionaryOO7 A
<OOA B
stringOOB H
,OOH I
JsonElementOOJ U
>OOU V
>OOV W
(OOW X
	jsonBytesOOX a
)OOa b
;OOb c
ifQQ 

(QQ 
keyValuePairsQQ 
isQQ 
nullQQ !
)QQ! "
{RR 	
returnSS 
claimsSS 
;SS 
}TT 	
foreachVV 
(VV 
varVV 
kvpVV 
inVV 
keyValuePairsVV )
)VV) *
{WW 	
ifXX 
(XX 
kvpXX 
.XX 
ValueXX 
.XX 
	ValueKindXX #
==XX$ &
JsonValueKindXX' 4
.XX4 5
ArrayXX5 :
)XX: ;
{YY 
foreachZZ 
(ZZ 
varZZ 
elementZZ $
inZZ% '
kvpZZ( +
.ZZ+ ,
ValueZZ, 1
.ZZ1 2
EnumerateArrayZZ2 @
(ZZ@ A
)ZZA B
)ZZB C
{[[ )
AddClaimWithRoleNormalization\\ 1
(\\1 2
claims\\2 8
,\\8 9
kvp\\: =
.\\= >
Key\\> A
,\\A B
element\\C J
.\\J K
ToString\\K S
(\\S T
)\\T U
)\\U V
;\\V W
}]] 
}^^ 
else__ 
{`` )
AddClaimWithRoleNormalizationaa -
(aa- .
claimsaa. 4
,aa4 5
kvpaa6 9
.aa9 :
Keyaa: =
,aa= >
kvpaa? B
.aaB C
ValueaaC H
.aaH I
ToStringaaI Q
(aaQ R
)aaR S
)aaS T
;aaT U
}bb 
}cc 	
returnee 
claimsee 
;ee 
}ff 
privatehh 
statichh 
voidhh )
AddClaimWithRoleNormalizationhh 5
(hh5 6
Listhh6 :
<hh: ;
Claimhh; @
>hh@ A
claimshhB H
,hhH I
stringhhJ P
	claimTypehhQ Z
,hhZ [
stringhh\ b

claimValuehhc m
)hhm n
{ii 
claimsjj 
.jj 
Addjj 
(jj 
newjj 
Claimjj 
(jj 
	claimTypejj &
,jj& '

claimValuejj( 2
)jj2 3
)jj3 4
;jj4 5
ifll 

(ll 
IsRoleClaimll 
(ll 
	claimTypell !
)ll! "
&&ll# %
	claimTypell& /
!=ll0 2

ClaimTypesll3 =
.ll= >
Rolell> B
)llB C
{mm 	
claimsnn 
.nn 
Addnn 
(nn 
newnn 
Claimnn  
(nn  !

ClaimTypesnn! +
.nn+ ,
Rolenn, 0
,nn0 1

claimValuenn2 <
)nn< =
)nn= >
;nn> ?
}oo 	
}pp 
privaterr 
staticrr 
boolrr 
IsRoleClaimrr #
(rr# $
stringrr$ *
	claimTyperr+ 4
)rr4 5
{ss 
returntt 
stringtt 
.tt 
Equalstt 
(tt 
	claimTypett &
,tt& '
AppClaimTypestt( 5
.tt5 6
Rolett6 :
,tt: ;
StringComparisontt< L
.ttL M
OrdinalIgnoreCasettM ^
)tt^ _
||uu 
stringuu 
.uu 
Equalsuu 
(uu 
	claimTypeuu &
,uu& '
$struu( .
,uu. /
StringComparisonuu0 @
.uu@ A
OrdinalIgnoreCaseuuA R
)uuR S
||vv 
stringvv 
.vv 
Equalsvv 
(vv 
	claimTypevv &
,vv& '

ClaimTypesvv( 2
.vv2 3
Rolevv3 7
,vv7 8
StringComparisonvv9 I
.vvI J
OrdinalIgnoreCasevvJ [
)vv[ \
||ww 
	claimTypeww 
.ww 
EndsWithww !
(ww! "
$strww" )
,ww) *
StringComparisonww+ ;
.ww; <
OrdinalIgnoreCaseww< M
)wwM N
;wwN O
}xx 
}yy €&
QC:\Users\310511\source\repos\HealthAxis\HealthAxis.Admin\Auth\AuthTokenHandler.cs
	namespace 	

HealthAxis
 
. 
Admin 
. 
Auth 
;  
public 
class 
AuthTokenHandler 
: 
DelegatingHandler  1
{		 
private

 
readonly

 
ITokenService

 "
_tokenService

# 0
;

0 1
private 
readonly -
!CustomAuthenticationStateProvider 6
_authStateProvider7 I
;I J
private 
readonly 
NavigationManager &
_navigationManager' 9
;9 :
public 

AuthTokenHandler 
( 
ITokenService 
tokenService "
," #-
!CustomAuthenticationStateProvider )
authStateProvider* ;
,; <
NavigationManager 
navigationManager +
)+ ,
{ 
_tokenService 
= 
tokenService $
;$ %
_authStateProvider 
= 
authStateProvider .
;. /
_navigationManager 
= 
navigationManager .
;. /
} 
	protected 
override 
async 
Task !
<! "
HttpResponseMessage" 5
>5 6
	SendAsync7 @
(@ A
HttpRequestMessage 
request "
," #
CancellationToken 
cancellationToken +
)+ ,
{ 
var 
token 
= 
await 
_tokenService '
.' (
GetAccessTokenAsync( ;
(; <
)< =
;= >
if 

( 
! 
string 
. 
IsNullOrWhiteSpace &
(& '
token' ,
), -
)- .
{ 	
request   
.   
Headers   
.   
Authorization   )
=  * +
new!! %
AuthenticationHeaderValue!! -
(!!- .
$str!!. 6
,!!6 7
token!!8 =
)!!= >
;!!> ?
}"" 	
var$$ 
response$$ 
=$$ 
await$$ 
base$$ !
.$$! "
	SendAsync$$" +
($$+ ,
request$$, 3
,$$3 4
cancellationToken$$5 F
)$$F G
;$$G H
if&& 

(&& .
"ShouldHandleSessionExpiredResponse&& .
(&&. /
request&&/ 6
,&&6 7
response&&8 @
,&&@ A
token&&B G
)&&G H
)&&H I
{'' 	
await(( 
_tokenService(( 
.((  
ClearTokensAsync((  0
(((0 1
)((1 2
;((2 3
_authStateProvider)) 
.)) 
NotifyUserLoggedOut)) 2
())2 3
)))3 4
;))4 5
_navigationManager** 
.** 

NavigateTo** )
(**) *
$str*** I
,**I J
	forceLoad**K T
:**T U
false**V [
)**[ \
;**\ ]
}++ 	
return-- 
response-- 
;-- 
}.. 
private00 
static00 
bool00 .
"ShouldHandleSessionExpiredResponse00 :
(00: ;
HttpRequestMessage11 
request11 "
,11" #
HttpResponseMessage22 
response22 $
,22$ %
string33 
?33 
token33 
)33 
{44 
if55 

(55 
response55 
.55 

StatusCode55 
!=55  "
HttpStatusCode55# 1
.551 2
Unauthorized552 >
)55> ?
{66 	
return77 
false77 
;77 
}88 	
if:: 

(:: 
string:: 
.:: 
IsNullOrWhiteSpace:: %
(::% &
token::& +
)::+ ,
)::, -
{;; 	
return<< 
false<< 
;<< 
}== 	
var?? 
path?? 
=?? 
request?? 
.?? 

RequestUri?? %
???% &
.??& '
AbsolutePath??' 3
????4 6
string??7 =
.??= >
Empty??> C
;??C D
returnAA 
!AA 
pathAA 
.AA 
ContainsAA 
(AA 
$strAA /
,AA/ 0
StringComparisonAA1 A
.AAA B
OrdinalIgnoreCaseAAB S
)AAS T
&&AAU W
!BB 
pathBB 
.BB 
ContainsBB 
(BB 
$strBB 2
,BB2 3
StringComparisonBB4 D
.BBD E
OrdinalIgnoreCaseBBE V
)BBV W
;BBW X
}CC 
}DD 