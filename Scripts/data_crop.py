import glob
import os
import sys
import xml.etree.ElementTree as ET
from xml.dom import minidom

import cv2
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy.misc as misc
from PIL import Image
from skimage import data, draw



# img = Image.fromarray(matrix[:608, :912, :])


def cut_pic_and_write_xml(path = 'Flower', HEIGHT=900, WIDTH=1200, GAP=200, H=3648, W=5472):

    obj_axis = xml_log('VOC2007')

    for jpg_file in glob.glob(path + '/*.JPG'):

        jpg_file_name = jpg_file.split('/')[1].split('.')[0]



        img = Image.open(jpg_file)
        matrix = np.asarray(img)
        h_ini, w_ini = int((H - HEIGHT) % (HEIGHT - GAP) / 2) , int((W - WIDTH) % (WIDTH - GAP) / 2)
        h, w = h_ini, w_ini
        count = 1


        while h + HEIGHT <= H:
            while w + WIDTH <= W:



                sub_img_name = jpg_file_name + '_{}.JPG'.format(str(count))
                sub_xml_name = jpg_file_name + '_{}.xml'.format(str(count))
                sub_image = matrix[h:h+HEIGHT, w:w+WIDTH,:]


                write_xml(sub_xml_name, h_0 = h, w_0 = w, HEIGHT = HEIGHT, WIDTH = WIDTH, obj_axis = obj_axis[jpg_file_name])
                print(sub_xml_name + ' was produced!')
                misc.imsave('split_flower/' + sub_img_name,sub_image)
                print(sub_img_name + ' was produced!')
                w += WIDTH - GAP
                count += 1

            h += HEIGHT - GAP
            w = w_ini


def write_xml(xml_name, h_0, w_0, HEIGHT, WIDTH, obj_axis):

    print(HEIGHT, WIDTH)


    dom=minidom.Document()
    root_node=dom.createElement('annotation')
    dom.appendChild(root_node)
    root_node.setAttribute('verified','no')


    folder_node=dom.createElement('folder')
    folder_text = dom.createTextNode('1月5号仿真花补采')
    root_node.appendChild(folder_node)
    folder_node.appendChild(folder_text)

    size_node = dom.createElement('size')
    root_node.appendChild(size_node)

    width_node = dom.createElement('width')
    size_node.appendChild(width_node)
    width_node.appendChild(dom.createTextNode('1200'))

    height_node = dom.createElement('height')
    size_node.appendChild(height_node)
    height_node.appendChild(dom.createTextNode('900'))

    depth_node = dom.createElement('depth')
    size_node.appendChild(depth_node)
    depth_node.appendChild(dom.createTextNode('3'))


    
    for x_min, y_min, x_max, y_max in obj_axis:

        print(x_min, y_min, x_max, y_max)

        x_min = clamp(0, WIDTH, x_min - w_0)
        y_min = clamp(0, HEIGHT, y_min - h_0)
        x_max = clamp(0, WIDTH, x_max - w_0)
        y_max = clamp(0, HEIGHT, y_max - h_0)

        print(x_min, y_min, x_max, y_max)
        print('-------------------------------')
        if x_min == x_max or y_min == y_max:
            continue

        object_node = dom.createElement('object')
        root_node.appendChild(object_node)

        x_min_node = dom.createElement('x_min')
        object_node.appendChild(x_min_node)
        x_min_node.appendChild(dom.createTextNode(str(x_min)))


        y_min_node = dom.createElement('y_min')
        object_node.appendChild(y_min_node)
        y_min_node.appendChild(dom.createTextNode(str(y_min)))

        x_max_node = dom.createElement('x_max')
        object_node.appendChild(x_max_node)
        x_max_node.appendChild(dom.createTextNode(str(x_max)))

        y_max_node = dom.createElement('y_max')
        object_node.appendChild(y_max_node)
        y_max_node.appendChild(dom.createTextNode(str(y_max)))

    try:
        with open('split_xml/' + xml_name, 'w',encoding='UTF-8') as fh:

            dom.writexml(fh,indent='',addindent='\t',newl='\n',encoding='UTF-8')

    except Exception as err:
        print('error:{0}'.format(err))


def xml_log(path='VOC2007'):
    object_axis = {}
    for xml_file in glob.glob(path + '/*.xml'):
        object_axis[xml_file.split('/')[1].split('.')[0]] = []
        tree = ET.parse(xml_file)
        root = tree.getroot()
        for member in root.findall('object'):
            x_min = int(member[4][0].text)
            y_min = int(member[4][1].text)
            x_max = int(member[4][2].text)
            y_max = int(member[4][3].text)
            object_axis[xml_file.split('/')[1].split('.')[0]].append((x_min, y_min, x_max,y_max))
    return object_axis

def clamp(low_bound, max_bound, x):
    if x < low_bound:
        return low_bound
    if x > max_bound:
        return max_bound
    return x

cut_pic_and_write_xml()
