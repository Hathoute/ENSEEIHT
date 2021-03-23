program test_solve

  implicit none

  integer :: i, j, ierr, n, k
  double precision, dimension (:,:), allocatable :: L
  double precision, dimension (:), allocatable :: x, b

  write(*,*) 'n?'
  read(*,*) n

  ! Initialization: L is lower triangular
  write(*,*) 'Initialization...'
  write(*,*)
  
  allocate(L(n,n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate L(n,n) with n=',n
    goto 999
  end if

  allocate(x(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate x(n) with n=',n
    goto 999
  end if

  allocate(b(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate b(n) with n10=',n
    goto 999
  end if

  L = 0.D0
  do i = 1, n  
    L(i,i) = n + 1.D0
    do j = 1, i-1
      L(i,j) = 1.D0
    end do
  end do
  b = 1.D0

  ! Left-looking triangular solve of Lx=b
  write(*,*) 'Solving with a left-looking method...'

  ! call left_looking_solve
  call left_looking_solve(L, x, b, n)
  
  ! call backward_error to check the accuracy
  write(*,*)"Backward error is", backward_error(L, x, b, n)

  ! display the solution if n <= 10
  if(n <= 10) then
    write(*,*)"x = "
    do k=1, n
      write(*,*) x(k)
    end do
  end if
  write(*,*)
 
  ! Right-looking triangular solve of Lx=b
  write(*,*) 'Solving with a right-looking method...'

  ! call right_looking_solve
  call right_looking_solve(L, x, b, n)
  
  ! call backward_error to check the accuracy
  print *, "Backward error is", backward_error(L, x, b, n)

  ! display the solution if n <= 10
  if(n <= 10) then
    write(*,*)"x = "
    do k=1, n
      write(*,*) x(k)
    end do
  end if
  write(*,*)


999 if(allocated(L)) deallocate(L)
    if(allocated(x)) deallocate(x)
    if(allocated(b)) deallocate(b)


contains

! TODO
! Implement sub-programs left_looking_solve, right_looking_solve, backward_error
subroutine left_looking_solve(L, x, b, n)
  integer, intent(in)  :: n
  double precision, dimension (n,n), intent(in)  :: L
  double precision, dimension (n), intent(in)  :: b
  double precision, dimension(n), intent(out) :: x
  real :: start, finish

  call cpu_time(start)

  x = b 
  do j = 1, n     
    do i = 1, j-1
      x(j) = x(j) - L(j,i)*x(i)
    end do
    x(j) = x(j)/l(j,j)
  end do

  call cpu_time(finish)

  print '("Time spent in left_looking_solve is = ",f6.3," seconds.")',finish-start
end subroutine

subroutine right_looking_solve(L, x, b, n)
  integer, intent(in)  :: n
  double precision, dimension (n,n), intent(in)  :: L
  double precision, dimension (n), intent(in)  :: b
  double precision, dimension(n), intent(out) :: x
  real :: start, finish

  call cpu_time(start)

  x = b 
  do j = 1, n     
    x(j) = x(j)/l(j,j)
    do i = j+1, n 
      x(i) = x(i) - l(i,j)*x(j)
    end do
  end do

  call cpu_time(finish)

  print '("Time spent in right_looking_solve is = ",f6.3," seconds.")',finish-start
end subroutine

function backward_error(L,x,b,n)
  double precision :: backward_error
  integer, intent(in)  :: n
  double precision, dimension (n,n), intent(in)  :: L
  double precision, dimension (n), intent(in)  :: b
  double precision, dimension(n), intent(out) :: x

  double precision, dimension(n) :: Lx
  
  Lx = matmul(L, x)
  backward_error = norm2(Lx-b)/norm2(b)

  return
end function

end program test_solve