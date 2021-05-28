ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('claim_starterpack:checkClaim', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        local claimed = json.decode(result[1].starterpack)
        cb(claimed)
	end)
end)

RegisterServerEvent('claim_starterpack:setVehicle')
AddEventHandler('claim_starterpack:setVehicle', function (vehicleProps, playerID)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `stored`) VALUES (@owner, @plate, @vehicle, @stored)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@stored']  = 1
    }, function ()
        MySQL.Async.execute('UPDATE `users` SET starterpack = 1 WHERE identifier = @identifier',
        {
            ['@identifier']   = xPlayer.identifier
        }, function ()
        end)
	end)
end)