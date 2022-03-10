//Get the File from link below

/*
 * ISO-standard metric threads, following this specification:
 *          http://en.wikipedia.org/wiki/ISO_metric_screw_thread
 *
 * Copyright 2021 Dan Kirshner - dan_kirshner@yahoo.com
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * See <http://www.gnu.org/licenses/>.
 *
 * Version 2.6.  2021-05-16  Contributed patches for leadin (thanks,
                             jeffery.spirko@tamucc.edu) and aligning thread
                             "facets" (triangulation) with base cylinder
                             (thanks, rambetter@protonmail.com).
 * Version 2.5.  2020-04-11  Leadin option works for internal threads.
 * Version 2.4.  2019-07-14  Add test option - do not render threads.
 * Version 2.3.  2017-08-31  Default for leadin: 0 (best for internal threads).
 * Version 2.2.  2017-01-01  Correction for angle; leadfac option.  (Thanks to
 *                           Andrew Allen <a2intl@gmail.com>.)
 * Version 2.1.  2016-12-04  Chamfer bottom end (low-z); leadin option.
 * Version 2.0.  2016-11-05  Backwards compatibility (earlier OpenSCAD) fixes.
 * Version 1.9.  2016-07-03  Option: tapered.
 * Version 1.8.  2016-01-08  Option: (non-standard) angle.
 * Version 1.7.  2015-11-28  Larger x-increment - for small-diameters.
 * Version 1.6.  2015-09-01  Options: square threads, rectangular threads.
 * Version 1.5.  2015-06-12  Options: thread_size, groove.
 * Version 1.4.  2014-10-17  Use "faces" instead of "triangles" for polyhedron
 * Version 1.3.  2013-12-01  Correct loop over turns -- don't have early cut-off
 * Version 1.2.  2012-09-09  Use discrete polyhedra rather than linear_extrude ()
 * Version 1.1.  2012-09-07  Corrected to right-hand threads!
 */

//https://dkprojects.net/openscad-threads/ (24.01.2022)
// Examples.
//
// Standard M8 x 1.
