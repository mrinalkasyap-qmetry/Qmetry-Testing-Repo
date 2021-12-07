program test2
    implicit none
    !!! A program to practice f90 writing.
    ! Define double precision data
    integer, parameter :: dp = kind(1.d0)
    real(dp) :: a(3), b(3)
    integer :: i
    a = (/(i, i=1, 3)/)
    b = (/(i, i=1, 3)/)
    write (*, *) m31tensorprod(a, b)

contains
    function m31tensorprod(a, b)
        real(dp), dimension(3), intent(in) :: a, b
        real(dp), intent(out) :: m31tensorprod(3, 3)
        integer :: k1, k2
        forall(k1=1:3, k2=1:3)
            m31tensorprod(k1, k2) = a(k1) * b(k2)
        end forall
        return
    end function m31tensorprod
end program test2
