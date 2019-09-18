within IBPSA.Utilities.IO.SignalExchange;
block Subcontroller
  "Subcontroller to track an external variable by overwriting another variable from the model"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter String description "Describes the signal being tracked";
  Modelica.Blocks.Sources.RealExpression uExt "External input signal"
  annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.BooleanExpression activate(y=false)
  "Block to activate use of external signal"
  annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealInput u_m
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

  parameter Real k = 1 "Gain of the PI controller";
  parameter Real Ti= 0.5
    "Time constant of the PI Integrator block"
     annotation(Dialog(enable=controllerType==.Modelica.Blocks.Types.SimpleController.PI or
                              controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Real Td = 0.1 "Time constant of the PID Derivative block"
       annotation(Dialog(enable=controllerType==.Modelica.Blocks.Types.SimpleController.PD or
                                controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Real yMax = 1 "Upper limit of PID output";
  parameter Real yMin = 0 "Lower limit of PID output";

  Buildings.Controls.OBC.CDL.Continuous.LimPID limPI(
    yMax=yMax,
    xi_start=0.1,
    Td=Td,
    yMin=yMin,
    k=k,
    Ti=Ti,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI)
    "Controller for heating"
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Logical.Switch swi
    "Switch between external signal and direct feedthrough signal"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
protected
  final parameter Boolean boptestOverwrite = true
    "Protected parameter, used by tools to search for overwrite block in models";



equation
  connect(u_m, limPI.u_m)
    annotation (Line(points={{-120,60},{-30,60},{-30,68}}, color={0,0,127}));
  connect(activate.y, swi.u2)
    annotation (Line(points={{-39,0},{38,0}}, color={255,0,255}));
  connect(limPI.y, swi.u1) annotation (Line(points={{-19,80},{0,80},{0,8},{38,
          8}}, color={0,0,127}));
  connect(u, swi.u3) annotation (Line(points={{-120,0},{-80,0},{-80,-8},{38,-8}},
        color={0,0,127}));
  connect(swi.y, y) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(uExt.y, limPI.u_s)
    annotation (Line(points={{-59,80},{-42,80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Line(points={{100,0},{42,0}}, color={0,0,127}),
        Line(points={{12,60},{-20,60}},
        color={0,0,127}),
        Line(points={{42,0},{-20,0}},
        color = DynamicSelect({235,235,235}, if activate.y then {235,235,235}
                    else {0,0,0})),
        Line(points={{-100,0},{-20,0}}, color={0,0,127}),
        Line(points={{-62,60},{-20,60}},  color={0,0,127}),
        Polygon(
          points={{-58,70},{-28,60},{-58,50},{-58,70}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,62},{-18,58}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,2},{-18,-2}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{40,2},{44,-2}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Line(points={{-16,0},{16,0}},     color={0,0,127},
          origin={-62,60},
          rotation=90),
        Line(points={{-16,0},{16,0}},     color={0,0,127},
          origin={-66,60},
          rotation=90),
        Line(points={{-16,0},{16,0}},     color={0,0,127},
          origin={-70,60},
          rotation=90),
        Ellipse(
          extent={{-77,67},{-91,53}},
          fillPattern=FillPattern.Solid,
          lineColor=DynamicSelect({235,235,235}, if activate.y then {0,255,0}
                    else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if activate.y then {0,255,0}
                    else {235,235,235})),
        Text(
          extent={{-16,30},{38,-28}},
          lineColor={28,108,200},
          textString="PI"),
        Rectangle(extent={{-18,28},{40,-28}}, lineColor={28,108,200}),
        Ellipse(
          extent={{10,32},{14,28}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Line(points={{12,60},{12,30}},
        color={0,0,127})}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Subcontroller;
