within IBPSA.Utilities.IO;
package SignalExchange
  "Package for blocks that identify signals to be exposed for overwriting and reading by a top-level model"
  extends Modelica.Icons.Package;
  block Overwrite "Block that allows a signal to be overwritten"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter String Description "Describes the signal being overwritten";
    Modelica.Blocks.Logical.Switch swi
      "Switch between external signal and direct feedthrough signal"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.RealExpression uExt "External input signal"
      annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
    Modelica.Blocks.Sources.BooleanExpression activate
      "Block to activate use of external signal"
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  protected
    final parameter Boolean boptestOverwrite = true
      "Protected parameter, used by tools to search for overwrite block in models";
  equation
    connect(activate.y, swi.u2)
      annotation (Line(points={{-39,0},{-12,0}}, color={255,0,255}));
    connect(swi.u3, u) annotation (Line(points={{-12,-8},{-80,-8},{-80,0},{-120,
            0}}, color={0,0,127}));
    connect(uExt.y, swi.u1) annotation (Line(points={{-39,20},{-26,20},{-26,8},
            {-12,8}}, color={0,0,127}));
    connect(swi.y, y)
      annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
    annotation (Icon(graphics={
          Line(points={{100,0},{42,0}}, color={0,0,127}),
          Line(points={{42,0},{-20,60}},
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
                      else {235,235,235}))}));
  end Overwrite;

  model Read "Model that allows a signal to be read as an FMU output"
    extends Modelica.Blocks.Routing.RealPassThrough;
    parameter String Description "Describes the signal being read";
    parameter SignalTypes.SignalsForKPIs KPIs = SignalTypes.SignalsForKPIs.None
      "Tag with the type of signal for the calculation of the KPIs";

  protected
    final parameter Boolean boptestRead = true
      "Protected parameter, used by tools to search for read block in models";
    annotation (Icon(graphics={
          Line(points={{22,60},{70,60}},  color={0,0,127}),
          Line(points={{-38,0},{22,60}}, color={0,0,127}),
          Line(points={{-100,0},{-38,0}}, color={0,0,127}),
          Line(points={{-38,0},{100,0}}, color={0,0,127}),
          Ellipse(
            extent={{-40,2},{-36,-2}},
            lineColor={28,108,200},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{36,70},{66,60},{36,50},{36,70}},
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid),
          Line(points={{-16,0},{16,0}},     color={0,0,127},
            origin={78,60},
            rotation=90),
          Line(points={{-16,0},{16,0}},     color={0,0,127},
            origin={74,60},
            rotation=90),
          Line(points={{-16,0},{16,0}},     color={0,0,127},
            origin={70,60},
            rotation=90)}));
  end Read;

  package Examples
    "This package contains examples for the signal exchange block"
    extends Modelica.Icons.ExamplesPackage;
    model FirstOrder
      "Implements signal exchange block for a first order dynamic system"
      extends Modelica.Icons.Example;
      BaseClasses.ExportedModel expMod
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.Constant uSet(k=2)
        annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
      Modelica.Blocks.Sources.BooleanStep actSet(startTime=50)
        annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
      Modelica.Blocks.Sources.BooleanStep actAct(startTime=100)
        annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
      Modelica.Blocks.Sources.Constant uAct(k=3)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    equation
      connect(uSet.y, expMod.oveWriSet_u) annotation (Line(points={{-39,70},{
              -20,70},{-20,10},{-12,10}}, color={0,0,127}));
      connect(actSet.y, expMod.oveWriSet_activate) annotation (Line(points={{
              -39,40},{-30,40},{-30,6},{-12,6}}, color={255,0,255}));
      connect(actAct.y, expMod.oveWriAct_activate) annotation (Line(points={{
              -39,-20},{-30,-20},{-30,-4},{-12,-4}}, color={255,0,255}));
      connect(uAct.y, expMod.oveWriAct_u) annotation (Line(points={{-39,10},{
              -34,10},{-34,0},{-12,0}}, color={0,0,127}));
      annotation (experiment(StopTime=150));
    end FirstOrder;

    package BaseClasses "Contains base classes for signal exchange examples"
      extends Modelica.Icons.BasesPackage;
      model OriginalModel "Original model"

        Modelica.Blocks.Sources.Constant TSet(k=1) "Set point"
          annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
        Modelica.Blocks.Continuous.LimPID conPI(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=10) "Controller"
          annotation (Placement(transformation(extent={{-10,20},{10,40}})));
        Modelica.Blocks.Continuous.FirstOrder firOrd(
          T=1,
          initType=Modelica.Blocks.Types.Init.InitialOutput)
          "First order element"
          annotation (Placement(transformation(extent={{50,20},{70,40}})));
        Overwrite oveWriSet "Overwrite block for setpoint"
          annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
        Overwrite oveWriAct "Overwrite block for actuator signal"
          annotation (Placement(transformation(extent={{20,20},{40,40}})));
        Read rea "Measured state variable"
          annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
      equation
        connect(TSet.y, oveWriSet.u)
          annotation (Line(points={{-49,30},{-42,30}}, color={0,0,127}));
        connect(oveWriSet.y, conPI.u_s)
          annotation (Line(points={{-19,30},{-12,30}}, color={0,0,127}));
        connect(conPI.y, oveWriAct.u)
          annotation (Line(points={{11,30},{18,30}}, color={0,0,127}));
        connect(oveWriAct.y, firOrd.u)
          annotation (Line(points={{41,30},{48,30}}, color={0,0,127}));
        connect(firOrd.y, rea.u) annotation (Line(points={{71,30},{80,30},{80,-20},{52,
                -20}}, color={0,0,127}));
        connect(rea.y, conPI.u_m)
          annotation (Line(points={{29,-20},{0,-20},{0,18}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end OriginalModel;

      model ExportedModel "Model to be exported as an FMU"

        Modelica.Blocks.Interfaces.RealInput oveWriSet_u "Signal for overwrite block for set point"
          annotation (Placement(transformation(extent={{-140,80},{-100,120}})));
        Modelica.Blocks.Interfaces.BooleanInput oveWriSet_activate "Activation for overwrite block for set point"
          annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
        Modelica.Blocks.Interfaces.RealInput oveWriAct_u "Signal for overwrite block for actuator signal"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanInput oveWriAct_activate "Activation for overwrite block for actuator signal"
          annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

        Modelica.Blocks.Interfaces.RealOutput rea = mod.rea.y
          "Measured state variable"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));

        BaseClasses.OriginalModel mod(oveWriSet(uExt(y=oveWriSet_u), activate(y=
                 oveWriSet_activate)), oveWriAct(uExt(y=oveWriAct_u), activate(
                y=oveWriAct_activate))) "Original model"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      end ExportedModel;
    end BaseClasses;
  end Examples;

  package SignalTypes "Package with signal type definitions"
   extends Modelica.Icons.TypesPackage;

    type SignalsForKPIs = enumeration(
        None
          "Not used for KPI",
        AirZoneTemperature
          "Air zone temperature",
        RadiativeZoneTemperature
          "Radiative zone temperature",
        OperativeZoneTemperature
          "Operative zone temperature",
        RelativeHumidity
          "Relative humidity",
        CO2Concentration
          "CO2 Concentration",
        ElectricPower
          "Electric power from grid",
        DistrictHeatingPower
          "Thermal power from district heating",
        GasPower
          "Thermal power from natural gas",
        BiomassPower
          "Thermal power from biomass",
        SolarThermalPower
          "Thermal power from solar thermal",
        FreshWaterFlowRate
          "FreshWaterFlowRate") "Signals used for the calculation of key performance indicators";
  end SignalTypes;

  model Subcontroller
    "Subcontroller to track an external variable by overwriting another variable from the model"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter String Description "Describes the signal being tracked";
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
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Subcontroller;
  annotation (Icon(graphics={Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,
              0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,10},{-10,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,10},{30,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-10,0},{10,0}}, color={0,0,0}),
        Line(
          points={{-60,0},{-30,0}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{30,0},{60,0}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Polygon(
          points={{-80,10},{-80,-10},{-60,0},{-80,10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{60,10},{60,-10},{80,0},{60,10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end SignalExchange;
