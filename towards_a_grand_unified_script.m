(* ::Package:: *)

(* ::Input:: *)
(*Define symmetric quantization rho*)


CleanSlate;
$MinPrecision=MachinePrecision;
  \[Rho]z[z_] := z/(1 + Sqrt[1 - z])^2; 
 \[Rho]zb[z_] := \[Rho]z[Conjugate[z]]; 
 (*error estimates*)
    \[Rho]intErrorEstimateG[d_, DDs_, z_, \[Gamma]_] := (2^(\[Gamma] + 4*d)*\[Beta]^(\[Gamma] - 4*d)*Gamma[1 - \[Gamma] + 4*d, \[Beta]*DDs])/(Gamma[1 - \[Gamma] + 4*d]*(1 - r^2)^\[Gamma])/.  {r -> Abs[\[Rho]z[z]], \[Beta] -> -Log[Abs[\[Rho]z[z]]]}; 
      \[Rho]intErrorEstimateFt[d_, DDs_, z_, \[Gamma]_] := 
     v^d*\[Rho]intErrorEstimateG[d, DDs, z, \[Gamma]] + u^d*\[Rho]intErrorEstimateG[d, DDs, 1 - z, \[Gamma]] /. {u -> z*Conjugate[z], v -> (1 - z)*(1 - Conjugate[z])}; 
     (*coefficients and prefactors*)
    kfunctAna[\[Beta]_, x_] := Exp[(\[Beta]/2)*Log[4*((1 - Sqrt[1 - x])^2/x)]]*(x/(2*(1 - x)^(1/4)*(1 - Sqrt[1 - x]))); 
    ConformalBlockAna[DD_, l_, z_] := ((-1)^l/2^l)*((z*Conjugate[z])/(z - Conjugate[z]))*(kfunctAna[DD + l, z]*kfunctAna[DD - l - 2, Conjugate[z]] - 
       kfunctAna[DD + l, Conjugate[z]]*kfunctAna[DD - l - 2, z]);
       (*derivatives*)
       FAnaDer[DD_, l_, z_] := (1/(z - Conjugate[z]))*(-1)^(2*l)*(1 - z)*z*
      (1 - Conjugate[z])*Conjugate[z]*(-((2^(-5 + 2*DD)*((1 - Sqrt[z])/(1 + Sqrt[z]))^((1/2)*(-2*l + DD))*(1 - z)*
          ((1 - Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))^((1/2)*(-2*l + DD))*(-((1 - Sqrt[z])/(1 + Sqrt[z]))^(2*l) - 
           Sqrt[z]*(((1 - Sqrt[z])/(1 + Sqrt[z]))^(2*l) + ((1 - Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))^(2*l)) + 
           ((1 - Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))^(2*l) + (((1 - Sqrt[z])/(1 + Sqrt[z]))^(2*l) + 
             Sqrt[z]*(((1 - Sqrt[z])/(1 + Sqrt[z]))^(2*l) - ((1 - Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))^(2*l)) + 
             ((1 - Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))^(2*l))*Sqrt[Conjugate[z]])*(1 - Conjugate[z])*
          (Log[16] + Log[-((-1 + Sqrt[z])/(1 + Sqrt[z]))] + Log[-((-1 + Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))]))/
         ((-1 + Sqrt[z])^2*z^(1/4)*(-1 + Sqrt[Conjugate[z]])^2*Conjugate[z]^(1/4))) + (2^(-5 + 2*DD)*((-1 + Sqrt[1 - z])^2/z)^((1/2)*(-2*l + DD))*z*
         ((-1 + Sqrt[1 - Conjugate[z]])^2/Conjugate[z])^((1/2)*(-2*l + DD))*Conjugate[z]*(-2*z*(-((-2 + 2*Sqrt[1 - z] + z)/z))^(2*l)*
           (-1 + Sqrt[1 - Conjugate[z]]) + Conjugate[z]*(2*(-1 + Sqrt[1 - z])*(-((-2 + 2*Sqrt[1 - Conjugate[z]] + Conjugate[z])/Conjugate[z]))^(2*l) + 
            z*(-(-((-2 + 2*Sqrt[1 - z] + z)/z))^(2*l) + (-((-2 + 2*Sqrt[1 - Conjugate[z]] + Conjugate[z])/Conjugate[z]))^(2*l))))*
         (Log[16] + Log[(-1 + Sqrt[1 - z])^2/z] + Log[(-1 + Sqrt[1 - Conjugate[z]])^2/Conjugate[z]]))/((-1 + Sqrt[1 - z])^3*(1 - z)^(1/4)*
         (-1 + Sqrt[1 - Conjugate[z]])^3*(1 - Conjugate[z])^(1/4))); 
	 ConformalBlockAnaDer[DD_, l_, z_] := 
     -((I*(-1)^l*2^(-6 - l + 2*DD)*((-1 + Sqrt[1 - z])^2/z)^((1/2)*(-l + DD))*Abs[z]^4*((-1 + Sqrt[1 - Conjugate[z]])^2/Conjugate[z])^
         ((1/2)*(-l + DD))*(2*z*(-1 + Sqrt[1 - Conjugate[z]])*(-((-2 + 2*Sqrt[1 - Conjugate[z]] + Conjugate[z])/Conjugate[z]))^l + 
         Conjugate[z]*(-2*(-1 + Sqrt[1 - z])*(-((-2 + 2*Sqrt[1 - z] + z)/z))^l + z*(-(-((-2 + 2*Sqrt[1 - z] + z)/z))^l + 
             (-((-2 + 2*Sqrt[1 - Conjugate[z]] + Conjugate[z])/Conjugate[z]))^l)))*(Log[(16*(-1 + Sqrt[1 - z])^2)/z] + 
         Log[(-1 + Sqrt[1 - Conjugate[z]])^2/Conjugate[z]]))/((-1 + Sqrt[1 - z])^3*(1 - z)^(1/4)*(-1 + Sqrt[1 - Conjugate[z]])^3*
        (1 - Conjugate[z])^(1/4)*Im[z])); 
	kfunct[\[Beta]_, x_] := kfunct[\[Beta], x] = x^(\[Beta]/2)*Hypergeometric2F1[\[Beta]/2, \[Beta]/2, \[Beta], x]; 
    ConformalBlock[DD_, l_, z_] := ((-1)^l/2^l)*((z*Conjugate[z])/(z - Conjugate[z]))*(kfunct[DD + l, z]*kfunct[DD - l - 2, Conjugate[z]] - 
       kfunct[DD + l, Conjugate[z]]*kfunct[DD - l - 2, z]); 
      
      (*random sample of z around (1/2+I0)*)
           Sample[nz_,var_,seed_] := Module[{imax}, SeedRandom[seed];Table[Abs[RandomVariate[NormalDistribution[0, var]]]+
           1/2+I Abs[RandomVariate[NormalDistribution[0, var]]],{imax,1,nz}]]; 
(*Exponential factor to renormalize*)
dimExpFactor[a_,b_]:=Log[4(1-Sqrt[1/2 -a -b])^2/(1/2 + a +b)];

renomFactor[dim_]:=Exp[-(dim-1)dimExpFactor[0,0]];
(*renomFactor[dim_]:=1;*)
(*Conformal Blocks*)
qQGen[\[CapitalDelta]\[Phi]_,\[CapitalDelta]_,L_,zsample_]:=renomFactor[\[CapitalDelta]] (((1 - zsample)*(1 - Conjugate[zsample]))^\[CapitalDelta]\[Phi]    ConformalBlock[\[CapitalDelta], L , zsample]- ((zsample)*( Conjugate[zsample]))^\[CapitalDelta]\[Phi] ConformalBlock[\[CapitalDelta], L,1- zsample])2^(L);
qQGenDims[\[CapitalDelta]\[Phi]_,\[CapitalDelta]L_,z_]:=qQGen[\[CapitalDelta]\[Phi],#1[[1]],#1[[2]], z]&/@\[CapitalDelta]L

(*functionals*)
chi2Functional[qq0_,id_,w_,rhovec_]:=Block[{nu,s,r},
nu = Dimensions[w][[1]]-Length[rhovec];
r=(qq0.rhovec-id);
s=r.w.r;
Return[s/nu]];

chi2Functional[qq0_,id_,w_]:=Block[{nu,s,r,rhovec=(cweightedLeastSquares[qq0,id,w])[[1]];},
nu = Dimensions[w][[1]]-Length[rhovec];
r=(qq0.rhovec-id);
s=r.w.r;
Return[s/nu]];

logDetFunctional[qq0_,id_]:=Block[{pp},
pp=Join[qq0,id];
Return[Log[Det[pp]^2]]];

(*MC routine*)
MetroGoFixedSelectiveDir[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,Ndit_,prec_,betad_,seed_,sigmaMC_,dcross_,lmax_,idTag_,initialOps_]:=Block[{itd, DDldata, sigmaz, sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, Nz, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    IdsampleEx,zOPE,QQOPE,Calc,coeffTemp,Ident,OPEcoeff,ActionTot,  TotD ,DDldataold,QQold,\[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L,dw,smearedaction}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
    Nz=Length[\[CapitalDelta]LOriginal]+1;
  zsample = Sample[Nz,1/100,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
     
    (*Monte Carlo Iteration*)
TotD =   Reap[ Do[
$MinPrecision=prec;
          \[CapitalDelta]LOld=\[CapitalDelta]L;
          QQold=QQ0;  
(*putative Unitarity bound*)
If[\[CapitalDelta]L[[1,1]]<1,\[CapitalDelta]L[[1,1]]=\[CapitalDelta]L[[1,1]]+1];
(*let every successive run start by varying only the new operator*)
        If[it<Ndit/10&& Nz!=initialOps+1,dimToVary=Nz-1,  dimToVary = RandomInteger[{1,lmax}]];
       (*Shift one dimension by a random amount*)       
          \[CapitalDelta]L[[dimToVary,1]] = \[CapitalDelta]L[[dimToVary,1]]+ RandomVariate[NormalDistribution[0, sigmaMC]];
(*Reevaluate coefficients*)
           QQ0[[dimToVary]] = qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]],\[CapitalDelta]L[[dimToVary]][[2]],zsample];
          
    (*Coefficients for LES and action thence*)
          PP = Join[QQ0, {Idsample}]; 
          Actionnew = Log[Det[PP]^2]; 
QQsave=QQ0;
(*Brot noch schmieren? *)
smearedaction=Reap[Table[
           QQ0[[dimToVary]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]]+dcross,\[CapitalDelta]L[[dimToVary]][[2]],zsample];  PP = Join[QQ0, {Idsample}]; 
          Sow[ Log[Det[PP]^2]];
           QQ0[[dimToVary]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]]-dcross,\[CapitalDelta]L[[dimToVary]][[2]],zsample];  PP = Join[QQ0, {Idsample}]; 
          Sow[ Log[Det[PP]^2]];QQ0=QQsave;,{dimToVary,1,lmax}]];

 Actionnew =Actionnew +Total[smearedaction[[2]]//Flatten] ;
         

          metcheck = Exp[(-betad)*(Actionnew - Action)];
          rr = RandomReal[{0, 1}];
          If[metcheck>rr, Action = Actionnew,\[CapitalDelta]L=\[CapitalDelta]LOld;QQ0=QQold];
          
$MinPrecision=10;
   dw=\[CapitalDelta]L[[All,1]];
          Sow[ {it, dw, N[Action,10]}],
     {it, 1, Ndit}]]; 
$MinPrecision=3;
      Export["Res-fixed_Param_Nit="<>ToString[Ndit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[betad,3]]<>"sigmaMC="<>ToString[N[sigmaMC,3]]<>"dcross="<>ToString[N[dcross,3]]<>"seed="<>ToString[seed]<>"id="<>idTag<>".txt", TotD[[2]]];]

(*MC routine-Chi2*)
MetroGoFixedSelectiveDirChi2[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,Nz_,Ndit_,prec_,betad_,seed_,sigmaMC_,dcross_,lmax_,idTag_,sigmaz_]:=Block[{itd, DDldata, sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample,  PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    IdsampleEx,zOPE,QQOPE,Calc,coeffTemp,Ident,OPEcoeff,ActionTot,  TotD ,DDldataold,QQold,\[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L,dw,errSample,results,nzeros=Length[\[CapitalDelta]LOriginal],fracvio=100,nzerosnew,fracvionew,res,sigmamods=ConstantArray[1,Length[\[CapitalDelta]LOriginal]]}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
     
          errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],0],{i,1,Nz}];
    (*Monte Carlo Iteration*)
TotD =   Reap[ Do[
$MinPrecision=prec;
          \[CapitalDelta]LOld=\[CapitalDelta]L;
          QQold=QQ0;  

  dimToVary =If[it==1,RandomInteger[{1,lmax}], RandomInteger[{1,lmax-nzeros}]];
       (*Shift one dimension by a random amount*)       
          \[CapitalDelta]L[[dimToVary,1]] = \[CapitalDelta]L[[dimToVary,1]]+ RandomVariate[NormalDistribution[0, sigmamods[[dimToVary]] sigmaMC]];
(*Reevaluate coefficients*)
           QQ0[[dimToVary]] = qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]],\[CapitalDelta]L[[dimToVary]][[2]],zsample];
           results=cweightedLeastSquares[(QQ0//Transpose)/errSample,Idsample/errSample,IdentityMatrix[Nz]];
           
(*Need to create two different sets of points for this to work. Leaving out for now
  zsample = Sample[Nz,sigmaz,seed+1]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];

errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];
*)

res=(results[[1]].QQ0-Idsample)/errSample;
nzerosnew=Count[results[[1]],0];
fracvionew=Count[Abs[res]<1//Thread,False]/Nz;
(*Print[{nzerosnew,fracvionew}];
*)

          If[fracvionew<fracvio || nzeros>nzerosnew, fracvio = fracvionew;nzeros=nzerosnew;sigmamods[[dimToVary]] =sigmamods[[dimToVary]] (101/100),\[CapitalDelta]L=\[CapitalDelta]LOld;QQ0=QQold;sigmamods[[dimToVary]] =sigmamods[[dimToVary]] (99/100)];
$MinPrecision=10;
   dw=\[CapitalDelta]L[[All,1]];
          Sow[ {it, dw,results[[1]], {nzeros,fracvio}}],
     {it, 1, Ndit}]]; 
$MinPrecision=3;
      Export["Res-chi_Param_Nit="<>ToString[Ndit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[betad,3]]<>"sigmaMC="<>ToString[N[sigmaMC,3]]<>"dcross="<>ToString[N[dcross,3]]<>"seed="<>ToString[seed]<>"Nz="<>ToString[Nz]<>"id="<>idTag<>".txt", TotD[[2]]];]

cweightedLeastSquares[qq0_,id_,w_]:=Block[{rhovec,nu,s,r,n=1,qq0bis},
rhovec=Inverse[Transpose[qq0].w.qq0].Transpose[qq0] . w.id;
nu = Dimensions[w][[1]]-Length[rhovec];
r=(qq0.rhovec-id);
s=r.w.r;
While[Or@@(rhovec<0//Thread),
qq0bis=qq0[[;;,1;;-1-n]];
rhovec=Inverse[Transpose[qq0bis].w.qq0bis].Transpose[qq0bis] . w.id;
nu = Dimensions[w][[1]]-Length[rhovec];
r=(qq0bis.rhovec-id);
s=r.w.r;n=n+1];
Return[{Join[rhovec,ConstantArray[0,n-1]], Sqrt[s/nu]}];
]
weightedLeastSquares[qq0_,id_,w_]:=Block[{rhovec,nu,s,r},
rhovec=Inverse[Transpose[qq0].w.qq0].Transpose[qq0] . w.id;
nu = Dimensions[w][[1]]-Length[rhovec];
r=(qq0.rhovec-id);
s=r.w.r;
Return[{rhovec,(Diagonal[Inverse[Transpose[qq0].w.qq0]])^(-1/2), Sqrt[s/nu]}];
]
metroReturnAvg[\[CapitalDelta]\[Phi]_,prec_,nit_,\[Beta]_,\[CapitalDelta]L_,seed_,initialOps_,idtag_]:=Block[{data},
MetroGoFixedSelectiveDir[\[CapitalDelta]\[Phi],\[CapitalDelta]L,nit,prec,\[Beta],seed,1/10,1/3,Length[\[CapitalDelta]L],ToString[Length[\[CapitalDelta]L]]<>idtag,initialOps];
data= Get["Res-fixed_Param_Nit="<>ToString[nit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[\[Beta],3]]<>"sigmaMC="<>ToString[N[1/10,3]]<>"dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]<>"id="<>ToString[Length[\[CapitalDelta]L]]<>idtag<>".txt"];
Export["Plot-fixed_Param_Nit="<>ToString[nit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[\[Beta],3]]<>"sigmaMC="<>ToString[N[1/10,3]]<>"dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]<>"id="<>ToString[Length[\[CapitalDelta]L]]<>".pdf",ListPlot[Table[data[[All,2]][[All,i]],{i,1,Length[\[CapitalDelta]L]}],Joined->True,GridLines->Automatic,PlotStyle->Thin,PlotLabel->ToString[Length[\[CapitalDelta]L]]<>"Nit="<>ToString[nit]<>" prec="<>ToString[prec]<>" beta="<>ToString[N[\[Beta],3]]<>" sigmaMC="<>ToString[N[1/10,3]]<>" dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]]];
Export["zoom-Plot-fixed_Param_Nit="<>ToString[nit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[\[Beta],3]]<>"sigmaMC="<>ToString[N[1/10,3]]<>"dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]<>"id="<>ToString[Length[\[CapitalDelta]L]]<>".pdf",ListPlot[Table[data[[All,2]][[All,i]]-2i+1,{i,1,Length[\[CapitalDelta]L]}],Joined->True,GridLines->Automatic,PlotStyle->Thin,PlotRange->{{0,nit},{0,2}},PlotLabel->ToString[Length[\[CapitalDelta]L]]<>"Nit="<>ToString[nit]<>" prec="<>ToString[prec]<>" beta="<>ToString[N[\[Beta],3]]<>" sigmaMC="<>ToString[N[1/10,3]]<>" dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]]];
{Mean[data[[All,2]][[nit-100;;nit,1;;Length[\[CapitalDelta]L]]]],StandardDeviation[data[[All,2]][[nit-100;;nit,1;;Length[\[CapitalDelta]L]]]],Mean[data[[All,3]][[nit-100;;nit,1;;Length[\[CapitalDelta]L]]]],StandardDeviation[data[[All,3]][[nit-100;;nit,1;;Length[\[CapitalDelta]L]]]]}]

metroReturnAvgChi2[prec_,nit_,Nz_,\[Beta]_,\[CapitalDelta]L_,seed_,initialOps_,idtag_,sigmaz_,sigmaMC_]:=Block[{data},
MetroGoFixedSelectiveDirChi2[1,\[CapitalDelta]L,Nz,nit,prec,\[Beta],seed,sigmaMC,1/3,Length[\[CapitalDelta]L],idtag,sigmaz];
data= Get["Res-chi_Param_Nit="<>ToString[nit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[\[Beta],3]]<>"sigmaMC="<>ToString[N[sigmaMC,3]]<>"dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]<>"Nz="<>ToString[Nz]<>"id="<>idtag<>".txt"];
Export["zoom-Plot-chi_Param_Nit="<>ToString[nit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[\[Beta],3]]<>"sigmaMC="<>ToString[N[1/10,3]]<>"dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]<>"Nz="<>ToString[Nz]<>"id="<>idtag<>".pdf",ListPlot[Table[data[[All,2]][[All,i]]-2i+1,{i,1,Length[\[CapitalDelta]L]}],Joined->True,GridLines->Automatic,PlotStyle->Thin,PlotRange->{{0,nit},{8/10,12/10}},PlotLabel->ToString[Length[\[CapitalDelta]L]]<>"Nit="<>ToString[nit]<>" prec="<>ToString[prec]<>" beta="<>ToString[N[\[Beta],3]]<>" sigmaMC="<>ToString[N[1/10,3]]<>" dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]]];
{Mean[data[[All,2]][[nit-100;;nit,1;;Length[\[CapitalDelta]L]]]],StandardDeviation[data[[All,2]][[nit-100;;nit,1;;Length[\[CapitalDelta]L]]]],Mean[data[[All,3]][[nit-100;;nit,1;;Length[\[CapitalDelta]L]]]],StandardDeviation[data[[All,3]][[nit-100;;nit,1;;Length[\[CapitalDelta]L]]]]}]

checkMetroWeighted[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_]:=Block[{itd, DDldata, sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,res}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],0],{i,1,Nz}];
results=weightedLeastSquares[(QQ0//Transpose)/errSample,Idsample/errSample,IdentityMatrix[Nz]];


res=results[[1]].QQ0-Idsample;
Export["histogram-res-nocon-dist.pdf",Histogram[res,Round[Nz/20]]];
finalcheck=Abs[res]<errSample//Thread;
Return[{results,If[And@@finalcheck,And@@finalcheck,finalcheck]}];
];
ccheckMetroWeightedBis[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_]:=Block[{itd, DDldata, sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,res,nzeros}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],0],{i,1,Nz}];
results=cweightedLeastSquares[(QQ0//Transpose)/errSample,Idsample/errSample,IdentityMatrix[Nz]];

  zsample = Sample[Nz,sigmaz,seed+1]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];

nzeros=Count[results[[1]],0];

errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]]-2 nzeros,zsample[[i]],1],{i,1,Nz}];
res=results[[1]].QQ0-Idsample;
Export["histogram-res-dist.pdf",Histogram[res,Round[Nz/50]]];
finalcheck=Abs[res]<1//Thread;
Return[{results,Count[finalcheck,True]/Nz}];
];



mcIterator[\[CapitalDelta]\[Phi]_,initialOps_,finalOps_,\[CapitalDelta]Linitial_,\[Beta]_,nz_,prec_,seedO_,nits_,runid_,sigmaz_,tol_]:=Block[{\[CapitalDelta]L=\[CapitalDelta]Linitial,results,it,seed=seedO},
it=initialOps;
results=Reap[
While[it<=finalOps,
\[CapitalDelta]L[[1;;it,1]]=Sow[metroReturnAvg[\[CapitalDelta]\[Phi],prec,nits[[it-initialOps+1]],\[Beta][[it-initialOps+1]],\[CapitalDelta]L[[1;;it]],seed+it,initialOps,runid]][[1]];
If[Sow[ccheckMetroWeightedBis[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[1;;it]],prec,seed+1,nz,sigmaz]][[2]]>tol,it=it+1,\[CapitalDelta]L[[1;;it,1]]=\[CapitalDelta]L[[1;;it,1]]+Table[RandomReal[{-1/10,1/10}],{i,1,it}];Print["Rejected"];seed=seed+finalOps;]];
];
Export["averages_n_checks"<>"from"<>ToString[initialOps]<>"to"<>ToString[finalOps]<>runid<>"prec="<>ToString[prec]<>"seed="<>ToString[seed]<>"nz="<>ToString[nz]<>".txt", results];
]
mcPlotDimsAndOPEs[initialOps_,finalOps_,nz_,prec_,seed_,runid_]:=Block[{data,dims,opes,mcDims,mcOpes,refDims,refOpes,nrecs=(finalOps-initialOps) +1},
data= Get["averages_n_checks"<>"from"<>ToString[initialOps]<>"to"<>ToString[finalOps]<>runid<>"prec="<>ToString[prec]<>"seed="<>ToString[seed]<>"nz="<>ToString[nz]<>".txt"];
dims=data[[1,Range[1,2nrecs -1,2]]];
opes=data[[1,Range[2,2nrecs ,2]]];
mcDims=ListPlot[dims[[;;,1,1;;4]]//Transpose,PlotLegends->{"l=0","l=2","l=4","l=6"},PlotRange->All];
refDims=Plot[{2,4,6,8},{x,0,nrecs},PlotStyle->Dashed];
mcOpes=ListPlot[opes[[;;,1,1,1;;4]]//Transpose,PlotLegends->{"l=0","l=2","l=4","l=6"},PlotRange->All];
refOpes=Plot[{2,1/3},{x,0,nrecs},PlotStyle->Dashed];
Export["dims-plot"<>"from"<>ToString[initialOps]<>"to"<>ToString[finalOps]<>runid<>"prec="<>ToString[prec]<>"seed="<>ToString[seed]<>"nz="<>ToString[nz]<>".pdf",Show[mcDims,refDims],PlotLabel->"Dims_from"<>ToString[initialOps]<>"to"<>ToString[finalOps]<>runid<>"prec="<>ToString[prec]<>"seed="<>ToString[seed]];
Export["opes-plot"<>"from"<>ToString[initialOps]<>"to"<>ToString[finalOps]<>runid<>"prec="<>ToString[prec]<>"seed="<>ToString[seed]<>"nz="<>ToString[nz]<>".pdf",Show[mcOpes,refOpes],PlotLabel->"OPEs_from"<>ToString[initialOps]<>"to"<>ToString[finalOps]<>runid<>"prec="<>ToString[prec]<>"seed="<>ToString[seed]];
Return[opes[[;;,2]]]
]

gradientComparisonLog[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_,epsilon_]:=Block[{itd, DDldata,  sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,gradientLog,func0}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];
func0=logDetFunctional[QQ0,{Idsample}];
gradientLog=(Table[
    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];\[CapitalDelta]L[[i,1]]=\[CapitalDelta]L[[i,1]]+epsilon; QQ0[[i]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[i]][[1]],\[CapitalDelta]L[[i]][[2]],zsample];\[CapitalDelta]L[[i,1]]=\[CapitalDelta]LOriginal[[i,1]];
logDetFunctional[QQ0,{Idsample}],{i,1,Length[\[CapitalDelta]L]}]-func0)/(epsilon);
Return[{func0,gradientLog}];

];

gradientComparisonLogSmeared[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_,epsilon_,dcross_]:=Block[{itd, DDldata,  sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,gradientLog,func0}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
    QQsave=QQ0;
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];
func0=logDetFunctional[QQ0,{Idsample}];
smearedaction=Reap[Table[
           QQ0[[dimToVary]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]]+dcross,\[CapitalDelta]L[[dimToVary]][[2]],zsample];  PP = Join[QQ0, {Idsample}]; 
          Sow[ Log[Det[PP]^2]];
           QQ0[[dimToVary]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]]-dcross,\[CapitalDelta]L[[dimToVary]][[2]],zsample];  PP = Join[QQ0, {Idsample}]; 
          Sow[ Log[Det[PP]^2]];QQ0=QQsave;,{dimToVary,1,Length[\[CapitalDelta]L]}]];
          
 func0 =func0 +Total[smearedaction[[2]]//Flatten]; 
gradientLog=Table[
    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];\[CapitalDelta]L[[i,1]]=\[CapitalDelta]L[[i,1]]+epsilon; QQ0[[i]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[i]][[1]],\[CapitalDelta]L[[i]][[2]],zsample];
   Actionnew= logDetFunctional[QQ0,{Idsample}];
smearedaction=Reap[Table[
           QQ0[[dimToVary]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]]+dcross,\[CapitalDelta]L[[dimToVary]][[2]],zsample];  PP = Join[QQ0, {Idsample}]; 
          Sow[ Log[Det[PP]^2]];
           QQ0[[dimToVary]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]]-dcross,\[CapitalDelta]L[[dimToVary]][[2]],zsample];  PP = Join[QQ0, {Idsample}]; 
          Sow[ Log[Det[PP]^2]];QQ0=QQsave;,{dimToVary,1,Length[\[CapitalDelta]L]}]];
\[CapitalDelta]L[[i,1]]=\[CapitalDelta]LOriginal[[i,1]];
 Actionnew =Actionnew +Total[smearedaction[[2]]//Flatten]; 
(Actionnew-func0)/(epsilon),{i,1,Length[\[CapitalDelta]L]}];


Return[{func0,gradientLog}];

];

gradientComparisonChi[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_,epsilon_]:=Block[{itd, DDldata,  sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,gradient,func0}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];
results=weightedLeastSquares[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)]];
func0=chi2Functional[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)],results[[1]]];
gradient=(Table[ QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];\[CapitalDelta]L[[i,1]]=\[CapitalDelta]L[[i,1]]+epsilon; QQ0[[i]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[i]][[1]],\[CapitalDelta]L[[i]][[2]],zsample];results=weightedLeastSquares[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)]];\[CapitalDelta]L[[i,1]]=\[CapitalDelta]LOriginal[[i,1]];
chi2Functional[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)],results[[1]]],{i,1,Length[\[CapitalDelta]L]}]-func0)/(epsilon);
Return[{func0,gradient}];
];

gradientComparisonChiSmeared[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_,epsilon_]:=Block[{itd, DDldata,  sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,gradient,func0}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];
results=weightedLeastSquares[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)]];
func0=chi2Functional[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)],results[[1]]];
gradient=(Table[ QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];\[CapitalDelta]L[[i,1]]=\[CapitalDelta]L[[i,1]]+epsilon; QQ0[[i]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[i]][[1]],\[CapitalDelta]L[[i]][[2]],zsample];results=weightedLeastSquares[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)]];\[CapitalDelta]L[[i,1]]=\[CapitalDelta]LOriginal[[i,1]];
chi2Functional[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)],results[[1]]],{i,1,Length[\[CapitalDelta]L]}]-func0)/(epsilon);
Return[{func0,gradient}];
];

(*assorted functions*)
deltaFree[n_]:={2#,2#-2}&/@Range[1,n,1];
opeFreeRen[n_]:=(renomFactor[2#])^(-1) 2((2#-2)!)^2/(2(2#-2))!&/@Range[1,n,1];

(*PLotters*)
genLog[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_]:=Block[{itd, DDldata,  sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,gradientLog,func0}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];
logDetFunctional[QQ0,{Idsample}]
];


biDimChi2DependencePlotter[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_,range_]:=Block[{itd, DDldata,  sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,deltaArray}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];
results=cweightedLeastSquares[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)]];
ContourPlot[\[CapitalDelta]L[[1,1]]=2+x;\[CapitalDelta]L[[2,1]]=4+y;QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];chi2Functional[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)],results[[1]]],{x,-range,range},{y,-range,range},PlotLegends->Automatic]
]
biDimChi2DependenceDataGen[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_,range_,npoints_,opstovary_]:=Block[{itd, DDldata,  sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,deltaArray}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];
results=cweightedLeastSquares[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)]];
ParallelTable[{\[CapitalDelta]L[[opstovary[[1]],1]]=\[CapitalDelta]LOriginal[[opstovary[[1]],1]]+x range/npoints, \[CapitalDelta]L[[opstovary[[2]],1]]=\[CapitalDelta]LOriginal[[opstovary[[2]],1]]+ y  range/npoints, QQ0[[opstovary]] = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[opstovary]],zsample];
results=cweightedLeastSquares[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)]];chi2Functional[(QQ0//Transpose),Idsample,DiagonalMatrix[errSample^(-2)],results[[1]]]},{x,-npoints,npoints},{y,-npoints,npoints}]
];

(*This function is analogous to ccheckMetroWeightedBis, but it takes an arbitrary set of OPE coefficients instead of solving for them.*)
manCheck[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_,rhovec_]:=Block[{itd, DDldata, sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini,
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],eqs,rhosol,last,check,results,indices
Export["histogram-res-dist.pdf",Histogram[res,Round[Nz/50]]];,rhopos,meanrho,sigmarho,finalcheck,errSample,res},
    (*precision*)
    SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed];
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],0],{i,1,Nz}];
res=(rhovec.QQ0-Idsample)/errSample;
finalcheck=Abs[res]<1//Thread;
Return[{Sqrt[(res.res)/(Nz-Length[rhovec])],If[And@@finalcheck,And@@finalcheck,finalcheck]}];
];

(*REsidual plotter*)
resFunc[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,rhovec_,prec_,x_,y_]:=Block[{itd, DDldata, sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini,
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,res},
    (*precision*)
    SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

  zsample = x + I y;
Idsample = SetPrecision[(zsample*Conjugate[zsample])^\[CapitalDelta]\[Phi] -
        ((1 - zsample)*(1 - Conjugate[zsample]))^\[CapitalDelta]\[Phi],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample= \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample,0];
res=(rhovec.QQ0-Idsample)/errSample;
Return[res];
];
biDimChi2DependenceDataGen[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_,sigmaz_,opstovary_,x_,y_]:=Block[{itd, DDldata,  sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample,deltaArray}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,sigmaz,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];
\[CapitalDelta]L[[opstovary[[1]],1]]=\[CapitalDelta]LOriginal[[opstovary[[1]],1]]+x; \[CapitalDelta]L[[opstovary[[2]],1]]=\[CapitalDelta]LOriginal[[opstovary[[2]],1]]+ y ;
 QQ0[[opstovary]] = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[opstovary]],zsample];
results=cweightedLeastSquares[(QQ0//Transpose)/errSample,Idsample/errSample,IdentityMatrix[Nz]];
chi2Functional[(QQ0//Transpose)/errSample,Idsample/errSample,IdentityMatrix[Nz],results[[1]]]
];


deltasimport=Import["~/mc-boo/gooddims"]//ToExpression;
deltamc=Table[Transpose[{deltasimport[[i]],Range[0,16,2]}],{i,1,3}];


\[CapitalDelta]L={{3,0},{5,2},{7,4},{9,6},{11,8},{13,10},{15,12},{17,14},{19,16}};
\[Beta]list={1/5,1/6,1/7,1/8,1/9,1/10,1/11,1/13,1/15};
nits=5{500,100,100,100,100,100,100,100,100};
ParallelTable[mcIterator[1,4,9,\[CapitalDelta]L,\[Beta]list,100,88,100+50tol,nits,"tol="<>ToString[tol],1/10,tol/10],{tol,1,9}]


\[CapitalDelta]L={{3,0},{5,2},{7,4},{9,6},{11,8},{13,10},{15,12},{17,14},{19,16}};
\[Beta]list={1/5,1/6,1/7,1/8,1/9,1/10,1/11,1/13,1/15};
nits=5{500,100,100,100,100,100,100,100,100};
ParallelTable[mcIterator[1,4,9,\[CapitalDelta]L,\[Beta]list,500,88,1000+50tol,nits,"tol="<>ToString[tol],1/10,tol/10],{tol,1,9}]


ParallelTable[metroReturnAvgChi2[88,5000,100,i/100,deltamc[[2]],1+i,4,"whutup",1/10,1/100],{i,1,20}]


metroReturnAvgChi2[88,5000,500,1/100,deltamc[[2]],3421,4,"adaptative-test",1/10,1/100]


ParallelTable[metroReturnAvgChi2[100,2000,800,1/100,deltamc[[2]],i,4,"adaptative-test",1/10,1/100],{i,1,4}]


metroReturnAvgChi2[88,1100,500,1/100,deltamc[[2]],3421,4,"whutup",1/10,1/100]









