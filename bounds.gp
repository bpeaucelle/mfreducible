bad(l,N,fa = 0) = {
  if(l == 2 && N == 1,return(1));
  if(fa == 0, fa = factor(N)[,1],fa = fa[,1]);
  my(bool = 1,i = 1);
  while(bool && i <= #fa,
    bool = (fa[i]%9 == 1);
    i++
  ); if(bool, return(1));
  return(1)
}

get_a(l,N,k1,m1,k2,m2,fa = 0) = {
  if(fa == 0, fa = factor(N));
  if(l == 3 && (k2-k1+2*(m2-m1)+2)%4 == 0 && bad(l,N,fa),
    return(4), return(0)
  )
}

get_b(l,N,fa = 0) = {
  if(l == 2 && N == 2,return(4));
  if(N%l == 0,return(3));
  if(fa == 0,fa = factor(N));
  if(bad(l,N,fa),return(6));
  return(l+1)
}

get_ktilde(l,N,k1,m1,k2,m2,fa = 0) = {
  if(fa == 0,fa = factor(N));
  my(a = get_a(l,N,k1,m1,k2,m2,fa));
  my(b = if(l == oo,0,get_b(l,N,fa)));
  return(a+max(k1+m1*b,k2+b*m2))
}

get_B(l,N1,k1,m1,N2,k2,m2,fa = 0) = {
  my(N = lcm(N1,N2));
  if(fa == 0,fa = factor(N));
  my(ktilde = get_ktilde(l,N,k1,m2,k2,m2,fa));
  return(floor(ktilde*N*prod(i = 1,#fa[,1],1+1/fa[i,1])/12))
}

get_kdash(l,m1,m2) = if(l == 2,2,m2-m1+1);

get_r(l,k,eps1,eps2,m1,m2) = {
  if(k == 2 && eps1 == Mod(0,1) && eps2 == Mod(0,1), return(4));
  if(l == 2 && eps2 == Mod(0,1) && eps2 != Mod(0,1),return(4));
  if(l >= 5 && eps1 == Mod(0,1) && eps2 == Mod(0,1) && m1 == 0 && m2 == l-2,return(4));
  return(1)
}

get_Ndash(N,a2,r) = {
  if(r = 1,return(N));
  if(N%2 == 1,return(4*N));
  if(a2 != 0,return(2*N));
  return(N)
}

get_Bred(N,k,l,a2,eps1,eps2,m1,m2) = {
	my(r = get_r(l,k,esp1,eps2,m1,m2));
	if(type(N) == "t_INT",fa = factor(N),[N,fa] = N);
	my(Ndash = get_Ndash(N,a2,r),fa);
	
	if(l == oo, return([get_B(oo,Ndash,k,0,k,0,fa),r]),
		my(kdash = get_kdash(l,m1,m2));
		return([get_B(l,Ndash,k,1,kdash,m1+1,fa),r])
	)
}