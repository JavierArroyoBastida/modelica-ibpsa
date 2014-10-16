within Annex60.Media.Examples.BaseClasses;
partial model FluidProperties
  "Model that tests the implementation of the fluid properties"
  extends Annex60.Media.Water.Examples.BaseClasses.FluidProperties;
  Medium.ThermodynamicState state_dTX "Medium state";
equation
    state_dTX = Medium.setState_dTX(d=d, T=T, X=X);
    checkState(state_pTX, state_dTX, "state_dTX");

   annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
      Documentation(info="<html>
<p>
This example checks thermophysical properties of the medium.
It extends from
<a href=\"modelica://Annex60.Media.Water.Examples.BaseClasses.FluidProperties\">
Annex60.Media.Water.Examples.BaseClasses.FluidProperties</a>
and adds tests that are only meaningful for compressible media.
</p>
</html>",
revisions="<html>
<ul>
<li>
October 16, 2014, by Michael Wetter:<br/>
Changed implementation to extend from
<a href=\"modelica://Annex60.Media.Water.Examples.BaseClasses.FluidProperties\">
Annex60.Media.Water.Examples.BaseClasses.FluidProperties</a>.
</li>
<li>
December 19, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end FluidProperties;
