$PBExportHeader$u_sle_find.sru
$PBExportComments$SingleLineEdit for DataWindow find and scroll
forward
global type u_sle_find from singlelineedit
end type
end forward

global type u_sle_find from singlelineedit
integer width = 731
integer height = 84
integer taborder = 1
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
event pbm_enchange pbm_enchange
event ue_find_new pbm_custom75
event ue_find_next pbm_custom74
event ue_find_previous pbm_custom73
event ue_post_constructor pbm_custom72
end type
global u_sle_find u_sle_find

type variables
private:

DataWindow idw_search // DataWindow to search
string is_search_col // Column name to search
boolean ib_beep // OK to beep when not found?
boolean ib_repeat_beep // OK to beep for repeated not found?
boolean ib_case_sensitive // Match case when comparing?
KeyCode ie_enter_key // key to trigger is_enter_event
string is_enter_event // event triggered by ie_enter_key
KeyCode ie_find_next // Hotkey to find next match
KeyCode ie_find_previous // Hotkey to find previous match
KeyCode ie_clear_find // Hotkey to clear this.text
KeyCode ie_scroll_next_page // Hotkey to scroll DataWindow
KeyCode ie_scroll_next_row // Hotkey to scroll DataWindow
KeyCode ie_scroll_prior_page // Hotkey to scroll DataWindow
KeyCode ie_scroll_prior_row // Hotkey to scroll DataWindow
boolean ib_has_focus = false // see Get/LoseFocus and other events
boolean ib_invalid = false   // see destructor and other events
string is_search_val = ""
string is_edited_val = ""
boolean ib_has_beeped = false
boolean ib_hot_key_pressed = false
string is_data_type = "unknown"
string is_string_format = "(Default)"

end variables

forward prototypes
private function long of_find (long al_from_row, long al_to_row)
public subroutine of_disable_beep ()
public subroutine of_set_repeat_beep ()
public subroutine of_disable_repeat_beep ()
public subroutine of_set_case_sensitive ()
public subroutine of_set_case_insensitive ()
public subroutine of_set_beep ()
public subroutine of_set_enter_processing (keycode ae_enter_key, string as_enter_event)
public subroutine of_set_find_next_key (keycode ae_find_next)
public subroutine of_set_find_previous_key (keycode ae_find_previous)
public subroutine of_set_clear_find_key (keycode ae_clear_find)
public subroutine of_set_scroll_next_page_key (keycode ae_scroll_next_page)
public subroutine of_set_scroll_next_row_key (keycode ae_scroll_next_row)
public subroutine of_set_scroll_prior_page_key (keycode ae_scroll_prior_page)
public subroutine of_set_scroll_prior_row_key (keycode ae_scroll_prior_row)
public subroutine of_disable_find_next_key ()
public subroutine of_disable_find_previous_key ()
public subroutine of_disable_clear_find_key ()
public subroutine of_disable_scroll_next_page_key ()
public subroutine of_disable_scroll_next_row_key ()
public subroutine of_disable_scroll_prior_page_key ()
public subroutine of_disable_scroll_prior_row_key ()
public subroutine of_disable_enter_processing ()
private subroutine of_error (string as_location, string as_message)
private function integer of_store_search_val ()
private subroutine documentation ()
private function integer of_check_column ()
private function string of_error_title (string as_function_name)
private subroutine of_scroll (long al_found_row)
public function integer of_register (datawindow adw_search, string as_search_col)
public function integer of_set_string_format (string as_string_format)
end prototypes

on pbm_enchange;/*
Description:
	Start a new search.

	The Windows event EN_CHANGE (pbm_enChange) is sent when the user
	has taken an action that may have altered text in an edit control.

	Unlike the Windows event EN_UPDATE (pbm_enUpdate),
	EN_CHANGE is sent sent after Windows updates the display.



	Unlike the PowerBuilder-specific Modified! event (pbm_enModified),
	EN_CHANGE is sent as the user types in the edit control rather than
	waiting until the user is finished.
*/


// Try to find a matching row, starting from the top.

this.PostEvent ( "ue_find_new" )

end on

event ue_find_new;// Description: Try to find a matching row, starting from the top.

integer li_RC
long    ll_found_row

// Check validity of idw_search and is_search_col.
li_RC = this.of_check_column()
if li_RC <> 1 then return

// Check for a new search string.

if this.is_search_val = this.text then
	return
end if

// Store the new value.

li_RC = this.of_store_search_val()

if li_RC = 1 then
	// Try to find matching row, starting from the top every time.
	ll_found_row = this.of_Find (1, this.idw_search.RowCount())
	// Scroll to the matching row, if one was found and it is different.
	this.of_scroll (ll_found_row)
end if

end event

on ue_find_next;/*
Description:
	Try to find a matching row, starting from the current row.
*/

integer li_RC
long    ll_found_row

// Check validity of idw_search and is_search_col.

li_RC = this.of_check_column()
if li_RC <> 1 then
	return
end if

// Try to find matching row, looking forward from the current row.

if this.idw_search.GetRow() &
      < this.idw_search.RowCount() then
   ll_found_row = this.of_Find &
       ( this.idw_search.GetRow() + 1, &
         this.idw_search.RowCount() )
else
   ll_found_row = -1 // force error
end if

// Scroll to the matching row, if one was found and it is different.

this.of_scroll ( ll_found_row )

end on

on ue_find_previous;/*
Description:
	Try to find a matching row, starting backwards from the current row.
*/

integer li_RC
long    ll_found_row

// Check validity of idw_search and is_search_col.

li_RC = this.of_check_column()
if li_RC <> 1 then
	return
end if

// Try to find matching row, looking backward from the current row.

if this.idw_search.GetRow() > 1 then
   ll_found_row = this.of_Find &
       ( this.idw_search.GetRow() - 1, &
         1 )
else
   ll_found_row = -1 // force error
end if

// Scroll to the matching row, if one was found and it is different.

this.of_scroll ( ll_found_row )

end on

event ue_post_constructor;this.ib_invalid = false // OK to start processing

end event

private function long of_find (long al_from_row, long al_to_row);/*
Description:
	Match leading characters of is_search_col against is_edited_val.

Example:
	ll_row = sle_1.of_Find &
		( 1, dw_1.RowCount() )
	if ll_row >= 0 then ok...
*/

long   ll_search_val_len
long   ll_row
string ls_column_specification

ll_search_val_len = len ( this.is_search_val )

// Determine column conversion, if required.
if lower ( this.is_string_format ) = "" then
	// Program-defined "no format".
	ls_column_specification = this.is_search_col
elseif lower ( this.is_string_format ) <> "(default)" then
	// Program-defined format.
	ls_column_specification = "string ( " + this.is_search_col + ", '" + this.is_string_format + "' )"
elseif this.is_data_type = "string" then
	ls_column_specification = this.is_search_col
elseif this.is_data_type = "numeric" then
	ls_column_specification = "string ( " + this.is_search_col + ", '0.00' )"
elseif this.is_data_type = "date" then
	ls_column_specification = "string ( " + this.is_search_col + ", 'yyyy mm dd' )"
elseif this.is_data_type = "datetime" then
	ls_column_specification = "string ( " + this.is_search_col + ", 'yyyy mm dd hh:mm:ss.ffffff' )"
elseif this.is_data_type = "time" then
	ls_column_specification = "string ( " + this.is_search_col + ", 'hh:mm:ss.ffffff' )"
else
	this.of_error (of_error_title ( "of_find" ), "Data type is unknown: '" + this.is_data_type + "'" )
	return -1
end if

// Do the case-sensitive/insensitive search.
if this.ib_case_sensitive then
   ll_row = this.idw_search.find("mid ( " + ls_column_specification + ", 1, " + String ( ll_search_val_len ) &
           + " ) = '" + this.is_edited_val + "'", al_from_row, al_to_row)
	if ll_row < 0 then
		this.of_error(of_error_title ( "of_find" ), "Case-sensitive find() failed" )
		return -1
	end if
else
   ll_row = this.idw_search.find("lower ( mid ( " + ls_column_specification + ", 1, " + String ( ll_search_val_len ) &
           + " ) ) = '" + this.is_edited_val + "'", al_from_row, al_to_row )
	if ll_row < 0 then
		this.of_error(of_error_title ( "of_find" ), "Case-insensitive find() failed" )
		return -1
	end if
end if

return ll_row

end function

public subroutine of_disable_beep ();/*
Description:
	Turn off beeping when not found.

No arguments or return value.

Example:
	sle_find.of_disable_beep()
*/

this.ib_beep = false

end subroutine

public subroutine of_set_repeat_beep ();/*
Description:
	Turn on beeping for repeated not found.

No arguments or return value.

Example:
	sle_find.of_set_repeat_beep()
*/

this.ib_repeat_beep = true

end subroutine

public subroutine of_disable_repeat_beep ();/*
Description:
	Turn off beeping for repeated not found.

No arguments or return value.

Example:
	sle_find.of_disable_repeat_beep()
*/

this.ib_repeat_beep = false

end subroutine

public subroutine of_set_case_sensitive ();/*
Description:
	Set comparisons to case-sensitive.

No arguments or return value.

Example:
	sle_find.of_set_case_sensitive()
*/

this.ib_case_sensitive = true

end subroutine

public subroutine of_set_case_insensitive ();/*
Description:
	Set comparisons to case-insensitive.

No arguments or return value.

Example:
	sle_find.of_set_case_insensitive()
*/

this.ib_case_sensitive = false // do not match case when comparing

end subroutine

public subroutine of_set_beep ();/*
Description:
	Turn on beeping when not found.

No arguments or return value.

Example:
	sle_find.of_set_beep()
*/

this.ib_beep = true


end subroutine

public subroutine of_set_enter_processing (keycode ae_enter_key, string as_enter_event);/*
Description:
	Set the KeyCode and DataWindow script name for pass-through
	"Enter" processing.

Arguments:
	ae_enter_key   - KeyCode value of keystroke to trigger Enter handling.
	as_enter_event - Name of DataWindow event to trigger.

No return value.

Example:
	sle_find.of_set_enter_processing ( KeyEnter!, "pbm_dwnprocessenter" )
*/

this.ie_enter_key   = ae_enter_key   // key to trigger enter processing
this.is_enter_event = as_enter_event // event triggered by ae_enter_key

//KeyCode ie_find_next // Hotkey to find next match
//KeyCode ie_find_previous // Hotkey to find previous match
//KeyCode ie_clear_find // Hotkey to clear this.text
//KeyCode ie_scroll_next_page // Hotkey to scroll DataWindow
//KeyCode ie_scroll_next_row // Hotkey to scroll DataWindow
//KeyCode ie_scroll_prior_page // Hotkey to scroll DataWindow
//KeyCode ie_scroll_prior_row // Hotkey to scroll DataWindow


end subroutine

public subroutine of_set_find_next_key (keycode ae_find_next);/*
Description:
	Set the KeyCode to be used to trigger find-next processing.

Arguments:
	ae_find_next - KeyCode value for find-next processing.

No return value.

Example:
	sle_find.of_set_find_next_key ( KeyAdd! )
*/

this.ie_find_next = ae_find_next


end subroutine

public subroutine of_set_find_previous_key (keycode ae_find_previous);/*
Description:
	Set the KeyCode to be used to trigger find-previous processing.

Arguments:
	ae_find_next - KeyCode value for find-previous processing.

No return value.

Example:
	sle_find.of_set_find_previous_key ( KeySubtract! )
*/

this.ie_find_previous = ae_find_previous

end subroutine

public subroutine of_set_clear_find_key (keycode ae_clear_find);/*
Description:
	Set the KeyCode to be used to trigger clear-find processing.

Arguments:
	ae_find_next - KeyCode value for clear-find processing.


No return value.

Example:
	sle_find.of_set_clear_find_key ( KeyEscape! )
*/

this.ie_clear_find = ae_clear_find

end subroutine

public subroutine of_set_scroll_next_page_key (keycode ae_scroll_next_page);/*
Description:
	Set the KeyCode to be used to trigger scroll-next-page processing.

Arguments:
	ae_find_next - KeyCode value for scroll-next-page processing.

No return value.

Example:
	sle_find.of_set_scroll_next_page_key ( KeyPageDown! )
*/

this.ie_scroll_next_page = ae_scroll_next_page

end subroutine

public subroutine of_set_scroll_next_row_key (keycode ae_scroll_next_row);/*
Description:
	Set the KeyCode to be used to trigger scroll-next-row processing.

Arguments:
	ae_find_next - KeyCode value for scroll-next-row processing.

No return value.

Example:
	sle_find.of_set_scroll_next_row_key ( KeyDownArrow! )
*/

this.ie_scroll_next_row = ae_scroll_next_row

end subroutine

public subroutine of_set_scroll_prior_page_key (keycode ae_scroll_prior_page);/*
Description:
	Set the KeyCode to be used to trigger scroll-prior-page processing.

Arguments:
	ae_find_next - KeyCode value for scroll-prior-page processing.

No return value.

Example:
	sle_find.of_set_scroll_prior_page_key ( KeyPageUp! )
*/

this.ie_scroll_prior_page = ae_scroll_prior_page

end subroutine

public subroutine of_set_scroll_prior_row_key (keycode ae_scroll_prior_row);/*
Description:
	Set the KeyCode to be used to trigger scroll-prior-row processing.

Arguments:
	ae_find_next - KeyCode value for scroll-prior-row processing.

No return value.

Example:
	sle_find.of_set_scroll_prior_row_key ( KeyUpArrow! )
*/

this.ie_scroll_prior_row = ae_scroll_prior_row

end subroutine

public subroutine of_disable_find_next_key ();/*
Description:
	Disable find-next processing.

No arguments or return value.

Example:
	sle_find.of_disable_find_next_key()
*/

SetNull ( this.ie_find_next )

end subroutine

public subroutine of_disable_find_previous_key ();/*
Description:
	Disable find-previous processing.

No arguments or return value.

Example:
	sle_find.of_disable_find_previous_key()
*/

SetNull ( this.ie_find_previous )

end subroutine

public subroutine of_disable_clear_find_key ();/*
Description:
	Disable clear-find processing.

No arguments or return value.

Example:
	sle_find.of_disable_clear_find_key()
*/

SetNull ( this.ie_clear_find )

end subroutine

public subroutine of_disable_scroll_next_page_key ();/*
Description:
	Disable scroll-next-page processing.

No arguments or return value.

Example:
	sle_find.of_disable_scroll_next_page_key()
*/

SetNull ( this.ie_scroll_next_page )

end subroutine

public subroutine of_disable_scroll_next_row_key ();/*
Description:
	Disable scroll-next-row processing.

No arguments or return value.

Example:
	sle_find.of_disable_scroll_next_row_key()
*/

SetNull ( this.ie_scroll_next_row )

end subroutine

public subroutine of_disable_scroll_prior_page_key ();/*
Description:
	Disable scroll-prior-page processing.

No arguments or return value.

Example:
	sle_find.of_disable_scroll_prior_page_key()
*/

SetNull ( this.ie_scroll_prior_page )

end subroutine

public subroutine of_disable_scroll_prior_row_key ();/*
Description:
	Disable scroll-prior-row processing.

No arguments or return value.

Example:
	sle_find.of_disable_scroll_prior_row_key()
*/

SetNull ( this.ie_scroll_prior_row )


end subroutine

public subroutine of_disable_enter_processing ();/*
Description:
	Turn off pass-through "Enter" processing.

No arguments or return value.

Example:
	sle_find.of_disable_enter_processing()
*/

SetNull ( this.ie_enter_key )
SetNull ( this.is_enter_event )



end subroutine

private subroutine of_error (string as_location, string as_message);MessageBox("U_SLE_find Error", "Error Location: " + as_location + "~r~n~r~nError Message: " + as_message)

end subroutine

private function integer of_store_search_val ();// Save this.text in both original and edited formats.  The edited format will be in lowercase unless case
// sensitive matching is requested.  Also, tildes will be placed in front of the special characters ~'" so that
// dwFind doesn't choke on them (e.g., find "Mom's Restaurant".)

string  ls_temp_val
integer li_pos

// Save original format.
this.is_search_val = this.text

// Convert to lowercase if case-insensitive matching is requested.
if this.ib_case_sensitive then
	this.is_edited_val = this.is_search_val
else
	this.is_edited_val = lower ( this.is_search_val )
end if

// Check to see if further processing is necessary (an optimization).
if ( pos ( this.is_search_val, "~~") > 0 ) or ( pos ( this.is_search_val, "'" ) > 0 ) or ( pos ( this.is_search_val, '"' ) > 0 ) then
	// Put tildes in front of special characters ~'".  A temporary string is used in case an error occurs.
	// The loop steps backwards because the result string grows in length.

	ls_temp_val = this.is_edited_val
	for li_pos = len ( this.is_search_val ) to 1 step -1
		choose case mid ( this.is_search_val, li_pos, 1 )
			case "~~"
				ls_temp_val = replace ( ls_temp_val, li_pos, 1, "~~~~" )
			case "'"
				ls_temp_val = replace ( ls_temp_val, li_pos, 1, "~~'" )
			case '"'
            ls_temp_val = replace ( ls_temp_val, li_pos, 1, '~~"' )
		end choose

		if len ( ls_temp_val ) = 0 then
			this.of_error (of_error_title ("of_store_search_val" ), "Replace failed")
			return -1
		end if
	next

	this.is_edited_val = ls_temp_val
end if

return 1

end function

private subroutine documentation ();/*

Documentation() Function in U_SLE_Find
--------------------------------------

u_sle_find - SingleLineEdit for DataWindow find and scroll.

Description:
	Scroll-while-you-type facility for searching a DataWindow.

Basic Setup:

	For example, a DataWindow control called dw_table is associated
	with a DataWindow object that contains a column called "entry".

	A SingleLineEdit control called sle_entry is created using
	this user object. It is enabled by the following statements
	in the window.open event:

		integer li_RC
		li_RC = sle_entry.of_register ( dw_table, "entry" )
		if li_RC <> 1 then
			halt close
		end if

	That's all there is to it; other function calls are optional.

Beeping On Not Found:

	The following call enables beeping when the search string
	is not found; this is the default behaviour:

		sle_entry.of_set_beep()

	The following call disables all beeping:

		sle_entry.of_disable_beep()

	If beeping is enabled, the following call enables repeated
	beeping when repeated attempts are made to extend a
	failing match string:

		sle_entry.of_set_repeat_beep()

	If beeping is enabled, the following call disables
	repeated beeping so that only one beep is heard when
	a search string is not found even if the user continues
	to type characters; this is the default behaviour:

		sle_entry.of_disable_repeat_beep()

Case-Sensitive and Case-Insensitive Matching:

	The following call enables case-sensitive (match on case)
	searching:

		sle_entry.of_set_case_sensitive()

	The following call enables case-insensitive searching;
	this is the default behaviour:

		sle_entry.of_set_case_insensitive()

Find Next and Find Previous Accelerator Keys:

	By default the plus and minus keys on the numeric keypad
	are the accelerator keys for find next and find previous
	matching rows. The following calls show the default values;
	you can change the accelerator keys by substituting different
	key code values:

		sle_find.of_set_find_next_key ( KeyAdd! )
		sle_find.of_set_find_previous_key ( KeySubtract! )

	The following calls disable find next and find previous:

		sle_find.of_disable_find_next_key()
		sle_find.of_disable_find_previous_key()

Clear Find Accelerator Key:

	By default the escape key is the accelerator key for clearing
	the SingleLineEdit contents. The following calls show the default
	values; you can change the accelerator keys by substituting
	different 	key code values:

		sle_find.of_set_clear_find_key ( KeyEscape! )

	The following call disables the clear find accelerator key:

		sle_find.of_disable_clear_find_key()

Pass-Through Keys:

	For ease-of-use certain keystrokes are passed on to the
	DataWindow control even though this SingleLineEdit control
	still has focus. This makes it unnecessary for the user to
	tab back and forth to switch between searching (e.g., find
	next) and scrolling (e.g., next page) operations.

Pass-Through Enter Key:

	One common enhancement is to pass Enter key presses to the
	DataWindow; this is enabled by the following statment:

		sle_entry.of_set_enter_processing &
			( KeyEnter!, "pbm_dwnprocessenter" )

	To disable pass-through processing of the Enter key (which
	is the default behaviour), code the following:

		sle_entry.of_disable_enter_processing()

Scrolling Accelerator Keys:

	Several other keystrokes are passed through to the DataWindow
	to perform scrolling by page and row. The following calls show
	the default values; 	you can change the accelerator keys by
	substituting different key code values:

		sle_find.of_set_scroll_next_page_key ( KeyPageDown! )
		sle_find.of_set_scroll_next_row_key ( KeyDownArrow! )
		sle_find.of_set_scroll_prior_page_key ( KeyPageUp! )
		sle_find.of_set_scroll_prior_row_key ( KeyUpArrow! )

	The following calls disable the scrolling accelerator keys:

		sle_find.of_disable_scroll_next_page_key()
		sle_find.of_disable_scroll_next_row_key()
		sle_find.of_disable_scroll_prior_page_key()
		sle_find.of_disable_scroll_prior_row_key()

Note on Column Data Types:

	The following formats are used when converting DataWindow column
	data types to string format for comparison purposes:

		            Default            of_set_string_format()
		Data Type   String Format          Call Allowed
		---------   -------------          ------------
		char(nn)    none                        no
		compute     none                        no
		number      none                        yes
		decimal(n)  none                        yes
		date        yyyy mm dd                  yes
		datetime    yyyy mm dd hh:mm:ss.ffffff  yes
		time        hh:mm:ss.ffffff             yes
		timestamp   not supported               n/a

	If the default string format does not agree with the column's
	display format, of_set_string_format may be called to make them agree.
	Here are some examples:

	// Allow keyboard entry of decimal point:
	li_RC = sle_purchase_amount.of_set_string_format ( "0.00" )
	if li_RC <> 1 then
		return
	end if

	// Change the date entry format:
	li_RC = sle_purchase_date.of_set_string_format ( "mmm dd, yyyy" )
	if li_RC <> 1 then
		return
	end if

	// Change the time entry format:
	li_RC = sle_purchase_date.of_set_string_format ( "hh mm" )
	if li_RC <> 1 then
		return
	end if
*/
end subroutine

private function integer of_check_column ();/*
Description:
	Check validity of idw_search and idw_search_col,
	set is_data_type, and issue a diagnostic message
	if anything is wrong.
*/

string ls_column_type

// Check if variables still have the
// initial "invalid" values that were
// set in the constructor event.
// These variables must be given values
// before the sle is used (e.g., before
// the sle receives focus.)

if IsNull ( this.idw_search ) then
	this.ib_invalid = true
	this.of_error(of_error_title("of_check_column" ), "idw_search is null")
	return -1
end if

if len ( this.is_search_col ) = 0 then
	this.ib_invalid = true
	this.of_error(of_error_title("of_check_column" ), "is_search_col is empty" )
    return -1
end if

// Check to see if this column is really
// a string-type column in the DataWindow.

ls_column_type = this.idw_search.Describe ( this.is_search_col + ".Coltype" )

if ls_column_type = "!" then
	ls_column_type = this.idw_search.Describe ( this.is_search_col + ".Type" )
end if

if ls_column_type = "!" then
	this.ib_invalid = true
	this.of_error ( of_error_title ( "of_check_column" ),  "is_search_col '" + this.is_search_col + "' not in DataWindow" )
	return -1
end if

// Determine the column's data type.

ls_column_type = lower ( trim ( ls_column_type ) )

if (left(ls_column_type, 5) = "char("   ) or ( ls_column_type = "compute" ) or (left(ls_column_type, 8) = "varchar(") then
	this.is_data_type = "string"
elseif ( ls_column_type             = "number"  ) or ( left ( ls_column_type, 7 ) = "decimal" ) then
	this.is_data_type = "numeric"
elseif ls_column_type = "date" then
	this.is_data_type = "date"
elseif ls_column_type = "datetime" then
	this.is_data_type = "datetime"
elseif ls_column_type = "time" then
	this.is_data_type = "time"
else
	this.ib_invalid = true
	this.of_error ( of_error_title ( "of_check_column" ), "Search column '" + this.is_search_col 	+ "' has an unsupported data type: '" + ls_column_type + "'" )
	return -1
end if

return 1

end function

private function string of_error_title (string as_function_name);// Form error title parameter to pass to of_error,
// by adding the ClassNames of both the current object and
// its parent to the program-specific "function name".

return parent.ClassName() &
   + "." + this.ClassName() &
   + "." + as_function_name
end function

private subroutine of_scroll (long al_found_row);// Scroll to the matching row, if one was found and it is different.

if al_found_row > 0 then
	if this.idw_search.GetRow() <> al_found_row then
		// Scroll to new row.
		this.idw_search.ScrollToRow ( al_found_row )
	end if
	this.ib_has_beeped = false
else
	if  (this.ib_beep) and ((not this.ib_has_beeped) or (this.ib_repeat_beep)) then
		// If beeping is enabled but repeat beeping is not, a beep will sound
		// only for the first of successive failed matches. In other words,
		// if the user types a whole series of not-found characters, there'll
		// only be one beep.
		this.ib_has_beeped = true
		
		// Cary changed this to two beeps to indicate not found
		// since one beep signifies "selected"
		beep(2)
	end if
end if

return

end subroutine

public function integer of_register (datawindow adw_search, string as_search_col);/*
Description:
	Store and check the DataWindows control and column name
	associated with this SingleLineEdit control.

Arguments:
	adw_search - DataWindow control
	as_search_col - Column name

Returns:
	1  - Call worked OK.
	-1 - An error was detected.

Example:
	li_RC = sle_find.of_register ( dw_data_entry, "person_id" )
	if li_RC <> 1 then
		halt close
	end if
*/

integer li_RC

this.idw_search       = adw_search
this.is_search_col    = as_search_col
this.is_data_type     = "unknown"
this.is_string_format = "(Default)"

li_RC = this.of_check_column()

return li_RC
end function

public function integer of_set_string_format (string as_string_format);/*
Description:
	Change string() conversion format from "(Default)"
	to some program-specified value. See the documentation()
	function for default values and the rules for changing
	conversion formats.

Note: Whenever of_register is called the string format
	is reset back to the default.

Argument:
	as_string_format - Format to be used in call to string(),
		or the empty string "" to specify "no format".

Return value:
	1  - Call worked OK.
	-1 - An error was detected.

Example - Allow keyboard entry of decimal point:
	li_RC = sle_purchase_amount.of_set_string_format ( "0.00" )
	if li_RC <> 1 then
		return
	end if

Example - Change the date entry format:
	li_RC = sle_purchase_date.of_set_string_format ( "mmm dd, yyyy" )
	if li_RC <> 1 then
		return
	end if

Example - Change the time entry format:
	li_RC = sle_purchase_date.of_set_string_format ( "hh mm" )
	if li_RC <> 1 then
		return
	end if
*/

if ( this.is_data_type = "numeric"  ) &
or ( this.is_data_type = "date"     ) &
or ( this.is_data_type = "datetime" ) &
or ( this.is_data_type = "time"     ) then

	this.is_string_format = as_string_format
	return 1

else

	this.of_error &
		( of_error_title ( "of_set_string_format" ), &
		  "String format cannot be changed for data type '" &
			+ this.is_data_type &
			+ "'" )
	return -1

end if




end function

on getfocus;/*
Description:
	Check validity, and start a new search if required.
*/

integer li_RC

// Allow processing of other events.
this.ib_has_focus = true

// Don't do any further processing in this script until
// ue_post_constructor has fired, which implies that
// of_register() has (probably) been called.
if this.ib_invalid then
	return
end if

// Force a new search.

this.is_search_val = ""
this.PostEvent ( "ue_find_new" )


end on

event constructor;/*
	See the documentation() function for a description of how to use this object.
*/

// Disable processing until ue_post_constructor fires.

this.ib_invalid = true

// Assign "invalid" values to idw_search and
// is_search_col. These variables MUST be
// given values before the sle is used
// (e.g., before the sle receives focus,
// as in the Window Open script.)

SetNull ( this.idw_search )
this.is_search_col = ""

// Set parameters to default values.

this.of_set_beep()
this.of_disable_repeat_beep()
this.of_set_case_insensitive()
//this.of_set_case_sensitive()
this.of_set_find_next_key     ( KeyAdd! )
this.of_set_find_previous_key ( KeySubtract! )
this.of_set_clear_find_key    ( KeyEscape! )
this.of_disable_enter_processing()
this.of_set_scroll_next_page_key  ( KeyPageDown! )
this.of_set_scroll_next_row_key   ( KeyDownArrow! )
this.of_set_scroll_prior_page_key ( KeyPageUp! )
this.of_set_scroll_prior_row_key  ( KeyUpArrow! )

this.PostEvent ( "ue_post_constructor" )

end event

on losefocus;// Prevent processing of other events.
this.ib_has_focus = false


end on

on destructor;this.ib_invalid = true   // for checking in the other event

end on

on u_sle_find.create
end on

on u_sle_find.destroy
end on

