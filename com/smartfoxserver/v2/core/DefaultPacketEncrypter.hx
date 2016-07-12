package com.smartfoxserver.v2.core;

/**
 * ...
 * @author vincent blanchet
 */

import com.hurlant.crypto.Crypto;
import com.hurlant.crypto.symmetric.ICipher;
import com.hurlant.crypto.symmetric.IPad;
import com.hurlant.crypto.symmetric.IVMode;
import com.hurlant.crypto.symmetric.PKCS5;
import com.smartfoxserver.v2.SmartFox;
import com.smartfoxserver.v2.bitswarm.BitSwarmClient;
import com.smartfoxserver.v2.kernel;
import com.smartfoxserver.v2.protocol.serialization.DefaultObjectDumpFormatter;
import com.smartfoxserver.v2.util.CryptoKey;

import flash.errors.IllegalOperationError;
import flash.utils.ByteArray;

public class DefaultPacketEncrypter implements IPacketEncrypter
{
	private var bitSwarm:BitSwarmClient;
	private static var ALGORITHM:String = "aes-cbc";
	
	public function new(bitSwarm:BitSwarmClient)
	{
		this.bitSwarm = bitSwarm;
	}
	
	public function encrypt(data:ByteArray):Void
	{
		var ck:CryptoKey = bitSwarm.cryptoKey
		
		/*
		trace("IV  : \n" + DefaultObjectDumpFormatter.hexDump(ck.iv))
		trace("KEY : \n" + DefaultObjectDumpFormatter.hexDump(ck.key))
		trace("DATA: \n" + DefaultObjectDumpFormatter.hexDump(data))
		*/
		haxe.crypto.
		var padding:IPad = new PKCS5()
		
		var cipher:ICipher = Crypto.getCipher(ALGORITHM, ck.key, padding)
		var ivmode:IVMode = cipher as IVMode
		ivmode.IV = ck.iv
		
		cipher.encrypt(data)
	}
	
	public function decrypt(data:ByteArray):Void
	{
		var ck:CryptoKey = bitSwarm.cryptoKey
			
		var padding:IPad = new PKCS5()
		
		var cipher:ICipher = Crypto.getCipher(ALGORITHM, ck.key, padding)
		var ivmode:IVMode = cipher as IVMode
		ivmode.IV = ck.iv
		
		cipher.decrypt(data)
	}
}
	