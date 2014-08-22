Object = {}

-- for creation of new instances
function Object:new (o)
	o = o or { }
	setmetatable(o, self)
    self.__index = self
    return o
end

local _localLuaAiAgent = LuaAiAgent(nil)
local _localLuaSceneObject = LuaSceneObject(nil)
local _localLuaTangibleObject = LuaTangibleObject(nil)
local _localLuaCreatureObject = LuaCreatureObject(nil)
local _localLuaPlayerObject = LuaPlayerObject(nil)
local _localLuaBuildingObject = LuaBuildingObject(nil)
local _localLuaCityRegion = LuaCityRegion(nil)
local _localLuaActiveArea = LuaActiveArea(nil)

local ObjectManager = Object:new {}

-- Perform the supplied function with an ai agent created from the pointer.
-- @param pCreatureObject a pointer to a creature object that is an AiAgent.
-- @param performThisFunction a function that takes an ai agent as its argument.
-- @return whatever performThisFunction returns or nil if the pCreatureObject pointer is nil.
function ObjectManager.withCreatureAiAgent(pCreatureObject, performThisFunction)
	if pCreatureObject == nil then
		return nil
	end
	--local aiAgent = LuaAiAgent(pCreatureObject)
	_localLuaAiAgent:_setObject(pCreatureObject)
	
	local ret = performThisFunction(_localLuaAiAgent)
	
	_localLuaAiAgent:_setObject(nil)
	
	return ret
end

-- Perform the supplied function with a scene object created from the pointer.
-- @param pSceneObject a pointer to a scene object.
-- @param performThisFunction a function that takes a scene object as its argument.
-- @return whatever performThisFunction returns or nil if the pSceneObject pointer is nil.
function ObjectManager.withSceneObject(pSceneObject, performThisFunction)
	if pSceneObject == nil then
		return nil
	end
	--local sceneObject = LuaSceneObject(pSceneObject)
	_localLuaSceneObject:_setObject(pSceneObject)
	
	local ret = performThisFunction(_localLuaSceneObject)
	
	_localLuaSceneObject:_setObject(nil)
	
	return ret
end

-- Perform the supplied function with a tangible object created from the pointer.
-- @param pTangibleObject a pointer to a scene object.
-- @param performThisFunction a function that takes a tangible object as its argument.
-- @return whatever performThisFunction returns or nil if the pTangibleObject pointer is nil.
function ObjectManager.withTangibleObject(pTangibleObject, performThisFunction)
	if pTangibleObject == nil then
		return nil
	end
	--local tangibleObject = LuaTangibleObject(pTangibleObject)
	_localLuaTangibleObject:_setObject(pTangibleObject)
	
	local ret = performThisFunction(_localLuaTangibleObject)
	
	_localLuaTangibleObject:_setObject(nil)
	
	return ret
end

-- Perform the supplied function with a creature object created from the pointer.
-- @param pCreatureObject a pointer to a creature object.
-- @param performThisFunction a function that takes a creature object as its argument.
-- @return whatever performThisFunction returns or nil if the pCreatureObject pointer is nil.
function ObjectManager.withCreatureObject(pCreatureObject, performThisFunction)
	if pCreatureObject == nil then
		return nil
	end
	--local creatureObject = LuaCreatureObject(pCreatureObject)
	_localLuaCreatureObject:_setObject(pCreatureObject)
	
	local ret = performThisFunction(_localLuaCreatureObject)
	
	_localLuaCreatureObject:_setObject(nil)
	
	return ret
end

-- Perform the supplied function with a player object created from the pointer.
-- @param pPlayerObject a pointer to a player object.
-- @param performThisFunction a function that takes a player object as its argument.
-- @return whatever performThisFunction returns or nil if the pPlayerObject pointer is nil.
function ObjectManager.withPlayerObject(pPlayerObject, performThisFunction)
	if pPlayerObject == nil then
		return nil
	end
	
	--local playerObject = LuaPlayerObject(pPlayerObject)
	_localLuaPlayerObject:_setObject(pPlayerObject)
	
	local ret = performThisFunction(_localLuaPlayerObject)
	
	_localLuaPlayerObject:_setObject(nil)
	
	return ret
end

-- Perform the supplied function with a building object created from the pointer.
-- @param pBuildingObject a pointer to a building object.
-- @param performThisFunction a function that takes a building object as its argument.
-- @return whatever performThisFunction returns or nil if the pBuildingObject pointer is nil.
function ObjectManager.withBuildingObject(pBuildingObject, performThisFunction)
	if pBuildingObject == nil then
		return nil
	end
	
	--local buildingObject = LuaBuildingObject(pBuildingObject)
	_localLuaBuildingObject:_setObject(pBuildingObject)
	
  local ret = performThisFunction(_localLuaBuildingObject)
  
  _localLuaBuildingObject:_setObject(nil)
  
  return ret
end

-- Perform the supplied function with a city region created from the pointer.
-- @param pCityRegion a pointer to a city region.
-- @param performThisFunction a function that takes a city region as its argument.
-- @return whatever performThisFunction returns or nil if the pCityRegion pointer is nil.
function ObjectManager.withCityRegion(pCityRegion, performThisFunction)
	if pCityRegion == nil then
		return nil
	end
	
	--local cityRegion = LuaCityRegion(pCityRegion)
	_localLuaCityRegion:_setObject(pCityRegion)
	
	local ret = performThisFunction(_localLuaCityRegion)
	
	_localLuaCityRegion:_setObject(nil)
	
	return ret
end

-- Perform the supplied function with a player object fetched from the creature object pointer.
-- @param pCreatureObject a pointer to a creature object.
-- @param performThisFunction a function that takes a player object as its argument.
-- @return whatever performThisFunction returns or nil if the pCreatureObject pointer is nil or does not have a player object.
function ObjectManager.withCreaturePlayerObject(pCreatureObject, performThisFunction)
	return ObjectManager.withCreatureObject(pCreatureObject, function(creatureObject)
		return ObjectManager.withPlayerObject(creatureObject:getPlayerObject(), performThisFunction)
	end)
end

-- Perform the supplied function with a creature object and a player object fetched from the creature object pointer.
-- @param pCreatureObject a pointer to a creature object.
-- @param performThisFunction a function that takes a creature object and a player object as its argument.
-- @return whatever performThisFunction returns or nil if the pCreatureObject pointer is nil or does not have a player object.
function ObjectManager.withCreatureAndPlayerObject(pCreatureObject, performThisFunction)
	return ObjectManager.withCreatureObject(pCreatureObject, function(creatureObject)
		return ObjectManager.withPlayerObject(creatureObject:getPlayerObject(), function(playerObject)
			return performThisFunction(creatureObject, playerObject)
		end)
	end)
end

-- Perform the supplied function with the inventory pointer from the pointer to the creature object.
-- @param pCreatureObject a pointer to a creature object.
-- @param performThisFunction a function that takes a pointer to an inventory as its argument.
-- @return whatever performThisFunction returns or nil if the pCreatureObject pointer is nil or does not have an inventory.
function ObjectManager.withInventoryPointer(pCreatureObject, performThisFunction)
	return ObjectManager.withCreatureObject(pCreatureObject, function(creatureObject)
		local pInventory = creatureObject:getSlottedObject("inventory")

		if pInventory ~= nil then
			return performThisFunction(pInventory)
		else
			return nil
		end
	end)
end

-- Perform the supplied function with a scene object with the supplied object id.
-- @param objectId the object id of the scene object to send to the function.
-- @param performThisFunction a function that takes a scene object as argument.
-- @return whatever performThisFunction returns or nil if no object with the specified id can be found.
function ObjectManager.withSceneObjectFromId(objectId, performThisFunction)
	return ObjectManager.withSceneObject(getSceneObject(objectId), performThisFunction)
end

-- Perform the supplied function with an active area.
-- @param pActiveArea pointer to the active area.
-- @param performThisFunction a function that takes an active area as argument.
-- @return whatever performThisFunction returns or nil if the pActiveArea is nil.
function ObjectManager.withActiveArea(pActiveArea, performThisFunction)
	if pActiveArea == nil then
		return nil
	end
	--local activeArea = LuaActiveArea(pActiveArea)
	_localLuaActiveArea:_setObject(pActiveArea)
	
	local ret = performThisFunction(_localLuaActiveArea)
	
	_localLuaActiveArea:_setObject(nil)
	
	return ret
end

return ObjectManager
