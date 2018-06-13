$PBExportHeader$nvo_inet.sru
forward
global type nvo_inet from nonvisualobject
end type
end forward

global type nvo_inet from nonvisualobject
end type
global nvo_inet nvo_inet

type prototypes
//winapi WinInet.dll
FUNCTION Long 		InternetOpen (String lpszAgent, Long dwAccessType, String lpszProxy, String lpszProxyBypass, Long dwFlags) LIBRARY "WinInet.dll" ALIAS FOR "InternetOpenW"
FUNCTION Boolean 	InternetCloseHandle (Long hInternet) LIBRARY "WinInet.dll"
FUNCTION Long 		InternetConnect (Long hInternet, String lpszServerName, long nServerPort, String lpszUserName, String lpszPassword, Long dwService, Long dwFlags, Long dwContext) LIBRARY "WinInet.dll" ALIAS FOR "InternetConnectW"
FUNCTION Long 		HttpOpenRequest (Long hConnect, String lpszVerb, String lpszObjectName, String lpszVersion, String lpszReferrer, String lplpszAcceptTypes, Long dwFlags, Long dwContext) LIBRARY "WinInet.dll" ALIAS FOR "HttpOpenRequestW"
FUNCTION Boolean 	HttpAddRequestHeaders(Long hConnect, String lpszHeaders, Long dwHeadersLength, Long dwModifiers) LIBRARY "WinInet.dll" ALIAS FOR "HttpAddRequestHeadersW"
FUNCTION Boolean 	HttpSendRequest (Long hRequest, REF String lpszHeaders, Long dwHeadersLength, REF Blob lpOptional, Long dwOptionalLength) LIBRARY "WinInet.dll" ALIAS FOR "HttpSendRequestW"
FUNCTION Boolean 	HttpQueryInfo (Long  hRequest, Long dwInfoLevel, REF String lpvBuffer, REF Long lpdwBufferLength, REF Long lpdwIndex ) LIBRARY "WinInet.dll" ALIAS FOR "HttpQueryInfoW"
FUNCTION Boolean 	InternetReadFile (Long hFile, REF Blob lpBuffer, Long dwNumberOfBytesToRead, REF Long lpdwNumberOfBytesRead) LIBRARY "WinInet.dll"
FUNCTION Long 		InternetOpenUrl (Long hInternet, String lpszUrl, String lpszHeaders, Long dwHeadersLength, Long dwFlags, Ref Long dwContext) LIBRARY "WinInet.dll" ALIAS FOR "InternetOpenUrlW"
//FUNCTION Boolean	InternetQueryDataAvailable(Long hRequest, REF Long dwNumberOfBytesToRead, Long dwFlags, Long dwContext ) LIBRARY "WinInet.dll" ALIAS FOR "InternetQueryDataAvailable"
FUNCTION Boolean	InternetWriteFile(Long hFile, Blob lpBuffer, Long dwNumberOfBytesToRight, REF Long lpdwNumberOfBytesWrite) LIBRARY "WinInet.dll"
//FUNCTION Boolean	InternetCheckConnection( String  lpszUrl, Long dwFlags, Long dwReserved ) LIBRARY "WinInet.dll" ALIAS FOR "InternetCheckConnectionW"



//httpcontrol.dll
FUNCTION Boolean 	httpupload(  String server, long port, String path, postvalue param[], long count, boolean debug, REF String msg) LIBRARY "httpcontrol.dll" ALIAS FOR "httpupload;ansi"
FUNCTION Boolean 	setHttpSendRequestEx(Long hRequest, Long dwPostSize, Boolean debugflag, REF String msg) LIBRARY "httpcontrol.dll" ALIAS FOR "setHttpSendRequestEx;ansi"
FUNCTION Boolean	setHttpEndRequest(Long hRequest, REF String ermsg) LIBRARY "httpcontrol.dll" ALIAS FOR "setHttpEndRequest;ansi"
end prototypes

type variables
public:
CONSTANT LONG	TYPE_VALUE											= 1
CONSTANT LONG  TYPE_FILE											= 2

//InternetOpen에 사용
CONSTANT Long INTERNET_OPEN_TYPE_PRECONFIG		= 0
CONSTANT Long INTERNET_OPEN_TYPE_DIRECT				= 1
CONSTANT Long INTERNET_OPEN_TYPE_GATEWAY			= 2
CONSTANT Long INTERNET_OPEN_TYPE_PROXY				= 3

//InternetConnect에 사용
CONSTANT Long INTERNET_SERVICE_FTP							= 1
CONSTANT Long INTERNET_SERVICE_GOPHER					= 2
CONSTANT Long INTERNET_SERVICE_HTTP						= 3

//HttpOpenRequest에 사용
CONSTANT Long INTERNET_FLAG_RELOAD						= 2147483648
CONSTANT Long INTERNET_FLAG_NO_CACHE_WRITE		= 67108864
CONSTANT Long INTERNET_FLAG_RAW_DATA					= 1073741824
CONSTANT Long INTERNET_FLAG_NEED_FILE					= 16

//HttpAddRequestHeaders에 사용
CONSTANT Long HTTP_ADDREQ_FLAG_ADD 						= 536870912
CONSTANT Long HTTP_ADDREQ_FLAG_REPLACE 				= 2147483648

//HttpQueryInfo에 사용
CONSTANT Long HTTP_QUERY_MIME_VERSION                 			= 0
CONSTANT Long HTTP_QUERY_CONTENT_TYPE                 			= 1
CONSTANT Long HTTP_QUERY_CONTENT_TRANSFER_ENCODING 	= 2
CONSTANT Long HTTP_QUERY_CONTENT_ID                  	 			= 3
CONSTANT Long HTTP_QUERY_CONTENT_DESCRIPTION          	= 4
CONSTANT Long HTTP_QUERY_CONTENT_LENGTH               		= 5
CONSTANT Long HTTP_QUERY_CONTENT_LANGUAGE             		= 6
CONSTANT Long HTTP_QUERY_ALLOW                        				= 7
CONSTANT Long HTTP_QUERY_PUBLIC                       					= 8
CONSTANT Long HTTP_QUERY_DATE                         					= 9
CONSTANT Long HTTP_QUERY_EXPIRES                      				= 10
CONSTANT Long HTTP_QUERY_LAST_MODIFIED                			= 11
CONSTANT Long HTTP_QUERY_MESSAGE_ID                   			= 12
CONSTANT Long HTTP_QUERY_URI                          					= 13
CONSTANT Long HTTP_QUERY_DERIVED_FROM                 			= 14
CONSTANT Long HTTP_QUERY_COST                         					= 15
CONSTANT Long HTTP_QUERY_LINK                         					= 16
CONSTANT Long HTTP_QUERY_PRAGMA                       				= 17
CONSTANT Long HTTP_QUERY_VERSION                      				= 18  
CONSTANT Long HTTP_QUERY_STATUS_CODE                  			= 19  
CONSTANT Long HTTP_QUERY_STATUS_TEXT                  			= 20  
CONSTANT Long HTTP_QUERY_RAW_HEADERS                  			= 21  
CONSTANT Long HTTP_QUERY_RAW_HEADERS_CRLF             		= 22  
CONSTANT Long HTTP_QUERY_CONNECTION                   			= 23
CONSTANT Long HTTP_QUERY_ACCEPT                       				= 24
CONSTANT Long HTTP_QUERY_ACCEPT_CHARSET               		= 25
CONSTANT Long HTTP_QUERY_ACCEPT_ENCODING              		= 26
CONSTANT Long HTTP_QUERY_ACCEPT_LANGUAGE              		= 27
CONSTANT Long HTTP_QUERY_AUTHORIZATION                			= 28
CONSTANT Long HTTP_QUERY_CONTENT_ENCODING             		= 29
CONSTANT Long HTTP_QUERY_FORWARDED                    			= 30
CONSTANT Long HTTP_QUERY_FROM                         					= 31
CONSTANT Long HTTP_QUERY_IF_MODIFIED_SINCE            			= 32
CONSTANT Long HTTP_QUERY_LOCATION                     				= 33
CONSTANT Long HTTP_QUERY_ORIG_URI                     				= 34
CONSTANT Long HTTP_QUERY_REFERER                      				= 35
CONSTANT Long HTTP_QUERY_RETRY_AFTER                  			= 36
CONSTANT Long HTTP_QUERY_SERVER                       				= 37
CONSTANT Long HTTP_QUERY_TITLE                        					= 38
CONSTANT Long HTTP_QUERY_USER_AGENT                   			= 39
CONSTANT Long HTTP_QUERY_WWW_AUTHENTICATE             	= 40
CONSTANT Long HTTP_QUERY_PROXY_AUTHENTICATE           	= 41
CONSTANT Long HTTP_QUERY_ACCEPT_RANGES                			= 42
CONSTANT Long HTTP_QUERY_SET_COOKIE                   			= 43
CONSTANT Long HTTP_QUERY_COOKIE                       				= 44
CONSTANT Long HTTP_QUERY_REQUEST_METHOD               		= 45  
CONSTANT Long HTTP_QUERY_REFRESH                      				= 46
CONSTANT Long HTTP_QUERY_CONTENT_DISPOSITION          		= 47
CONSTANT Long HTTP_QUERY_AGE                          					= 48
CONSTANT Long HTTP_QUERY_CACHE_CONTROL                			= 49
CONSTANT Long HTTP_QUERY_CONTENT_BASE                 			= 50
CONSTANT Long HTTP_QUERY_CONTENT_LOCATION             		= 51
CONSTANT Long HTTP_QUERY_CONTENT_MD5                  			= 52
CONSTANT Long HTTP_QUERY_CONTENT_RANGE                		= 53
CONSTANT Long HTTP_QUERY_ETAG                         					= 54
CONSTANT Long HTTP_QUERY_HOST                         					= 55
CONSTANT Long HTTP_QUERY_IF_MATCH                     				= 56
CONSTANT Long HTTP_QUERY_IF_NONE_MATCH                			= 57
CONSTANT Long HTTP_QUERY_IF_RANGE                     				= 58
CONSTANT Long HTTP_QUERY_IF_UNMODIFIED_SINCE          		= 59
CONSTANT Long HTTP_QUERY_MAX_FORWARDS                 		= 60
CONSTANT Long HTTP_QUERY_PROXY_AUTHORIZATION          	= 61
CONSTANT Long HTTP_QUERY_RANGE                        				= 62
CONSTANT Long HTTP_QUERY_TRANSFER_ENCODING            		= 63
CONSTANT Long HTTP_QUERY_UPGRADE                      				= 64
CONSTANT Long HTTP_QUERY_VARY                         					= 65
CONSTANT Long HTTP_QUERY_VIA                          					= 66
CONSTANT Long HTTP_QUERY_WARNING                      				= 67
CONSTANT Long HTTP_QUERY_EXPECT                       				= 68
CONSTANT Long HTTP_QUERY_PROXY_CONNECTION             		= 69
CONSTANT Long HTTP_QUERY_UNLESS_MODIFIED_SINCE        		= 70
CONSTANT Long HTTP_QUERY_ECHO_REQUEST                 			= 71
CONSTANT Long HTTP_QUERY_ECHO_REPLY                   			= 72
CONSTANT Long HTTP_QUERY_ECHO_HEADERS                 			= 73
CONSTANT Long HTTP_QUERY_ECHO_HEADERS_CRLF            		= 74

CONSTANT Long HTTP_QUERY_MAX                          					= 74
CONSTANT Long HTTP_QUERY_CUSTOM                       				= 65535
CONSTANT Long HTTP_QUERY_FLAG_REQUEST_HEADERS         	= 2147483648 
CONSTANT Long HTTP_QUERY_FLAG_SYSTEMTIME              		= 1073741824 
CONSTANT Long HTTP_QUERY_FLAG_NUMBER                  			= 536870912 
CONSTANT Long HTTP_QUERY_FLAG_COALESCE                			= 268435456 
CONSTANT Long HTTP_QUERY_MODIFIER_FLAGS_MASK   				= HTTP_QUERY_FLAG_REQUEST_HEADERS   &
                                                													+ HTTP_QUERY_FLAG_SYSTEMTIME        &
                                                													+ HTTP_QUERY_FLAG_NUMBER            &
                                                													+ HTTP_QUERY_FLAG_COALESCE          
                                               
// HTTP Response Status Codes:
CONSTANT Long HTTP_STATUS_CONTINUE            						= 100 // OK to continue with request
CONSTANT Long HTTP_STATUS_SWITCH_PROTOCOLS    				= 101 // server has switched protocols in upgrade header
CONSTANT Long HTTP_STATUS_OK                  							= 200 // request completed
CONSTANT Long HTTP_STATUS_CREATED             						= 201 // object created, reason = new URI
CONSTANT Long HTTP_STATUS_ACCEPTED            						= 202 // async completion (TBS)
CONSTANT Long HTTP_STATUS_PARTIAL             						= 203 // partial completion
CONSTANT Long HTTP_STATUS_NO_CONTENT          					= 204 // no info to return
CONSTANT Long HTTP_STATUS_RESET_CONTENT       				= 205 // request completed, but clear form
CONSTANT Long HTTP_STATUS_PARTIAL_CONTENT     				= 206 // partial GET furfilled

CONSTANT Long HTTP_STATUS_AMBIGUOUS           					= 300 // server couldn't decide what to return
CONSTANT Long HTTP_STATUS_MOVED               						= 301 // object permanently moved
CONSTANT Long HTTP_STATUS_REDIRECT            						= 302 // object temporarily moved
CONSTANT Long HTTP_STATUS_REDIRECT_METHOD     				= 303 // redirection w/ new access method
CONSTANT Long HTTP_STATUS_NOT_MODIFIED        					= 304 // if-modified-since was not modified
CONSTANT Long HTTP_STATUS_USE_PROXY           					= 305 // redirection to proxy, location header specifies proxy to use
CONSTANT Long HTTP_STATUS_REDIRECT_KEEP_VERB  				= 307 // HTTP/1.1: keep same verb

CONSTANT Long HTTP_STATUS_BAD_REQUEST         					= 400 // invalid syntax
CONSTANT Long HTTP_STATUS_DENIED              						= 401 // access denied
CONSTANT Long HTTP_STATUS_PAYMENT_REQ         					= 402 // payment required
CONSTANT Long HTTP_STATUS_FORBIDDEN           						= 403 // request forbidden
CONSTANT Long HTTP_STATUS_NOT_FOUND           					= 404 // object not found
CONSTANT Long HTTP_STATUS_BAD_METHOD          					= 405 // method is not allowed
CONSTANT Long HTTP_STATUS_NONE_ACCEPTABLE     				= 406 // no response acceptable to client found
CONSTANT Long HTTP_STATUS_PROXY_AUTH_REQ      				= 407 // proxy authentication required
CONSTANT Long HTTP_STATUS_REQUEST_TIMEOUT     				= 408 // server timed out waiting for request
CONSTANT Long HTTP_STATUS_CONFLICT            						= 409 // user should resubmit with more info
CONSTANT Long HTTP_STATUS_GONE                						= 410 // the resource is no longer available
CONSTANT Long HTTP_STATUS_LENGTH_REQUIRED     				= 411 // the server refused to accept request w/o a length
CONSTANT Long HTTP_STATUS_PRECOND_FAILED      					= 412 // precondition given in request failed
CONSTANT Long HTTP_STATUS_REQUEST_TOO_LARGE   			= 413 // request entity was too large
CONSTANT Long HTTP_STATUS_URI_TOO_LONG        					= 414 // request URI too long
CONSTANT Long HTTP_STATUS_UNSUPPORTED_MEDIA   				= 415 // unsupported media type
CONSTANT Long HTTP_STATUS_RETRY_WITH          					= 449 // retry after doing the appropriate action.

CONSTANT Long HTTP_STATUS_SERVER_ERROR        					= 500 // internal server error
CONSTANT Long HTTP_STATUS_NOT_SUPPORTED       				= 501 // required not supported
CONSTANT Long HTTP_STATUS_BAD_GATEWAY         					= 502 // error response received from gateway
CONSTANT Long HTTP_STATUS_SERVICE_UNAVAIL     					= 503 // temporarily overloaded
CONSTANT Long HTTP_STATUS_GATEWAY_TIMEOUT     				= 504 // timed out waiting for gateway
CONSTANT Long HTTP_STATUS_VERSION_NOT_SUP     				= 505 // HTTP version not supported

CONSTANT Long HTTP_STATUS_FIRST               							= HTTP_STATUS_CONTINUE
CONSTANT Long HTTP_STATUS_LAST                							= HTTP_STATUS_VERSION_NOT_SUP

//모든 함수의 Return
CONSTANT Int SUCCESS 																= 1
CONSTANT Int FAILURE 																= -1

Protected:
  FileManager		file
  StringTokenizer	stringtoken
  Vector				ivc
  String 					is_boundary 	= "---------------------------7d729f2ea1356"
  String					is_bound		= "--"
  Boolean				canceltf 		= false
end variables

forward prototypes
private subroutine of_filepathd (string as_filepath, ref string as_path, ref string as_file)
public function integer of_uploadfile (parameters ast_parm)
public function integer of_downloadfile (parameters ast_parm)
private subroutine of_filecheckcount (ref string as_filename)
public function integer of_directdownload (parameters ast_parm)
public function integer of_sendrul (parameters ast_parm, ref string as_rtnmsg)
public function integer of_downloadprogress (w_webdown aw_win, parameters ast_parm)
private subroutine of_sethttpproperties (string as_url, ref vector avc)
private function string of_returnsize (long al_size)
public function integer of_uploadfileex (parameters ast_parm)
private function blob defaultparam (postvalue data)
private function blob fileparam (postvalue data)
private function long totalparamsize (postvalue data[])
public function integer of_uploadfiledll (parameters ast_parm)
private function long totalparamsize (postvalue data[], ref w_webupload wdata, ref decimal filetotalsize)
public function integer of_uploadfileex_progress (parameters ast_parm, w_webupload wdata)
public subroutine canceldata (boolean data)
end prototypes

private subroutine of_filepathd (string as_filepath, ref string as_path, ref string as_file);Long	ll_pos
ll_pos = LastPos(as_filepath, "\")

as_path = Left(as_filepath, ll_pos)

as_file = Right(as_filepath, (Len(as_filepath) - ll_pos))
end subroutine

public function integer of_uploadfile (parameters ast_parm);Long		ll_iopenhandle, ll_iconnecthandle, ll_OpenRequestHandle
Long		ll_offset = 32765
Long		lpdwBufferLength, dwHeadersLength, lpdwIndex, li_RT, i, ll_size
Blob		lb_buffer, lb_totalblob
String		ls_Agent = "PB", ls_ProxyName, ls_ProxyByPass
String		lpvBuffer, ls_filepath
String 	ls_name, ls_pass, lpszHeaders, ls_null, ls_filename
//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
String	ls_nulval
SetNull(ls_nulval)
//=================================

Vector	lvc
//

lvc = Create Vector
lpdwBufferLength = ll_offset
lpvBuffer = Space(lpdwBufferLength)
//
of_sethttpproperties(ast_parm.serverurl, lvc)

ls_filename = ast_parm.filename

//Internet Opened
ll_iopenhandle = InternetOpen(ls_Agent, INTERNET_OPEN_TYPE_PRECONFIG, ls_ProxyName, ls_ProxyByPass, 0)
IF ll_iopenhandle > 0 THEN
	//url로 Connect한다.
	ll_iconnecthandle = InternetConnect(ll_iopenhandle, lvc.getproperty('serverurl'), Long(lvc.getproperty('port')), ls_name, ls_pass, INTERNET_SERVICE_HTTP, 0, 0)
	IF ll_iconnecthandle > 0 THEN
		//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
		ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", ls_nulval, INTERNET_FLAG_RELOAD, 0)
		//==================================
		//ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", "", INTERNET_FLAG_RELOAD, 0)
		//==================================
		IF ll_OpenRequestHandle > 0 THEN
			lpszHeaders  = "Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-powerpoint, application/vnd.ms-excel, application/msword, */*~r~n"
			lpszHeaders += "Referer: http://localhost/upload/up.html~r~n"
			lpszHeaders += "Accept-Language: ko~r~n"
			lpszHeaders += "Content-Type: multipart/form-data; boundary="
			lpszHeaders += is_boundary
			lpszHeaders += "~r~n"
			lpszHeaders += "Accept-Encoding: gzip, deflate~r~n"
			lpszHeaders += "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)~r~n"
			lpszHeaders += "Connection: Keep-Alive~r~n"
			lpszHeaders += "Cache-Control: no-cache~r~n"
			
			dwHeadersLength = Len(lpszHeaders)
			
			IF HttpAddRequestHeaders(ll_OpenRequestHandle, lpszHeaders, dwHeadersLength, HTTP_ADDREQ_FLAG_ADD) THEN 
				For i = 1 TO UpperBound(ast_parm.parameter)
					//Yield()
					IF ast_parm.parameter[i].param_type = TYPE_VALUE THEN
						lb_buffer  	+= Blob(is_bound,EncodingAnsi!)
						lb_buffer  	+= Blob(is_boundary, EncodingAnsi!)
						lb_buffer  	+= Blob("~r~n", EncodingAnsi!)
						lb_buffer 	+= Blob("Content-Disposition: form-data; name=~"" + ast_parm.parameter[i].param + "~"~r~n~r~n", EncodingAnsi!)
						lb_buffer 	+= Blob(ast_parm.parameter[i].data, EncodingAnsi!)
						lb_buffer 	+= Blob("~r~n", EncodingAnsi!)
					ELSE
						ll_size = file.getfile( ast_parm.parameter[i].data, lb_totalblob)
						lb_buffer  	+= Blob(is_bound, EncodingAnsi!)
						lb_buffer  	+= Blob(is_boundary, EncodingAnsi!)
						lb_buffer  	+= Blob("~r~n", EncodingAnsi!)
						of_FilePathD(ast_parm.parameter[i].data, ls_filepath , ls_filename)
						IF Trim(ast_parm.parameter[i].rename) = '' OR IsNull(ast_parm.parameter[i].rename) OR (ls_filepath + ast_parm.parameter[i].rename = ast_parm.parameter[i].data) THEN
							lb_buffer 	+= Blob("Content-Disposition: form-data; name=~"" + ast_parm.parameter[i].param + "~"; filename=~"" + ast_parm.parameter[i].data + "~"~r~n", EncodingAnsi!)
						ELSE
							lb_buffer 	+= Blob("Content-Disposition: form-data; name=~"" + ast_parm.parameter[i].param + "~"; filename=~"" + ls_filepath + ast_parm.parameter[i].rename + "~"~r~n", EncodingAnsi!)
						END IF
						lb_buffer 	+= Blob("Content-Type: application/octet-stream~r~n~r~n", EncodingAnsi!)
						lb_buffer	+= lb_totalblob
						lb_totalblob = Blob("")
						lb_buffer	+= Blob("~r~n", EncodingAnsi!)
					END IF
				NEXT
				
				lb_buffer += Blob(is_bound + is_boundary + is_bound + "~r~n", EncodingAnsi!)
				dwHeadersLength = Len(lb_buffer)
				
				IF HttpSendRequest (ll_OpenRequestHandle, ls_null, 0, lb_buffer, dwHeadersLength) THEN
					lpdwBufferLength = ll_offset
					lpvBuffer = Space(lpdwBufferLength)
					IF HttpQueryInfo(ll_OpenRequestHandle, HTTP_QUERY_STATUS_CODE, lpvBuffer, lpdwBufferLength, lpdwIndex) THEN
						IF Long(lpvBuffer) = HTTP_STATUS_OK THEN
							lb_buffer = Blob(Space(ll_offset), EncodingUTF8!)
							lb_totalblob = Blob("", EncodingUTF8!)
							do while InternetReadFile(ll_OpenRequestHandle, lb_buffer, ll_offset, ll_size)
								lb_buffer = BlobMid ( lb_buffer, 1, ll_size )
								lb_totalblob += lb_buffer
								lb_buffer = Blob("")
								IF ll_size = 0 THEN Exit								
							loop
							//messagebox("Info", Trim(String(lb_totalblob, EncodingUTF8!)))
							li_RT = SUCCESS
						ELSE
							messagebox("Response", Trim(lpvBuffer))
							li_RT = FAILURE
						END IF
					ELSE
						messagebox("HttpQueryInfo", "Response에 대한 Status를 가지고 올 수 없습니다.")
						li_RT = FAILURE
					END IF
				ELSE
					messagebox("HttpSendRequest", "Request를 보낼 수 없습니다.")
					li_RT = FAILURE
				END IF
			ELSE
				messagebox("HttpAddRequestHeaders", "Header에 값을 넣을 수 없습니다.")
				li_RT = FAILURE
			END IF
			
			InternetCloseHandle(ll_OpenRequestHandle)
		ELSE
			messagebox("HttpOpenRequest", "Request Handle를 열수 없습니다.")
			li_RT = FAILURE
		END IF
		
		InternetCloseHandle(ll_iconnecthandle)
	ELSE
		messagebox("InternetConnect", "Internet에서 해당 URL를 열수가 없습니다.")
		li_RT = FAILURE
	END IF
	
	InternetCloseHandle(ll_iopenhandle)
ELSE
	messagebox("InternetOpen", "Internet Connector을 열수가 없습니다.")
	li_RT = FAILURE
END IF

return li_rt
end function

public function integer of_downloadfile (parameters ast_parm);Long		ll_iopenhandle, ll_iconnecthandle, ll_OpenRequestHandle
Long		ll_offset = 32765
Long		lpdwBufferLength, dwHeadersLength, lpdwIndex, li_RT, i, ll_filesize, ll_size, ll_total
Blob		lb_buffer, lb_totalblob
String		ls_Agent = "PB", ls_ProxyName, ls_ProxyByPass
String		lpvBuffer, ls_filepath
String 	ls_name, ls_pass, lpszHeaders, ls_null, ls_buffer, ls_filename
//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
String	ls_nulval
SetNull(ls_nulval)
//=================================

Vector	lvc

lvc = Create Vector
lpdwBufferLength = ll_offset
lpvBuffer = Space(lpdwBufferLength)

of_sethttpproperties(ast_parm.serverurl, lvc)

ls_filename = ast_parm.filename

//Internet Opened
ll_iopenhandle = InternetOpen(ls_Agent, INTERNET_OPEN_TYPE_PRECONFIG, ls_ProxyName, ls_ProxyByPass, 0)
IF ll_iopenhandle > 0 THEN

	//url로 Connect한다.
	ll_iconnecthandle = InternetConnect(ll_iopenhandle, lvc.getproperty('serverurl'), Long(lvc.getproperty('port')), ls_name, ls_pass, INTERNET_SERVICE_HTTP, 0, 0)
	IF ll_iconnecthandle > 0 THEN
		//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
		ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", ls_nulval, INTERNET_FLAG_RELOAD, 0)
		//==================================
		//ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", "", INTERNET_FLAG_RELOAD, 0)
		//==================================
		IF ll_OpenRequestHandle > 0 THEN
			lpszHeaders  = "Accept: */*~r~n"
			lpszHeaders += "Referer: http://localhost/download/down.html~r~n"
			lpszHeaders += "Accept-Language: ko~r~n"
			lpszHeaders += "Content-Type: application/x-www-form-urlencoded~r~n"
			lpszHeaders += "Accept-Encoding: gzip, deflate~r~n"
			lpszHeaders += "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)~r~n"
			lpszHeaders += "Connection: Keep-Alive~r~n"
			lpszHeaders += "Cache-Control: no-cache~r~n"
			dwHeadersLength = Len(lpszHeaders)

			IF HttpAddRequestHeaders(ll_OpenRequestHandle, lpszHeaders, dwHeadersLength, HTTP_ADDREQ_FLAG_ADD) THEN 
				For i = 1 TO UpperBound(ast_parm.parameter)
					IF ast_parm.parameter[i].param_type = TYPE_VALUE THEN
						ls_buffer = ast_parm.parameter[i].param + "=" + ast_parm.parameter[i].data
						lb_buffer  	+= Blob(ls_buffer, EncodingAnsi!)
						IF i <> UpperBound(ast_parm.parameter) THEN lb_buffer += Blob("&", EncodingAnsi!)
					END IF
				NEXT
			
				dwHeadersLength = Len(lb_buffer)

				IF HttpSendRequest (ll_OpenRequestHandle, ls_null, 0, lb_buffer, dwHeadersLength) THEN
					lpdwBufferLength = ll_offset
					lpvBuffer = Space(lpdwBufferLength)
					IF HttpQueryInfo(ll_OpenRequestHandle, HTTP_QUERY_STATUS_CODE, lpvBuffer, lpdwBufferLength, lpdwIndex) THEN
						IF Long(lpvBuffer) = HTTP_STATUS_OK THEN
							lpdwBufferLength = ll_offset
							lpvBuffer = Space(lpdwBufferLength)
							
							HttpQueryInfo(ll_OpenRequestHandle, HTTP_QUERY_CONTENT_LENGTH , lpvBuffer, lpdwBufferLength, lpdwIndex)
							ll_filesize = Long(lpvBuffer)

							IF ll_filesize < ll_offset THEN ll_offset = ll_filesize
							
							lb_buffer = Blob(Space(ll_offset))
							ls_filepath = ast_parm.defaultpath + "\" + ls_filename
							
							// File존재여부 확인하기.
							IF FileExists(ls_filepath) THEN
								of_fileCheckCount(ls_filename)
								FileMove(ls_filepath, ast_parm.defaultpath + "\" + ls_filename)
							END IF

							lb_totalblob = Blob("")
							
							//li_FileNum = FileOpen(ls_filepath, StreamMode!, Write!, LockWrite!, Replace!)
							do while InternetReadFile(ll_OpenRequestHandle, lb_buffer, ll_offset, ll_size)
								Yield()
								ll_total += ll_size
								lb_buffer = BlobMid ( lb_buffer, 1, ll_size )
								lb_totalblob += lb_buffer
								IF ll_size > 0 THEN
									Yield()
									file.setFile(ls_filepath, lb_buffer, file.WRITE_STREAM_BLOB_APEND)
									
									IF ll_offset > ( ll_filesize - ll_total ) THEN ll_offset = ll_filesize - ll_total
									
									lb_buffer = Blob(Space(ll_offset))
								ELSE
									Exit
								END IF
								Yield()
							loop

							IF ll_total = ll_filesize THEN 
								li_RT = SUCCESS
							ELSE
								messagebox("Information", "DownLoad Failed : " + Trim(String(lb_buffer)))
								FileDelete(ls_filepath)
								li_RT = FAILURE
							END IF
						ELSE
							messagebox("Response", Trim(lpvBuffer))
							li_RT = FAILURE
						END IF
					ELSE
						messagebox("HttpQueryInfo", "Response에 대한 Status를 가지고 올 수 없습니다.")
						li_RT = FAILURE
					END IF
				ELSE
					messagebox("HttpSendRequest", "Request를 보낼 수 없습니다.")
					li_RT = FAILURE
				END IF
			ELSE
				messagebox("HttpAddRequestHeaders", "Header에 값을 넣을 수 없습니다.")
				li_RT = FAILURE
			END IF
			
			InternetCloseHandle(ll_OpenRequestHandle)
			
		ELSE
			messagebox("HttpOpenRequest", "Request Handle를 열수 없습니다.")
			li_RT = FAILURE
		END IF
		
		InternetCloseHandle(ll_iconnecthandle)

	ELSE
		messagebox("InternetConnect", "Internet에서 해당 URL를 열수가 없습니다.")
		li_RT = FAILURE
	END IF
	
	InternetCloseHandle(ll_iopenhandle)
ELSE
	messagebox("InternetOpen", "Internet Connector을 열수가 없습니다.")
	li_RT = FAILURE
END IF

return li_RT
end function

private subroutine of_filecheckcount (ref string as_filename);/*=================================================================================

		Function Name 	: of_filecheckcount
		Access Type		: private
		Return Type		: Void
		Argument Name					Type					Command
		--------------------------------------------------------
		reference as_filename		String				file name
		
		Command : 파일 이름 바꾸기. 
					 파일명 + 날짜시간분초 + 확장자.
		
		-------------------------------------------------------
		작성자 	: 송상철
		작성일자 : 2006.01.06
		-------------------------------------------------------
		수정자 	:
		수정일자 :
		-------------------------------------------------------
		
=================================================================================*/
String	ls_name, ls_file
Long		ll_number

ll_number 	= LastPos(as_filename, ".")
ls_name 		= Left(as_filename, ll_number - 1)
ls_file 		= Mid(as_filename, ll_number)

as_filename = ls_name + "_" + String(today(), "yyyymmddhhmmss") + ls_file



end subroutine

public function integer of_directdownload (parameters ast_parm);Long		ll_iopenhandle, ll_iconnecthandle, ll_Context
Long		ll_offset = 32765
Long		lpdwBufferLength, lpdwIndex, li_RT, ll_filesize, ll_size, ll_total
Blob		lb_buffer, lb_totalblob
String	ls_Agent = "PB", ls_ProxyName, ls_ProxyByPass
String	lpvBuffer, ls_filepath
String 	ls_null, ls_filename

Vector	lvc

lvc = Create Vector
lpdwBufferLength = ll_offset
lpvBuffer = Space(lpdwBufferLength)

ls_filename = ast_parm.filename

//Internet Opened
ll_iopenhandle = InternetOpen(ls_Agent, INTERNET_OPEN_TYPE_PRECONFIG, ls_ProxyName, ls_ProxyByPass, 0)
IF ll_iopenhandle > 0 THEN

	//url로 Connect한다.
	ll_iconnecthandle = InternetOpenURL(ll_iopenhandle, ast_parm.serverurl, ls_null, 0, INTERNET_FLAG_RELOAD, ll_Context)
	IF ll_iconnecthandle > 0 THEN
		IF HttpQueryInfo(ll_iconnecthandle, HTTP_QUERY_STATUS_CODE, lpvBuffer, lpdwBufferLength, lpdwIndex) THEN
			IF Long(lpvBuffer) = HTTP_STATUS_OK THEN
				lpdwBufferLength = ll_offset
				lpvBuffer = Space(lpdwBufferLength)
				
				HttpQueryInfo(ll_iconnecthandle, HTTP_QUERY_CONTENT_LENGTH , lpvBuffer, lpdwBufferLength, lpdwIndex)
				ll_filesize = Long(lpvBuffer)
				
				IF ll_filesize < ll_offset THEN ll_offset = ll_filesize
					
				lb_buffer = Blob(Space(ll_offset))

				ls_filepath = ast_parm.defaultpath + "\" + ls_filename
				
				// File존재여부 확인하기.
				IF FileExists(ls_filepath) THEN
					of_fileCheckCount(ls_filename)
					FileMove(ls_filepath, ast_parm.defaultpath + "\" + ls_filename)
				END IF

				lb_totalblob = Blob("")
						
				//li_FileNum = FileOpen(ls_filepath, StreamMode!, Write!, LockWrite!, Replace!)
				do while InternetReadFile(ll_iconnecthandle, lb_buffer, ll_offset, ll_size)
					Yield()
					ll_total += ll_size
					lb_buffer = BlobMid ( lb_buffer, 1, ll_size )
					lb_totalblob += lb_buffer
					IF ll_size > 0 THEN
						Yield()
						file.setFile(ls_filepath, lb_buffer, file.WRITE_STREAM_BLOB_APEND)
						
						IF ll_offset > ( ll_filesize - ll_total ) THEN ll_offset = ll_filesize - ll_total
						lb_buffer = Blob(Space(ll_offset))
					ELSE
						Exit
					END IF
					Yield()
				loop

				IF ll_total = ll_filesize THEN 
					li_RT = SUCCESS
				ELSE
					messagebox("Information", "DownLoad Failed : " + Trim(String(lb_buffer)))
					FileDelete(ls_filepath)
					li_RT = FAILURE
				END IF
			ELSE
				messagebox("Response", Trim(lpvBuffer))
				li_RT = FAILURE
			END IF
		ELSE
			messagebox("HttpQuryInfo", "Request Information를 가지고 올 수  없습니다.")
			li_RT = FAILURE
		END IF
		
		InternetCloseHandle(ll_iconnecthandle)
	ELSE
		messagebox("InternetConnect", "Internet에서 해당 URL를 열수가 없습니다.")
		li_RT = FAILURE
	END IF
	
	InternetCloseHandle(ll_iopenhandle)
ELSE
	messagebox("InternetOpen", "Internet Connector을 열수가 없습니다.")
	li_RT = FAILURE
END IF


return li_RT
end function

public function integer of_sendrul (parameters ast_parm, ref string as_rtnmsg);Long		ll_iopenhandle, ll_iconnecthandle, ll_OpenRequestHandle
Long		ll_offset = 32765
Long		lpdwBufferLength, dwHeadersLength, lpdwIndex, li_RT, i, ll_size
Blob		lb_buffer, lb_totalblob
String		ls_Agent = "PB", ls_ProxyName, ls_ProxyByPass
String		lpvBuffer
String 	ls_name, ls_pass, lpszHeaders, ls_null, ls_buffer, ls_filename
//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
String	ls_nulval
SetNull(ls_nulval)
//=================================

Vector	lvc

lvc = Create Vector
lpdwBufferLength = ll_offset
lpvBuffer = Space(lpdwBufferLength)

of_sethttpproperties(ast_parm.serverurl, lvc)

ls_filename = ast_parm.filename

//Internet Opened
ll_iopenhandle = InternetOpen(ls_Agent, INTERNET_OPEN_TYPE_PRECONFIG, ls_ProxyName, ls_ProxyByPass, 0)
IF ll_iopenhandle > 0 THEN
	//url로 Connect한다.
	ll_iconnecthandle = InternetConnect(ll_iopenhandle, lvc.getproperty('serverurl'), Long(lvc.getproperty('port')), ls_name, ls_pass, INTERNET_SERVICE_HTTP, 0, 0)
	IF ll_iconnecthandle > 0 THEN
		//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
		ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", ls_nulval, INTERNET_FLAG_RELOAD, 0)
		//=====================================
		//ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", ls_acept, INTERNET_FLAG_RELOAD, 0)
		//=====================================
		IF ll_OpenRequestHandle > 0 THEN
			lpszHeaders  = "Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*~r~n"
			lpszHeaders += "Referer: http://localhost/download/down.html~r~n"
			lpszHeaders += "Accept-Language: ko~r~n"
			lpszHeaders += "Content-Type: application/x-www-form-urlencoded~r~n"
			lpszHeaders += "Accept-Encoding: gzip, deflate~r~n"
			lpszHeaders += "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)~r~n"
			lpszHeaders += "Connection: Keep-Alive~r~n"
			lpszHeaders += "Cache-Control: no-cache~r~n"
			
			dwHeadersLength = Len(lpszHeaders)
			
			IF HttpAddRequestHeaders(ll_OpenRequestHandle, lpszHeaders, dwHeadersLength, HTTP_ADDREQ_FLAG_ADD) THEN 
				For i = 1 TO UpperBound(ast_parm.parameter)
					IF ast_parm.parameter[i].param_type = TYPE_VALUE THEN
						ls_buffer = ast_parm.parameter[i].param + "=" + ast_parm.parameter[i].data
						lb_buffer  	+= Blob(ls_buffer, EncodingAnsi!)
						IF i <> UpperBound(ast_parm.parameter) THEN lb_buffer += Blob("&", EncodingAnsi!)
					END IF
				NEXT
				dwHeadersLength = Len(lb_buffer)
				
				IF HttpSendRequest (ll_OpenRequestHandle, ls_null, 0, lb_buffer, dwHeadersLength) THEN
					lpdwBufferLength = ll_offset
					lpvBuffer = Space(lpdwBufferLength)
					IF HttpQueryInfo(ll_OpenRequestHandle, HTTP_QUERY_STATUS_CODE, lpvBuffer, lpdwBufferLength, lpdwIndex) THEN
						IF Long(lpvBuffer) = HTTP_STATUS_OK THEN
							lb_buffer = Blob(Space(ll_offset), EncodingUTF8!)
							lb_totalblob = Blob("", EncodingUTF8!)
							do while InternetReadFile(ll_OpenRequestHandle, lb_buffer, ll_offset, ll_size)
								lb_buffer = BlobMid ( lb_buffer, 1, ll_size )
								lb_totalblob += lb_buffer
								lb_buffer = Blob(Space(ll_offset), EncodingUTF8!)
								IF ll_size = 0 THEN Exit								
							loop
							
							messagebox("Info", Trim(String(lb_totalblob, EncodingUTF8!)))
							li_RT = SUCCESS
						ELSE
							messagebox("Response", Trim(lpvBuffer))
							li_RT = FAILURE
						END IF
					ELSE
						messagebox("HttpQueryInfo", "Response에 대한 Status를 가지고 올 수 없습니다.")
						li_RT = FAILURE
					END IF
				ELSE
					messagebox("HttpSendRequest", "Request를 보낼 수 없습니다.")
					li_RT = FAILURE
				END IF
			ELSE
				messagebox("HttpAddRequestHeaders", "Header에 값을 넣을 수 없습니다.")
				li_RT = FAILURE
			END IF
			
			InternetCloseHandle(ll_OpenRequestHandle)
		ELSE
			messagebox("HttpOpenRequest", "Request Handle를 열수 없습니다.")
			li_RT = FAILURE
		END IF
		
		InternetCloseHandle(ll_iconnecthandle)
	ELSE
		messagebox("InternetConnect", "Internet에서 해당 URL를 열수가 없습니다.")
		li_RT = FAILURE
	END IF
	
	InternetCloseHandle(ll_iopenhandle)
ELSE
	messagebox("InternetOpen", "Internet Connector을 열수가 없습니다.")
	li_RT = FAILURE
END IF

return li_rt
end function

public function integer of_downloadprogress (w_webdown aw_win, parameters ast_parm);Long		ll_iopenhandle, ll_iconnecthandle, ll_OpenRequestHandle
Long		ll_offset = 32765
Long		lpdwBufferLength, dwHeadersLength, lpdwIndex, li_RT, i, ll_filesize, ll_size, ll_total
Blob		lb_buffer, lb_totalblob
String		ls_Agent = "PB", ls_ProxyName, ls_ProxyByPass
String		lpvBuffer, ls_filepath
String 	ls_name, ls_pass, lpszHeaders, ls_null, ls_buffer, ls_filename
//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
String	ls_nulval
SetNull(ls_nulval)
//=================================

Vector	lvc

lvc = Create Vector
lpdwBufferLength = ll_offset
lpvBuffer = Space(lpdwBufferLength)

of_sethttpproperties(ast_parm.serverurl, lvc)

ls_filename = ast_parm.filename

//Internet Opened
ll_iopenhandle = InternetOpen(ls_Agent, INTERNET_OPEN_TYPE_PRECONFIG, ls_ProxyName, ls_ProxyByPass, 0)
IF ll_iopenhandle > 0 THEN

	//url로 Connect한다.
	ll_iconnecthandle = InternetConnect(ll_iopenhandle, lvc.getproperty('serverurl'), Long(lvc.getproperty('port')), ls_name, ls_pass, INTERNET_SERVICE_HTTP, 0, 0)
	IF ll_iconnecthandle > 0 THEN
		//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
		ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "",ls_nulval, INTERNET_FLAG_RELOAD, 0)
		//=================================
		//ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", "", INTERNET_FLAG_RELOAD, 0)
		//=================================
		IF ll_OpenRequestHandle > 0 THEN
			lpszHeaders  = "Accept: */*~r~n"
			lpszHeaders += "Referer: http://localhost/download/down.html~r~n"
			lpszHeaders += "Accept-Language: ko~r~n"
			lpszHeaders += "Content-Type: application/x-www-form-urlencoded~r~n"
			lpszHeaders += "Accept-Encoding: gzip, deflate~r~n"
			lpszHeaders += "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)~r~n"
			lpszHeaders += "Connection: Keep-Alive~r~n"
			lpszHeaders += "Cache-Control: no-cache~r~n"
			dwHeadersLength = Len(lpszHeaders)

			IF HttpAddRequestHeaders(ll_OpenRequestHandle, lpszHeaders, dwHeadersLength, HTTP_ADDREQ_FLAG_ADD) THEN 
				For i = 1 TO UpperBound(ast_parm.parameter)
					IF ast_parm.parameter[i].param_type = TYPE_VALUE THEN
						ls_buffer = ast_parm.parameter[i].param + "=" + ast_parm.parameter[i].data
						lb_buffer  	+= Blob(ls_buffer, EncodingAnsi!)
						IF i <> UpperBound(ast_parm.parameter) THEN lb_buffer += Blob("&", EncodingAnsi!)
					END IF
				NEXT
			
				dwHeadersLength = Len(lb_buffer)

				IF HttpSendRequest (ll_OpenRequestHandle, ls_null, 0, lb_buffer, dwHeadersLength) THEN
					lpdwBufferLength = ll_offset
					lpvBuffer = Space(lpdwBufferLength)
					IF HttpQueryInfo(ll_OpenRequestHandle, HTTP_QUERY_STATUS_CODE, lpvBuffer, lpdwBufferLength, lpdwIndex) THEN
						IF Long(lpvBuffer) = HTTP_STATUS_OK THEN
							lpdwBufferLength = ll_offset
							lpvBuffer = Space(lpdwBufferLength)
							
							HttpQueryInfo(ll_OpenRequestHandle, HTTP_QUERY_CONTENT_LENGTH , lpvBuffer, lpdwBufferLength, lpdwIndex)
							ll_filesize = Long(lpvBuffer)
							
							IF ll_filesize < ll_offset THEN ll_offset = ll_filesize
							
							lb_buffer = Blob(Space(ll_offset))
							ls_filepath = ast_parm.defaultpath + "\" + ls_filename
							
							aw_win.st_filename.text = ls_filename
							
							// File존재여부 확인하기.
							IF FileExists(ls_filepath) THEN
								of_fileCheckCount(ls_filename)
								FileMove(ls_filepath, ast_parm.defaultpath + "\" + ls_filename)
							END IF

							aw_win.st_local.text 		= ls_filepath
							aw_win.st_tot.text  		= of_returnsize(ll_filesize)
						
							lb_totalblob = Blob("")
							
							//li_FileNum = FileOpen(ls_filepath, StreamMode!, Write!, LockWrite!, Replace!)
							do while InternetReadFile(ll_OpenRequestHandle, lb_buffer, ll_offset, ll_size)
								Yield()
								
								IF canceltf THEN
									IF MessageBox("Question", "정말로 취소 하시겠습니까?", Question!, YesNo!, 2) = 1 THEN
										lb_buffer = Blob("DownLoad를 취소 하였습니다.")
										Exit
									END IF
								END IF

								ll_total += ll_size
								lb_buffer = BlobMid ( lb_buffer, 1, ll_size )
								lb_totalblob += lb_buffer
								IF ll_size > 0 THEN
									Yield()
									file.setFile(ls_filepath, lb_buffer, file.WRITE_STREAM_BLOB_APEND)
									IF ll_filesize > 0 THEN
										aw_win.hpb_per.position 	= Truncate((ll_total / ll_filesize ) * 100, 0)
										aw_win.st_per.text 			= String(Truncate((ll_total / ll_filesize ) * 100, 0)) + "%"
									END IF
									aw_win.st_down.text 		= of_returnsize(ll_total)
									
									IF ll_offset > ( ll_filesize - ll_total ) THEN ll_offset = ll_filesize - ll_total
									
									lb_buffer = Blob(Space(ll_offset))
								ELSE
									Exit
								END IF
								Yield()
							loop

							IF ll_total = ll_filesize THEN 
								li_RT = SUCCESS
							ELSE
								messagebox("Information", "DownLoad Failed : " + Trim(String(lb_buffer)))
								FileDelete(ls_filepath)
								li_RT = FAILURE
							END IF
						ELSE
							messagebox("Response", Trim(lpvBuffer))
							li_RT = FAILURE
						END IF
					ELSE
						messagebox("HttpQueryInfo", "Response에 대한 Status를 가지고 올 수 없습니다.")
						li_RT = FAILURE
					END IF
				ELSE
					messagebox("HttpSendRequest", "Request를 보낼 수 없습니다.")
					li_RT = FAILURE
				END IF
			ELSE
				messagebox("HttpAddRequestHeaders", "Header에 값을 넣을 수 없습니다.")
				li_RT = FAILURE
			END IF
			
			InternetCloseHandle(ll_OpenRequestHandle)
		ELSE
			messagebox("HttpOpenRequest", "Request Handle를 열수 없습니다.")
			li_RT = FAILURE
		END IF
		
		InternetCloseHandle(ll_iconnecthandle)
	ELSE
		messagebox("InternetConnect", "Internet에서 해당 URL를 열수가 없습니다.")
		li_RT = FAILURE
	END IF
	
	InternetCloseHandle(ll_iopenhandle)
ELSE
	messagebox("InternetOpen", "Internet Connector을 열수가 없습니다.")
	li_RT = FAILURE
END IF





return li_RT
end function

private subroutine of_sethttpproperties (string as_url, ref vector avc);/*=================================================================================

		Function Name 	: of_sethttpproperties
		Access Type		: private 
		Return Type		: void
		Argument Name					Type					Command
		--------------------------------------------------------
		value		as_url				String				url
		
		Command : 서버와/포트/하우패스/파일이름 분리 해내기.
		
		-------------------------------------------------------
		작성자 	: 송상철
		작성일자 : 2006.01.06
		-------------------------------------------------------
		수정자 	:
		수정일자 :
		-------------------------------------------------------
		
=================================================================================*/
String 	ls_first, ls_last
Long		ll_port

//Server Name Check
stringtoken.settokenizer( as_url, "http://")
IF stringtoken.hasmoretokens() THEN 
	ls_first = stringtoken.nexttoken( )
	ls_last 	= stringtoken.getmorestring( )
	
	//FileName url path check
	stringtoken.settokenizer( ls_last, "/")
	IF stringtoken.hasmoretokens( ) THEN
		ls_first = stringtoken.nexttoken( )
		ls_last 	= stringtoken.getmorestring( )
		
		avc.setproperty('filepath', ls_last)
		//is_urlfilepath = ls_last
		
		stringtoken.settokenizer( ls_last, "/")
		do while stringtoken.hasmoretokens( )
			avc.setproperty('filename', stringtoken.nexttoken( ) )
			//is_filename = stringtoken.nexttoken( )
		loop
		
		//Port Check
		stringtoken.settokenizer( ls_first, ":")
		IF stringtoken.hasmoretokens( ) THEN
			ls_first = stringtoken.nexttoken( )
			ls_last 	= stringtoken.getmorestring( )
			
			//is_ServerURL = ls_first
			avc.setproperty('serverurl', ls_first)
			
			ll_port = Long(ls_last)
			IF ll_port = 0 THEN ll_port = 80			
			avc.setproperty('port', String(ll_port))
		END IF
	END IF
END IF
end subroutine

private function string of_returnsize (long al_size);/*=================================================================================

		Function Name 	: of_returnsize
		Access Type		: private
		Return Type		: String   File Size를 뒤에 단위 붙여서 나타내기.
		Argument Name					Type					Command
		--------------------------------------------------------
		value		al_size				long					File Size
		
		Command : File Size Checking
		
		-------------------------------------------------------
		작성자 	: 송상철
		작성일자 : 2006.01.06
		-------------------------------------------------------
		수정자 	:
		수정일자 :
		-------------------------------------------------------
		
=================================================================================*/
String 	ls_ea[] = {"Bytes", "KB", "MB", "TB"}
String	ls_rtn
Integer	i
Decimal	ldc_size		
ldc_size = al_size

do while true
	i++
	ldc_size = ldc_size / 1024
	IF ldc_size < 1 THEN
		ldc_size = ldc_size * 1024
		exit
	END IF
loop

ls_rtn = String(ldc_size, "#,##0.00") + " " + ls_ea[i]

return ls_rtn
end function

public function integer of_uploadfileex (parameters ast_parm);Long		ll_iopenhandle, ll_iconnecthandle, ll_OpenRequestHandle
Long		ll_offset = 32765
Long		lpdwBufferLength, dwHeadersLength, lpdwIndex, li_RT, i, ll_size
Blob		lb_buffer, lb_totalblob
String		ls_Agent = "PB", ls_ProxyName, ls_ProxyByPass
String		lpvBuffer
String 	ls_name, ls_pass, lpszHeaders, ls_filename
String		ls_boundary = "---------------------------7d729f2ea1356"
Boolean	lb_tf
Vector	lvc
String  ls_err
ls_err = Space(512)
//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
String	ls_nulval
SetNull(ls_nulval)
//=================================

//

lvc = Create Vector
lpdwBufferLength = ll_offset
lpvBuffer = Space(lpdwBufferLength)
//
of_sethttpproperties(ast_parm.serverurl, lvc)

ls_filename = ast_parm.filename
Boolean  lb_check
//Internet Opened
ll_iopenhandle = InternetOpen(ls_Agent, INTERNET_OPEN_TYPE_PRECONFIG, ls_ProxyName, ls_ProxyByPass, 0)
IF ll_iopenhandle > 0 THEN
	//url로 Connect한다.
	ll_iconnecthandle = InternetConnect(ll_iopenhandle, lvc.getproperty('serverurl'), Long(lvc.getproperty('port')), ls_name, ls_pass, INTERNET_SERVICE_HTTP, 0, 0)
	IF ll_iconnecthandle > 0 THEN
		//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
		ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", ls_nulval, INTERNET_FLAG_RELOAD, 0)
		//=================================
		//ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", "", INTERNET_FLAG_RELOAD, 0)
		//=================================
		IF ll_OpenRequestHandle > 0 THEN
			lpszHeaders  = "Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-powerpoint, application/vnd.ms-excel, application/msword, */*~r~n"
			lpszHeaders += "Referer: http://localhost/upload/up.html~r~n"
			lpszHeaders += "Accept-Language: ko~r~n"
			lpszHeaders += "Content-Type: multipart/form-data; boundary="
			lpszHeaders += ls_boundary
			lpszHeaders += "~r~n"
			lpszHeaders += "Accept-Encoding: gzip, deflate~r~n"
			lpszHeaders += "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)~r~n"
			lpszHeaders += "Connection: Keep-Alive~r~n"
			lpszHeaders += "Cache-Control: no-cache~r~n"
			
			dwHeadersLength = Len(lpszHeaders)
			
			//Header Setting
			IF HttpAddRequestHeaders(ll_OpenRequestHandle, lpszHeaders, dwHeadersLength, HTTP_ADDREQ_FLAG_ADD) THEN
				
				//HttpRequest
				IF setHttpSendRequestEx( ll_OpenRequestHandle, totalparamsize(ast_parm.parameter), false, ls_err) THEN
					
					//Http WriteFile
					Long		ll_cnt
					ll_cnt = UpperBound(ast_parm.parameter)
					For i = 1 TO ll_cnt
						IF ast_parm.parameter[i].param_type = TYPE_VALUE THEN
							lb_buffer = defaultparam(ast_parm.parameter[i])
							lb_tf = InternetWriteFile(ll_OpenRequestHandle, lb_buffer, Len(lb_buffer), ll_size)
							IF Not lb_tf THEN
								Messagebox("Error", "Param InternetWrite Failed ")
								Exit
							END IF
						ELSE
							lb_buffer = fileparam(ast_parm.parameter[i])
							lb_tf = InternetWriteFile(ll_OpenRequestHandle, lb_buffer, Len(lb_buffer), ll_size)
							IF Not lb_tf THEN
								Messagebox("Error", "File Param InternetWrite Failed ")
								Exit
							END IF
							
							Long	 ll_filesize, ll_fileHandle, ll_rtnsize
							ll_filesize = FileLength(ast_parm.parameter[i].data)
							
							ll_filehandle = FileOpen(ast_parm.parameter[i].data, StreamMode!, Read!, LockRead!, Append! )
							IF ll_filehandle < 0 THEN 
								lb_tf = False
								Exit
							END IF
							
							DO WHILE TRUE
								ll_rtnsize = FileRead(ll_filehandle, lb_buffer)
								lb_tf = InternetWriteFile(ll_OpenRequestHandle, lb_buffer, ll_rtnsize, ll_size)
								IF Not lb_tf THEN Exit

								ll_filesize = ll_filesize - ll_size
								
								IF ll_filesize = 0 THEN Exit
							LOOP
							
							FileClose(ll_filehandle)
							
							lb_buffer = Blob("~r~n", EncodingAnsi!)
							lb_tf = InternetWriteFile(ll_OpenRequestHandle, lb_buffer, Len(lb_buffer), ll_size)
							IF Not lb_tf THEN Exit
						END IF
					NEXT
					
					IF lb_tf THEN
						
						//End Boundary
						lb_buffer = Blob(is_bound + is_boundary + is_bound + "~r~n", EncodingAnsi!)
						lb_tf = InternetWriteFile(ll_OpenRequestHandle, lb_buffer, Len(lb_buffer), ll_size)
						
						//HttpEndRequest
						IF lb_tf THEN
							//HttpEndRequest
							ls_err = Space(512)
							IF setHttpEndRequest(ll_OpenRequestHandle, ls_err) THEN
								lpdwBufferLength = ll_offset
								lpvBuffer = Space(lpdwBufferLength)
								
								//Get Status
								IF HttpQueryInfo(ll_OpenRequestHandle, HTTP_QUERY_STATUS_CODE, lpvBuffer, lpdwBufferLength, lpdwIndex) THEN
									IF Long(lpvBuffer) = HTTP_STATUS_OK THEN
										lb_buffer = Blob(Space(ll_offset), EncodingUTF8!)
										lb_totalblob = Blob("", EncodingUTF8!)
										
										//Response File
										do while InternetReadFile(ll_OpenRequestHandle, lb_buffer, ll_offset, ll_size)
											lb_buffer = BlobMid ( lb_buffer, 1, ll_size )
											lb_totalblob += lb_buffer
											lb_buffer = Blob("")
											IF ll_size = 0 THEN Exit				
										loop
										
										//messagebox("Info", Trim(String(lb_totalblob, EncodingUTF8!)))
										li_RT = SUCCESS
									ELSE
										messagebox("Response", Trim(lpvBuffer))
										li_RT = FAILURE
									END IF
								ELSE
									messagebox("HttpQueryInfo", "Response에 대한 Status를 가지고 올 수 없습니다.")
									li_RT = FAILURE
								END IF
							ELSE
								MessageBox("Error", "HttpEndRequest Failed : " + ls_err)
								li_RT = FAILURE
							END IF
						ELSE
							Messagebox("Error", "Param End InternetWrite Failed ")
							li_Rt = FAILURE
						END IF
					ELSE
						Messagebox("Error", "Param InternetWrite Failed : " + ls_err)
						li_Rt = FAILURE
					END IF
				ELSE
					messagebox("HttpSendRequestEx", "Request를 보낼 수 없습니다.")
					li_RT = FAILURE
				END IF
			ELSE
				messagebox("HttpAddRequestHeaders", "Header에 값을 넣을 수 없습니다.")
				li_RT = FAILURE
			END IF
			
			InternetCloseHandle(ll_OpenRequestHandle)
		ELSE
			messagebox("HttpOpenRequest", "Request Handle를 열수 없습니다.")
			li_RT = FAILURE
		END IF
		
		InternetCloseHandle(ll_iconnecthandle)
	ELSE
		messagebox("InternetConnect", "Internet에서 해당 URL를 열수가 없습니다.")
		li_RT = FAILURE
	END IF
	
	InternetCloseHandle(ll_iopenhandle)
ELSE
	messagebox("InternetOpen", "Internet Connector을 열수가 없습니다.")
	li_RT = FAILURE
END IF

return li_rt
end function

private function blob defaultparam (postvalue data);BLOB  	lb_rtn
lb_rtn  	+= Blob(is_bound + is_boundary + "~r~n" ,EncodingAnsi!)
lb_rtn 	+= Blob("Content-Disposition: form-data; name=~"" + data.param + "~"~r~n~r~n", EncodingAnsi!)
lb_rtn 	+= Blob(data.data, EncodingAnsi!)
lb_rtn 	+= Blob("~r~n", EncodingAnsi!)
return lb_rtn
end function

private function blob fileparam (postvalue data);BLOB  	lb_rtn
String	ls_filepath, ls_filename

lb_rtn  	+= Blob(is_bound + is_boundary + "~r~n", EncodingAnsi!)
lb_rtn	+= Blob("Content-Disposition: form-data; name=~"" + data.param + "~"; filename=~"", EncodingAnsi!)
IF Trim(data.rename) = "" OR IsNull(data.rename) THEN
	lb_rtn += Blob(data.data + "~"~r~n", EncodingAnsi!)
ELSE
	of_FilePathD(data.data, ls_filepath , ls_filename)
	lb_Rtn += Blob(ls_filepath + data.rename + "~"~r~n", EncodingAnsi!)
END IF

lb_Rtn 	+= Blob("Content-Type: application/octet-stream~r~n~r~n", EncodingAnsi!)

return lb_rtn
end function

private function long totalparamsize (postvalue data[]);Integer	li_cnt, i
Long		ll_totalsize

li_cnt = UpperBound(data)
FOR i = 1 TO li_cnt
	IF data[i].param_type = TYPE_FILE THEN
		ll_totalsize += Len(fileparam(data[i]))
		ll_totalsize += FileLength(data[i].data)
		ll_totalsize += Len(Blob("~r~n", EncodingAnsi!))
	ELSE
		ll_totalsize += Len(defaultparam(data[i]))
	END IF
NEXT

return ll_totalsize
end function

public function integer of_uploadfiledll (parameters ast_parm);Integer	li_rt
String ls_ermsg
Boolean  lb_tf

Vector	lvc

lvc = Create Vector

of_sethttpproperties(ast_parm.serverurl, lvc)

ls_ermsg = Space(512)

lb_tf = httpupload( lvc.getproperty('serverurl'), Long(lvc.getproperty('port')), lvc.getproperty('filepath'),  ast_parm.parameter, UpperBound(ast_parm.parameter), false, ls_ermsg)

//Messagebox("Info", ls_ermsg)

setnull(ls_ermsg)

IF lb_tf THEN 
	li_rt = -1
ELSE
	li_rt = 1
END IF

return li_rt
end function

private function long totalparamsize (postvalue data[], ref w_webupload wdata, ref decimal filetotalsize);Integer	li_cnt, i, li_row
Long		ll_totalsize, ll_size

li_cnt = UpperBound(data)
wdata.dw_filecontrol.reset()
FOR i = 1 TO li_cnt
	IF data[i].param_type = TYPE_FILE THEN
		
		ll_totalsize += Len(fileparam(data[i]))
		
		ll_size = FileLength(data[i].data)
		li_row = wdata.dw_filecontrol.insertrow(0)
		
		wdata.dw_filecontrol.SetItem(li_row, 'filename', data[i].data)
		wdata.dw_filecontrol.SetItem(li_row, 'filesize', ll_size)
		filetotalsize += ll_size
		ll_totalsize += ll_size
		ll_totalsize += Len(Blob("~r~n", EncodingAnsi!))
	ELSE
		ll_totalsize += Len(defaultparam(data[i]))
	END IF
NEXT

wdata.st_totup.text = of_returnsize(filetotalsize)

return ll_totalsize
end function

public function integer of_uploadfileex_progress (parameters ast_parm, w_webupload wdata);Long		ll_iopenhandle, ll_iconnecthandle, ll_OpenRequestHandle
Long		ll_offset = 32765
Long		lpdwBufferLength, dwHeadersLength, lpdwIndex, li_RT, i, ll_size
Blob		lb_buffer, lb_totalblob
String		ls_Agent = "PB", ls_ProxyName, ls_ProxyByPass
String		lpvBuffer
String 	ls_name, ls_pass, lpszHeaders 
String		ls_boundary = "---------------------------7d729f2ea1356"
Boolean	lb_tf
Vector	lvc
String  ls_err
decimal		totalfilesize
long			tfilesize
//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
String	ls_nulval
SetNull(ls_nulval)
//=================================

ls_err = Space(512)
//

lvc = Create Vector
lpdwBufferLength = ll_offset
lpvBuffer = Space(lpdwBufferLength)

wdata.st_url.text = ast_parm.serverurl
//
of_sethttpproperties(ast_parm.serverurl, lvc)

//Internet Opened
SetNull(ls_ProxyName)
SetNull(ls_ProxyByPass)
ll_iopenhandle = InternetOpen(ls_Agent, INTERNET_OPEN_TYPE_PRECONFIG, ls_ProxyName, ls_ProxyByPass, 0)
IF ll_iopenhandle > 0 THEN
	//url로 Connect한다.
	ll_iconnecthandle = InternetConnect(ll_iopenhandle, lvc.getproperty('serverurl'), Long(lvc.getproperty('port')), ls_name, ls_pass, INTERNET_SERVICE_HTTP, 0, 0)
	IF ll_iconnecthandle > 0 THEN
		//V1.9.9.021   acept에 대한 내용을 Null로 해주어야 한다.
		ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", ls_nulval, INTERNET_FLAG_RELOAD , 0)
		//=================================
		//ll_OpenRequestHandle = HttpOpenRequest(ll_iconnecthandle, "POST", lvc.getproperty('filepath'), "HTTP/1.1", "", "", INTERNET_FLAG_RELOAD , 0)
		//=================================
		IF ll_OpenRequestHandle > 0 THEN
			lpszHeaders  = "Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-powerpoint, application/vnd.ms-excel, application/msword, */*~r~n"
			lpszHeaders += "Referer: http://localhost/upload/up.html~r~n"
			lpszHeaders += "Accept-Language: ko~r~n"
			lpszHeaders += "Content-Type: multipart/form-data; boundary="
			lpszHeaders += ls_boundary
			lpszHeaders += "~r~n"
			lpszHeaders += "Accept-Encoding: gzip, deflate~r~n"
			lpszHeaders += "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)~r~n"
			lpszHeaders += "Connection: Keep-Alive~r~n"
			lpszHeaders += "Cache-Control: no-cache~r~n"
			
			dwHeadersLength = Len(lpszHeaders)
			
			//Header Setting
			IF HttpAddRequestHeaders(ll_OpenRequestHandle, lpszHeaders, dwHeadersLength, HTTP_ADDREQ_FLAG_ADD) THEN
				
				//HttpRequest
				IF setHttpSendRequestEx( ll_OpenRequestHandle,  totalparamsize(ast_parm.parameter, wdata, totalfilesize), false, ls_err) THEN
					
					//Http WriteFile
					Long		ll_cnt
					ll_cnt = UpperBound(ast_parm.parameter)
					For i = 1 TO ll_cnt
						Yield()
						
						IF canceltf THEN
							IF MessageBox("Question", "정말로 취소 하시겠습니까?", Question!, YesNo!, 2) = 1 THEN
								lb_tf = false
								Exit
							END IF
						END IF
						
						IF ast_parm.parameter[i].param_type = TYPE_VALUE THEN
							lb_buffer = defaultparam(ast_parm.parameter[i])
							lb_tf = InternetWriteFile(ll_OpenRequestHandle, lb_buffer, Len(lb_buffer), ll_size)
							IF Not lb_tf THEN
								Messagebox("Error", "Param InternetWrite Failed ")
								Exit
							END IF
						ELSE
							lb_buffer = fileparam(ast_parm.parameter[i])
							lb_tf = InternetWriteFile(ll_OpenRequestHandle, lb_buffer, Len(lb_buffer), ll_size)
							IF Not lb_tf THEN
								Messagebox("Error", "File Param InternetWrite Failed ")
								Exit
							END IF
							
							Long	 ll_filesize, ll_fileHandle, ll_rtnsize, ll_filetotal, ll_Row
							ll_filesize = FileLength(ast_parm.parameter[i].data)
							
							wdata.st_filetotup.text = of_returnsize(ll_filesize)
							
							ll_Row  = wdata.dw_filecontrol.find("filename = '" + ast_parm.parameter[i].data + "'", 1 , wdata.dw_filecontrol.rowcount())
							
							wdata.dw_filecontrol.selectrow(0, false)
							wdata.dw_filecontrol.selectrow(ll_Row, true)
							wdata.dw_filecontrol.scrolltorow(ll_Row)
							wdata.wf_settext(ll_row)
							
							ll_filehandle = FileOpen(ast_parm.parameter[i].data, StreamMode!, Read!, LockRead!, Append! )
							IF ll_filehandle < 0 THEN 
								lb_tf = False
								Exit
							END IF
							
							ll_filetotal = 0
							
							DO WHILE TRUE
								Yield()
								
								ll_rtnsize = FileRead(ll_filehandle, lb_buffer)
								lb_tf = InternetWriteFile(ll_OpenRequestHandle, lb_buffer, ll_rtnsize, ll_size)

								IF canceltf THEN
									IF MessageBox("Question", "정말로 취소 하시겠습니까?", Question!, YesNo!, 2) = 1 THEN
										ls_err = "Upload 취소 하였습니다."
										lb_tf = false
										Exit
									END IF
								END IF

								IF Not lb_tf THEN Exit
								
								ll_filetotal += ll_size
								tfilesize    += ll_size
								
								wdata.st_up.text = of_returnsize(tfilesize)
								wdata.hpb_per.position = Round( (tfilesize /totalfilesize) * 100, 0)
								wdata.st_per.text = String(wdata.hpb_per.position) + "%"
								
								wdata.st_fileup.text = of_Returnsize(ll_filetotal)
								wdata.hpb_fileper.position = Round( (ll_filetotal / ll_filesize) * 100, 0)
								wdata.st_fileper.text = String(wdata.hpb_fileper.position) + "%"
								
								wdata.setredraw(true)
								IF ll_filesize = ll_filetotal THEN Exit
								Yield()
							LOOP
							
							FileClose(ll_filehandle)

							IF Not lb_tf THEN exit
							
							wdata.dw_filecontrol.deleterow(ll_Row)
							
							lb_buffer = Blob("~r~n", EncodingAnsi!)
							lb_tf = InternetWriteFile(ll_OpenRequestHandle, lb_buffer, Len(lb_buffer), ll_size)
							IF Not lb_tf THEN Exit
						END IF
					NEXT
					
					IF lb_tf THEN
						
						//End Boundary
						lb_buffer = Blob(is_bound + is_boundary + is_bound + "~r~n", EncodingAnsi!)
						lb_tf = InternetWriteFile(ll_OpenRequestHandle, lb_buffer, Len(lb_buffer), ll_size)
						
						//HttpEndRequest
						IF lb_tf THEN
							//HttpEndRequest
							ls_err = Space(512)
							IF setHttpEndRequest(ll_OpenRequestHandle, ls_err) THEN
								lpdwBufferLength = ll_offset
								lpvBuffer = Space(lpdwBufferLength)
								
								//Get Status
								IF HttpQueryInfo(ll_OpenRequestHandle, HTTP_QUERY_STATUS_CODE, lpvBuffer, lpdwBufferLength, lpdwIndex) THEN
									IF Long(lpvBuffer) = HTTP_STATUS_OK THEN
										lb_buffer = Blob(Space(ll_offset), EncodingUTF8!)
										lb_totalblob = Blob("", EncodingUTF8!)
										
										//Response File
										do while InternetReadFile(ll_OpenRequestHandle, lb_buffer, ll_offset, ll_size)
											lb_buffer = BlobMid ( lb_buffer, 1, ll_size )
											lb_totalblob += lb_buffer
											lb_buffer = Blob("")
											IF ll_size = 0 THEN Exit				
										loop
										
										//messagebox("Info", Trim(String(lb_totalblob, EncodingUTF8!)))
										li_RT = SUCCESS
									ELSE
										messagebox("Response", Trim(lpvBuffer))
										li_RT = FAILURE
									END IF
								ELSE
									messagebox("HttpQueryInfo", "Response에 대한 Status를 가지고 올 수 없습니다.")
									li_RT = FAILURE
								END IF
							ELSE
								MessageBox("Error", "HttpEndRequest Failed : " + Trim(ls_err))
								li_RT = FAILURE
							END IF
						ELSE
							Messagebox("Error", "Param End InternetWrite Failed ")
							li_Rt = FAILURE
						END IF
					ELSE
						Messagebox("Error", "Param InternetWrite Failed : " + Trim(ls_err))
						li_Rt = FAILURE
					END IF
				ELSE
					messagebox("HttpSendRequestEx", "Request를 보낼 수 없습니다.")
					li_RT = FAILURE
				END IF
			ELSE
				messagebox("HttpAddRequestHeaders", "Header에 값을 넣을 수 없습니다.")
				li_RT = FAILURE
			END IF
			
			InternetCloseHandle(ll_OpenRequestHandle)
		ELSE
			messagebox("HttpOpenRequest", "Request Handle를 열수 없습니다.")
			li_RT = FAILURE
		END IF
		
		InternetCloseHandle(ll_iconnecthandle)
	ELSE
		messagebox("InternetConnect", "Internet에서 해당 URL를 열수가 없습니다.")
		li_RT = FAILURE
	END IF
	
	InternetCloseHandle(ll_iopenhandle)
ELSE
	messagebox("InternetOpen", "Internet Connector을 열수가 없습니다.")
	li_RT = FAILURE
END IF

return li_rt
end function

public subroutine canceldata (boolean data);canceltf = data
end subroutine

event constructor;file 			= Create FileManager
end event

event destructor;IF IsValid(file) THEN Destroy file
end event

on nvo_inet.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_inet.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

