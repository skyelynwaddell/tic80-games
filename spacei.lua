0  ,]']�>S�}W��u��pq�@%qy)6o4]uA��s��������Vl�3<W
0      ����    ����2Tv�����ͫ�gE#2Tv����2Tv����W                                        �   �  ��  �� �� ��� ��       �   �  ��  ��  ���                                  �� �ʬ
��̪��̬��̬��̪�ʬ
 ��                                                                                                                                                                                                                                                                                                                                                                         �   �  �  �  � ����� �  �� �� �� � ��������  �� 
�� �� �� �� ��� ��� ���             ��  ��  �� ������ ""  �,"��"���,���,"��" �, ""                                                                                                                                                                                                                                                                                                                                                                 ��������  �  �  �           ����������� � ��� ��  ��  ������������ ��� �� ��  �  ��������  ��  ��  ��                                                                                                                                                                                                                                                                                                                                                                                                                                             ��  ��  �� ������ ���        �  �  �  ��� �����	>                                                                | --TOP
-- title:   space vaporizors
-- author:  @ver2ion
-- script:  lua
---------------------------------

function BOOT()
	init() --set init vars
end

function TIC()
	cls(0)
	update()
	draw()
end -- TIC()

function init()	
	initGame()
	initPlayer()
	initPlayerBullet()
	initPlayerBulletsArray()
end -- init()

function update()
	Controls()
	MovePlayer()
	MovePlayerBullet()
	ShootPlayerBullet()
end --update()

function draw()
	DrawPlayer()
	DrawPlayerBullet()
	DrawHUD()
end --draw()

---------------------------------

--Custom Functions

---------------------------------

function Controls()
	up = btn(0)
	down = btn(1)
	left = btn(2)
	right = btn(3)
	shootBtn = btnp(4)
end --Controls()

---------------------------------

function initGame()
	--init game variables
	window_width = 240
	window_height = 136
	score = 100
	end

---------------------------------
	
function initPlayer()
--player table
player = {
	sprite = 1,
	spd = 2,
	x = window_width/2-8,
	y = window_height-60,
	scale = 1,
	dirx = 0,
	diry = 0
}--
end

-----------------------------

function initPlayerBullet()
bulletAmount = 100
playerBullets = {}
bullet = 1
coolDownTime = 10
coolDownTimer = 0
canShoot = true
end

-----------------------------

function DrawPlayer()
--draw the player
	spr(
		1, --sprite
		player.x, --x
		player.y, --y
		0, --background color
		player.scale --scale
	)
	
		spr(
		2, --sprite
		player.x+8, --x
		player.y, --y
		0, --background color
		player.scale --scale
	)
	
			spr(
		16, --sprite
		player.x-8, --x
		player.y+8, --y
		0, --background color
		player.scale --scale
	)
	
			spr(
		17, --sprite
		player.x, --x
		player.y+8, --y
		0, --background color
		player.scale --scale
	)
	
			spr(
		18, --sprite
		player.x+8, --x
		player.y+8, --y
		0, --background color
		player.scale --scale
	)
	
			spr(
		19, --sprite
		player.x+16, --x
		player.y+8, --y
		0, --background color
		player.scale --scale
	)
	
			spr(
		32, --sprite
		player.x-8, --x
		player.y+16, --y
		0, --background color
		player.scale --scale
	)
	
				spr(
		33, --sprite
		player.x, --x
		player.y+16, --y
		0, --background color
		player.scale --scale
	)
				spr(
		34, --sprite
		player.x+8, --x
		player.y+16, --y
		0, --background color
		player.scale --scale
	)
				spr(
		35, --sprite
		player.x+16, --x
		player.y+16, --y
		0, --background color
		player.scale --scale
	)
	
				spr(
		49, --sprite
		player.x, --x
		player.y+24, --y
		0, --background color
		player.scale --scale
	)
	
					spr(
		50, --sprite
		player.x+8, --x
		player.y+24, --y
		0, --background color
		player.scale --scale
	)
	
end

---------------------------------

--player movement function
function MovePlayer()
	
	--left/right key checks
	if left and player.x > 8
	then
		player.dirx = -1
	elseif right 
	and player.x < window_width - 24
	then
		player.dirx = 1
	else player.dirx = 0
	end --left/right key checks
	
	--up/down key checks
	if up and player.y > 0 
	then
		player.diry=-1
	elseif down 
	and player.y < window_height - 30
	then
		player.diry = 1
	else player.diry = 0
	end --up/down key checks
	
	--apply movement to player
	
	--horizontal movement
	player.x = (
		player.x + player.spd * player.dirx)

	--vertical movement
	player.y = (
		player.y + player.spd * player.diry)
end --MovePlayer()

---------------------------------

function initPlayerBulletsArray()
	for bullet = 1, bulletAmount
	do
		playerBullets[bullet] = {
				x = 0,
				y = 0,
				scale = 1,
				sprite = 4,
				color = 13,
				spd = 2,
				length = 5,
				active = false
		}
	end -- end do forloop
end --function initPlayerBulletsArray()


-----------

function DrawPlayerBullet()
	for bullet = 1, bulletAmount
	do
		if playerBullets[bullet].active
		then
			--draw the bullet
			spr(
			playerBullets[bullet].sprite,
			playerBullets[bullet].x,
			playerBullets[bullet].y,
			playerBullets[bullet].color,
			playerBullets[bullet].scale
			)
		end -- if bullet is active
	end -- do for loop
end --function draw player bullet

---------------------------------

function ShootPlayerBullet()
local bulletFired = false

if canShoot == false
then
	coolDownTimer = coolDownTimer + 1
end

if coolDownTimer >= coolDownTime
then
	canShoot = true
	coolDownTimer = 0
end

if shootBtn and canShoot
then
	canShoot = false
	
	for bullet = 1, bulletAmount
	do
	
	if 
	(bulletFired == false)
	and
	(not playerBullets[bullet].active)
	then
		playerBullets[bullet].x =
			player.x + 4

		playerBullets[bullet].y =
			player.y
		
		playerBullets[bullet].active = true
		bulletFired = true
	end -- if not active
	end --bullet array do for loop
end --if shoot btn

end -- function shootplayerbullet()

function MovePlayerBullet()
	
	for bullet = 1, bulletAmount
	do
	
	if (playerBullets[bullet].active == true)
	then
		playerBullets[bullet].y =
			playerBullets[bullet].y - playerBullets[bullet].spd
		
		if (playerBullets[bullet].y < 0)
		then
			playerBullets[bullet].active = false
		
		end --if y < 0 set to not active
		
	end --is playerbullet active?
	
	end -- do for loop
	
end --function moveplayerbullet

---------------------------------

function DrawHUD()
	local scoreX = 2
	local scoreY = 2
	local scoreColor = 9
	print(score,scoreX,scoreY-2,scoreColor,0,2)
	print(score,scoreX,scoreY+2,scoreColor,0,2)
	
	print(score,scoreX-2,scoreY,scoreColor,0,2)
	print(score,scoreX+2,scoreY,scoreColor,0,2)
	
	print(score,scoreX,scoreY,12,0,2)
	score = score + 1
	
end --function drawHUD

---------------------------------


---------------------------------
--BOTTOM