% Create Flight Animations from Trajectory Data
%% Location of HL20 folder
fullfile(matlabroot, "examples", "aero", "data");

%% Import flight trajectory data
traj_data = readmatrix("traj.csv");
time_data = readmatrix("time.csv");
alt_data = readmatrix("alt.csv");

%% Create a time series object from trajectory data

%{
Use the MATLAB® timeseries command to create the time series 
object, ts, from the latitude, longitude, altitude, and Euler angle 
data along with the time array in traj_data. To convert the latitude, 
longitude, and Euler angles from degrees to radians, use the 
convang function.
%}

ts = timeseries([convang(traj_data(:,[3 2]),"deg","rad") ... 
    alt_data(:,1) convang(traj_data(:,5:7),"deg","rad")],time_data(:,1));

% Array6DoF
% ts = [tdata(:,1) convang(tdata(:,[3 2]),'deg','rad') tdata(:,4) ... 
%    convang(tdata(:,5:7),'deg','rad')];

% Array3DoF
%ts = [tdata(:,1) convang(tdata(:,3),'deg','rad') tdata(:,4) ... 
%    convang(tdata(:,6),'deg','rad')];

%% Use FlightGearAnimation Object to initialize flight animation
% Open a FlightGearAnimation object
h = Aero.FlightGearAnimation;

% Set FlightGearAnimation object properties for timeseries
h.TimeseriesSourceType = "Timeseries";
h.TimeseriesSource = ts;

% Set FlightGearAnimation object properties about FlightGear
h.FlightGearBaseDirectory = "C:\Program Files\FlightGear 2020.3";
h.GeometryModelName = "HL20";
h.DestinationIpAddress =  "127.0.0.1";
h.DestinationPort = "5502";

% Set the desired initial conditions (location and orientation) for FlightGear flight simulator
h.AirportId = "KSFO";
h.RunwayId = "10L";
h.InitialAltitude = 7224;
h.InitialHeading = 113;
h.OffsetDistance = 4.72;
h.OffsetAzimuth = 0;

h.InstallScenery = true;

% Disable FlightGearShaders
h.DisableShaders = true;

% Set the seconds of animation data per second of wall-clock time
h.TimeScaling = 1;

% Check the FlightGearAnimation object properties and their values
get(h)

%% Create a run script to launch FlightGear flight simulator
GenerateRunScript(h)

%% Start FlightGear flight simulator
system("runfg.bat &");

%% Play the flight animation of trajectory data
play(h)

%% Dsiplay a screenshot of the flight animation, using MATLAB image command
image(imread(fullfile(matlabroot, "examples","aero","data","astfganim01.png"),"png"));
axis off;
set(gca,"Position",[ 0 0 1 1 ]);
set(gcf,"MenuBar","none");


