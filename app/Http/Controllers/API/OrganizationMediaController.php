<?php

namespace App\Http\Controllers\API;

use App\Models\ContentLibrary as ContentLibrary;
use App\Models\Media as Media;
use App\Models\ScormDetails;
use Illuminate\Http\Request;
use Validator;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use Illuminate\Support\Facades\Redis;
use DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use DOMDocument;

class OrganizationMediaController extends BaseController
{
    public function getOrgMediaList(Request $request)
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



        $medias = DB::table('lms_org_content_library as content_library')
            ->leftJoin('lms_org_master as org_master', 'content_library.org_id', '=', 'org_master.org_id')
            ->leftJoin('lms_org_media as media', 'content_library.media_id', '=', 'media.media_id')
            ->leftJoin('lms_org_content_types as content_type', 'content_library.content_types_id', '=', 'content_type.content_types_id')
            ->leftJoin('lms_org_content_library as parent_content_library', 'content_library.parent_content_id', '=', 'parent_content_library.content_id')
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
                'content_library.content_version as contentVersion',
                'content_type.content_type as contentType',
                'media.media_name as mediaName',
                'media.media_url as mediaUrl',
                'parent_content_library.content_name as parentContentName',
                'content_library.date_created as dateCreated',
                'content_library.date_modified as dateModified',
                DB::raw('(CASE WHEN content_library.is_active = 1 THEN "Active" ELSE "Inactive" END) AS isActive')
            )
            ->get();

        if ($medias->count() > 0) {
            foreach ($medias as $media) {
                if ($media->mediaUrl != '') {
                    if ($media->contentId == 3) {

                        $mediaName = $media->mediaName;
                        $mediaUrl = $media->mediaUrl;
                        if ($media->launch) {
                            $media->mediaUrl = getFileS3Bucket(getPathS3Bucket()) . '/media/' . $mediaUrl . '/' . $mediaName . '/' . $media->launch;
                        }
                    } else if ($media->contentId == 5 || $media->contentId == 8) {
                        $media->mediaUrl = $media->mediaUrl;
                    } else {
                        $media->mediaUrl = getFileS3Bucket(getPathS3Bucket() . '/media/' . $media->mediaUrl);
                    }

                }
            }
        }

        return response()->json(['status' => true, 'code' => 200, 'data' => $medias], 200);
    }

    public function addOrgMedia(Request $request)
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

            if ($request->contentType == 3) {
                $zipFileName = time() . Str::random(16);
                $zipFileNameWithExtension = $zipFileName . '.' . $mediaType;
                $mediaUrl = $zipFileName;
                $mediaName = $mediaFileName;
            } else {
                $mediaUrl = fileUploadS3Bucket($request->mediaUrl, 'media');
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

                if ($request->file('mediaUrl') && $request->contentType == 3) {
                    fileUploadS3Bucket($request->file('mediaUrl'), 'media', 's3', $request, $zipFileName);
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

                if ($request->file('mediaUrl') && $request->contentType == 3) {
                    fileUploadS3Bucket($request->file('mediaUrl'), 'media', 's3', $request, $zipFileName);
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

    public function getOrgMediaById($contentId)
    {

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;

        $contentLibrary = DB::table('lms_content_library as content_library')
            ->leftJoin('lms_org_master as org_master', 'content_library.org_id', '=', 'org_master.org_id')
            ->leftJoin('lms_media as media', 'content_library.media_id', '=', 'media.media_id')
            ->leftJoin('lms_content_types as content_type', 'content_library.content_types_id', '=', 'content_type.content_types_id')
            ->leftJoin('lms_content_library as parent_content_library', 'content_library.parent_content_id', '=', 'parent_content_library.content_id')
            ->leftJoin('lms_scorm_details as scormDetails', 'media.media_id', '=', 'scormDetails.media_id')
            //->groupBy('scormDetails.scorm_id')
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
        $contentLibrary = $contentLibrary->select('content_library.content_id as contentId', 'content_library.content_name as contentName', 'content_library.content_version as contentVersion', 'content_library.content_types_id as contentTypesId', 'content_type.content_type as contentType', 'content_library.media_id as mediaId', 'media.media_name as mediaName', 'media.media_url as mediaUrl', 'content_library.parent_content_id as parentContentId', 'parent_content_library.content_name as parentContentName', 'scormDetails.scorm_details_id as scormId', 'scormDetails.scorm_version as scormVersion', 'scormDetails.launch', 'content_library.is_active as isActive')->first();

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


    public function deleteOrgMedia(Request $request)
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

    public function getOrgParentContentList()
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

    public function getOrgContentVersion(Request $request)
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
            $content = ContentLibrary::join('lms_org_content_types', 'lms_org_content_library.content_types_id', '=', 'lms_org_content_types.content_types_id')
                ->join('lms_org_media', 'lms_org_content_library.media_id', '=', 'lms_org_media.media_id')
                ->where(function ($query) use ($organizationId, $roleId, $authId) {
                    if ($roleId == 1) {
                        $query->where('lms_org_content_library.org_id', $organizationId);
                        $query->where('lms_org_content_library.created_id', $authId);

                        $query->where('lms_org_media.org_id', $organizationId);
                        $query->where('lms_org_media.created_id', $authId);
                    } else {
                        $query->where('lms_org_content_library.org_id', $organizationId);
                        $query->where('lms_org_media.org_id', $organizationId);
                    }
                })
                ->where('lms_org_content_library.is_active', '!=', '0')->where('lms_org_content_library.content_id', $contentId);
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
            $content = ContentLibrary::join('lms_org_content_types', 'lms_org_content_library.content_types_id', '=', 'lms_org_content_types.content_types_id')
                ->where('lms_org_content_library.is_active', '!=', '0')
                ->where(function ($query) use ($organizationId, $roleId, $authId) {
                    if ($roleId == 1) {
                        $query->where('lms_org_content_library.org_id', $organizationId);
                        $query->where('lms_org_content_library.created_id', $authId);
                    } else {
                        $query->where('lms_org_content_library.org_id', $organizationId);
                    }
                })
                ->where('lms_org_content_library.content_id', $contentId);
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


    public function getOrgMediaOptionList(Request $request)
    {

        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;
        $authId = Auth::user()->user_id;

        $medias = Media::where('is_active', '1')
            ->where(function ($query) use ($organizationId, $roleId, $authId) {
                // if ($roleId == 1) {
                //     $query->where('org_id', $organizationId);
                //     $query->where('created_id', $authId);
                // } else {
                //     $query->where('org_id', $organizationId);
                // }
                $query->where('org_id', $organizationId);
            })
            ->select('media_id as mediaId', 'media_name as mediaName', 'media_type as mediaType', 'media_size as mediaSize', 'date_created as dateCreated', 'is_active as isActive')
            ->get();
        return response()->json(['status' => true, 'code' => 200, 'data' => $medias], 200);
    }

    public function deleteOrgMediaCourseLibrary(Request $request)
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

    public function getOrgMediaCourseLibraryById($mediaId)
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

}