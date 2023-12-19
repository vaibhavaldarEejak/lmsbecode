<?php

namespace App\Http\Controllers\API;

use App\Models\ContentLibrary;
use App\Models\ContentType;
use App\Models\Media;
use Illuminate\Http\Request;
use Validator;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use Illuminate\Support\Facades\Redis;
use DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use App\Models\ScormDetails;
use DOMDocument;

class MediaController extends BaseController
{
    public function getMediaList(Request $request)
    {

        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;
        $authId = Auth::user()->user_id;

        $sort = $request->has('sort') ? $request->get('sort') : 'content_library.content_id';
        $order = $request->has('order') ? $request->get('order') : 'DESC';
        $search = $request->has('search') ? $request->get('search') : '';

        $sortColumn = $sort;
        if ($sort == 'contentName') {
            $sortColumn = 'content_library.content_name';
        } elseif ($sort == 'contentVersion') {
            $sortColumn = 'content_library.content_version';
        } elseif ($sort == 'contentType') {
            $sortColumn = 'content_type.content_type';
        } elseif ($sort == 'mediaName') {
            $sortColumn = 'media.media_name';
        } elseif ($sort == 'parentContentName') {
            $sortColumn = 'parent_content_library.content_name';
        } elseif ($sort == 'organizationName') {
            //$sortColumn = 'org_master.organization_name';
        } elseif ($sort == 'isActive') {
            $sortColumn = 'content_library.is_active';
        }



        $medias = DB::table('lms_content_library as content_library')
            ->leftJoin('lms_org_master as org_master', 'content_library.org_id', '=', 'org_master.org_id')
            ->leftJoin('lms_media as media', 'content_library.media_id', '=', 'media.media_id')
            ->leftJoin('lms_content_types as content_type', 'content_library.content_types_id', '=', 'content_type.content_types_id')
            ->leftJoin('lms_content_library as parent_content_library', 'content_library.parent_content_id', '=', 'parent_content_library.content_id')

            ->leftJoin('lms_scorm_details as scorm', 'media.media_id', '=', 'scorm.media_id')

            ->where('content_library.is_active', '!=', '0')
            ->where('org_master.is_active', '1')
            ->where('media.is_active', '1')
            ->where(function ($query) use ($search) {
                if ($search != '') {
                    $query->where('content_library.content_name', 'LIKE', '%' . $search . '%');
                    $query->orWhere('content_library.content_version', 'LIKE', '%' . $search . '%');
                    $query->orWhere('content_type.content_type', 'LIKE', '%' . $search . '%');
                    $query->orWhere('media.media_name', 'LIKE', '%' . $search . '%');
                    //$query->orWhere('parent_content_library.content_name', 'LIKE', '%'.$search.'%');
                    //$query->orWhere('org_master.organization_name', 'LIKE', '%'.$search.'%');
                    if (in_array($search, ['active', 'act', 'acti', 'activ'])) {
                        $query->orWhere('content_library.is_active', '1');
                    }
                    if (in_array($search, ['inactive', 'inact', 'inacti', 'inactiv'])) {
                        $query->orWhere('content_library.is_active', '2');
                    }
                }
            })
            ->where(function ($query) use ($organizationId, $roleId, $authId) {
                if ($roleId == 1) {
                    $query->where('content_library.org_id', $organizationId);
                    $query->where('content_library.created_id', $authId);
                } else {
                    $query->where('content_library.org_id', $organizationId);
                }
            })
            ->orderBy($sortColumn, $order)
            ->select(
                'content_library.content_id as contentId',
                'content_library.content_name as contentName',
                'content_library.content_types_id as contentTypesId',
                'content_library.content_version as contentVersion',
                'content_type.content_type as contentType',
                'media.media_name as mediaName',
                'media.media_url as mediaUrl',
                'parent_content_library.content_name as parentContentName',
                'scorm.launch',
                'content_library.date_created as dateCreated',
                'content_library.date_modified as dateModified',
                DB::raw('(CASE WHEN content_library.is_active = 1 THEN "Active" ELSE "Inactive" END) AS isActive')
            )
            ->get();


            if($medias->count() > 0){
                foreach($medias as $media){
                    if ($media->mediaUrl != '') {
                        if ($media->contentTypesId == 3) {
            
                            $mediaName = $media->mediaName;
                            $mediaUrl = $media->mediaUrl;
                            if ($media->launch) {
                                $media->mediaUrl = getFileS3Bucket(getPathS3Bucket()) . '/media/' . $mediaUrl . '/' . $mediaName . '/' . $media->launch;
                            } 
                        } else if ($media->contentTypesId == 5 || $media->contentTypesId == 8) {
                            $media->mediaUrl = $media->mediaUrl;
                        } else {
                            $media->mediaUrl = getFileS3Bucket(getPathS3Bucket() . '/media/' . $media->mediaUrl);
                        }
            
                    }
                }
            }

        return response()->json(['status' => true, 'code' => 200, 'data' => $medias], 200);
    }

    public function addMedia(Request $request)
    {
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;

        if ($request->optionType == 1) {
            $validator = Validator::make($request->all(), [
                'optionType' => 'required|integer',
                'parentContent' => 'required|integer',
                'contentVersion' => 'required',
                'contentType' => 'required|integer',
                'mediaUrl' => 'required',
                'isActive' => 'integer'
            ]);
        } elseif ($request->optionType == 2) {
            $validator = Validator::make($request->all(), [
                'optionType' => 'required|integer',
                'parentContent' => 'required|integer',
                'contentType' => 'required|integer',
                'mediaUrl' => 'required',
                'isActive' => 'integer'
            ]);
        } elseif ($request->optionType == 3) {
            $validator = Validator::make($request->all(), [
                'optionType' => 'required|integer',
                'contentName' => 'required|max:64',
                'contentType' => 'required|integer',
                'mediaUrl' => 'required',
                'isActive' => 'integer'
            ]);
        } else {
            return response()->json(['status' => false, 'code' => 400, 'error' => 'The content type fields is required.'], 400);
        }


        if ($validator->fails()) {
            return response()->json(['status' => false, 'code' => 400, 'errors' => $validator->errors()->all()], 400);
        }

        $mediaUrl = $mediaSize = $mediaType = $mediaName = '';
        if ($request->file('mediaUrl') != '') {

            $mediaSize = $request->file('mediaUrl')->getSize();
            $mediaType = $request->file('mediaUrl')->extension();
            $mediaName = $request->file('mediaUrl')->getClientOriginalName();

            $mediaFileName = substr($mediaName, 0, strrpos($mediaName, '.'));
            $mediaFileName = str_replace(' ', '_', $mediaFileName);

            if($request->contentType == 3){
                $zipFileName = time().Str::random(16);
                $zipFileNameWithExtension = $zipFileName.'.'.$mediaType;
                $mediaUrl = $zipFileName;
                $mediaName = $mediaFileName;
                
            } else {
                $mediaUrl = fileUploadS3Bucket($request->mediaUrl,'media');
            }
        } else {
            $mediaUrl = $request->mediaUrl;
            $mediaName = $mediaUrl;
            $mediaType = '';

            if ($request->contentType == 5) {
                $mediaType = 'Embedded Code';
            }
            if ($request->contentType == 8) {
                $mediaType = 'URL';
            }
        }


        if ($request->optionType == 1) {

            $content = ContentLibrary::where('is_active', '!=', '0')
                ->where(function ($query) use ($organizationId, $roleId, $authId) {
                    if ($roleId == 1) {
                        $query->where('org_id', $organizationId);
                        $query->where('created_id', $authId);
                    } else {
                        $query->where('org_id', $organizationId);
                    }
                })
                ->where('content_id', $request->parentContent)
                ->where('content_version', $request->contentVersion);
            if ($content->count() > 0) {
                $mediaId = $content->first()->media_id;
                $content->update([
                    'content_types_id' => $request->contentType
                ]);
            } else {
                $parentContent = ContentLibrary::where('is_active', '!=', '0')
                    ->where(function ($query) use ($organizationId, $roleId, $authId) {
                        if ($roleId == 1) {
                            $query->where('org_id', $organizationId);
                            $query->where('created_id', $authId);
                        } else {
                            $query->where('org_id', $organizationId);
                        }
                    })
                    ->where('parent_content_id', $request->parentContent)->where('content_version', $request->contentVersion);
                if ($parentContent->count() > 0) {
                    $mediaId = $parentContent->first()->media_id;
                    $parentContent->update([
                        'content_types_id' => $request->contentType
                    ]);
                } else {
                    return response()->json(['status' => false, 'code' => 400, 'message' => 'Media has been not updated.'], 400);
                }
            }

            $media = Media::find($mediaId);
            $media->media_name = $mediaName;
            $media->media_url = $mediaUrl;
            $media->media_size = $mediaSize;
            $media->media_type = $mediaType;
            $media->modified_id = $authId;
            $media->save();

            return response()->json(['status' => true, 'code' => 200, 'message' => 'Media has been updated successfully.'], 200);

        } elseif ($request->optionType == 2) {

            $media = new Media;
            $media->media_name = $mediaName;
            $media->media_url = $mediaUrl;
            $media->media_size = $mediaSize;
            $media->media_type = $mediaType;
            $media->org_id = $organizationId;
            $media->created_id = $authId;
            $media->modified_id = $authId;
            $media->save();

            if ($media->media_id != '') {

                if($request->file('mediaUrl') && $request->contentType == 3){
                    fileUploadS3Bucket($request->file('mediaUrl'),'media','s3',$request,$zipFileName);
                    $zip = new \ZipArchive();
                    if ($zip->open(Storage::disk('public')->path('media/'.$zipFileNameWithExtension), \ZipArchive::CREATE) === TRUE) {
                        //$zip->extractTo(Storage::disk('public')->path('media/'.$zipFileName));

                        $stream = $zip->getStream('imsmanifest.xml');
                        $contents = '';
                        while (!feof($stream)) {
                            $contents .= fread($stream, 2);
                        }
                        fclose($stream);
                        $dom = new \DOMDocument();

                        if($dom->loadXML($contents)) {

                            $manifest = $dom->getElementsByTagName('manifest')->item(0);
                            $version = @$manifest->attributes->getNamedItem('version')->nodeValue;
                            $manifestIdentifier = @$manifest->attributes->getNamedItem('identifier')->nodeValue;

                            $organization = $dom->getElementsByTagName('organization')->item(0);
                            $title = @$organization->getElementsByTagName('title')->item(0)->textContent;

                            $resource = $dom->getElementsByTagName('resource')->item(0);
                            $identifier = @$resource->attributes->getNamedItem('identifier')->nodeValue;
                            $scormType = @$resource->attributes->getNamedItem('scormType')->nodeValue; 
                            $launch = @$resource->attributes->getNamedItem('href')->nodeValue;              

                            $scoMenisfestReader = new ScormDetails;
                            $scoMenisfestReader->media_id = $media->media_id;
                            $scoMenisfestReader->scorm_name = $title;
                            $scoMenisfestReader->scorm_type = $scormType;
                            $scoMenisfestReader->reference = $identifier;
                            $scoMenisfestReader->scorm_version = $version;
                            $scoMenisfestReader->identifier = $manifestIdentifier;                                            
                            $scoMenisfestReader->launch = $launch;
                            $scoMenisfestReader->created_id = $authId;
                            $scoMenisfestReader->modified_id = $authId;
                            $scoMenisfestReader->save();                    
                        }
                        $zip->close();

                        // $files = \File::allFiles(Storage::disk('public')->path('/media/'.$zipFileName));
                        // foreach ($files as $k => $file) {
                        //     $dirname = pathinfo($file)['dirname'];
                        //     $basename = pathinfo($file)['basename'];
                        //     $explode = explode($zipFileName, $dirname);
                        //     scormFileUpload(file_get_contents($dirname . '/' . $basename),'/media/' . $zipFileName . '/' . $mediaFileName . $explode[1] . '/' . $basename);
                        // }

                        \File::deleteDirectory(Storage::disk('public')->path('media/'.$zipFileName));
                        \File::delete(Storage::disk('public')->path('media/'.$zipFileNameWithExtension));
                    }
                }

                $content = ContentLibrary::where('is_active', '!=', '0')
                    ->where(function ($query) use ($organizationId, $roleId, $authId) {
                        if ($roleId == 1) {
                            $query->where('org_id', $organizationId);
                            $query->where('created_id', $authId);
                        } else {
                            $query->where('org_id', $organizationId);
                        }
                    })
                    ->where('content_id', $request->parentContent);
                if ($content->count() > 0) {

                    $contentName = $content->first()->content_name;

                    $parentContent = ContentLibrary::where('is_active', '!=', '0')
                        ->where(function ($query) use ($organizationId, $roleId, $authId) {
                            if ($roleId == 1) {
                                $query->where('org_id', $organizationId);
                                $query->where('created_id', $authId);
                            } else {
                                $query->where('org_id', $organizationId);
                            }
                        })
                        ->where('parent_content_id', $request->parentContent)->orderBy('content_id', 'DESC');
                    if ($parentContent->count() > 0) {

                        $number = $parentContent->first()->content_version;
                        $pre_number = strtok($number, ".");
                        $post_number = substr($number, strrpos($number, '.') + 1);
                        if ($post_number != '') {
                            $contentVersion = $pre_number . "." . $post_number + 1;
                        } else {
                            $contentVersion = $number + 0.1;
                        }
                        $contentTypesId = $parentContent->select('content_types_id')->first()->content_types_id;
                    } else {
                        $contentVersion = $content->max('content_version') + 0.1;
                        $contentTypesId = $content->select('content_types_id')->first()->content_types_id;
                    }

                    $contentLibrary = new ContentLibrary;
                    $contentLibrary->content_name = $contentName;
                    $contentLibrary->parent_content_id = $request->parentContent;
                    $contentLibrary->content_version = $contentVersion;
                    $contentLibrary->content_types_id = $request->contentType;
                    $contentLibrary->media_id = $media->media_id;
                    $contentLibrary->org_id = $organizationId;
                    $contentLibrary->is_active = $request->isActive == '' ? '1' : $request->isActive;
                    $contentLibrary->created_id = $authId;
                    $contentLibrary->modified_id = $authId;
                    $contentLibrary->save();

                    return response()->json(['status' => true, 'code' => 200, 'message' => 'Media has been created successfully.'], 200);

                } else {
                    return response()->json(['status' => false, 'code' => 400, 'message' => 'Media has been not created.'], 400);
                }
            }
        } elseif ($request->optionType == 3) {
            $media = new Media;
            $media->media_name = $mediaName;
            $media->media_url = $mediaUrl;
            $media->media_size = $mediaSize;
            $media->media_type = $mediaType;
            $media->org_id = $organizationId;
            $media->created_id = $authId;
            $media->modified_id = $authId;
            $media->save();

            if ($media->media_id != '') {

                if($request->file('mediaUrl') && $request->contentType == 3){
                    fileUploadS3Bucket($request->file('mediaUrl'),'media','s3',$request,$zipFileName);
                    $zip = new \ZipArchive();
                    if ($zip->open(Storage::disk('public')->path('media/'.$zipFileNameWithExtension), \ZipArchive::CREATE) === TRUE) {
                        //$zip->extractTo(Storage::disk('public')->path('media/'.$zipFileName));

                        $stream = $zip->getStream('imsmanifest.xml');
                        $contents = '';
                        while (!feof($stream)) {
                            $contents .= fread($stream, 2);
                        }
                        fclose($stream);
                        $dom = new \DOMDocument();

                        if($dom->loadXML($contents)) {

                            $manifest = $dom->getElementsByTagName('manifest')->item(0);
                            $version = @$manifest->attributes->getNamedItem('version')->nodeValue;
                            $manifestIdentifier = @$manifest->attributes->getNamedItem('identifier')->nodeValue;

                            $organization = $dom->getElementsByTagName('organization')->item(0);
                            $title = @$organization->getElementsByTagName('title')->item(0)->textContent;

                            $resource = $dom->getElementsByTagName('resource')->item(0);
                            $identifier = @$resource->attributes->getNamedItem('identifier')->nodeValue;
                            $scormType = @$resource->attributes->getNamedItem('scormType')->nodeValue; 
                            $launch = @$resource->attributes->getNamedItem('href')->nodeValue;              

                            $scoMenisfestReader = new ScormDetails;
                            $scoMenisfestReader->media_id = $media->media_id;
                            $scoMenisfestReader->scorm_name = $title;
                            $scoMenisfestReader->scorm_type = $scormType;
                            $scoMenisfestReader->reference = $identifier;
                            $scoMenisfestReader->scorm_version = $version;
                            $scoMenisfestReader->identifier = $manifestIdentifier;                                            
                            $scoMenisfestReader->launch = $launch;
                            $scoMenisfestReader->created_id = $authId;
                            $scoMenisfestReader->modified_id = $authId;
                            $scoMenisfestReader->save();      
                        }
                        $zip->close();

                        // $files = \File::allFiles(Storage::disk('public')->path('/media/'.$zipFileName));
                        // foreach ($files as $k => $file) {
                        //     $dirname = pathinfo($file)['dirname'];
                        //     $basename = pathinfo($file)['basename'];
                        //     $explode = explode($zipFileName, $dirname);
                        //     scormFileUpload(file_get_contents($dirname . '/' . $basename),'/media/' . $zipFileName . '/' . $mediaFileName . $explode[1] . '/' . $basename);
                        // }

                        \File::deleteDirectory(Storage::disk('public')->path('media/'.$zipFileName));
                        \File::delete(Storage::disk('public')->path('media/'.$zipFileNameWithExtension));
                    }
                }

                $contentVersion = "1.0";

                $contentLibrary = new ContentLibrary;
                $contentLibrary->content_name = $request->contentName;
                $contentLibrary->content_version = $contentVersion;
                $contentLibrary->content_types_id = $request->contentType;
                $contentLibrary->media_id = $media->media_id;
                $contentLibrary->org_id = $organizationId;
                $contentLibrary->is_active = $request->isActive == '' ? '1' : $request->isActive;
                $contentLibrary->created_id = $authId;
                $contentLibrary->modified_id = $authId;
                $contentLibrary->save();
            }

            return response()->json(['status' => true, 'code' => 200, 'message' => 'Media has been created successfully.'], 200);
        } else {
            return response()->json(['status' => false, 'code' => 400, 'message' => 'Media has been created successfully.'], 400);
        }

    }

    public function getMediaById($contentId)
    {
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;

        $contentLibrary = DB::table('lms_content_library as content_library')
            ->leftJoin('lms_org_master as org_master', 'content_library.org_id', '=', 'org_master.org_id')
            ->leftJoin('lms_media as media', 'content_library.media_id', '=', 'media.media_id')
            ->leftJoin('lms_content_types as content_type', 'content_library.content_types_id', '=', 'content_type.content_types_id')
            ->leftJoin('lms_content_library as parent_content_library', 'content_library.parent_content_id', '=', 'parent_content_library.content_id')
            ->leftJoin('lms_scorm_details as scorm', 'media.media_id', '=', 'scorm.media_id')
            ->where('org_master.is_active', '1')
            ->where('media.is_active', '1')
            ->where('content_library.is_active', '!=', '0')
            ->where(['content_library.content_id' => $contentId])
            ->where(function ($query) use ($organizationId, $roleId, $authId) {
                if ($roleId == 1) {
                    $query->where('content_library.org_id', $organizationId);
                    $query->where('content_library.created_id', $authId);

                    $query->where('media.org_id', $organizationId);
                    $query->where('media.created_id', $authId);
                } else {
                    $query->where('content_library.org_id', $organizationId);
                    $query->where('media.org_id', $organizationId);
                }
            });

        if ($contentLibrary->count() < 1) {
            return response()->json(['status' => false, 'code' => 404, 'error' => 'Media is not found.'], 404);
        }
        $contentLibrary = $contentLibrary->select('content_library.content_id as contentId','scorm.scorm_details_id as scormID','scorm.scorm_version as scormVersion', 'content_library.content_name as contentName', 'content_library.content_version as contentVersion', 'content_library.content_types_id as contentTypesId', 'content_type.content_type as contentType', 'content_library.media_id as mediaId', 'media.media_name as mediaName', 'media.media_url as mediaUrl', 'content_library.parent_content_id as parentContentId', 'parent_content_library.content_name as parentContentName', 'scorm.launch', 'content_library.is_active as isActive')->first();

        if ($contentLibrary->mediaUrl != '') {
            if ($contentLibrary->contentTypesId == 3) {

                $mediaName = $contentLibrary->mediaName;
                $mediaUrl = $contentLibrary->mediaUrl;

                if ($contentLibrary->launch) {
                    $contentLibrary->mediaUrl = getFileS3Bucket(getPathS3Bucket()) . '/media/' . $mediaUrl . '/' . $mediaName . '/' . $contentLibrary->launch;
                } 
            } else if ($contentLibrary->contentTypesId == 5 || $contentLibrary->contentTypesId == 8) {
                $contentLibrary->mediaUrl = $contentLibrary->mediaUrl;
            } else {
                $contentLibrary->mediaUrl = getFileS3Bucket(getPathS3Bucket() . '/media/' . $contentLibrary->mediaUrl);
            }

        }

        return response()->json(['status' => true, 'code' => 200, 'data' => $contentLibrary], 200);

    }

    public function updateMedia(Request $request)
    {

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;

        $validator = Validator::make($request->all(), [
            'contentId' => 'required|integer',
            'contentName' => 'required|max:64',
            'contentType' => 'required|integer',
            'mediaUrl' => 'nullable',
            'isActive' => 'integer'
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'code' => 400, 'errors' => $validator->errors()->all()], 400);
        }

        try {

            $contentLibrary = ContentLibrary::where('is_active', '!=', '0')
                ->where(function ($query) use ($organizationId, $roleId, $authId) {
                    if ($roleId == 1) {
                        $query->where('org_id', $organizationId);
                        $query->where('created_id', $authId);
                    } else {
                        $query->where('org_id', $organizationId);
                    }
                })
                ->where('content_id', $request->contentId);
            if ($contentLibrary->count() < 1) {
                return response()->json(['status' => false, 'code' => 404, 'error' => 'Media is not found.'], 404);
            }

            $mediaId = $contentLibrary->first()->media_id;

            $contentLibrary->update([
                'content_name' => $request->contentName,
                'content_types_id' => $request->contentType,
                'is_active' => $request->isActive == '' ? $contentLibrary->first()->is_active ? $contentLibrary->first()->is_active : '1' : $request->isActive,
                'modified_id' => $request->authId
            ]);

            $mediaUrl = $mediaSize = $mediaType = '';
            if ($request->file('mediaUrl') != '') {
                $path = getPathS3Bucket() . '/media';
                $s3MediaUrl = Storage::disk('s3')->put($path, $request->mediaUrl);
                $mediaUrl = substr($s3MediaUrl, strrpos($s3MediaUrl, '/') + 1);
                $mediaSize = $request->file('mediaUrl')->getSize();
                $mediaType = $request->file('mediaUrl')->extension();
                $mediaName = $request->file('mediaUrl')->getClientOriginalName();

                Media::where('media_id', $mediaId)->update([
                    'media_name' => $mediaName,
                    'media_url' => $mediaUrl,
                    'media_size' => $request->mediaSize,
                    'media_type' => $request->mediaType,
                    'modified_id' => $request->authId
                ]);
            }

            return response()->json(['status' => true, 'code' => 200, 'message' => 'Media has been updated successfully.'], 200);

        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'code' => 501, 'message' => $e->getMessage()], 501);
        }
    }

    public function deleteMedia(Request $request)
    {
        try {
            $authId = Auth::user()->user_id;
            $organizationId = Auth::user()->org_id;
            $roleId = Auth::user()->user->role_id;

            $contentLibrary = ContentLibrary::where('is_active', '!=', '0')
                ->where(function ($query) use ($organizationId, $roleId, $authId) {
                    if ($roleId == 1) {
                        $query->where('org_id', $organizationId);
                        $query->where('created_id', $authId);
                    } else {
                        $query->where('org_id', $organizationId);
                    }
                })
                ->where('content_id', $request->contentId);
            if ($contentLibrary->count() < 1) {
                return response()->json(['status' => false, 'code' => 404, 'error' => 'Media is not found.'], 404);
            }
            $contentLibrary->update([
                'is_active' => 0
            ]);
            return response()->json(['status' => true, 'code' => 200, 'message' => 'Media has been deleted successfully.'], 200);
        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'code' => 501, 'message' => $e->getMessage()], 501);
        }
    }

    public function getParentContentList()
    {

        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;
        $authId = Auth::user()->user_id;

        $contents = ContentLibrary::where('is_active', '!=', '0')
            ->whereNull('parent_content_id')
            ->where(function ($query) use ($organizationId, $roleId, $authId) {
                if ($roleId == 1) {
                    $query->where('org_id', $organizationId);
                    $query->where('created_id', $authId);
                } else {
                    $query->where('org_id', $organizationId);
                }
            })
            ->select('content_id as contentId', 'content_name as contentName')
            ->get();
        return response()->json(['status' => true, 'code' => 200, 'data' => $contents], 200);
    }

    public function getContentVersion(Request $request)
    {

        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;
        $authId = Auth::user()->user_id;

        $contentId = $request->contentId;
        $optionType = $request->optionType;
        $version = $allVersion = [];

        $contentTypesId = '';
        $contentTypesName = '';
        $mediaName = '';

        if ($optionType == 1) {
            $contentVersion = '';
            $content = ContentLibrary::join('lms_content_types', 'lms_content_library.content_types_id', '=', 'lms_content_types.content_types_id')
                ->join('lms_media', 'lms_content_library.media_id', '=', 'lms_media.media_id')
                ->where(function ($query) use ($organizationId, $roleId, $authId) {
                    if ($roleId == 1) {
                        $query->where('lms_content_library.org_id', $organizationId);
                        $query->where('lms_content_library.created_id', $authId);

                        $query->where('lms_media.org_id', $organizationId);
                        $query->where('lms_media.created_id', $authId);
                    } else {
                        $query->where('lms_content_library.org_id', $organizationId);
                        $query->where('lms_media.org_id', $organizationId);
                    }
                })
                ->where('lms_content_library.is_active', '!=', '0')->where('lms_content_library.content_id', $contentId);
            if ($content->count() > 0) {
                $content = $content->first();
                $allVersion[] = $content->content_version;
                $contentTypesId = $content->content_types_id;
                $contentTypesName = $content->content_type;
                $mediaName = $content->media_name;

                $parentContent = ContentLibrary::where('is_active', '!=', '0')
                    ->where(function ($query) use ($organizationId, $roleId, $authId) {
                        if ($roleId == 1) {
                            $query->where('org_id', $organizationId);
                            $query->where('created_id', $authId);
                        } else {
                            $query->where('org_id', $organizationId);
                        }
                    })
                    ->where('parent_content_id', $contentId);
                if ($parentContent->count() > 0) {
                    $contentVersions = $parentContent->select('content_version')->get();
                    foreach ($contentVersions as $contentVersion) {
                        $version = $contentVersion->content_version;
                        $allVersion[] = $version;
                    }
                }
            }
            $data = [
                'version' => $allVersion,
                'contentTypesId' => $contentTypesId,
                'contentTypesName' => $contentTypesName,
                'mediaName' => $mediaName,
            ];
            return response()->json(['status' => true, 'code' => 200, 'data' => $data], 200);
        } elseif ($optionType == 2) {
            $contentVersion = '';
            $content = ContentLibrary::join('lms_content_types', 'lms_content_library.content_types_id', '=', 'lms_content_types.content_types_id')
                ->where('lms_content_library.is_active', '!=', '0')
                ->where(function ($query) use ($organizationId, $roleId, $authId) {
                    if ($roleId == 1) {
                        $query->where('lms_content_library.org_id', $organizationId);
                        $query->where('lms_content_library.created_id', $authId);
                    } else {
                        $query->where('lms_content_library.org_id', $organizationId);
                    }
                })
                ->where('lms_content_library.content_id', $contentId);
            if ($content->count() > 0) {

                $content = $content->first();
                $contentTypesId = $content->content_types_id;
                $contentTypesName = $content->content_type;

                $subContent = ContentLibrary::where('is_active', '!=', '0')
                    ->where(function ($query) use ($organizationId, $roleId, $authId) {
                        if ($roleId == 1) {
                            $query->where('org_id', $organizationId);
                            $query->where('created_id', $authId);
                        } else {
                            $query->where('org_id', $organizationId);
                        }
                    })
                    ->where('parent_content_id', $contentId)->orderBy('content_id', 'DESC');
                if ($subContent->count() > 0) {
                    $number = $subContent->first()->content_version;
                    $pre_number = strtok($number, ".");
                    $post_number = substr($number, strrpos($number, '.') + 1);
                    if ($post_number != '') {
                        $contentVersion = $pre_number . "." . $post_number + 1;
                    } else {
                        $contentVersion = $number + 0.1;
                    }
                } else {
                    $contentVersion = $content->first()->content_version + 0.1;
                }
            }
            return response()->json([
                'status' => true,
                'code' => 200,
                'data' => [
                    'version' => $contentVersion,
                    'contentTypesId' => $contentTypesId,
                    'contentTypesName' => $contentTypesName,
                ]
            ], 200);

        } elseif ($optionType == 3) {
            $contentVersion = "1.0";
            // $content = ContentLibrary::where('is_active','!=','0')->whereNull('parent_content_id');
            // if($content->count() > 0){
            //     $contentVersion = $content->max('content_version') + 1.0;
            // }
            return response()->json(['status' => true, 'code' => 200, 'data' => $contentVersion], 200);
        } else {
            return response()->json(['status' => false, 'code' => 400, 'message' => 'Content version not found.'], 400);
        }
    }


    public function playMedia(Request $request)
    {
        $organizationId = Auth::user()->org_id;

        $validator = Validator::make($request->all(), [
            'mediaId' => 'required|integer'
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'code' => 400, 'errors' => $validator->errors()->all()], 400);
        }

        $data = $finalData = [];
        $media = Media::where('media_id', $request->mediaId)->where('is_active', '1');
        if ($media->count() > 0) {
            $media = $media->select('media_url', 'media_type')->first();
            $mediaUrl = $media->media_url;
            $mediaType = $media->media_type;
            if ($mediaType == 'zip') {
                $files = Storage::disk('s3')->allFiles(getPathS3Bucket() . '/media/' . $mediaUrl);

                foreach ($files as $file) {
                    $fileName = substr($file, strrpos($file, "/") + 1);
                    $fileExtension = pathinfo($fileName, PATHINFO_EXTENSION);
                    //$fileUrl = getFileS3Bucket($file);
                    if ($fileExtension == 'xml') {
                        $fileUrl = getFileS3Bucket($file);
                        $xmlString = file_get_contents($fileUrl);
                        $xmlObject = simplexml_load_string($xmlString);
                        $xmlFile = json_encode($xmlObject);

                    }
                    if (strpos($file, 'shared/launchpage.html') !== false) {
                        $fileUrl = getFileS3Bucket($file);
                        $data = $fileUrl;
                        $data2[] = $data;
                    }

                }
                $finalData['xmlFile'] = $xmlFile;
                $finalData['resources'] = $data2;

                return response()->json(['status' => true, 'code' => 200, 'data' => $finalData], 200);
            } else {
                $finalData = getFileS3Bucket(getPathS3Bucket() . '/media/' . $mediaUrl);
                return response()->json(['status' => true, 'code' => 200, 'data' => $finalData], 200);
            }
        } else {
            return response()->json(['status' => false, 'code' => 400, 'error' => 'Media not found.'], 400);
        }
    }

    public function getMediaOptionList(Request $request)
    {

        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;
        $authId = Auth::user()->user_id;

        $medias = Media::where('is_active', '1')
            ->where(function ($query) use ($organizationId, $roleId, $authId) {
                if ($roleId == 1) {
                    $query->where('org_id', $organizationId);
                    $query->where('created_id', $authId);
                } else {
                    $query->where('org_id', $organizationId);
                }
            })
            ->select('media_id as mediaId', 'media_name as mediaName', 'media_type as mediaType', 'media_size as mediaSize', 'date_created as dateCreated', 'is_active as isActive')
            ->get();
        return response()->json(['status' => true, 'code' => 200, 'data' => $medias], 200);
    }

    public function deleteMediaCourseLibrary(Request $request)
    {
        try {
            $media = Media::where('is_active', '!=', '0')->where('media_id', $request->mediaId);
            if ($media->count() < 1) {
                return response()->json(['status' => false, 'code' => 404, 'error' => 'Media is not found.'], 404);
            }
            $media->update([
                'is_active' => 0
            ]);
            return response()->json(['status' => true, 'code' => 200, 'message' => 'Media has been deleted successfully.'], 200);
        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'code' => 501, 'message' => $e->getMessage()], 501);
        }
    }

    public function getMediaCourseLibraryById($mediaId)
    {

        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;
        $authId = Auth::user()->user_id;

        $media = Media::where('is_active', '!=', '0')->where('media_id', $mediaId);
        if ($media->count() < 1) {
            return response()->json(['status' => false, 'code' => 404, 'error' => 'Media is not found.'], 404);
        }

        $media = $media->select('media_id as mediaId', 'media_name as mediaName', 'media_type as mediaType', 'media_size as mediaSize', 'date_created as dateCreated', 'is_active as isActive')
            ->first();
        return response()->json(['status' => true, 'code' => 200, 'data' => $media], 200);
    }

    public function scormTracking($mediaId)
    {

    }

}