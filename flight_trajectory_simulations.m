% Create Flight Animations from Trajectory Data
%% Import flight trajectory data
tdata = readmatrix('traj.csv');

%% Create a time series object from trajectory data
ts = timeseries([convang(tdata(:,[3 2]),'deg','rad') ...
                 tdata(:,4) convang(tdata(:,5:7),'deg','rad')],tdata(:,1));
ts = [tdata]

%% Use FlightGearAnimation Object to initialize flight animation
% Open a FlightGearAnimation object
h = Aero.FlightGearAnimation;

% Set FlightGearAnimation object properties for timeseries
h.TimeseriesSourceType = 'Timeseries';
h.TimeseriesSource = ts;

% Set FlightGearAnimation object properties about FlightGear
h.FlightGearBaseDirectory = 'C:\Program Files\FlightGear';
h.GeometryModelName = 'HL20';
h.DestinationIpAddress =  '127.0.0.1';
h.DestinationPort = '5502';

% Set the desired initial conditions (location and orientation) for FlightGear flight simulator
h.AirportId = 'KSFO';
h.RunwayId = '10L';
h.InitialAltitude = 7224;
h.InitialHeading = 113;
h.OffsetDistance = 4.72;
h.OffsetAzimuth = 0;

h.InstallScenery = true;

% Disable FlightGearShaders
h.DisableShaders = true;

% Set the seconds of animation data per second of wall-clock time
h.TimeScaling = 5;

% Check the FlightGearAnimation object properties and their values
get(h)



%% Set Flight
