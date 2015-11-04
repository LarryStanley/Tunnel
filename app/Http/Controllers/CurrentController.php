<?php
namespace App\Http\Controllers;
use DB;
use App\User;
use App\Http\Controllers\Controller;
use Input;
use URL;
use Session;
use \XMLReader;

class CurrentController extends Controller
{
	public function index() {
		$xml = simplexml_load_file("compress.zlib://http://tisvcloud.freeway.gov.tw/roadlevel_info.xml.gz");

		return response()->json($xml->Infos);
	}
}