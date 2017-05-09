!===============================================================================
subroutine maxi(vect, vect_len, mm)
!simple example for computing the maximum of a given vector
!DEC$ ATTRIBUTES DLLEXPORT,C,REFERENCE,ALIAS:'maxi_' :: maxi
    !the previous line is necessary for R to find the external function under its name

    implicit none
    !-------------------------------------------------------------------------------
    !INPUT
    integer, intent(in)                     :: vect_len !length of input vector (needs to be specified explicitly)
    real(8), intent(in), dimension(vect_len):: vect !actual vector
    !-------------------------------------------------------------------------------
    ! OUTPUT
    real(8), intent(out):: mm  !for delivering the result
    !-------------------------------------------------------------------------------

    !-------------------------------------------------------------------------------
    ! CODE
        mm = maxval(vect) 
    !-------------------------------------------------------------------------------
end subroutine maxi
    
subroutine clean_data_7(datamatrix, rows, cols, meas_thresh, valid_rows)
!for the given matrix, return a logical vector of rows that do not exceed the threshold value
!DEC$ ATTRIBUTES DLLEXPORT,C,REFERENCE,ALIAS:'clean_data_7_' :: clean_data_7
!the previous line is necessary for R to find the external function under its name

implicit none
!-------------------------------------------------------------------------------
!INPUT
integer, intent(in):: rows, cols !
real(8), dimension(rows, cols), intent(in):: datamatrix
real(8) :: meas_thresh !measurement threshold for filtering data
!-------------------------------------------------------------------------------
! OUTPUT
logical, intent(out):: valid_rows(rows)
!-------------------------------------------------------------------------------
! CODE   
valid_rows =  .NOT. any(datamatrix > meas_thresh, DIM=2)  !identify all valid rows
! unfortunately, we cannot return the already cleaned matrix, because dynamically sizing the 
! the return value is not possible (afaik)

end subroutine clean_data_7

!===============================================================================
