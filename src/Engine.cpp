#include "libtcod.hpp"
#include "Actor.hpp"
#include "Map.hpp"
#include "Engine.hpp"

Engine::Engine() {
  TCODConsole::setCustomFont("data/fonts/arial8x8-ext.png", TCOD_FONT_LAYOUT_TCOD | TCOD_FONT_TYPE_GREYSCALE, 32, 14);
  TCODConsole::initRoot(80,50,"2drl-2016-09-22",false);
  player = new Actor(40,25,'@',TCODColor::white);
  actors.push(player);
  actors.push(new Actor(60,13,'@',TCODColor::yellow));
  map = new Map(80,45);
}

Engine::~Engine() {
  actors.clearAndDelete();
  delete map;
}

void Engine::update() {
  TCOD_key_t key;
  TCODSystem::checkForEvent(TCOD_EVENT_KEY_PRESS,&key,NULL);
  switch(key.vk) {
    case TCODK_UP :
      if ( !map->isWall(player->x,player->y-1) ) {
        player->y--;  
      }
    break;
    case TCODK_DOWN :
      if ( !map->isWall(player->x,player->y+1) ) {
        player->y++;
      }
    break;
    case TCODK_LEFT :
      if ( !map->isWall(player->x-1,player->y) ) {
        player->x--;
      }
    break;
    case TCODK_RIGHT :
      if ( !map->isWall(player->x+1,player->y) ) {
        player->x++;
      }
    break;
    default:break;
  }
}

void Engine::render() {
  TCODConsole::root->clear();
  // Draw the map
  map->render();

  // Draw the actors
  for (Actor **iterator=actors.begin();
    iterator != actors.end(); iterator++) {
    (*iterator)->render();
  }
}
