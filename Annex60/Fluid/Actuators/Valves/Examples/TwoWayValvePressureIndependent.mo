within Annex60.Fluid.Actuators.Valves.Examples;
model TwoWayValvePressureIndependent
  "Two way valves with pressure independent opening characteristic"
  extends Modelica.Icons.Example;
  package Medium = Annex60.Media.Water.Simple;

    Modelica.Blocks.Sources.Ramp y(
    height=1,
    duration=1,
    offset=0) "Control signal"
                 annotation (Placement(transformation(extent={{-60,70},{-40,90}})));

  Annex60.Fluid.Sources.Boundary_pT sou(             redeclare package Medium
      = Medium,
    use_p_in=true,
    T=293.15,
    nPorts=3) "Boundary condition for flow source"  annotation (Placement(
        transformation(extent={{-70,-10},{-50,10}})));
  Annex60.Fluid.Sources.Boundary_pT sin(             redeclare package Medium
      = Medium,
    p(displayUnit="Pa") = 3E5,
    T=293.15,
    nPorts=3) "Boundary condition for flow sink"    annotation (Placement(
        transformation(extent={{72,-10},{52,10}})));

  TwoWayPressureIndependent valInd(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    CvData=Annex60.Fluid.Types.CvTypes.OpPoint,
    filteredOpening=false,
    l=0.05,
    from_dp=true,
    dpFixed_nominal=0,
    l2=0.1,
    dpValve_nominal=10000) "Pressure independent valve"
             annotation (Placement(transformation(extent={{-10,30},{10,50}})));
    Modelica.Blocks.Sources.Ramp dp(
    duration=1,
    startTime=1,
    offset=303000,
    height=12000) "Pressure ramp"
                 annotation (Placement(transformation(extent={{-100,-2},{-80,18}})));
  TwoWayPressureIndependent valIndDpFix(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    CvData=Annex60.Fluid.Types.CvTypes.OpPoint,
    filteredOpening=false,
    l=0.05,
    dpFixed_nominal=5000,
    from_dp=true,
    l2=0.1,
    dpValve_nominal=10000) "Pressure independent valve using dp_Fixed_nominal"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  TwoWayPressureIndependent valIndFromMflow(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    CvData=Annex60.Fluid.Types.CvTypes.OpPoint,
    filteredOpening=false,
    l=0.05,
    from_dp=false,
    dpFixed_nominal=0,
    l2=0.1,
    dpValve_nominal=10000) "Pressure independent valve using from_dp = false"
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
equation
  connect(valInd.y, y.y) annotation (Line(
      points={{0,52},{0,66},{-20,66},{-20,80},{-39,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sou.ports[1], valInd.port_a) annotation (Line(
      points={{-50,2.66667},{-30,2.66667},{-30,40},{-10,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valInd.port_b, sin.ports[1]) annotation (Line(
      points={{10,40},{32,40},{32,2.66667},{52,2.66667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dp.y, sou.p_in) annotation (Line(
      points={{-79,8},{-72,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(valIndDpFix.port_a, sou.ports[2]) annotation (Line(
      points={{-10,0},{-30,0},{-30,-2.22045e-16},{-50,-2.22045e-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valIndDpFix.port_b, sin.ports[2]) annotation (Line(
      points={{10,0},{32,0},{32,-2.22045e-16},{52,-2.22045e-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valIndFromMflow.port_a, sou.ports[3]) annotation (Line(
      points={{-10,-40},{-30,-40},{-30,-2.66667},{-50,-2.66667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valIndFromMflow.port_b, sin.ports[3]) annotation (Line(
      points={{10,-40},{32,-40},{32,-2.66667},{52,-2.66667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(y.y, valIndDpFix.y) annotation (Line(
      points={{-39,80},{-20,80},{-20,20},{0,20},{0,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(y.y, valIndFromMflow.y) annotation (Line(
      points={{-39,80},{-20,80},{-20,-20},{0,-20},{0,-28}},
      color={0,0,127},
      smooth=Smooth.None));
    annotation (experiment(StopTime=2),
__Dymola_Commands(file=
          "modelica://Annex60/Resources/Scripts/Dymola/Fluid/Actuators/Valves/Examples/TwoWayValvePressureIndependent.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>Test model for pressure independent valves. Note that the leakage at full mass flow rate (<code>l2</code>) has been set to a large value for better visualization of the valve characteristics. To use common values, use the default values. </p>
<p>The parameter <code>filterOpening</code> is set to <code>false</code>, as this model is used to plot the flow at different opening signals without taking into account the travel time of the actuator. </p>
</html>", revisions="<html>
<ul>
<li>
January 29, 2015 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics),
    __Dymola_experimentSetupOutput);
end TwoWayValvePressureIndependent;
