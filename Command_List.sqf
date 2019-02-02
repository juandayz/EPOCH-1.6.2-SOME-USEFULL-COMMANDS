//Some Commands

//used to recognize anykind of thing (players,zeds,vehicles,objects) when you aim with your mouse for example.
_object = _this select 3;
//


//exit condition if u have another action in progress
if (dayz_actionInProgress) exitWith {localize "str_epoch_player_40" call dayz_rollingMessages;};
dayz_actionInProgress = true;
dayz_actionInProgress = false;
///////////////////////////////

//get humanity ammount of the player
_humanity = player getVariable["humanity", 0];
//////////////////////////////

//add humanity 
[50,0] call player_humanityChange;
//remove humanity
[-50,0] call player_humanityChange;
////////////////////////////////


//get player coins amount
_coins = player getVariable [Z_moneyVariable,0];
//////////////////////////////

//add coins
player setVariable[Z_moneyVariable, (_coins + 100), true];
//remove coins
player setVariable[Z_moneyVariable, (_coins - 100), true];

//normalize hunger values from 0 to 100
_hunger = round(100 - (dayz_hunger / SleepFood) * 100);
//condition to know if hunger is less,bigest or equal to x ammount.
if (_hunger < 25) then {
if (_hunger > 25) then {
if (_hunger <= 25) then {
if (_hunger >= 25) then {
///////////////////////////////////


//add hunger points
["FoodDrink",0,[0,180,0,0]] call dayz_NutritionSystem;
PVDZ_serverStoreVar = [player,"messing",[dayz_hunger,dayz_thirst,dayz_nutrition]];
publicVariableServer "PVDZ_serverStoreVar";
/////////////////////////////////////////


//normalize thirst values from 0 to 100
_thirst = round(100 - (dayz_thirst / SleepWater) * 100);
//condition to know if thirst is less,bigest or equal to x ammount.
if (_thirst < 50) then {
if (_thirst > 50) then {
if (_thirst <= 50) then {
if (_thirst >= 50) then {
//condition to know if thirst is between two values.
if ((_thirst >= 10) && (_thirst <=90)) then { //this mean if thirst is between 10 to 90
///////////////////////////////////

//add thirst points
["FoodDrink",0,[0,0,280,0]] call dayz_NutritionSystem;
/////////////////////////////////////////




//normalize blood from 0 to 100.
_blood = round((r_player_blood / r_player_bloodTotal) * 100); //read blood as 0% to 100%
/////////////////////////////////////////////////////


//reduce player blood
r_player_blood = r_player_blood - 100;
//rise player blood
r_player_blood = r_player_blood + 100;
//////////////////////////////////////////////////

//randomize
_randomize = [10000,30000];
_randomize = (random((_randomize select 1) - (_randomize select 0)) + (_randomize select 0)) / 10;
//use randomize for example to reduce player blood amount
r_player_blood = r_player_blood - _randomize;
///////////////////////////////////////////////

//another way to use random
_chance= round(random 10);
_winchance = 2;
if (_chance == _winchance) then {};
//////////////////////////////////////




//randomize things inside a []
["itemKiloHemp","ItemBloodBag","ItemBandage"]call BIS_fnc_selectRandom;
/////////////////////


//set player in pain
r_player_inpain = true;
player setVariable["USEC_inPain",true,true];
////////////////////////////////////////////////////

//set infection on player
r_player_infected = true;
player setVariable["USEC_infected",true,true];
//////////////////////////////////////////////////////


//hits player hands
player setHit["Hands",0.5];
////////////////////////////

//play some default sounds
[player,"chopwood",0,false] call dayz_zombieSpeak;
[player, "gut", 0, false, 5] call dayz_zombieSpeak;
/////////////////////////////////

//custom sounds
playsound "your custom sound name"; //this sound will be hear by one single player.you need define it in your description.ext format is .ogg
null = [objNull,player,rSAY,"your sound name",80] call RE;//sound for everyone at 80mts around from player.//needs be defined in description.ext format .ogg
//////////////////////////////////////////////////

//Drop items to the ground
["FoodBeefRaw",1,1] call fn_dropItem; //[item class name//item kind (1 items, 2 tools or weapons)//item amount];
//drop weapons or tools to the ground
["ItemKnife",2,1] call fn_dropItem;
//Randomize amount of items droped
["FoodBeefRaw",1,(round(random 3)*2)] call fn_dropItem;//aviable chances : 1x2,2x2,3x2.
["FoodBeefRaw",1,(round(random 5)*3)] call fn_dropItem;//aviable chances : 1x3,2x3,3x3,4x3,5x3.
/////////////////////////////////////////////////


//Count nearest players,ai exit too.
_playerNear = {isPlayer _x} count (([player] call FNC_GetPos) nearEntities ["CAManBase",5]) > 1;
if (_playerNear) exitWith {localize "STR_EPOCH_PLAYER_84" call dayz_rollingMessages;};
////////////////////////////////////////////

//shake camera
addCamShake [2, 0.5, 25];
////////////////////////////////

//block player mouse and keyboard
disableuserinput true; disableuserinput true; disableuserinput true;
//unblock
disableuserinput false; disableuserinput false; disableuserinput false;

//msgs
systemchat "";
"" call dayz_rollingMessages;
titleText ["","PLAIN DOWN", 1];
cutText ["", "BLACK FADED"];
titleCut ["", "BLACK IN", 5];
//////////////////////////

//msg format
_local_variable = "hello";
systemChat format["blablabla %1",_local_variable];

_local_variable = "hello";
Format ["blablabla %1.", _local_variable] call dayz_rollingMessages;

_local_variable = "hello";
titleText [format["blabla %1",_local_variable] , "PLAIN DOWN", 1];

_local_variable = "hello";
cutText [format["%1 ",_local_variable], "PLAIN DOWN"];

_local_variable = "hello";//colored msg
[format["<t size='1.2' color='#D01000'>BLABLABLA!!!!%1</t><br/><t size='0.9'>BLABLABLA!!!!.</t>",_local_variable],0,0,2,2] spawn BIS_fnc_dynamicText;
//////////////////////////////////////////////////////////////


//animation
player playActionNow "Medic";
player playActionNow "GesturePoint";
player playmove "ActsPercMstpSnonWpstDnon_suicide1B";//suicide animation
////////////////////////////

//get player animation
_animState = animationState player;
////get this animation in a text
systemChat format["animation name is %1",_animState];
/////////////////

//time restriction
_Time = time - lastuse;
if(_Time < 60) exitWith {cutText [format["wait %1 seconds before play again!",(round(_Time - 60))], "PLAIN DOWN"];};
lastuse = time;
///////////////////////

//remove maganizes from player inventory
player removeMagazine "ItemclassNameHere";
/////////

//add magazines in players invetory
player addMagazine "ItemClassNameHere";
////////

//Count ammount of one kind of item in player inventory
_count_amount = {_x == "ItemClassNameHere"} count magazines player;
if (_count_amount < 10) exitWith { systemChat "You need 10";};
//////////////////////////

//add backpack
player addBackpack "BackpackClassName";
////////////////

//add weapon
player addWeapon "ItemClassName";//used for tools and weapons.
//////////////


//remove all weapons,tools,backpacks from player inventory
removeBackpack player;
removeAllItems player;
removeAllWeapons player;
////////////////////////



