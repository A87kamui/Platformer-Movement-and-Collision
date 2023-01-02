/// @description Insert description here

//Get keyboard inputs
rightKey = keyboard_check(ord("D"));		//Check if “D” is pressed 1 or 0 —need ord when checking keyboard letters
leftKey = keyboard_check(ord("A"));		//Check if “A” is pressed 1 or 0—need ord when checking keyboard letters
jumpKeyPressed =  keyboard_check_pressed(vk_space);	//Check if spacebar is pressed

//Getting xspd and yspd
//xspd based on button presses
xspd = (rightKey - leftKey) * moveSpd;		//left/rightKey is 1 or 0 times the move speed rate of 2 (from Create Event)

//Apply gravity to the yspd
yspd += grav;	//This will add gravity to give a falling effect

//Jump
//Check if jump is pressed and there is a wall below the player
if jumpKeyPressed && place_meeting(x, y+1, obj_wall)
{
	yspd = jumpSpd; 
}

//Wall collision
//Collision on x axis 
//Check 1 space from player’s current x position
if place_meeting(x + xspd, y, obj_wall)
{
	//move player as close to the wall as possible to there is no gap between player and wall
	//store the sign of xspd, +, -, or 0 and check in front of player a pixel at a time 
	var _pixelCheck = sign(xspd);	

	//While there isn’t a wall from player position + 1 pixel 
	//then player can keep moving forward by pixel amount
	while !place_meeting(x + _pixelCheck, y, obj_wall)
	{
		x += _pixelCheck;
	}

	//Set x speed to 0 by stopping player if there is a wall
	xspd = 0;
}	

//Collision on y axis 
//Check 1 space from player’s current x and y position 
if place_meeting(x + xspd, y + yspd, obj_wall)
{
	//move player as close to the wall as possible to there is no gap between player and wall
	//store the sign of xspd, +, -, or 0 and check in front of player a pixel at a time 
	var _pixelCheck = sign(yspd);	

	//While there isn’t a wall from player position + 1 pixel 
	//then player can keep moving forward by pixel amount
	while !place_meeting(x + xspd, y + _pixelCheck, obj_wall)
	{
		y += _pixelCheck;
	}

	//Set y speed to 0 by stopping player if there is a wall
	yspd = 0;
}	

//Move the player 
x += xspd;
y += yspd;